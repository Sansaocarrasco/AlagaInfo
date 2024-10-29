import 'package:flutter/material.dart';
import 'AboutUsPage.dart';
import 'MapScreen.dart';

class EnvironmentalLawsPage extends StatelessWidget {
  final List<String> laws = [
    "Lei 12.651/2012 - Código Florestal",
    "Lei 9.605/1998 - Lei de Crimes Ambientais",
    "Lei 10.650/2003 - Política Nacional de Resíduos Sólidos",
    "Lei 9.433/1997 - Política Nacional de Recursos Hídricos",
    "Lei 6.938/1981 - Política Nacional do Meio Ambiente",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3F2FD), // Azul claro
      appBar: AppBar(
        title: Text(
          'Leis Ambientais',
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 62, 80, 119), // Cor da barra superior igual à inferior
        automaticallyImplyLeading: false, // Remove o botão de retorno
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Conheça algumas leis importantes que protegem o meio ambiente:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: laws.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        laws[index],
                        style: TextStyle(fontSize: 16, color: Color(0xFF1E88E5)), // Azul escuro
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        color: Color.fromARGB(255, 62, 80, 119), // Cor da barra inferior
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.supervisor_account_rounded, color: Colors.white),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.map, color: Colors.white),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()));
              },
            ),
            IconButton(
              icon: Icon(Icons.balance, color: Colors.white),
              onPressed: () {
                //
              },
            ),
          ],
        ),
      ),
    );
  }
}
