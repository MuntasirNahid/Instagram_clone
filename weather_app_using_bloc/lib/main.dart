import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_using_bloc/bloc/weather_bloc.dart';
import 'package:weather_app_using_bloc/data/data_provider/weather_data_provider.dart';
import 'package:weather_app_using_bloc/data/repository/weather_repository.dart';
import 'package:weather_app_using_bloc/presentation/screens/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        WeatherDataProvider(),
      ),
      child: BlocProvider(
        create: (context) => WeatherBloc(
          context.read<WeatherRepository>(),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(useMaterial3: true),
          home: const WeatherScreen(),
        ),
      ),
    );
  }
}
