import 'package:flutter/material.dart';
import 'package:qr_reader_app/src/pages/mapas_page.dart';
import 'package:qr_reader_app/src/pages/direcciones_page.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';
//import 'package:qr_reader_app/src/providers/db_provider.dart';
import 'package:qr_reader_app/src/bloc/scans_bloc.dart';
import 'package:qr_reader_app/src/utils/utils.dart' as utils;
import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scansBloc = new ScansBloc();
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              scansBloc.borrarScansTodos(); //DBProvider.db.deleteAll();
            }
          ),
        ],
      ),
      body: _cargarPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: ()=>_scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR(BuildContext context) async{
    String futureString='https://www.google.com/';
    //android/app/src/debug/AndroidManifest.xml
    //Future<String> 
    //https://www.google.com/
    //geo:-17.847217669425717,-63.16433712681659
    /*
    try {
      futureString = await new QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
    }
    print('futureString : $futureString');*/
    if(futureString != null){
      //print('Esta Aqui');
      final scan = ScanModel( valor: futureString );
      scansBloc.agregarScan(scan); //DBProvider.db.createScan(scan);
      final scan2 = ScanModel( valor: 'geo:-17.847217669425717,-63.16433712681659' );
      scansBloc.agregarScan(scan2); //DBProvider.db.createScan(scan);
      //-----------------------------
      /*if( Platform.isIOS){
        Future.delayed( Duration(milliseconds: 750), (){
          utils.abrirScan(context,scan);
        });
      }else{
        utils.abrirScan(context,scan);
      }*/
      //utils.abrirScan(scan);
    }
  }

  Widget _cargarPage(int paginaActual){
    switch(paginaActual){
      case 0: return MapasPage();
      case 1: return DireccionesPage();
      default: return MapasPage();
    }
  }

  Widget _crearBottomNavigationBar(){
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex=index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.find_in_page),
          title: Text('Direcciones')
        ),
      ],
    );
  }
}