import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/rutas/rutas.dart';
import 'package:transita3/screens/inicio_sesion_pantalla.dart';
import 'package:transita3/services/IncidenciaService.dart';
import 'package:transita3/services/LoginService.dart';
import 'package:transita3/services/ClienteService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  static final defaultDarkColorScheme = ColorScheme.fromSwatch(
    accentColor: Colors.blue,
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LoginService(),
        ),
        ChangeNotifierProvider.value(
          value: ClienteService(),
        ),
        ChangeNotifierProvider.value(
          value: IncidenciaService(),
        ),
      ],
      child: MaterialApp(
        title: 'Transita App',
        darkTheme: ThemeData(
          colorScheme: defaultDarkColorScheme,
          scaffoldBackgroundColor: Color.fromRGBO(41, 39, 39, 0.68),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        routes: getApplicationRoutes(),
        initialRoute: "/",
      ),
    );
  }
}
