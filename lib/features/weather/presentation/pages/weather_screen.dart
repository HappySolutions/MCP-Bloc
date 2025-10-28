import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcp_bloc_joke/features/weather/presentation/bloc/weather_bloc.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _controller =
      TextEditingController(text: 'Cairo');

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<WeatherBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('MCP + Bloc Weather'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'City'),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                final city = _controller.text.trim();
                if (city.isNotEmpty) {
                  // context.read<WeatherBloc>().add(GetWeatherEvent(city));
                  bloc.add(GetWeatherEvent('القاهرة'));
                }
              },
              child: const Text('Get Weather'),
            ),
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
              if (state is WeatherInitial)
                return const Text('ادخلي مدينة واضغطي Get Weather');
              if (state is WeatherLoading)
                return const CircularProgressIndicator();
              if (state is WeatherLoaded)
                return Text(state.result.toString(),
                    textAlign: TextAlign.center);
              if (state is WeatherError)
                return Text(state.message,
                    style: const TextStyle(color: Colors.red));
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
