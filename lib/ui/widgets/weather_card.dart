import 'package:flutter/material.dart';
import '../../models/weather_model.dart';
import 'info_chip.dart';
import 'stat_tile.dart';
import 'hourly_preview.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel model;
  final Size screen;

  const WeatherCard({super.key, required this.model, required this.screen});

  @override
  Widget build(BuildContext context) {
    final location = model.location;
    final current = model.current;

    final iconUrl = ((current['weather_icons'] as List?)?.isNotEmpty ?? false)
        ? current['weather_icons'][0]
        : null;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.10),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 20,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${location['name']}, ${location['country']}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Local time: ${location['localtime']}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  if (iconUrl != null)
                    Image.network(iconUrl, width: 64, height: 64),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${current['temperature']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 68,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text('°C',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 22)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          current['weather_descriptions'][0],
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InfoChip(title: 'Feels', value: '${current['feelslike']}°'),
                      const SizedBox(height: 8),
                      InfoChip(title: 'Humidity', value: '${current['humidity']}%'),
                      const SizedBox(height: 8),
                      InfoChip(title: 'Wind', value: '${current['wind_speed']} km/h'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: StatTile(title: 'Pressure', value: '${current['pressure']} mb'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: StatTile(title: 'Visibility', value: '${current['visibility']} km'),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: StatTile(title: 'UV Index', value: '${current['uv_index']}'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        HourlyPreview(current: current),
      ],
    );
  }
}
