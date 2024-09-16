import 'package:flutter/material.dart';
import 'package:smart_fert/common/widgets/appbar.dart';
import '../common/widgets/analysis_box.dart';
import '../common/widgets/home_container.dart';
import '../common/widgets/npk_box.dart';
import '../common/widgets/sensor_data_box.dart';
import '../utils/theme/constants/colors.dart';
import '../utils/theme/constants/sizes.dart';
import '../utils/theme/helper_functions/helper_functions.dart';
import 'analytics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../common/widgets/linechart.dart';

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

  bool showAvg = false;
  final PageController _pageController = PageController();
  final PageController _pageController2 = PageController();
  @override
  void initState() {
    super.initState();
    // Additional initialization if needed
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

    return Scaffold(
      backgroundColor: const Color(0xFF70BE92), // Green tone

      appBar: EAppBar(
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
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
              backgroundColor: const Color(0xFF70BE92),
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
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 68,
                              ),
                              // const Icon(Icons.cloud,
                              //     color: Colors.blue, size: 40),
                              const Text(
                                'Tirunelveli',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 24),
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: '30',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 64,
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: Transform.translate(
                                        offset: const Offset(0, -25),
                                        child: const Text(
                                          '°C',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Cloudy',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    '37°',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Text(
                                    '/',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 1,
                                  ),
                                  Text(
                                    '40°',
                                    style: TextStyle(fontSize: 12),
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
                                      builder: (context) => const Analytics()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.white10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
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
              const SizedBox(height: 16), // Spacing between containers


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


              // --Section 3--
              ReusableContainer(
                height: 250,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(ESizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            '24-hour forecast',
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Stack(
                        children: <Widget>[
                          AspectRatio(
                            aspectRatio: 1.70,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 0,
                                left: 0,
                                top: 20,
                                bottom: 0,
                              ),
                              child: LineChart(
                                showAvg ? avgData() : mainData(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            height: 34,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  showAvg = !showAvg;
                                });
                              },
                              child: Text(
                                'Avg',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: showAvg
                                      ? Colors.white.withOpacity(0.5)
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16), // Spacing between containers


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
                              Icon(Icons.recycling, size: 20, color: Colors.white54,),
                              Text(
                                'Last Fertilizer Used',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white54),
                              ),
                              SizedBox(height: ESizes.sm,),
                              Text(
                                '10-10-10 NPK',
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
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
                                  Icon(Icons.pin_drop, color: Colors.white54,),
                                  const SizedBox(width: 1,),
                                  Text('Field Location', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white54),)
                                ],
                              ),
                              SizedBox(height: ESizes.sm,),
                              Text(
                                'V.M Chatram',
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
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
                              Icon(Icons.equalizer_outlined, color: Colors.white54,),
                              SizedBox(width: 2,),
                              Text('Soil Nutrition', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white54),),
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
              const SizedBox(height: 16,),

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








