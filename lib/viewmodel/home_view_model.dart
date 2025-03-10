import 'package:carnaval_no_bolso_app/model/bloco.dart';
import 'package:carnaval_no_bolso_app/service/bloco_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
class HomeViewModel extends ChangeNotifier{

BlocoServiceImpl blocoServiceImpl = BlocoServiceImpl();

List<Bloco> _blocoList = [];

Future<List<Bloco>> fetchAllBlocos() async{
  
   try{
    
   _blocoList = await blocoServiceImpl.getAllBloco();
    notifyListeners();
    return _blocoList;
    }catch (e){
      print('Erro ao buscar contatos: $e ');
    }
  
  return _blocoList;

}


 Future<void> getCurrentLocation(LatLng? currentPosition, MapController mapController) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return;
    }

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return;
      }
    }

     if (permission == LocationPermission.deniedForever) {
      return;
    }
    // Obtém a localização atual
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );


    
    currentPosition = LatLng(position.latitude, position.longitude);
    mapController.move(currentPosition, 15.0); // Move o mapa para a posição do usuário
    
    notifyListeners();
    print(currentPosition);
    
  }

}