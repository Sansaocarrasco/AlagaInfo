import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart'; // Para abrir os PDFs localmente
import 'package:path_provider/path_provider.dart'; // Para acessar o sistema de arquivos
import 'dart:io'; // Para manipular arquivos

class EnvironmentalLawsPage extends StatelessWidget {
  final List<Map<String, String>> laws = [
    {"name": "Lei 12.651/2012 - Novo Código Florestal Brasileiro", "file": "lei_12651.pdf"},
    {"name": "Lei 14026/2020 - Novo Marco Legal do Saneamento Básico", "file": "lei_14026.pdf"},
    {"name": "Lei 6.938/1981 - Política Nacional do Meio Ambiente", "file": "lei_6938.pdf"},
    {"name": "Lei 9.433/1997 - Política Nacional dos Recursos Hidricos", "file": "lei_9433.pdf"},
    {"name": "Lei 12305/2010 - Politica Nacional de Residuos Solidos", "file": "lei_12305.pdf"},
    {"name": "Lei 9605/1998 - Lei de Crimes Ambientais", "file": "lei_9605.pdf"},
  ];

  Future<void> openPDF(BuildContext context, String fileName) async {
    try {
      // Supondo que os PDFs estejam na pasta assets
      final dir = await getApplicationDocumentsDirectory();
      final filePath = '${dir.path}/$fileName';

      // Verifica se o arquivo já foi copiado, caso contrário copia do assets
      if (!File(filePath).existsSync()) {
        final data = await DefaultAssetBundle.of(context).load('assets/$fileName');
        final bytes = data.buffer.asUint8List();
        await File(filePath).writeAsBytes(bytes);
      }

      await OpenFilex.open(filePath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao abrir o arquivo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE3F2FD),
      appBar: AppBar(
        title: Text(
          'Leis Ambientais',
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 62, 80, 119),
        automaticallyImplyLeading: false,
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
                    child: ListTile(
                      title: Text(
                        laws[index]["name"]!,
                        style: TextStyle(fontSize: 16, color: Color(0xFF1E88E5)),
                      ),
                      trailing: Icon(Icons.picture_as_pdf, color: Colors.red),
                      onTap: () => openPDF(context, laws[index]["file"]!),
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
        color: Color.fromARGB(255, 62, 80, 119),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.supervisor_account_rounded, color: Colors.white),
              onPressed: () {
                // Navegação para AboutUsPage
              },
            ),
            IconButton(
              icon: Icon(Icons.map, color: Colors.white),
              onPressed: () {
                // Navegação para MapScreen
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
