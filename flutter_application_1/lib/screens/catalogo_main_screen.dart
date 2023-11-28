import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/catalogo_gestionar.dart';
import 'package:flutter_application_1/screens/catalogo_screen.dart';

class CatalogoMain extends StatelessWidget {
  const CatalogoMain({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Catálogo de Productos'),
          backgroundColor: Colors.black,
          bottom: TabBar(tabs: [
            Tab(
              text: 'Clientes',
            ),
            Tab(
              text: 'Gestionar',
            )
          ]),
        ),
        body: TabBarView(children: [Catalogo(), CatalogoGestionar()]),
      ),
    );
  }
}
