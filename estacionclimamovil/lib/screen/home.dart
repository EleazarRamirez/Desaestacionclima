import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart'; // Para leer archivos en almacenamiento local

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<double> data = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Función para leer datos de un archivo .txt
  Future<void> _loadData() async {
    List<double> loadedData = await readDataFromTxt();  // Llamamos la función para cargar datos
    setState(() {
      data = loadedData;
    });
  }

  // Función para leer el archivo .txt
  Future<List<double>> readDataFromTxt() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data.txt');  // Cambia la ruta si lo guardas en otro lado
      List<String> lines = await file.readAsLines();  // Leer líneas del archivo
      return lines.map((line) => double.parse(line)).toList();  // Convertir las líneas en valores numéricos
    } catch (e) {
      print("Error al leer el archivo: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Monserrat'
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 48, 45, 45),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 245, 71, 3),
          leading: CircleAvatar(backgroundImage: AssetImage('assets/img/logo.png')),
          title: Center(child: Text('Weather', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))),
          actions: <Widget>[IconButton(icon: Icon(Icons.menu_sharp), onPressed: () {/* acción a realizar */},)],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              Text('Ensenada, Baja California', style: TextStyle(fontSize: 24, color: Colors.white)),
              Image.asset('assets/img/movil.png', fit: BoxFit.contain),
              Text('Cloudy', style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Text(
                        '8',
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 8,
                        child: Text(
                          '°C',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 60),
                  Column(
                    children: [
                      Image.asset(
                        'assets/img/humedad1.jpg', 
                        width: 40,
                        height: 40,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 8),
                      Text(
                        '58%',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Humidity',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Today, 5:40 am',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              // Aquí añadimos la gráfica
              Container(
                height: 300,
                padding: EdgeInsets.all(16),
                child: data.isEmpty
                    ? CircularProgressIndicator()
                    : LineChartSample(data: data),
              ),
              Container(
                height: 200, 
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      weaterday(title: 'Today', subtitle: '19 | 8'),
                      weaterday(title: 'Monday', subtitle: '19 | 8'),
                      weaterday(title: 'Tuesday', subtitle: '19 | 8'),
                      weaterday(title: 'Wednesday', subtitle: '19 | 8'),
                      weaterday(title: 'Thursday', subtitle: '19 | 8'),
                      weaterday(title: 'Friday', subtitle: '19 | 8'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF302D2D),
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Locations',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Analysis',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class weaterday extends StatelessWidget {
  final String title;
  final String subtitle;
  const weaterday({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(136, 36, 33, 33),
      width: 130,
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 24, color: const Color.fromARGB(99, 255, 255, 255))),
          Icon(Icons.wb_sunny, size: 80.0, color: Colors.yellow),
          Text(subtitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white)),
        ],
      ),
    );
  }
}

class LineChartSample extends StatelessWidget {
  final List<double> data;

  LineChartSample({required this.data});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: data
                .asMap()
                .entries
                .map((e) => FlSpot(e.key.toDouble(), e.value))
                .toList(),
            isCurved: true,
            color: Colors.blue,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.2)),
          ),
        ],
        titlesData: FlTitlesData(show: true),
        gridData: FlGridData(show: false),
      ),
    );
  }
}
