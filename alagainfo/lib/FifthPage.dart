import 'package:alagainfo/main.dart';
import 'package:flutter/material.dart';

class FifthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
  return Scaffold( 
    backgroundColor: const Color.fromARGB(255, 91, 173, 240),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40), // Espaçamento entre o texto e a imagem
            //Image(image: AssetImage('images/Inicio-4.png')),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: Text("Mapa Informativo"),
              ),
           ElevatedButton(
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: Text("Quem somos"),
              ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: Text("Legislações Ambientais"),
              )
          ],
        ),
      ),
    );
  }
}