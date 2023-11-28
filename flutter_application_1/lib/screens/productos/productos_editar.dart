// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter_application_1/providers/repuestos_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:intl/intl.dart';

class ProductosDetalle extends StatefulWidget {
  final String codProducto;
  const ProductosDetalle({super.key, this.codProducto = ""});

  @override
  State<ProductosDetalle> createState() => _ProductosDetalleState();
}

class _ProductosDetalleState extends State<ProductosDetalle> {
  RepuestosProvider provider = RepuestosProvider();
  var fPrecio =
      NumberFormat.currency(decimalDigits: 0, locale: 'es_cl', symbol: '');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: FutureBuilder(
            future: provider.getProducto(widget.codProducto),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var producto = snapshot.data;
              return Container(
                margin: EdgeInsets.only(top: 20),
                child: Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(MdiIcons.carInfo),
                        title: Text('Info: ${producto['nombre']}',
                            style: TextStyle(fontSize: 18)),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Codigo: ${producto['cod_producto']}'),
                              Text(
                                  'Auto: ${producto['categoria'] == null ? 'sin categoria' : producto['categoria']['nombre']}'),
                              Text('Descripción: ${producto['descripcion']}')
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Color(0xFF006D97),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Precio \$',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                                children: [
                                  TextSpan(
                                    text: fPrecio.format(producto['precio']),
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(MdiIcons.trashCan),
                              Text('   Eliminar')
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          onPressed: () async {
                            await provider.productosBorrar(widget.codProducto);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
