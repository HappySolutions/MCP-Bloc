part of 'weather_bloc.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final String result;
  WeatherLoaded(this.result);
}

class WeatherError extends WeatherState {
  final String message;
  WeatherError(this.message);
}
