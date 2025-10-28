import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcp_bloc_joke/features/weather/domain/usecases/get_weather_usecase.dart';
import 'package:mcp_bloc_joke/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:mcp_bloc_joke/features/weather/presentation/pages/weather_screen.dart';
import 'package:mcp_bloc_joke/mcp/mcp_client.dart';
import 'mcp/mcp_server.dart';

void main() {
  final mcpServer = MCPServer();
  final mcpClient = McpClient(mcpServer);

  mcpServer.registerTool('getWeather', (dynamic args) {
    final city = args?.toString() ?? 'unknown';

    return 'The Weather in $city is sunny today';
  });

  final getWeatherUseCase = GetWeatherUsecase(mcpClient);
  // 5️⃣ إنشاء WeatherBloc وربطه بالـ UseCase
  final weatherBloc = WeatherBloc(getWeatherUseCase);

  // 6️⃣ الاستماع لحالات الـ Bloc
  weatherBloc.stream.listen((state) {
    if (state is WeatherLoading) {
      print('⏳ جاري تحميل الطقس...');
    } else if (state is WeatherLoaded) {
      print('✅ النتيجة: ${state.result}');
    } else if (state is WeatherError) {
      print('❌ خطأ: ${state.message}');
    }
  });

  // 7️⃣ إرسال حدث للحصول على طقس مدينة معينة
  weatherBloc.add(GetWeatherEvent('القاهرة'));
  runApp(MyApp(getWeatherUseCase: getWeatherUseCase));
}

class MyApp extends StatelessWidget {
  final GetWeatherUsecase getWeatherUseCase;
  const MyApp({super.key, required this.getWeatherUseCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
      create: (_) => WeatherBloc(getWeatherUseCase),
      child: const WeatherPage(),
    ));
  }
}
