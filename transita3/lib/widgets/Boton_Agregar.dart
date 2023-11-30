import 'package:flutter/material.dart';

Widget botonAgregar(BuildContext context, String routeName, double width, double height) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, routeName);
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
