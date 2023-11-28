// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations

import 'package:flutter_application_1/providers/repuestos_providers.dart';
import 'package:flutter_application_1/screens/productos/productos_agregar.dart';
import 'package:flutter_application_1/screens/productos/productos_editar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:intl/intl.dart';

class ProductosScreen extends StatefulWidget {
  const ProductosScreen({super.key});

  @override
  State<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  RepuestosProvider provider = RepuestosProvider();
  var fPrecio =
      NumberFormat.currency(decimalDigits: 0, locale: 'es_cl', symbol: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: provider.getProductos(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return DataTable(
                    columns: [
                      DataColumn(label: Text('Detalles')),
                      DataColumn(label: Text('Producto')),
                      DataColumn(label: Text('Precio'), numeric: true),
                    ],
                    rows: snapshot.data.map<DataRow>((producto) {
                      return DataRow(cells: [
                        DataCell(
                          OutlinedButton(
                            child: Icon(
                              MdiIcons.carInfo,
                              color: Color(0xFF012534),
                            ),
                            onPressed: () {
                              MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => ProductosDetalle(
                                      codProducto: producto['cod_producto']));
                              Navigator.push(context, route).then((value) {
                                setState(() {});
                              });
                            },
                          ),
                        ),
                        DataCell(Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              producto['nombre'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${producto['categoria'] != null ? '${producto['categoria']['nombre']}' : 'Sin categoría'}',
                            ),
                          ],
                        )),
                        DataCell(Text('\$' +
                            fPrecio.format(producto['precio']).toString())),
                      ]);
                    }).toList());
              },
            ),
          )),
      floatingActionButton: FloatingActionButton(
        child: Icon(MdiIcons.archivePlus),
        backgroundColor: Color(0xFF012534),
        onPressed: () async {
          // Espera hasta que se complete la operación de agregar productos
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductosAgregar(),
            ),
          );
          setState(() {});
        },
      ),
    );
  }
}
