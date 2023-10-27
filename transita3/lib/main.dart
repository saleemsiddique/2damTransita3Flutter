import 'package:flutter/material.dart';
import 'package:transita3/navigation_bar.dart';
import 'package:transita3/screens/inicio_sesion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
    accentColor: Colors.blue,
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transita App',
      darkTheme: ThemeData(
        colorScheme: defaultDarkColorScheme,
        scaffoldBackgroundColor: Color.fromRGBO(41, 39, 39, 0.68),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: BottomNavigationBarProvider(), //IniciarSesionPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
