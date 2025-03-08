import 'dart:convert';

import 'package:carnaval_no_bolso_app/model/bloco.dart';
import 'package:carnaval_no_bolso_app/service/bloco_service.dart';
import 'package:carnaval_no_bolso_app/utils/constants.dart';
import 'package:http/http.dart' as http;

class BlocoServiceImpl  implements BlocoService{

  
  @override
  Future<List<Bloco>> getAllBloco() async {
  final response = await http.get(Uri.parse(Constants.URL));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final BlocoJson = json
          .map((e) => Bloco(
              id: e['id'],
              title: e['title'],
              description: e['description'],
              dateTime: e['date_time'],
              address: e['address'],
              city: e['city'],
              completeAddress: e['complete_address'],
              eventUrl: e['event_url'],
              neighboorhood: e['neighborhood'],
              price: e['price']))

          .toList();
      return BlocoJson;
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