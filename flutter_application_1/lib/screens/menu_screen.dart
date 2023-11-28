import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/catalogo_main_screen.dart';
import 'package:flutter_application_1/screens/contacto_screen.dart';
import 'package:flutter_application_1/screens/inicio_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
        backgroundColor: Colors.black,
      ),
      body: Center(child: Text("Bienvenidos a auto parts")),
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
            child: Column(children: [
              Text("Auto Parts",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              Divider(),
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/images/fotoPerfil.jpg")),
                    border: Border.all(
                        width: 2.0, color: const Color.fromARGB(255, 0, 0, 0))),
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: Text(
                  "Manuel Perez",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ]),
          ),
          ListTile(
            title: Text("Inicio"),
            leading: Icon(
              MdiIcons.home,
              color: Colors.black,
            ),
            onTap: () => _navegar(context, 2),
          ),
          Divider(),
          ListTile(
            title: Text("Catalogo"),
            leading: Icon(
              MdiIcons.book,
              color: Colors.black,
            ),
            onTap: () => _navegar(context, 3),
          ),
          Divider(),
          ListTile(
            title: Text("Contacto"),
            leading: Icon(
              MdiIcons.accountMultiple,
              color: Colors.black,
            ),
            onTap: () => _navegar(context, 4),
          ),
          Divider(),
          ListTile(
            title: Text("Cerrar"),
            leading: Icon(
              MdiIcons.close,
              color: Colors.black,
            ),
            onTap: () => Navigator.pop(context),
          ),
        ],
      )),
    );
  }

  void _navegar(BuildContext context, int pagina) {
    List<Widget> paginas = [MenuScreen(), Inicio(), CatalogoMain(), Contacto()];
    final pageRouteBuilder = PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, animatioTime) {
          return paginas[pagina - 1];
        },
        transitionsBuilder: (context, animation, AnimationTime, child) {
          return SlideTransition(
            position: Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                .animate(animation),
            child: child,
          );
        });
    Navigator.push(context, pageRouteBuilder);
  }
}
