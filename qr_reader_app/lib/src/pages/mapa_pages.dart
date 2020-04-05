import 'package:flutter/material.dart';
//-------------------import 'package:flutter_map/flutter_map.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';
//import 'package:latlong/latlong.dart';

class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;   //Recuperamos los Argumentos del GEO

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){},
          ),
        ],
      ),
      body: Center()//-------------------_crearFlutterMap(scan)
    );
  }

  //-------------------Widget _crearFlutterMap( ScanModel scan ){
    //-------------------return FlutterMap(
      //-------------------options: MapOptions(
        //-------------------center: scan.getLatLng(),
        //-------------------zoom: 10.0
      //-------------------),
      //-------------------layers: [
        //-------------------_crearMapa()
      //-------------------],
    //-------------------);
  //-------------------}

  //-------------------_crearMapa(){
    //-------------------return TileLayerOptions(
      //-------------------urlTemplate: 'https://api.mapbox.com/v4/'
      //-------------------'{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      //-------------------additionalOptions: {
        //-------------------'accessToken': 'pk.eyJ1IjoicGVyY3l0b21pY2hhIiwiYSI6ImNrOG5jY2xyYjB3dWszbXB6Y2gxM3dwOWoifQ.pX0hu0prmdLQABMwsijDSg',
        //-------------------'id': 'mapbox.streets'
      //-------------------}
    //-------------------);
  //-------------------}
}