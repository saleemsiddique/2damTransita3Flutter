import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:transita3/services/Services.dart';
import 'package:transita3/widgets/Error_TokenExpired.dart';

class BotonFiltro extends StatefulWidget {
  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<BotonFiltro> {
  bool isIncidentActive = true;
  bool isAccessibleActive = false;
  bool isFavoriteActive = true;
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
        buildExpandedButtonContainer(
          Icons.accessibility,
          isAccessibleActive,
          () async {
            try {
              setState(() {
                isAccessibleActive = !isAccessibleActive;
                if (isIncidentActive) {
                  isIncidentActive = !isIncidentActive;
                }
              });
              if (isAccessibleActive) {
                // Llamar a la función getPuntosForMapFiltered del servicio
                await puntosService.getPuntosForMapFiltered();
              } else {
                // Llamar a la función clearAccesiblesMap del servicio
                puntosService.clearAccesiblesMap();
              }
            } catch (error) {
              // Mostrar un aviso en caso de error
              errorTokenExpired(context);
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        buildExpandedButtonContainer(
          Icons.accessible_outlined,
          isIncidentActive,
          () async {
            try {
              setState(() {
                isIncidentActive = !isIncidentActive;
                if (isAccessibleActive) {
                  isAccessibleActive = !isAccessibleActive;
                }
              });
              if (isIncidentActive) {
                // Llamar a la función getPuntosForMap del servicio
                await puntosService.getPuntosForMap();
              } else {
                // Llamar a la función clearIncidencesMap del servicio
                puntosService.clearIncidencesMap();
              }
            } catch (error) {
              // Mostrar un aviso en caso de error
              errorTokenExpired(context);
            }
          },
        ),
        SizedBox(
          height: 10,
        ),
        buildExpandedButtonContainer(
          Icons.favorite,
          isFavoriteActive,
          () async {
            try {
              setState(() {
                isFavoriteActive = !isFavoriteActive;
              });
              if (isFavoriteActive) {
                // Llamar a la función getPuntosByIdCliente del servicio
                await puntosService
                    .getPuntosByIdCliente(LoginService.cliente.id);
              } else {
                // Llamar a la función clearFavsMap del servicio
                puntosService.clearFavsMap();
              }
            } catch (error) {
              // Mostrar un aviso en caso de error
              errorTokenExpired(context);
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
