import 'package:alagainfo/AboutUsPage.dart';
import 'package:alagainfo/EnvironmentalLawsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:alagainfo/PolygonData.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late List<Polygon> polygons;
  
  // Novo modelo para armazenar mensagens e dados por índice
  Map<int, Map<String, String>> polygonMessages = {};
  Map<int, Color> polygonColors = {};
  Map<int, String> polygonNames = {};
  
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

    // Inicializando as mensagens e as cores dos polígonos
    _loadPolygonData();
  }

  // Função para carregar dados dos polígonos de maneira flexível
  void _loadPolygonData() {
    // Exemplo de como você pode carregar dados dinamicamente
    for (int i = 0; i < polygons.length; i++) {
      polygonMessages[i] = {
        'general': 'Mensagem geral para o polígono $i',
        'macrodrenagem': 'Macrodrenagem para o polígono $i',
        'conclusion': 'Conclusão para o polígono $i',
      };

      polygonNames[i] = 'Nome do Polígono $i';
      polygonColors[i] = PolygonData.getPolygonColor(i); // Usando a cor do PolygonData
    }
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
      selectedMessageGeneral = polygonMessages[index]?['general'] ?? '';
      selectedMessageMacrodrenagem = polygonMessages[index]?['macrodrenagem'] ?? '';
      selectedMessageConclusion = polygonMessages[index]?['conclusion'] ?? '';
      selectedNeighborhoodName = polygonNames[index] ?? '';
      selectedPolygonColor = polygonColors[index] ?? Colors.transparent;
      
      // Atualiza a cor do polígono selecionado para a cor associada
      polygons[index] = Polygon(
        points: polygons[index].points,
        borderColor: polygons[index].borderColor,
        borderStrokeWidth: polygons[index].borderStrokeWidth,
        color: polygonColors[index], // Cor definida na PolygonData
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
