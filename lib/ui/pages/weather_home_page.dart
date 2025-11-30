import 'package:flutter/material.dart';
import '../../presenters/weather_presenter.dart';
import '../../models/weather_model.dart';
import '../widgets/search_bar.dart';
import '../widgets/weather_card.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage>
    with TickerProviderStateMixin {
  final TextEditingController controller = TextEditingController(text: 'Lagos');
  final WeatherPresenter presenter = WeatherPresenter();

  WeatherModel? weather;
  bool loading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchWeather(controller.text);
  }

  Future<void> fetchWeather(String query) async {
    setState(() {
      loading = true;
      error = '';
    });

    try {
      final result = await presenter.loadWeather(query);
      setState(() {
        weather = result;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient (unchanged)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.indigo.shade800,
                  Colors.indigo.shade500,
                  Colors.cyan.shade300,
                ],
              ),
            ),
          ),

          // RESPONSIVE WRAPPER HERE ⬇️
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 620, // 🔥 Desktop responsive limit
              ),

              // All original content remains unchanged inside
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: WeatherSearchBar(
                              controller: controller,
                              onSubmitted: fetchWeather,
                            ),
                          ),
                          const SizedBox(width: 12),
                          GestureDetector(
                            onTap: () => fetchWeather(controller.text),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.refresh,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 20),

                      Expanded(
                        child: loading
                            ? const Center(child: CircularProgressIndicator())
                            : error.isNotEmpty
                                ? Center(
                                    child: Text(
                                      error,
                                      style: const TextStyle(
                                          color: Colors.white70, fontSize: 16),
                                    ),
                                  )
                                : weather == null
                                    ? const Center(
                                        child: Text(
                                          'No data',
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      )
                                    : WeatherCard(
                                        model: weather!,
                                        screen: screen,
                                      ),
                      ),

                      const SizedBox(height: 10),
                      const Text(
                        'Weather data from Weatherstack',
                        style: TextStyle(color: Colors.white70),
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
