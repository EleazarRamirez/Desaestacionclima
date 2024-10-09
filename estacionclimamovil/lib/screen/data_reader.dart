import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<List<double>> readDataFromTxt() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/assets/docs/otro.TXT');  // Asegúrate de que el archivo esté en este directorio o lo cargues manualmente
    List<String> lines = await file.readAsLines();  // Leer líneas del archivo
    return lines.map((line) => double.parse(line)).toList();  // Convertir las líneas en valores numéricos
  } catch (e) {
    print("Error al leer el archivo: $e");
    return [];
  }
}
