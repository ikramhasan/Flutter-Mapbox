import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_test/blocs/geocoding.bloc.dart';
import 'package:mapbox_test/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    BlocProvider<GeocodingBloc>(
      create: (context) => GeocodingBloc(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Mapbox',
      theme: ThemeData(
        brightness: Brightness.dark,
        canvasColor: Colors.black,
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
