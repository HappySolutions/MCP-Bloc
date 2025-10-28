import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../domain/usecases/get_weather_usecase.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUsecase getWeatherUsecase;

  WeatherBloc(this.getWeatherUsecase) : super(WeatherInitial()) {
    on<GetWeatherEvent>((event, emit) {
      emit(WeatherLoading());
      try {
        final result = getWeatherUsecase.execute(event.city);
        emit(WeatherLoaded(result));
      } catch (e) {
        emit(WeatherError('Somthing is wrong $e'));
      }
    });
  }
}
