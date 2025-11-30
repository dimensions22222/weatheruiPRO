import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HourlyPreview extends StatelessWidget {
  final Map<String, dynamic> current;

  const HourlyPreview({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final icons = current['weather_icons'] as List?;
    final icon = (icons != null && icons.isNotEmpty) ? icons.first : null;

    final items = List.generate(6, (i) {
      final time = now.add(Duration(hours: i * 3));
      final temp = ((current['temperature'] as num) + i - 1).toInt();

      return {
        'time': DateFormat.Hm().format(time),
        'temp': temp.toString(),
        'icon': icon,
      };
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map(
              (it) => Container(
                width: 92,
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(it['time']!,
                        style: const TextStyle(color: Colors.white70)),
                    const SizedBox(height: 6),
                    it['icon'] != null
                        ? Image.network(it['icon']!, width: 34, height: 34)
                        : const Icon(Icons.wb_sunny, color: Colors.white70),
                    const SizedBox(height: 6),
                    Text('${it['temp']}°',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}


