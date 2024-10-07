import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      home: Scaffold(
        backgroundColor:  const Color.fromARGB(255, 48, 45, 45),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 245, 71, 3),
          leading: const CircleAvatar(),
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
            Stack(alignment: Alignment.topCenter,
            children: [
              Text('8',style: TextStyle(fontSize: 100,fontWeight: FontWeight.normal, color: Colors.white),),
              Positioned(
                top: 8,
              right: 0,
              child: Text('°C',style: TextStyle(fontSize: 20, color: Colors.white),),)
            ],),
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

