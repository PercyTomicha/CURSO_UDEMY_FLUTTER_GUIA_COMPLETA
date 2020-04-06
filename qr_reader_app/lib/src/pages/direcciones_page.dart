import 'package:flutter/material.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';
//import 'package:qr_reader_app/src/providers/db_provider.dart';
import 'package:qr_reader_app/src/bloc/scans_bloc.dart';
import 'package:qr_reader_app/src/utils/utils.dart' as utils;

class DireccionesPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {

    scansBloc.obtenerScans();

    return StreamBuilder<List<ScanModel>>( //FutureBuilder<List<ScanModel>>(
      stream: scansBloc.scansStreamHttp, //future: DBProvider.db.getTodosScans(),
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final scans = snapshot.data;
        if( scans.length == 0 ){
          return Center(
            child: Text('No hay Información'),
          );
        }
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (content, i) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete,color: Colors.white),
            ),
            onDismissed: (direction) => scansBloc.borrarScan(scans[i].id), //DBProvider.db.deleteScan(scans[i].id),
            child: ListTile(
              leading: Icon(Icons.find_in_page, color: Theme.of(context).primaryColor ),
              title: Text(scans[i].valor),
              subtitle: Text('ID : ${scans[i].id}'),
              onTap: () => utils.abrirScan(context,scans[i]), //Se Abre en el Navegador
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            ),
          )
        );
      },
    );
  }
}