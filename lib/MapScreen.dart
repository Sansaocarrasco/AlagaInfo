import 'package:alagainfo/PolygonData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alagainfo/FifthPage.dart';
import 'package:alagainfo/SixthPage.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final List<Polygon> polygons;

  // Listas de mensagens divididas
  final List<String> generalMessages = [
    'Região do Jardim Amazonas.',
    'Região do Antonio Cassimiro',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selectedMessageGeneral,
                      style: GoogleFonts.openSans(color: Colors.black, fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      selectedMessageMacrodrenagem,
                      style: GoogleFonts.openSans(color: Colors.black, fontSize: 26),
                    ),
                    SizedBox(height: 8),
                    Text(
                      selectedMessageConclusion,
                      style: GoogleFonts.openSans(color: Colors.black, fontSize: 26),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 50,
                      height: 20,
                      color: selectedPolygonColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(0),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FifthPage()));
              },
              child: Icon(Icons.arrow_circle_right_outlined, color: Colors.black, size: 40),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(0),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SixthPage()));
              },
              child: Icon(Icons.arrow_circle_left_outlined, color: Colors.black, size: 40),
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
