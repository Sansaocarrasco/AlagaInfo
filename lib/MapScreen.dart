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
  final List<String> neighborhoodNames = [
    'Jardim Amazonas',
    'Antonio Cassimiro',
  ];

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
  String selectedNeighborhoodName = "";
  Color selectedPolygonColor = Colors.transparent;
  int? previousIndex;
  bool isInfoVisible = false;

  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    polygons = PolygonData.getPolygons();
  }

  void _setSelectedMessages(int index) {
    setState(() {
      if (previousIndex != null) {
        polygons[previousIndex!] = Polygon(
          points: polygons[previousIndex!].points,
          borderColor: polygons[previousIndex!].borderColor,
          borderStrokeWidth: polygons[previousIndex!].borderStrokeWidth,
          color: polygons[previousIndex!].color!.withOpacity(0.0),
        );
      }

      selectedMessageGeneral = generalMessages[index];
      selectedMessageMacrodrenagem = macrodrenagemMessages[index];
      selectedMessageConclusion = conclusionMessages[index];
      selectedNeighborhoodName = neighborhoodNames[index];
      selectedPolygonColor = PolygonData.getPolygonColor(index);
      polygons[index] = Polygon(
        points: polygons[index].points,
        borderColor: polygons[index].borderColor,
        borderStrokeWidth: polygons[index].borderStrokeWidth,
        color: polygons[index].color!.withOpacity(0.4),
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
                      _setSelectedMessages(i);
                      // Move the map to the tapped point
                      mapController.move(point, 14.9);
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
                  onPressed: () {
                    //
                  },
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
