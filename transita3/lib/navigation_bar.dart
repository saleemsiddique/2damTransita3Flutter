import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transita3/generated/l10n.dart';
import 'package:transita3/screens/gestion_inc_pantalla.dart';
import 'package:transita3/screens/mapa_pantalla.dart';
import 'package:transita3/screens/perfil_pantalla.dart';
import 'package:transita3/screens/ajustes_pantalla.dart';
import 'package:transita3/services/Services.dart';
import 'package:transita3/widgets/Error_TokenExpired.dart';

class BottomNavigationBarProvider extends StatefulWidget {
  const BottomNavigationBarProvider({super.key});

  @override
  State<BottomNavigationBarProvider> createState() =>
      _BottomNavigationBarProviderState();
}

class _BottomNavigationBarProviderState
    extends State<BottomNavigationBarProvider> {
  int _selectedIndex = 0;
  final screens = [
    Mapa_pantalla(),
    GestionIncidenciasPage(),
  ];

  void _onItemTapped(int index) {
    final incidenciasService =
        Provider.of<IncidenciaService>(context, listen: false);
    if (index == 1) {
      try {
        incidenciasService.getIncidencias();
      } catch (error) {
        errorTokenExpired(context);
      }
    }

    setState(() {
      _selectedIndex = index;
    });
    print('Is open ${Mapa_pantalla.isBottomSheetOpen}');
    if (_selectedIndex == 1 && Mapa_pantalla.isBottomSheetOpen) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      appBar: _appBarr(),
      endDrawer: CustomEndDrawer(),
      body: Center(
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.only(bottom: 0),
              child: Icon(Icons.map_outlined, size: 30),
            ),
            label: '', // Establece el label como una cadena vacía
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.only(bottom: 0),
              child: Icon(Icons.report_problem_outlined, size: 30),
            ),
            label: '', // Establece el label como una cadena vacía
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }

  PreferredSizeWidget _appBarr() {
    return CustomAppBar(
      onLogoutPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            final incidenciasService =
                Provider.of<IncidenciaService>(context, listen: false);
            return AlertDialog(
              title: Text(S.of(context).logout),
              content: Text(S.of(context).confirmLogout),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(S.of(context).cancel),
                ),
                TextButton(
                  onPressed: () {
                    incidenciasService.incidenciasDeUsuario = [];
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  child: Text(S.of(context).accept),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogoutPressed;

  const CustomAppBar({Key? key, required this.onLogoutPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Transita'),
      leading: IconButton(
        icon: Icon(Icons.logout_sharp),
        onPressed: onLogoutPressed,
      ),
      actions: [
        IconButton(
          icon: CircleAvatar(
            foregroundImage: AssetImage('assets/perfil.png'),
          ),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CustomEndDrawer extends StatefulWidget {
  @override
  State<CustomEndDrawer> createState() => _CustomEndDrawerState();
}

class _CustomEndDrawerState extends State<CustomEndDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset('assets/transitaLogo.png'),
                ),
                SizedBox(
                  height: 10.0,
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Color.fromRGBO(41, 39, 39, 0.68),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(S.of(context).profile),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PerfilPantalla()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(S.of(context).settings),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AjustesPantalla()),
              );
            },
          ),
        ],
      ),
    );
  }
}
