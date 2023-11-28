// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter_application_1/providers/repuestos_providers.dart';
import 'package:flutter_application_1/screens/categorias/categorias_agregar.dart';
import 'package:flutter_application_1/screens/categorias/categorias_editar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  @override
  Widget build(BuildContext context) {
    RepuestosProvider provider = RepuestosProvider();
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
              future: provider.getCategorias(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                    separatorBuilder: (_, __) => Divider(
                          color: Colors.black,
                        ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                        child: ListTile(
                          leading: Icon(MdiIcons.archive),
                          iconColor: Color(0xFF012534),
                          title: Text(snapshot.data[index]['nombre'],
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        startActionPane:
                            ActionPane(motion: ScrollMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {
                              MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => CategoriasEditar(
                                        id: snapshot.data[index]['id'],
                                        nombre: snapshot.data[index]['nombre'],
                                      ));
                              Navigator.push(context, route).then((value) {
                                setState(() {});
                              });
                            },
                            backgroundColor: Colors.green,
                            icon: MdiIcons.archiveEdit,
                            label: "Editar",
                          ),
                        ]),
                        endActionPane:
                            ActionPane(motion: ScrollMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {
                              var nombre = snapshot.data[index]['nombre'];
                              setState(() {
                                provider
                                    .categoriasBorrar(
                                        snapshot.data[index]['id'])
                                    .then((borradoExitoso) {
                                  if (!borradoExitoso) {
                                    showSnackbar(
                                        'Ha ocurrido un problema al eliminar.');
                                  } else {
                                    showSnackbar(
                                        'Categoría <$nombre> ha sido eliminada.');
                                    snapshot.data.removeAt(index);
                                  }
                                });
                              });
                            },
                            backgroundColor: Colors.red,
                            icon: MdiIcons.archiveMinus,
                            label: "Borrar",
                          )
                        ]),
                      );
                    });
              }),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Color(0xFF012534), // Cambia el color de fondo del botón
              foregroundColor:
                  Colors.white, // Cambia el color del texto del botón
            ),
            child: Text('Agregar Categoría'),
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => CategoriasAgregar(),
              );
              Navigator.push(context, route).then(
                (value) {
                  setState(() {});
                },
              );
            },
          ),
        )
      ],
    );
  }

  void showSnackbar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(mensaje),
      ),
    );
  }
}
