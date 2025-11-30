import 'package:flutter/material.dart';
import 'ui/pages/weather_home_page.dart';

void main() {
  runApp(const WeatherShowcaseApp());
}

class WeatherShowcaseApp extends StatelessWidget {
  const WeatherShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Showcase',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const WeatherHomePage(),
    );
  }
}
