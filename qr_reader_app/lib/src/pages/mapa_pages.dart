import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';
//import 'package:latlong/latlong.dart';

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final map = new MapController();
  String tipoMapa = 'streets';
  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;   //Recuperamos los Argumentos del GEO

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              map.move(scan.getLatLng(), 15.0);
            },
          ),
        ],
      ),
      body: _crearFlutterMap(scan),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearBotonFlotante( BuildContext context ){
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      tooltip: 'Cambiar Estilo del Mapa',
      onPressed: () {
        //streets, dark, light, outdoors, satellite
        if(tipoMapa=='streets') tipoMapa='dark';
        else if(tipoMapa=='dark') tipoMapa='light';
        else if(tipoMapa=='light') tipoMapa='outdoors';
        else if(tipoMapa=='outdoors') tipoMapa='satellite';
        else tipoMapa='streets';
        setState(() {});
      },
    );
  }

  Widget _crearFlutterMap( ScanModel scan ){
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15.0
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan)
      ],
    );
  }

  _crearMapa(){
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoicGVyY3l0b21pY2hhIiwiYSI6ImNrOG5jY2xyYjB3dWszbXB6Y2gxM3dwOWoifQ.pX0hu0prmdLQABMwsijDSg',
        'id': 'mapbox.$tipoMapa'
        //streets, dark, light, outdoors, satellite
      }
    );
  }

  _crearMarcadores( ScanModel scan ){
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            //color: Colors.red,
            child: Icon(  //new FlutterLogo(),
              Icons.location_on,
              size: 40.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}