import 'package:flutter/material.dart';
import 'package:smart_fert/common/widgets/appbar.dart';

class Analytics extends StatelessWidget {
  const Analytics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EAppBar(title: Text('Analytics', style: Theme.of(context).textTheme.headlineMedium,),),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Analytics Screen')
          ],
        ),
      ),
    );
  }
}
