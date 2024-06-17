// ignore: file_names
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutterservicios/models/estudiante.dart';
import 'package:flutterservicios/services/students_services.dart';
import 'package:flutterservicios/views/homepage.dart';

class FormularioEditar extends StatefulWidget {
  final Estudiante student;
  const FormularioEditar({super.key, required this.student});

  @override
  State<FormularioEditar> createState() =>
      _FormularioEditarState(student: student);
}

class _FormularioEditarState extends State<FormularioEditar> {
  final Estudiante student;
  final _formKey = GlobalKey<FormState>();
  final _cedulaKey = TextEditingController();
  final _nombreKey = TextEditingController();
  final _apellidoKey = TextEditingController();
  final _direccionKey = TextEditingController();
  final _telefonoKey = TextEditingController();

  _FormularioEditarState({required this.student}) {
    _cedulaKey.text = student.cedula;
    _nombreKey.text = student.nombre;
    _apellidoKey.text = student.apellido;
    _direccionKey.text = student.direccion;
    _telefonoKey.text = student.telefono;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar estudiante"),
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
                enabled: false,
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

                      StudentsServices.putEstudiante(est).then((success) {
                        if (success) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Homepage()));
                        }
                      });
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
