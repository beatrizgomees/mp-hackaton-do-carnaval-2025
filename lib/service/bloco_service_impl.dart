import 'dart:convert';

import 'package:carnaval_no_bolso_app/model/bloco.dart';
import 'package:carnaval_no_bolso_app/service/bloco_service.dart';
import 'package:carnaval_no_bolso_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class BlocoServiceImpl  implements BlocoService{

  
  @override
  Future<List<Bloco>> getAllBloco() async {
  final response = await http.get(Uri.parse(Constants.URL + '/agenda'));
    if (response.statusCode == 200) {
     final decodedJson = jsonDecode(response.body);

      final List<dynamic> jsonList = decodedJson['data']; // Ajuste conforme a chave real da API

      final List<Bloco> blocoJson = jsonList.map((e) => Bloco(
            id: e['id'],
            title: e['title'],
            description: e['description'],
            dateTime: e['date_time'] != null ? DateTime.parse(e['date_time']) : null, // Aqui tratamos null
            address: e['address'],
            city: e['city'],
            completeAddress: e['complete_address'],
            eventUrl: e['event_url'],
            neighboorhood: e['neighborhood'],
            price: e['price'],
          )).toList();

      return blocoJson;
          }
    return [];



    throw UnimplementedError();
  }

  @override
  Future<Bloco> getBloco() {
    // TODO: implement getBloco
    throw UnimplementedError();
  }
  
}