// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/firestore-services.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({super.key});

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: FirestoreService().Categorias(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.separated(
                separatorBuilder: (_,__) => Divider(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  var categoria = snapshot.data!.docs[index];
                  return ListTile(
                    leading: Icon(MdiIcons.label),
                    title: Text('${categoria['nombre']}'),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
