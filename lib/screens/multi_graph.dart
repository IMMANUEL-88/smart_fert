import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SoilDataChart extends StatelessWidget {
  const SoilDataChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soil Data Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: true, drawVerticalLine: true),
            titlesData: const FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.grey),
            ),
            lineBarsData: [
              _buildLineChartBarData(
                data: [30, 45, 60, 55, 70], // Replace with your soil moisture values
                color: Colors.blue,
                label: 'Soil Moisture',
              ),
              _buildLineChartBarData(
                data: [20, 22, 25, 23, 26], // Replace with your temperature values
                color: Colors.red,
                label: 'Temperature',
              ),
              _buildLineChartBarData(
                data: [40, 50, 45, 60, 55], // Replace with your humidity values
                color: Colors.green,
                label: 'Humidity',
              ),
            ],
            minX: 0,
            maxX: 4,
            minY: 0,
            maxY: 100,
          ),
        ),
      ),
    );
  }

  LineChartBarData _buildLineChartBarData({
    required List<double> data,
    required Color color,
    required String label,
  }) {
    return LineChartBarData(
      spots: data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
      isCurved: true,
      color: color,
      barWidth: 3,
      belowBarData: BarAreaData(
        show: true,
        color: color.withOpacity(0.3),
      ),
      dotData: const FlDotData(show: false),
    );
  }
}
