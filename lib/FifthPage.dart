import 'package:alagainfo/MapScreen.dart';
import 'package:alagainfo/SixthPage.dart';
import 'package:flutter/material.dart';

class FifthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100], // Fundo azul claro
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5), // Espaçamento no topo
                  // Retângulo com bordas arredondadas para o cabeçalho
                  Container(
                    width: MediaQuery.of(context).size.width, // Ocupa a largura da tela
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 62, 80, 119), // Cor do retângulo
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Quem Somos",
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 3.0,
                            color: Colors.black54,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // Espaçamento entre o cabeçalho e a imagem
                  // Imagem
                  Image.asset(
                    'images/pet.png',
                    height: 400, // Diminuindo a altura da imagem
                  ),
                  SizedBox(height: 10), // Espaçamento reduzido entre a imagem e o texto
                  // Texto descritivo
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      "O PET (Programa de Educação Tutorial) é um Programa do MEC, Ministério da Educação, que é desenvolvido por grupos de estudantes de graduação, sob a tutoria de um Professor. Um grupo tutorial se caracteriza pela presença de um tutor com a missão de estimular a aprendizagem ativa dos seus membros, através da vivência, reflexões e discussões, num clima de informalidade e cooperação. É um programa de longo prazo que visa realizar, dentro da universidade o modelo de indissociabilidade do ensino, pesquisa a e extensão de forma que uma vez selecionado, o estudante pode permanecer no grupo até a conclusão da sua graduação.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Espaçamento reduzido entre o texto e os patrocinadores
                  // Imagens dos patrocinadores
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espaçamento igual entre as logos
                    children: [
                      Image.asset(
                        'images/lea-logo.png',
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                      ),
                      Image.asset(
                        'images/pet-logo.png',
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                      ),
                      Image.asset(
                        'images/univasf-logo.png',
                        height: 80,
                        width: 80,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Espaço reservado abaixo dos patrocinadores
                ],
              ),
            ),
          ),
          // Barra de navegação personalizada
          Container(
            color: Color.fromARGB(255, 62, 80, 119), // Cor da barra de navegação
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    // Navegar para a página atual
                  },
                ),
                IconButton(
                  icon: Icon(Icons.info, color: Colors.white),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen()));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings, color: Colors.white),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SixthPage()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
