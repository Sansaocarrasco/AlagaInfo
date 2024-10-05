import 'package:flutter/material.dart';
import 'package:alagainfo/SecondPage.dart';

void main(){
  runApp(AlagaInfo());  
}

class AlagaInfo extends StatelessWidget{
  const AlagaInfo({Key? key}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage()
    );
  }
}

// Remove this custom StatelessWidget class

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
  return Scaffold( 
    backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20), // Espaçamento entre o texto e a imagem
            Image(image: AssetImage('images/Inicio.png')),
            Container(
                child: Text("AlagaInfo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,),
                ),
            ),
            Container(
                child: Text("Informe-se & Cuide-se",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,),
                ),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context,
                MaterialPageRoute(builder: (context) => SecondPage()));
              },
              child: Image(image: AssetImage('images/seta.jpeg'), height: 50, width: 50,)
              style: ButtonStyle(
                shape: BorderRadius.circular(2),
              ),z
              )
          ],
        ),
      ),
    );
  }
}

