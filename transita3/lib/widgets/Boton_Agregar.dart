import 'package:flutter/material.dart';
import 'package:transita3/models/models.dart';

Widget botonAgregar(BuildContext context, String routeName, Punto? punto, double width, double height) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, routeName, arguments: punto);
    },
    child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/boton.png'),
        ),
        borderRadius: BorderRadius.circular(0.50),
      ),
      width: width,
      height: height,
    ),
  );
}
