// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutterservicios/models/estudiante.dart';
import 'package:http/io_client.dart';

class StudentsServices {
  //emulador
  static var url =
      Uri.parse("http://10.0.2.2/loro/javaApi/controllers/apiRest.php");
  //celular
  static var urlcelu =
      Uri.parse("http://10.79.5.223/loro/javaApi/controllers/apiRest.php");

  static getEstudiantes() async {
    try {
      HttpClient http = HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
      IOClient ioClient = IOClient(http);

      var response = await ioClient.get(url);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      }
    } catch (e) {
      print(e);
    }
  }

  static postEstudiante(Estudiante estudiante) async {
    try {
      HttpClient http = HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
      IOClient ioClient = IOClient(http);
      String jsonbody = jsonEncode(estudiante.toJson());
      print(jsonbody);
      var response = await ioClient.post(url,
          headers: {"Content-Type": "application/json"}, body: jsonbody);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  static deleteEstudiantes(String id) async {
    try {
      var urlid = Uri.parse("$url?cedula=$id");
      HttpClient http = HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
      IOClient ioClient = IOClient(http);

      var response = await ioClient
          .delete(urlid, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static putEstudiante(Estudiante estudiante) async {
    try {
      HttpClient http = HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
      IOClient ioClient = IOClient(http);
      String jsonbody = jsonEncode(estudiante.toJson());
      final putUrl = Uri.parse(
          "http://10.0.2.2/loro/javaApi/controllers/apiRest.php?cedula=${estudiante.cedula}&nombre=${estudiante.nombre}&apellido=${estudiante.apellido}&direccion=${estudiante.direccion}&telefono=${estudiante.telefono}");
      var response = await ioClient.put(putUrl,
          headers: {"Content-Type": "application/json"}, body: jsonbody);
      if (response.statusCode == 200) {
        await getEstudiantes();
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }
}
