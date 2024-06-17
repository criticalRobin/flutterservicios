// ignore: file_names
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutterservicios/models/estudiante.dart';
import 'package:flutterservicios/services/students_services.dart';

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();
  final _cedulaKey = TextEditingController();
  final _nombreKey = TextEditingController();
  final _apellidoKey = TextEditingController();
  final _direccionKey = TextEditingController();
  final _telefonoKey = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingresar estudiante"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _cedulaKey,
                decoration: InputDecoration(labelText: 'Ingrese la cedula'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una cedula';
                  }
                  if (value.length != 10) {
                    return 'La cedula debe contener 10 digito';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nombreKey,
                decoration: InputDecoration(labelText: 'Ingrese el nombre'),
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                controller: _apellidoKey,
                decoration: InputDecoration(labelText: 'Ingrese el apellido'),
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                controller: _direccionKey,
                decoration: InputDecoration(labelText: 'Ingrese la direccion'),
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                controller: _telefonoKey,
                decoration: InputDecoration(labelText: 'Ingrese el telefono'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Estudiante est = Estudiante(
                          cedula: _cedulaKey.text,
                          nombre: _nombreKey.text,
                          apellido: _apellidoKey.text,
                          direccion: _direccionKey.text,
                          telefono: _telefonoKey.text);
                      Navigator.pop(
                          context, StudentsServices.postEstudiante(est));
                    }
                  },
                  child: Text('Guardar'))
            ],
          ),
        ),
      ),
    );
  }
}
