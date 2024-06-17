// To parse this JSON data, do
//
//     final estudiante = estudianteFromJson(jsonString);

import 'dart:convert';

Estudiante estudianteFromJson(String str) => Estudiante.fromJson(json.decode(str));

String estudianteToJson(Estudiante data) => json.encode(data.toJson());

class Estudiante {
    final String cedula;
    final String nombre;
    final String apellido;
    final String direccion;
    final String telefono;

    Estudiante({
        required this.cedula,
        required this.nombre,
        required this.apellido,
        required this.direccion,
        required this.telefono,
    });

    factory Estudiante.fromJson(Map<String, dynamic> json) => Estudiante(
        cedula: json["cedula"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        direccion: json["direccion"],
        telefono: json["telefono"],
    );

    Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "nombre": nombre,
        "apellido": apellido,
        "direccion": direccion,
        "telefono": telefono,
    };
}