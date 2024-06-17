import 'package:flutter/material.dart';
import 'package:flutterservicios/models/estudiante.dart';
import 'package:flutterservicios/services/students_services.dart';
import 'package:flutterservicios/views/formularioEstudiante.dart';
import 'package:flutterservicios/views/formularioeditar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late List<Estudiante> estudiantes;
  late List<Estudiante> estudiantesFiltrados;

  @override
  void initState() {
    super.initState();
    estudiantesFiltrados = [];
    cargarEstudiantes();
  }

  Future<void> cargarEstudiantes() async {
    List<dynamic> data = await StudentsServices.getEstudiantes();
    setState(() {
      estudiantes =
          data.map<Estudiante>((item) => Estudiante.fromJson(item)).toList();
      estudiantesFiltrados = estudiantes;
    });
  }

  void eliminarEstudiante(int index) async {
    final result =
        await StudentsServices.deleteEstudiantes(estudiantes[index].cedula);
    if (result) {
      setState(() {
        estudiantes.removeAt(index);
      });
    }
  }

  void filtrarEstudiantes(String query) {
    List<Estudiante> resultados = estudiantes
        .where((estudiante) =>
            estudiante.cedula.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      estudiantesFiltrados = resultados;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estudiantes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: filtrarEstudiantes,
              decoration: const InputDecoration(
                hintText: 'Buscar estudiante...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: estudiantesFiltrados.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Cedula: ${estudiantesFiltrados[index].cedula}'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(
                            'Nombre: ${estudiantesFiltrados[index].nombre}'
                            '\nApellido: ${estudiantesFiltrados[index].apellido}'
                            '\nDireccion: ${estudiantesFiltrados[index].direccion}'
                            '\nTelefono: ${estudiantesFiltrados[index].telefono}',
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FormularioEditar(
                                      student: estudiantesFiltrados[index],
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Editar'),
                            ),
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                eliminarEstudiante(index);
                              },
                              child: const Text(
                                'Eliminar',
                                style: TextStyle(color: Colors.red),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Formulario(),
            ),
          );
          if (result == true) {
            cargarEstudiantes();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
