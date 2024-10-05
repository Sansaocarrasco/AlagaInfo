import 'package:flutter/material.dart';
import 'package:alagainfo/FifthPage.dart';

class FouthPage extends StatelessWidget{
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
                child: Text("Por fim, observe as informações a cerca da localidade desejada. As cores reerentes as regiões informam a vúlnerabilidade do local.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,),
                ),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => FifthPage()));
              },
              child: Image(image: AssetImage('images/seta.png'), height: 50, width: 50,))
          ],
        ),
      ),
    );
  }
}