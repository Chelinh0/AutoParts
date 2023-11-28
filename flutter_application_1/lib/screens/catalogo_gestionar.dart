import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/categorias/categorias.dart';
import 'package:flutter_application_1/screens/productos/productos.dart';

class CatalogoGestionar extends StatelessWidget {
  const CatalogoGestionar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.black,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'Categorías',
                  ),
                  Tab(
                    text: 'Productos',
                  )
                ],
              )),
          body: TabBarView(children: [CategoriasScreen(), ProductosScreen()]),
        ));
  }
}
