import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        fontFamily: 'Monserrat'
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor:  const Color.fromARGB(255, 48, 45, 45),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 245, 71, 3),
          leading:  CircleAvatar(backgroundImage: AssetImage('assets/img/logo.png',)),
          title: Center(child: Text('Weather', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),),
          actions: <Widget>[IconButton( icon: Icon(Icons.menu_sharp), onPressed: (){/*accion a realizar*/},)],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            SizedBox(height: 40,),
            Text('Ensenada, Baja California',
            style: TextStyle(fontSize: 24, color: Colors.white),),
            Image.asset('assets/img/movil.png',fit: BoxFit.contain, ),
            Text('Cloudy',style: TextStyle(fontSize: 20, color: Colors.white)),
            SizedBox(height: 16,),
             Row(
              mainAxisAlignment: MainAxisAlignment.center, // Centrar los elementos en la fila
              crossAxisAlignment: CrossAxisAlignment.start, // Alinear el °C con la parte superior del número
              children: [
                Stack(
                  children: [
                    // Número grande de temperatura
                    Text(
                      '8',
                      style: TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                    // °C posicionado en la parte superior derecha del número
                    Positioned(
                      top: 0,
                      right: 8, // Ajusta la posición del °C
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
                SizedBox(width: 60), // Espacio entre la temperatura y la humedad
                Column(
                  children: [
                    // Ícono de humedad
                    Image.asset('assets/img/humedad1.jpg', // Ruta a la imagen del ícono de humedad
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 8), // Espacio entre el ícono y el texto
                    // Texto para la humedad
                    Text(
                      '58%',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    // Texto "Humidity"
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
            SizedBox(height: 16), // Espacio entre la temperatura y la hora
            // Texto para la fecha y la hora
            Text(
              'Today, 5:40 am',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            Container(
                  height: 200, // Altura de los elementos de la lista horizontal
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal, // Hace que la lista sea horizontal
                    child: Row(
                      children: [
                       weaterday(title: 'Today',subtitle: '19 | 8',),
                       weaterday(title: 'Monday',subtitle: '19 | 8',),
                       weaterday(title: 'Thusday',subtitle: '19 | 8',),
                       weaterday(title: 'Wednesday',subtitle: '19 | 8',),
                       weaterday(title: 'Thursday',subtitle: '19 | 8',),
                       weaterday(title: 'Friday',subtitle: '19 | 8',),
                      ]
                      // Ejemplo de 
                      //varios elementos dentro de la lista horizontal
                  ),),)
          ],
          ),
          )
          
        ),
        bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Fijar el estilo de la barra
        backgroundColor: Color(0xFF302D2D), // Color de fondo de la barra
        selectedItemColor: Colors.red, // Color del ítem seleccionado
        unselectedItemColor: Colors.white, // Color de los ítems no seleccionados
        
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
         Text(title,style: TextStyle(fontSize: 24,color: const Color.fromARGB(99, 255, 255, 255))),
         Image.network('https://imgs.search.brave.com/Q50IFja_65Z9mDTFLeSQ96a3mTVwJc1D_WVod2BvbCI/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/aWNvbi1pY29ucy5j/b20vaWNvbnMyLzEz/NzAvUE5HLzk2L2lm/LXdlYXRoZXItMy0y/NjgyODQ4XzkwNzg1/LnBuZw'),
         Text(subtitle, style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,color: Colors.white),)
       ],
     ),
                          );
  }
}

