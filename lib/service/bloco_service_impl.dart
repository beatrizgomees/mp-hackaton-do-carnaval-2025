import 'dart:convert';

import 'package:carnaval_no_bolso_app/model/bloco.dart';
import 'package:carnaval_no_bolso_app/service/bloco_service.dart';
import 'package:carnaval_no_bolso_app/utils/constants.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';


class BlocoServiceImpl  implements BlocoService{
  List<Bloco> allBlocos = []; // Lista de todos os blocos
  List<Bloco> blocosProximos = []; // Lista apenas dos próximos blocos
  bool isLoading = true;
  int currentPage = 1;
  
  @override
  Future<List<Bloco>> getAllBloco() async {
    List<Bloco> tempBlocos = [];
    bool hasMore = true;

    while (hasMore && currentPage <= 210) {
      final response = await http.get(
        Uri.parse('https://apis.codante.io/api/bloquinhos2025/agenda?page=$currentPage'),
      );

      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        final List<dynamic> jsonList = decodedJson['data']; // Ajuste conforme a estrutura da API

        if (jsonList.isEmpty) {
          hasMore = false; // Para o loop se não houver mais blocos
        } else {
          // Converte JSON para objetos Bloco
          final List<Bloco> blocos = jsonList.map((e) => Bloco(
              id: e['id'] ?? 0, // Se for null, assume 0
              title: e['title'] ?? 'Sem título',
              description: e['description'] ?? 'Sem descrição',
               dateTime: e['date_time'] != null ? DateTime.parse(e['date_time']) : null,
              address: e['address'] ?? 'Endereço não disponível',
              city: e['city'] ?? 'Cidade desconhecida',
              completeAddress: e['complete_address'] ?? '',
              eventUrl: e['event_url'] ?? '',
              neighboorhood: e['neighborhood'] ?? '',
              price: e['price'] ?? '',
        )).toList();

          tempBlocos.addAll(blocos);
          currentPage++; // Avança para a próxima página
        }
      } else {
        print("Erro ao buscar blocos: ${response.statusCode}");
        hasMore = false;
      }
      
    }

   allBlocos.addAll(tempBlocos);
  return tempBlocos;

}
  
  @override
  Future<Bloco> getBloco() {
    // TODO: implement getBloco
    throw UnimplementedError();
  }
  
  @override
  Future<List<Bloco>> getBlocosByCity(String city) async {
    List<Bloco> blocosPorCidade = [];
    int page = 1;
    bool hasMore = true;
    Set<int> blocosIds = {}; // Set para armazenar os IDs dos blocos já adicionados

    while (hasMore) {
      final blocos = await getAllBloco();
      final blocosFiltrados = blocos.where((bloco) => bloco.city == city && !blocosIds.contains(bloco.id)).toList();

      if (blocosFiltrados.isEmpty) {
        hasMore = false;
      } else {
        blocosPorCidade.addAll(blocosFiltrados);
        blocosIds.addAll(blocosFiltrados.map((bloco) => bloco.id));

      }

      // if (blocos.length < pageSize) {
      //   hasMore = false;
      // }

    }
    blocosProximos.addAll(blocosPorCidade);
     return blocosPorCidade;
  }
  

 


  
}