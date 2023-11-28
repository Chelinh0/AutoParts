import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RepuestosProvider {
  final String apiUrl = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> getCategorias() async {
    var url = Uri.parse('$apiUrl/categorias');
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>> categoriasAgregar(
      String nombreCategoria) async {
    var uri = Uri.parse('$apiUrl/categorias');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
        'Accept': 'application/post',
      },
      body: jsonEncode(
        <String, String>{'nombre': nombreCategoria},
      ),
    );
    return json.decode(respuesta.body);
  }

  Future<bool> categoriasBorrar(int id) async {
    var uri = Uri.parse('$apiUrl/categorias/$id');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  Future<LinkedHashMap<String, dynamic>> categoriasEditar(
      int id, String nombreCategoria) async {
    var uri = Uri.parse('$apiUrl/categorias/$id');
    var respuesta = await http.put(
      uri,
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
        'Accept': 'application/post',
      },
      body: jsonEncode(
        <String, String>{'nombre': nombreCategoria},
      ),
    );
    return json.decode(respuesta.body);
  }

  Future<List<dynamic>> getProductos() async {
    var url = Uri.parse('$apiUrl/productos');
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>> getProducto(String codProducto) async {
    var url = Uri.parse('$apiUrl/productos/$codProducto');
    var respuesta = await http.get(url);

    return json.decode(respuesta.body);
  }

  Future<bool> productosBorrar(String codProducto) async {
    var uri = Uri.parse('$apiUrl/productos/$codProducto');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  Future<LinkedHashMap<String, dynamic>> productosAgregar(
    String nombre,
    String descripcion,
    double precio,
    int categoriaId,
  ) async {
    var uri = Uri.parse('$apiUrl/productos');
    var respuesta = await http.post(
      uri,
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
        'Accept': 'application/post',
      },
      body: jsonEncode(
        <String, dynamic>{
          'nombre': nombre,
          'descripcion': descripcion,
          'precio': precio,
          'categoria_id': categoriaId,
        },
      ),
    );
    return json.decode(respuesta.body);
  }
}
