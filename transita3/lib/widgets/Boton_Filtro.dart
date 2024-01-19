import 'package:flutter/material.dart';

class BotonFiltro extends StatefulWidget {
  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<BotonFiltro> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: isExpanded ? buildExpandedButton() : buildCollapsedButton(),
    );
  }

  Widget buildCollapsedButton() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red
      ),
      child: Icon(
        Icons.search,
        color: Colors.white,
      ),
    );
  }

  Widget buildExpandedButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            // Lógica para el primer botón
          },
          child: Text('Botón 1'),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            // Lógica para el segundo botón
          },
          child: Text('Botón 2'),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            // Lógica para el tercer botón
          },
          child: Text('Botón 3'),
        ),
      ],
    );
  }
}
