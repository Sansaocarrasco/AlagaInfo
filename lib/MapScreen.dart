import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
  final List<Polygon> polygons = [
    // Jardim Amazonas (Vermelho)
    Polygon(
      points: [
        LatLng(-9.37521406536559, -40.53755448438904),
        LatLng(-9.378485896235834, -40.53452017118217),
        LatLng(-9.384776339458098, -40.52848732734354),
        LatLng(-9.382021925854806, -40.5250689302532),
        LatLng(-9.376293676017177, -40.52753721617111),
        LatLng(-9.373553180000165, -40.52892689450886),
        LatLng(-9.37301176110667, -40.5294766293151),
        LatLng(-9.37211418726382, -40.52944940533195),
        LatLng(-9.37107943836129, -40.531925336164),
        LatLng(-9.372283518256044, -40.53393722096383),
        LatLng(-9.37521406536559, -40.53755448438904),
      ],
      borderColor: Colors.white,
      borderStrokeWidth: 3.0,
      color: Colors.red.withOpacity(0.4), // Vermelho para alto risco
    ),
    // Antonio Cassimiro (Verde)
    Polygon(
      points: [
        LatLng(-9.370697053061356, -40.52242682629748),
        LatLng(-9.374384026941252, -40.52012881840212),
        LatLng(-9.374932018534828, -40.52132654098072),
        LatLng(-9.376987654491272, -40.52012879433881),
        LatLng(-9.378589177211287, -40.51881691172614),
        LatLng(-9.381655463860028, -40.51653812686345),
        LatLng(-9.380858809505597, -40.51466904781015),
        LatLng(-9.38211154395586, -40.51415666337709),
        LatLng(-9.381635583056733, -40.51315341977207),
        LatLng(-9.380502563487266, -40.51119053464137),
        LatLng(-9.379576719961007, -40.51134690574681),
        LatLng(-9.378659259597299, -40.51152808214285),
        LatLng(-9.378015697106134, -40.51091828803853),
        LatLng(-9.374876474221155, -40.50821758413236),
        LatLng(-9.371841529507277, -40.50552081087474),
        LatLng(-9.369355566817832, -40.50282378471944),
        LatLng(-9.36879281313913, -40.50161582202593),
        LatLng(-9.367463636244333, -40.50020229758848),
        LatLng(-9.366862505857497, -40.50097459189859),
        LatLng(-9.364432281915484, -40.49894850380188),
        LatLng(-9.363646851337332, -40.49990999440138),
        LatLng(-9.362395690842305, -40.50142025113799),
        LatLng(-9.360886827472948, -40.50321411216185),
        LatLng(-9.36049365850122, -40.50291145865805),
        LatLng(-9.35979878082513, -40.50381289057414),
        LatLng(-9.358883296252914, -40.50448728874967),
        LatLng(-9.357786476526407, -40.50521900221329),
        LatLng(-9.356815760197549, -40.50589346839702),
        LatLng(-9.355778412542014, -40.50663613663652),
        LatLng(-9.354774053312765, -40.50734199576659),
        LatLng(-9.35429251311053, -40.50767010463045),
        LatLng(-9.35435187281405, -40.50797540926369),
        LatLng(-9.351297005863685, -40.50873832866019),
        LatLng(-9.351490715850916, -40.50931240735779),
        LatLng(-9.35255528183799, -40.51250695292332),
        LatLng(-9.354094999256333, -40.51635567026972),
        LatLng(-9.358726578443534, -40.52111716103276),
        LatLng(-9.359697561600086, -40.52218636667379),
        LatLng(-9.361311168767122, -40.52377218700482),
        LatLng(-9.363044718423815, -40.52549706759762),
        LatLng(-9.363742651247648, -40.52618498510802),
        LatLng(-9.370697053061356, -40.52242682629748),
      ],
      borderColor: Colors.white,
      borderStrokeWidth: 3.0,
      color: Colors.green.withOpacity(0.4), // Verde para baixo risco
    ),
  ];

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

  void _setSelectedMessages(int index) {
    setState(() {
      selectedMessageGeneral = generalMessages[index];
      selectedMessageMacrodrenagem = macrodrenagemMessages[index];
      selectedMessageConclusion = conclusionMessages[index];
      selectedNeighborhoodName = neighborhoodNames[index]; // Atualiza o bairro
      selectedPolygonColor = polygons[index].color!;
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedNeighborhoodName, // Exibe o nome do bairro
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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

             