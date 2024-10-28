import 'package:alagainfo/FifthPage.dart';
import 'package:alagainfo/SixthPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:alagainfo/PolygonData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MapScreen(),
    );
  }
}

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late List<Polygon> polygons;
  final List<String> neighborhoodNames = [
    'Jardim Amazonas',
    'Antonio Cassimiro',
  ];

  // Listas de mensagens divididas
  final List<String> generalMessages = [
    'A região apresenta riscos elevados de alagamento.',
    'A região apresenta risco moderado de alagamento.',
  ];

  final List<String> macrodrenagemMessages = [
    'Macrodrenagem: Nenhuma.',
    'Macrodrenagem: Riacho Porteiras, 5 Lagoa.',
  ];

  final List<String> conclusionMessages = [
    'Conclusão: Alta chance de alagamento.',
    'Conclusão: Baixa chance de alagamento.',
  ];

  String selectedMessageGeneral = "";
  String selectedMessageMacrodrenagem = "";
  String selectedMessageConclusion = "";
  String selectedNeighborhoodName = ""; // Nome do bairro selecionado
  Color selectedPolygonColor = Colors.transparent;

  @override
  void initState() {
    super.initState();
    polygons = PolygonData.getPolygons();
  }

  void _setSelectedMessages(int index) {
    setState(() {
      selectedMessageGeneral = generalMessages[index];
      selectedMessageMacrodrenagem = macrodrenagemMessages[index];
      selectedMessageConclusion = conclusionMessages[index];
      selectedNeighborhoodName = neighborhoodNames[index]; // Atualiza o bairro
      selectedPolygonColor = polygons[index].color!; // Cor correspondente ao polígono selecionado
      // Alterar a cor do polígono selecionado
      polygons[index] = Polygon(
        points: polygons[index].points,
        borderColor: polygons[index].borderColor,
        borderStrokeWidth: polygons[index].borderStrokeWidth,
        color: polygons[index].color!.withOpacity(0.4), // Revela a cor ao selecionar
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delimitação de Bairros'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(-9.37521406536559, -40.53755448438904),
              initialZoom: 15.0,
              onTap: (tapPosition, point) {
                // Verifica qual polígono foi clicado
                for (int i = 0; i < polygons.length; i++) {
                  if (isPointInPolygon(point, polygons[i].points)) {
                    _setSelectedMessages(i);
                    break;
                  }
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              PolygonLayer(
                polygons: polygons,
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Centraliza o conteúdo
                  children: [
                    Text(
                      selectedNeighborhoodName, // Exibe o nome do bairro
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // Centraliza o texto
                    ),
                    SizedBox(height: 8), // Espaço entre o nome do bairro e as mensagens
                    Text(
                      selectedMessageGeneral,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Text(
                      selectedMessageMacrodrenagem,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, // Centraliza a linha
                      children: [
                        Text(
                          selectedMessageConclusion,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 50,
                          height: 20,
                          color: selectedPolygonColor,
                        ),
                      ],
                    ),
                    Spacer(), // Para empurrar os botões para baixo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => FifthPage()));
                          },
                          child: Text("Quem Somos"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SixthPage()));
                          },
                          child: Text("Legislações"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isPointInPolygon(LatLng point, List<LatLng> polygon) {
    int j = polygon.length - 1;
    bool oddNodes = false;
    for (int i = 0; i < polygon.length; i++) {
      if (polygon[i].latitude < point.latitude && polygon[j].latitude >= point.latitude ||
          polygon[j].latitude < point.latitude && polygon[i].latitude >= point.latitude) {
        if (polygon[i].longitude +
            (point.latitude - polygon[i].latitude) /
            (polygon[j].latitude - polygon[i].latitude) *
            (polygon[j].longitude - polygon[i].longitude) < point.longitude) {
          oddNodes = !oddNodes;
        }
      }
      j = i; // j é o último vértice
    }
    return oddNodes;
  }
}