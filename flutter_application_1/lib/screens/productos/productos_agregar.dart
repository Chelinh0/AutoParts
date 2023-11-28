// ignore_for_file: prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter_application_1/providers/repuestos_providers.dart';
import 'package:flutter/material.dart';

class ProductosAgregar extends StatefulWidget {
  const ProductosAgregar({Key? key}) : super(key: key);

  @override
  State<ProductosAgregar> createState() => _ProductosAgregarState();
}

class _ProductosAgregarState extends State<ProductosAgregar> {
  RepuestosProvider provider = RepuestosProvider();
  List<dynamic> categorias = [];
  bool isLoading = true;
  dynamic selectedCategoria;

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController precioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadCategorias();
  }

  void loadCategorias() async {
    try {
      List<dynamic> categoriasList = await provider.getCategorias();
      setState(() {
        categorias = categoriasList;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Producto'),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Ingrese Nombre'),
              ),
              TextField(
                controller: descripcionController,
                decoration: InputDecoration(labelText: 'Ingrese Descripción'),
              ),
              TextField(
                controller: precioController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Ingrese Precio \$'),
              ),
              Container(
                margin: EdgeInsets.only(top: 16),
                width: double.infinity,
                height: 60,
                child: DropdownButton(
                  hint: Text('Categoría'),
                  isExpanded: true,
                  items: categorias.map<DropdownMenuItem<dynamic>>(
                    (categoria) {
                      return DropdownMenuItem<dynamic>(
                        child: Text(categoria['nombre']),
                        value: categoria,
                      );
                    },
                  ).toList(),
                  onChanged: (dynamic categoria) {
                    setState(() {
                      selectedCategoria = categoria;
                    });
                    // Aquí puedes manejar la categoría seleccionada
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                selectedCategoria != null
                    ? 'Categoría seleccionada: ${selectedCategoria['nombre']}'
                    : 'No se ha seleccionado ninguna categoría',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xFF012534)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () async {
            bool productoAgregado = await agregarProducto();
            if (productoAgregado) {
              setState(() {});
              Navigator.pop(context);
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('Agregar', style: TextStyle(fontSize: 16)),
          ),
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

  Future<bool> agregarProducto() async {
    if (nombreController.text.isEmpty ||
        descripcionController.text.isEmpty ||
        precioController.text.isEmpty ||
        selectedCategoria == null) {
      // Validaciones adicionales, por ejemplo, asegurarse de que los campos no estén vacíos
      return false;
    }

    RepuestosProvider provider = RepuestosProvider();
    var respuesta = await provider.productosAgregar(
      nombreController.text,
      descripcionController.text,
      double.parse(precioController.text),
      selectedCategoria['id'],
    );

    if (respuesta['message'] != null) {
      showSnackbar(context, respuesta['errors']['nombre'][0]);
      return false;
    } else {
      return true;
    }
  }
}
