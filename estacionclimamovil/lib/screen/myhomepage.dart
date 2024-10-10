import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart' show rootBundle;

class WeatherData {
  final DateTime dateTime;
  final double temperature;

  WeatherData({
    required this.dateTime,
    required this.temperature,
  });

  @override
  String toString() {
    return 'Date: $dateTime, Temperature: $temperature';
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<WeatherData> weatherDataList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final String response = await rootBundle.loadString('asset/data.txt');
      final List<dynamic> data = json.decode(response);

      // Limpiar la lista antes de agregar nuevos datos
      weatherDataList.clear();
      
      for (var entry in data) {
        weatherDataList.add(
          WeatherData(
            dateTime: DateTime.parse(entry['DateTime']),
            temperature: entry['Temperature'],
          ),
        );
      }

      // Notificar a Flutter que los datos han cambiado
      setState(() {}); // Agregado para redibujar la UI con los nuevos datos

      // Imprimir los datos cargados
      print(weatherDataList.map((data) => data.toString()).toList());
    } catch (e) {
      print('Error loading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 48, 45, 45),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 245, 71, 3),
          leading: CircleAvatar(backgroundImage: AssetImage('asset/img/logo.png')),
          title: Center(
            child: Text('Weather', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.menu_sharp), onPressed: () {/* acción a realizar */}),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40),
              Text('Ensenada, Baja California', style: TextStyle(fontSize: 24, color: Colors.white)),
              Image.asset('asset/img/movil.png', fit: BoxFit.contain),
              Text('Cloudy', style: TextStyle(fontSize: 20, color: Colors.white)),
              SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  SizedBox(width: 65),
                  Column(
                    children: [
                      Image.asset(
                        'asset/img/humedad1.png',
                        width: 30,
                        height: 30,
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
                  SizedBox(width: 20),
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
              SizedBox(height: 10),
              Container(
                height: 150,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      WeatherDay(title: 'Today', subtitle: '19 | 8'),
                      WeatherDay(title: 'Monday', subtitle: '19 | 8'),
                      WeatherDay(title: 'Tuesday', subtitle: '19 | 8'),
                      WeatherDay(title: 'Wednesday', subtitle: '19 | 8'),
                      WeatherDay(title: 'Thursday', subtitle: '19 | 8'),
                      WeatherDay(title: 'Friday', subtitle: '19 | 8'),
                    ],
                  ),
                ),
              ),
              // Sección para mostrar la gráfica
              SizedBox(height: 20),
              weatherDataList.isNotEmpty
                  ? Container(
                      height: 200,
                      padding: EdgeInsets.all(10),
                      child: LineChart(
                        LineChartData(
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,getTitlesWidget: (value, meta) {
                                      return Text(
                                        value.toString(),
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 48, 45, 45), // Cambia el color de los números del eje izquierdo
                                          fontSize: 14,
                                        ),
                                      );
                                    },)),
                            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toString(),
                                    style: TextStyle(
                                      color: Colors.white, // Cambia el color de los números del eje inferior
                                      fontSize: 14,
                                    ),
                                  );
                                },)),
                                topTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          return Text(
            value.toString(),
            style: TextStyle(
              color: Color.fromARGB(255, 48, 45, 45), // 
              fontSize: 14,
            ),
          );
        },
      ),
    ),
    rightTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          return Text(
            value.toString(),
            style: TextStyle(
              color: Colors.white, // Color de los números del eje derecho
              fontSize: 14,
            ),
          );
        },
      ),
    ),
                          ),
                          borderData: FlBorderData(show: true),
                          lineBarsData: [
                            LineChartBarData(
                              spots: weatherDataList
                                  .asMap()
                                  .entries
                                  .map((e) => FlSpot(e.key.toDouble(), e.value.temperature))
                                  .toList(),
                              isCurved: true,
                              color: Colors.red,
                              barWidth: 2,
                              gradient: LinearGradient(
                                    colors: [
                                      Colors.blue,  // Color inicial
                                      Colors.purple, // Color final
                                    ],)
                            ),
                          ],                          
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
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

class WeatherDay extends StatelessWidget {
  final String title;
  final String subtitle;

  const WeatherDay({
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
