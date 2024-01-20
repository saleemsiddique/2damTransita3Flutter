import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/services/Services.dart';

class BotonFiltro extends StatefulWidget {
  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<BotonFiltro> {
  bool isIncidentActive = true;
  bool isAccessibleActive = false;
  bool isFavoriteActive = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: isExpanded ? buildExpandedButtons() : buildCollapsedButton(),
    );
  }

  Widget buildCollapsedButton() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      child: Icon(
        Icons.search,
        color: Colors.white,
      ),
    );
  }

  Widget buildExpandedButtons() {
    final puntosService = Provider.of<PuntoService>(context, listen: true);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildExpandedButtonContainer(Icons.accessibility, isAccessibleActive,
            () {
          setState(() {
            isAccessibleActive = !isAccessibleActive;
            if (isIncidentActive) {
              isIncidentActive = !isIncidentActive;
            }
          });
          if (isAccessibleActive) {
            puntosService.getPuntosForMapFiltered(0);
          } else {
            puntosService.clearAccesiblesMap();
          }
          ;
        }),
        SizedBox(
          height: 10,
        ),
        buildExpandedButtonContainer(
          Icons.accessible_outlined,
          isIncidentActive,
          () {
            setState(() {
              isIncidentActive = !isIncidentActive;
              if (isAccessibleActive) {
                isAccessibleActive = !isAccessibleActive;
              }
            });
            if (isIncidentActive) {
              puntosService.getPuntosForMap();
            } else {
              puntosService.clearIncidencesMap();
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        buildExpandedButtonContainer(
          Icons.favorite,
          isFavoriteActive,
          () {
            setState(() {
              isFavoriteActive = !isFavoriteActive;
            });
            if (isFavoriteActive) {
              puntosService.getPuntosByIdCliente(LoginService.cliente.id);
            } else {
              puntosService.clearFavsMap();
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        buildExpandedButtonContainer(
          Icons.close,
          true, // Icono X no es un botón toggle
          () {
            setState(() {
              isExpanded = false;
            });
          },
        ),
      ],
    );
  }

  Widget buildExpandedButtonContainer(
    IconData icon,
    bool isActive,
    VoidCallback onTap,
  ) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.green : Colors.red,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
