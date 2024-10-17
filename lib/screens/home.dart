import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_fert/common/widgets/appbar.dart';
import 'package:smart_fert/common/widgets/weather_container.dart';
import 'package:smart_fert/models/weather_model.dart';
import 'package:smart_fert/screens/multi_graph.dart';
import 'package:smart_fert/screens/week_forecast.dart';
import 'package:smart_fert/services/weather_service.dart';
import '../common/widgets/analysis_box.dart';
import '../common/widgets/home_container.dart';
import '../common/widgets/npk_box.dart';
import '../common/widgets/sensor_data_box.dart';
import '../utils/theme/constants/colors.dart';
import '../utils/theme/constants/image_strings.dart';
import '../utils/theme/constants/sizes.dart';
import '../utils/theme/helper_functions/helper_functions.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  Map<String, dynamic>? data;
  List<dynamic>? hourlyTimes;
  List<dynamic>? hourlyTemperatures;
  List<dynamic>? hourlyHumidities;
  List<dynamic>? hourlyCode;
  String? timezone;
  String? formattedDate;
  String? greeting;
  String? formattedTime;

  bool showAvg = false;
  final PageController _pageController = PageController();
  final PageController _pageController2 = PageController();

  Map<int, String> weatherCodeToAsset = {
    0: EImages.clearsky,
    1: EImages.mainlyclear,
    2: EImages.partlycloudy,
    3: EImages.overcast,
    45: EImages.fog,
    51: EImages.lightrain,
    53: EImages.moderaterain,
    55: EImages.heavyrain,
    61: EImages.showers,
    63: EImages.thunderstorm,
    80: EImages.snowflurries,
    81: EImages.lightsnow,
    82: EImages.moderatesnow,
    85: EImages.heavysnow,
    90: EImages.heavysnow,
    95: EImages.heavysnow,
    // Add other weather codes and their corresponding assets as needed
  };

  //api key
  final _weatherService = WeatherService('e9a24f4d031012ffddaa2eea9f408516');
  Weather? _weather;

  // fetchData function to make HTTP GET request to the provided API
  void fetchData() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print('lat & lon: ${position.latitude} ${position.longitude}');
    // Convert URL string to Uri object
    Uri url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=${position.latitude}&longitude=${position.longitude}&current=temperature_2m,relative_humidity_2m&hourly=temperature_2m,relative_humidity_2m,weather_code');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        data = jsonDecode(response.body);
        hourlyTimes = data!['hourly']['time'].sublist(0, 24);
        hourlyCode = data!['hourly']['weather_code'].sublist(0, 24);
        hourlyTemperatures = data!['hourly']['temperature_2m'].sublist(0, 24);
        hourlyHumidities =
            data!['hourly']['relative_humidity_2m'].sublist(0, 24);
        timezone = data!['timezone'];



        // Determine the greeting and format the date and time
        DateTime currentTime = DateTime.parse(data!['current']['time']);
        int currentHour = currentTime.hour;
        if (currentHour < 12) {
          greeting = 'Good Morning';
        } else if (currentHour < 17) {
          greeting = 'Good Afternoon';
        } else {
          greeting = 'Good Evening';
        }

        // Formatted date
        formattedDate = DateFormat('EEEE d').format(currentTime);

        // Formatted time
        formattedTime = DateFormat('h:mm a').format(currentTime);
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }
  }

  //fetch weather
  _fetchWeather() async {
    //get current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/animations/dot_loader2.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/animations/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/animations/rain.json';
      case 'thunderstorm':
        return 'assets/animations/thunder.json';
      case 'clear':
        return 'assets/animations/sunny.json';
      default:
        return 'assets/animations/sunny.json';
    }
  }

  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup
    _fetchWeather();
    fetchData();
  }

  @override
  void dispose() {
    // Dispose of the controller to prevent memory leaks
    _pageController.dispose();
    _pageController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = EHelperFunctions.screenHeight(context);
    // var chartData = [
    //   ChartData('00:00', 30),
    //   ChartData('01:00', 28),
    //   ChartData('02:00', 29),
    //   ChartData('03:00', 27),
    //   ChartData('04:00', 30),
    //   ChartData('05:00', 31),
    //   ChartData('06:00', 28),
    //   ChartData('07:00', 29),
    //   ChartData('08:00', 30),
    //   ChartData('09:00', 27),
    // ];

    return Scaffold(
      backgroundColor: Colors.green, // Green tone

      appBar: EAppBar(
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        precedingIcon: Icons.settings,
        precedingIconColor: Colors.white,
        leadingIcon: Icons.keyboard_arrow_down_rounded,
        // Icon for the dropdown
        leadingIconColor: Colors.white,
        leadingIconSize: 30,
        leadingOnPressed: () {
          // Define dropdown behavior
          showMenu(
            color: EColors.black,
            context: context,
            position: const RelativeRect.fromLTRB(0, 56.0, 0, 0),
            // Dropdown position
            items: [
              const PopupMenuItem(
                value: 'Option 1',
                child: Text('Field 1'),
              ),
              const PopupMenuItem(
                value: 'Option 2',
                child: Text('Field 2'),
              ),
              const PopupMenuItem(
                value: 'Option 3',
                child: Text('Field 3'),
              ),
            ],
          ).then((value) {
            // Handle dropdown selection
            if (value != null) {
              print("Selected: $value");
            }
          });
        },
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: false,
              expandedHeight: screenHeight * 0.55,
              // Adjust the height as needed
              backgroundColor: Colors.green,
              // Green tone
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  // Calculate the opacity based on the scroll position
                  var top = constraints.biggest.height;
                  var opacity = (top - 80) / 220; // Adjust for smooth fading

                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: Opacity(
                      opacity: opacity.clamp(0.0, 1.0),
                      // Ensures opacity stays between 0 and 1
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: EHelperFunctions.screenHeight(context) *
                                    0.15,
                              ),
                              // const Icon(Icons.cloud,
                              //     color: Colors.blue, size: 40),
                              Center(
                                child: _weather == null
                                    ? const SizedBox(
                                        child: Text(""),
                                      ) // Show loader if _weather is null
                                    : Text(
                                        _weather?.cityName ?? "Loading city...",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                              ),
                              SizedBox(
                                  height:
                                      EHelperFunctions.screenHeight(context) *
                                          0.09,
                                  width:
                                      EHelperFunctions.screenHeight(context) *
                                          0.09,
                                  child: Lottie.asset(getWeatherAnimation(
                                      _weather?.mainCondition))),
                              Center(
                                child: _weather == null
                                    ? const SizedBox(
                                        child: Text(""),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${_weather?.temperature.round()}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 44,
                                            ),
                                          ),
                                          const Text(
                                            '°C',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _weather?.mainCondition ?? "",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // --Section 1--
              ReusableContainer(
                height: 280,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(ESizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sensor Readings',
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                'More Details',
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: ESizes.spaceBtwItems),
                      // Sensor & Values
                      const SensorData(
                        sensorIcon: Icons.water_drop,
                        iconColor: Colors.white70,
                        sensorName: "Soil Moisture",
                        sensorActualValue: 988,
                        sensorAvgValue: 850,
                      ),
                      const SizedBox(
                        height: ESizes.md,
                      ),
                      const SensorData(
                        sensorIcon: Icons.thermostat,
                        iconColor: Colors.white70,
                        sensorName: "Temperature",
                        sensorActualValue: 37,
                        sensorAvgValue: 35,
                      ),
                      const SizedBox(
                        height: ESizes.md,
                      ),
                      const SensorData(
                        sensorIcon: Icons.water_damage,
                        iconColor: Colors.white70,
                        sensorName: "Humidity",
                        sensorActualValue: 70,
                        sensorAvgValue: 65,
                      ),

                      const SizedBox(
                        height: ESizes.spaceBtwSections,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 55,
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SoilDataChart()),
                                );
                              },
                              child: const Text(
                                'Analytics',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Spacing between containers

              // --Section 2--
              SizedBox(
                height: 130,
                // Adjust height for scrollable content and indicator
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        children: const [
                          Analysis_box(
                            icon: Icons.water_drop,
                            title: 'Soil moisture looks like',
                            subTitle:
                                'The soil moisture levels are optimal. No additional irrigation is required.',
                          ),
                          Analysis_box(
                            icon: Icons.thermostat,
                            title: 'Temperature looks like',
                            subTitle:
                                'The field temperature is within the ideal range for crop growth.',
                          ),
                          Analysis_box(
                            icon: Icons.water_damage,
                            title: 'Humidity looks like',
                            subTitle:
                                'The humidity levels are well-balanced, minimizing the risk of fungal diseases.',
                          ),
                          // Add more pages as needed
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Page Indicator
                    SmoothPageIndicator(
                      controller: _pageController, // PageView controller
                      count: 3, // Number of pages
                      effect: const WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Colors.white,
                        dotColor: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // // --Section 3--
              // ReusableContainer(
              //   height: 200,
              //   width: double.infinity,
              //   child: Padding(
              //     padding: const EdgeInsets.all(ESizes.sm),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const Row(
              //           children: [
              //             Text(
              //               '24-hour forecast',
              //               style: TextStyle(
              //                   color: Colors.white54,
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.bold),
              //             ),
              //           ],
              //         ),
              //         Expanded(
              //           child: SingleChildScrollView(
              //             scrollDirection: Axis.horizontal,
              //             child: Container(
              //               width: 1100,
              //               child: SfCartesianChart(
              //                 plotAreaBorderColor: Colors.transparent,
              //                 borderWidth: 0,
              //                 borderColor: Colors.transparent,
              //                 primaryXAxis: CategoryAxis(
              //                   majorTickLines: MajorTickLines(width: 0),
              //                   majorGridLines: MajorGridLines(width: 0),
              //                   axisLine: AxisLine(color: Colors.transparent),
              //                   edgeLabelPlacement: EdgeLabelPlacement.shift,
              //                   labelStyle: TextStyle(
              //                     fontWeight: FontWeight.w600,
              //                     color: Colors.white54,
              //                   ),
              //                   // title: AxisTitle(text: 'Time (Hours)'),
              //                 ),
              //                 primaryYAxis: NumericAxis(
              //                   majorGridLines: MajorGridLines(width: 0),
              //                   axisLine: AxisLine(color: Colors.black),
              //                   isVisible: false,
              //                   desiredIntervals: 1,
              //                   labelFormat: '{value}°C',
              //                   title: AxisTitle(text: 'Temperature (°C)'),
              //                 ),
              //                 // title: ChartTitle(text: 'Temperature Variation Over Time'),
              //                 tooltipBehavior: TooltipBehavior(enable: true),
              //                 series: <CartesianSeries<dynamic, dynamic>>[
              //                   SplineSeries<ChartData, String>(
              //                     dataSource: chartData,
              //                     xValueMapper: (ChartData data, _) => data.x,
              //                     yValueMapper: (ChartData data, _) => data.y,
              //                     markerSettings: MarkerSettings(
              //                       isVisible: true,
              //                       shape: DataMarkerType.circle,
              //                       color: Colors.white,
              //                       borderWidth: 2,
              //                       borderColor: Colors.white54,
              //                     ),
              //                     dataLabelSettings: DataLabelSettings(
              //                       isVisible: true,
              //                     ),
              //                     enableTooltip: true,
              //                     splineType: SplineType.monotonic,
              //                     color: Colors.white54,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 16), // Spacing between containers

              // --Section 3--
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WeekScreen()),
                          );
                        },
                        child: const Row(
                          children: [
                            Text(
                              'More Details',
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: ESizes.sm,
                  ),
                  SizedBox(
                    height: 140,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(24, (index) {
                              return Row(
                                children: [
                                  WeatherContainer(
                                    weatherCode: (hourlyCode != null && hourlyCode!.isNotEmpty)
                                        ? hourlyCode![index]
                                        : 0, // Default to 0 if not found
                                    time: '${index == 0 ? 12 : index > 12 ? index - 12 : index}:00 ${index < 12 ? 'AM' : 'PM'}',
                                    temp: (hourlyTemperatures != null && hourlyTemperatures!.isNotEmpty)
                                        ? hourlyTemperatures![index]
                                        : null, // Default temperature if not found
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),

              // --Section 4--
              const Row(
                children: [
                  // First Container
                  Expanded(
                    child: Column(
                      children: [
                        ReusableContainer(
                          height: 108,
                          width: double.infinity,
                          // Set width to infinity to fill the available space
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.recycling,
                                size: 20,
                                color: Colors.white54,
                              ),
                              Text(
                                'Last Fertilizer Used',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white54),
                              ),
                              SizedBox(
                                height: ESizes.sm,
                              ),
                              Text(
                                '10-10-10 NPK',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: ESizes.sm,
                        ),
                        ReusableContainer(
                          height: 108,
                          width: double.infinity,
                          // Set width to infinity to fill the available space
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.pin_drop,
                                    color: Colors.white54,
                                  ),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Text(
                                    'Field Location',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white54),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: ESizes.sm,
                              ),
                              Text(
                                'V.M Chatram',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                      width: ESizes.sm), // Slight gap between the containers

                  // Second Container
                  Expanded(
                    child: ReusableContainer(
                      height: 224,
                      width: double.infinity,
                      // Set width to infinity to fill the available space
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.equalizer_outlined,
                                color: Colors.white54,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                'Soil Nutrition',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white54),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ESizes.md,
                          ),
                          NPK(
                            nutrient: 'Nitrogen',
                            value: 70,
                          ),
                          Divider(
                            color: Colors.white24,
                          ),
                          SizedBox(
                            height: ESizes.sm,
                          ),
                          NPK(
                            nutrient: 'Phosphorous',
                            value: 70,
                          ),
                          Divider(
                            color: Colors.white24,
                          ),
                          SizedBox(
                            height: ESizes.sm,
                          ),
                          NPK(
                            nutrient: 'Potassium',
                            value: 70,
                          ),
                          Divider(
                            color: Colors.white24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),

              // --Section 5--
              SizedBox(
                height: 130,
                // Adjust height for scrollable content and indicator
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: _pageController2,
                        children: const [
                          Analysis_box(
                            icon: Icons.query_stats_rounded,
                            title: 'Nitrogen Analysis',
                            subTitle:
                                'The nitrogen levels are optimal, promoting healthy leaf and stem growth.',
                          ),
                          Analysis_box(
                            icon: Icons.query_stats_rounded,
                            title: 'Phosphorous Analysis',
                            subTitle:
                                'Phosphorus levels are sufficient, supporting strong root development.',
                          ),
                          Analysis_box(
                            icon: Icons.query_stats_rounded,
                            title: 'Potassium Analysis',
                            subTitle:
                                'The potassium levels are balanced, enhancing disease resistance.',
                          ),
                          // Add more pages as needed
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Page Indicator
                    SmoothPageIndicator(
                      controller: _pageController2, // PageView controller
                      count: 3, // Number of pages
                      effect: const WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: Colors.white,
                        dotColor: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}
