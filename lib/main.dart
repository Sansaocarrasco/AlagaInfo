import 'package:flutter/material.dart';
import 'package:alagainfo/SecondPage.dart';
import 'package:google_fonts/google_fonts.dart';

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
            Image(image: AssetImage('assets/images/Inicio.png')),
            Container(
              child:
              Column(
                children: [
                  RichText(
  text: TextSpan(
    children: [
      TextSpan(
        text: 'Alaga',
        style: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 45,
              color: Color(0xFF87AAD2), // Corrigido para usar o código de cor hexadecimalr
            fontWeight: FontWeight.bold, // Deixa o texto em negrito
          ),
        ),
      ),
      TextSpan(
        text: ' ',
      ), // Espaçamento entre os textos
      TextSpan(
        text: 'Info',
        style: GoogleFonts.lato(
          textStyle: TextStyle(
            fontSize: 45,
            color: Colors.black,
            fontWeight: FontWeight.bold, // Deixa o texto em negrito
          ),
        ),
      ),
    ],
  ),
)
                ]

              )
            ),

            Container(
                child: Text("Informe-se & Cuide-se",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Deixa o texto em negrito
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
                MaterialPageRoute(builder: (context) => SecondPage()));
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

