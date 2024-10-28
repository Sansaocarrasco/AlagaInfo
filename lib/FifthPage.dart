import 'package:flutter/material.dart';
import 'package:alagainfo/MapScreen.dart';

class FifthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
  return Scaffold( 
    backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20), // Espaçamento entre o texto e a imagem
            Image(image: AssetImage('images/Inicio-4.png')),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Text("Por fim, observe as informações a cerca da localidade desejada. As cores referentes as regiões informam a vúlnerabilidade do local.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,),
                ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(0),
              ),
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => MapScreen()));
              },
              child: Icon(Icons.arrow_circle_right_outlined,
              color: Colors.black,
              size: 40, 
              ),
              
              )
          ],
        ),
      ),
    );
  }
}