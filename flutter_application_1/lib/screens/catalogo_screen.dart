import 'package:flutter/material.dart';

class Catalogo extends StatefulWidget {
  const Catalogo({Key? key}) : super(key: key);

  @override
  State<Catalogo> createState() => _CatalogoState();
}

class _CatalogoState extends State<Catalogo> {
  List<Producto> productos = [];
  late List<String> categorias;
  String categoriaSeleccionada = "Todas";

  @override
  void initState() {
    super.initState();
    cargarProductos();
  }

  Future<void> cargarProductos() async {
    // Aquí deberías obtener los productos desde tu fuente de datos, por ejemplo, una API
    // productos = await obtenerProductosDesdeAPI();

    // Mientras tanto, uso datos de ejemplo
    productos = [
      Producto("Bujía", "assets/images/bujia.jpg", "Categoria1"),
      // ... Agrega más productos con información de categoría
    ];

    // Extrae automáticamente las categorías de los productos
    categorias = obtenerCategorias(productos);

    setState(() {});
  }

  List<String> obtenerCategorias(List<Producto> productos) {
    Set<String> categoriasSet = Set();
    for (var producto in productos) {
      categoriasSet.add(producto.categoria);
    }
    return ["Todas", ...categoriasSet.toList()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Catálogo",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DropdownButton<String>(
            value: categoriaSeleccionada,
            onChanged: (String? nuevaCategoria) {
              setState(() {
                categoriaSeleccionada = nuevaCategoria!;
              });
            },
            items: categorias.map((String categoria) {
              return DropdownMenuItem<String>(
                value: categoria,
                child: Text(categoria),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          // Aquí puedes mostrar los productos si lo necesitas
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: productos.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(productos[index].photoPath),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Producto {
  final String nombre;
  final String photoPath;
  final String categoria;

  Producto(this.nombre, this.photoPath, this.categoria);
}
