import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/add_measurement_screen.dart';
import 'screens/edit_measurement_screen.dart';
import 'models/measurement.dart';

void main() {
  runApp(const PluviApp());
}

class PluviApp extends StatelessWidget {
  const PluviApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PluviApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2196F3), // Azul
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF2196F3), // Azul
          secondary: const Color(0xFF4CAF50), // Verde
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2196F3),
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF4CAF50),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/': (context) => const HomeScreen(),
        '/add': (context) => const AddMeasurementScreen(),
        '/edit': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return EditMeasurementScreen(
            measurement: args['measurement'] as Measurement,
            index: args['index'] as int,
          );
        },
      },
  );
  }
}
