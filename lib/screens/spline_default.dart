import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SplineChartExample extends StatefulWidget {
  const SplineChartExample({super.key});

  @override
  _SplineChartExampleState createState() => _SplineChartExampleState();
}

class _SplineChartExampleState extends State<SplineChartExample> {
  List<ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
    // Sample data for the chart
    chartData = [
      ChartData('00:00', 30),
      ChartData('01:00', 28),
      ChartData('02:00', 29),
      ChartData('03:00', 27),
      ChartData('04:00', 30),
      ChartData('05:00', 31),
      ChartData('06:00', 28),
      ChartData('07:00', 29),
      ChartData('08:00', 30),
      ChartData('09:00', 27),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 200,
                child: SizedBox(
                  width: 1100,
                  child: SfCartesianChart(
                    plotAreaBorderColor: Colors.transparent,
                    borderWidth: 0,
                    borderColor: Colors.transparent,
                    primaryXAxis: CategoryAxis(
                      majorTickLines: const MajorTickLines(width: 0),
                      majorGridLines: const MajorGridLines(width: 0),
                      axisLine: const AxisLine(color: Colors.transparent),
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white54),
                    ),
                    primaryYAxis: NumericAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      axisLine: const AxisLine(color: Colors.black),
                      isVisible: false,
                      desiredIntervals: 1,
                      labelFormat: '{value}°C',
                      title: AxisTitle(text: 'Temperature (°C)'),
                    ),
                    tooltipBehavior: TooltipBehavior(enable: true),
                    series: <CartesianSeries<dynamic, dynamic>>[
                      SplineSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        markerSettings: const MarkerSettings(
                          isVisible: true,
                          shape: DataMarkerType.circle,
                          color: Colors.white,
                          borderWidth: 2,
                          borderColor: Colors.white54,
                        ),
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                        enableTooltip: true,
                        splineType: SplineType.monotonic,
                        color: Colors.white54,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key, required this.iconName, required this.time});

  final IconData iconName;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(iconName, size: 15),
        Text(
          time,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }
}
