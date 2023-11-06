import 'package:flutter/material.dart';
import 'package:transita3/screens/gestion_inc_pantalla.dart';
import 'package:transita3/screens/mapa_pantalla.dart';

class BottomNavigationBarProvider extends StatefulWidget {
  const BottomNavigationBarProvider({super.key});

  @override
  State<BottomNavigationBarProvider> createState() =>
      _BottomNavigationBarProviderState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _BottomNavigationBarProviderState
    extends State<BottomNavigationBarProvider> {
  int _selectedIndex = 0;
  final screens = [
    Mapa_pantalla(),
    GestionIncidenciasPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      key: _scaffoldKey,
      appBar: _appBarr(),
      endDrawer: Drawer(
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
              title: Text('Perfil'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Ajustes'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'GPS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report_problem_outlined),
            label: 'Incidencias',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        onTap: _onItemTapped,
      ),
    );
  }

  PreferredSizeWidget _appBarr() {
    return AppBar(
      title: Text('Transita'),
      leading: IconButton(
        icon: Icon(Icons.logout_sharp),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Cerrar sesión'),
                  content: Text('¿Estás seguro de que quieres cerrar sesión'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Aceptar'),
                    ),
                  ],
                );
              });
        },
      ),
      actions: [
        IconButton(
          icon: CircleAvatar(
            foregroundImage: AssetImage('assets/perfil.png'),
          ),
          onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
        ),
      ],
    );
  }
}
