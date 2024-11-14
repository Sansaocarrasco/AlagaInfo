// lib/screens/MapScreen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:alagainfo/PolygonData.dart';
import 'package:alagainfo/PolygonMessageRepository.dart';
import 'package:alagainfo/PolygonMessage.dart';
import 'package:alagainfo/AboutUsPage.dart';
import 'package:alagainfo/EnvironmentalLawsPage.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late List<Polygon> polygons;
  late List<PolygonMessage> polygonMessages;  // Lista de mensagens e dados de polígonos
  
  String selectedMessageGeneral = "";
  String selectedMessageMacrodrenagem = "";
  String selectedMessageConclusion = "";
  String selectedNeighborhoodName = "";
  Color selectedPolygonColor = Colors.transparent;
  int? previousIndex;
  bool isInfoVisible = false;

  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    polygons = PolygonData.getPolygons();
    
    // Carregar os dados dos polígonos usando o repositório
    polygonMessages = PolygonMessageRepository.getPolygonMessages();
  }

  // Função para atualizar as mensagens e cores com base no índice
  void _setSelectedMessages(int index) {
    setState(() {
      if (previousIndex != null) {
        // Retorna o polígono anterior para a cor original (transparente)
        polygons[previousIndex!] = Polygon(
          points: polygons[previousIndex!].points,
          borderColor: polygons[previousIndex!].borderColor,
          borderStrokeWidth: polygons[previousIndex!].borderStrokeWidth,
          color: Colors.transparent, // Mantém transparente quando desmarcado
        );
      }

      // Atualizando as mensagens e dados do polígono
      final polygonMessage = polygonMessages[index];
      selectedMessageGeneral = polygonMessage.general;
      selectedMessageMacrodrenagem = polygonMessage.macrodrenagem;
      selectedMessageConclusion = polygonMessage.conclusion;
      selectedNeighborhoodName = polygonMessage.name;
      selectedPolygonColor = polygonMessage.color;

      // Atualiza a cor do polígono selecionado para a cor associada
      polygons[index] = Polygon(
        points: polygons[index].points,
        borderColor: polygons[index].borderColor,
        borderStrokeWidth: polygons[index].borderStrokeWidth,
        color: selectedPolygonColor, // Cor definida na PolygonMessage
      );

      previousIndex = index;
      isInfoVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mapa Informativo',
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 62, 80, 119),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Flexible(
            flex: 5,
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: LatLng(-9.37521406536559, -40.53755448438904),
                initialZoom: 15.0,
                onTap: (tapPosition, point) {
                  for (int i = 0; i < polygons.length; i++) {
                    if (isPointInPolygon(point, polygons[i].points)) {
                      _setSelectedMessages(i);  // Atualiza a cor e as informações
                      mapController.move(point, 14.9);  // Move o mapa para o ponto clicado
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
          ),
          if (isInfoVisible)
            Flexible(
              flex: 2,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        selectedNeighborhoodName,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Text(
                        selectedMessageGeneral,
                        style: TextStyle(color: selectedPolygonColor, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        selectedMessageMacrodrenagem,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        selectedMessageConclusion,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Container(
            width: double.infinity,
            color: Color.fromARGB(255, 62, 80, 119),
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
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.balance, color: Colors.white),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EnvironmentalLawsPage()));
                  },
                ),
              ],
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
      j = i;
    }
    return oddNodes;
  }
}
