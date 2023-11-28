// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter_application_1/providers/repuestos_providers.dart';
import 'package:flutter/material.dart';

class CategoriasEditar extends StatefulWidget {
  final int id;
  final String nombre;

  const CategoriasEditar({super.key, this.id = 0, this.nombre = ""});

  @override
  State<CategoriasEditar> createState() => _CategoriasEditarState();
}

class _CategoriasEditarState extends State<CategoriasEditar> {
  TextEditingController nombreController = TextEditingController();
  String textoError = '';
  @override
  void initState() {
    super.initState();
    nombreController.text = widget.nombre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text('Editar Categoría'),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(
                  labelText: 'Nombre de la categoría',
                  hintText: 'Ingrese nombre para la categoría'),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                textoError,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF012534),
                    foregroundColor: Colors.white),
                child: Text('Guardar Cambios'),
                onPressed: () async {
                  RepuestosProvider provider = RepuestosProvider();
                  var respuesta = await provider.categoriasEditar(
                      widget.id, nombreController.text);
                  Navigator.pop(context);

                  //Validaciones
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
