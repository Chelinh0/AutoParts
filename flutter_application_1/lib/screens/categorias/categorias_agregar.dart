// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously
import 'package:flutter_application_1/providers/repuestos_providers.dart';
import 'package:flutter/material.dart';

class CategoriasAgregar extends StatefulWidget {
  const CategoriasAgregar({super.key});

  @override
  State<CategoriasAgregar> createState() => _CategoriasAgregarState();
}

class _CategoriasAgregarState extends State<CategoriasAgregar> {
  TextEditingController nombreController = TextEditingController();
  String textoError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF006D97),
        title: Text('Agregar Categoría'),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre de la categoría',
                hintText: 'Ingrese nombre para la categoría',
              ),
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
                ),
                child: Text('Guardar Categoría'),
                onPressed: () async {
                  RepuestosProvider provider = RepuestosProvider();
                  var respuesta =
                      await provider.categoriasAgregar(nombreController.text);
                  if (respuesta['message'] != null) {
                    setState(() {
                      textoError = respuesta['errors']['nombre'][0];
                    });
                    showSnackbar(context, textoError);
                  } else {
                    Navigator.pop(context);
                  }

                  //Validaciones
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(mensaje),
      ),
    );
  }
}
