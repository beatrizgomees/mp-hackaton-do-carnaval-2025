import 'package:carnaval_no_bolso_app/model/bloco.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

abstract class BlocoService {

  Future<Bloco> getBloco();
  Future<List<Bloco>> getAllBloco();

}