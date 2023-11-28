import 'package:flutter/material.dart';

class Contacto extends StatefulWidget {
  const Contacto({Key? key}) : super(key: key);

  @override
  State<Contacto> createState() => _ContactoState();
}

class _ContactoState extends State<Contacto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Contacto"),
        centerTitle: true,
      ),
      body: ContactoForm(),
    );
  }
}

class ContactoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Contacto",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          ContactInputField(label: "Nombre"),
          SizedBox(height: 16),
          ContactInputField(label: "Email"),
          SizedBox(height: 16),
          ContactInputField(label: "Descripción", maxLines: 5),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Aquí puedes agregar la lógica para enviar el formulario o datos de contacto.
              // Por ahora, solo imprimo los valores en la consola.
              print(
                  "Nombre: ${ContactInputFieldController.nameController.text}");
              print(
                  "Email: ${ContactInputFieldController.emailController.text}");
              print(
                  "Descripción: ${ContactInputFieldController.descriptionController.text}");
            },
            child: Text("Enviar"),
          ),
        ],
      ),
    );
  }
}

class ContactInputField extends StatelessWidget {
  final String label;
  final int maxLines;

  ContactInputField({required this.label, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextField(
          controller: label == "Nombre"
              ? ContactInputFieldController.nameController
              : label == "Email"
                  ? ContactInputFieldController.emailController
                  : ContactInputFieldController.descriptionController,
          maxLines: maxLines,
        ),
      ],
    );
  }
}

class ContactInputFieldController {
  static final nameController = TextEditingController();
  static final emailController = TextEditingController();
  static final descriptionController = TextEditingController();
}
