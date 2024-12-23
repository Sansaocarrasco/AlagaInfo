import 'package:flutter/material.dart';
import 'package:alagainfo/FouthPage.dart';

class ThirdPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
  return Scaffold( 
    backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Image(image: AssetImage('assets/images/Inicio3-1.png')), //Diminuir o tamanho da imagem
            Image(image: AssetImage('assets/images/Inicio-3.png')), //Diminuir o tamanho da imagem
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Text("No “Mapa Informativo”, escolha a região que você gostaria de obter as informações de alagamento",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  ),
                ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(0),
              ),
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => FouthPage()));
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