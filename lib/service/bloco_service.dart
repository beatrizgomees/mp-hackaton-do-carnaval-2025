 import 'package:carnaval_no_bolso_app/model/bloco.dart';

abstract class BlocoService {

  Future<Bloco> getBloco();
  Future<List<Bloco>> getAllBloco();

}