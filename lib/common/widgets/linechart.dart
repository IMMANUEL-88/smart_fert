import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('00:00', style: style);
      break;
    case 1:
      text = const Text('01:00', style: style);
      break;
    case 2:
      text = const Text('02:00', style: style);
      break;
    case 3:
      text = const Text('03:00', style: style);
      break;
    case 4:
      text = const Text('04:00', style: style);
      break;
    case 5:
      text = const Text('05:00', style: style);
      break;
    case 6:
      text = const Text('06:00', style: style);
      break;
    case 7:
      text = const Text('07:00', style: style);
      break;
    case 8:
      text = const Text('08:00', style: style);
      break;
    case 9:
      text = const Text('09:00', style: style);
      break;
    case 10:
      text = const Text('10:00', style: style);
      break;
    case 11:
      text = const Text('11:00', style: style);
      break;
    case 12:
      text = const Text('12:00', style: style);
      break;
    case 13:
      text = const Text('13:00', style: style);
      break;
    case 14:
      text = const Text('14:00', style: style);
      break;
    case 15:
      text = const Text('15:00', style: style);
      break;
    case 16:
      text = const Text('16:00', style: style);
      break;
    case 17:
      text = const Text('17:00', style: style);
      break;
    case 18:
      text = const Text('18:00', style: style);
      break;
    case 19:
      text = const Text('19:00', style: style);
      break;
    case 20:
      text = const Text('20:00', style: style);
      break;
    case 21:
      text = const Text('21:00', style: style);
      break;
    case 22:
      text = const Text('22:00', style: style);
      break;
    case 23:
      text = const Text('23:00', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

// Widget leftTitleWidgets(double value, TitleMeta meta) {
//   const style = TextStyle(
//     fontWeight: FontWeight.bold,
//     fontSize: 15,
//   );
//   String text;
//   switch (value.toInt()) {
//     case 1:
//       text = '10K';
//       break;
//     case 3:
//       text = '30k';
//       break;
//     case 5:
//       text = '50k';
//       break;
//     default:
//       return Container();
//   }
//
//   return Text(text, style: style, textAlign: TextAlign.left);
// }

LineChartData mainData() {
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  bool showAvg = false;
  return LineChartData(
    gridData: FlGridData(
      show: false,
      drawVerticalLine: true,
      horizontalInterval: 1,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: Colors.transparent,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return const FlLine(
          color: Colors.transparent,
          strokeWidth: 1,
        );
      },
    ),
    titlesData: const FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      // leftTitles: AxisTitles(
      //   sideTitles: SideTitles(
      //     showTitles: true,
      //     interval: 1,
      //     getTitlesWidget: leftTitleWidgets,
      //     reservedSize: 42,
      //   ),
      // ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false)
      )
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: Colors.transparent),
    ),
    minX: 0,
    maxX: 24,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 3),
          FlSpot(1, 2),
          FlSpot(2, 5),
          FlSpot(3, 3.1),
          FlSpot(4, 4),
          FlSpot(5, 3),
          FlSpot(6, 4),
          FlSpot(7, 3),
          FlSpot(8, 2),
          FlSpot(9, 5),
          FlSpot(10, 3.1),
          FlSpot(11, 4),
          FlSpot(12, 3),
          FlSpot(13, 4),
          FlSpot(14, 3),
          FlSpot(15, 2),
          FlSpot(16, 5),
          FlSpot(17, 3.1),
          FlSpot(18, 4),
          FlSpot(19, 3),
          FlSpot(20, 4),
          FlSpot(21, 4),
          FlSpot(22, 3),
          FlSpot(23, 4),
        ],
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors:
            gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ),
    ],
  );
}
