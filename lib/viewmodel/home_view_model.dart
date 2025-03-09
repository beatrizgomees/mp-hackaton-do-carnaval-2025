import 'package:carnaval_no_bolso_app/model/bloco.dart';
import 'package:carnaval_no_bolso_app/service/bloco_service_impl.dart';
import 'package:flutter/material.dart';

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

}