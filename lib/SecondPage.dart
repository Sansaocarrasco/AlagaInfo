
import 'package:flutter/material.dart';
import 'package:alagainfo/ThirdPage.dart';

class SecondPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
  return Scaffold( 
    backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20), // Espaçamento entre o texto e a imagem
            Image(image: AssetImage('assets/images/Inicio-2.png')),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Text("Bem vindo ao AlagaInfo, seu aplicativo informativo sobre as regiões críticasde alagamento em Petrolina/PE. O objetivo do aplicativo é te informar se o local informado é uma região sucetível a alagamento",
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
                MaterialPageRoute(builder: (context) => ThirdPage()));
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