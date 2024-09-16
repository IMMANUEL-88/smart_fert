import 'package:flutter/material.dart';

class SensorData extends StatelessWidget {
  const SensorData({
    super.key,
    required this.sensorName,
    required this.sensorActualValue,
    required this.sensorAvgValue,
    required this.sensorIcon,
    required this.iconColor,
  });

  final String sensorName;
  final double sensorActualValue;
  final double sensorAvgValue;
  final IconData sensorIcon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              sensorIcon,
              color: iconColor,
            ),
            const SizedBox(
              width: 1,
            ),
            Text(
              sensorName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Text(
          '$sensorActualValue / $sensorAvgValue',
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}