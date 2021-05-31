import 'package:dio/dio.dart';
import '../global.dart';

class CodigoGerenteDAO {
  final dio = Dio();
  StringBuffer sql;

  Future<String> getCodigoGerente(String login, String senha) async {
    sql = new StringBuffer();
    String valorChave;
    sql.write(" SELECT chaveGerente FROM USUARIO ");
    sql.write(" WHERE gerente = 1 ");
    sql.write(" AND login = '$login' ");
    sql.write(" AND senha = '$senha' ");

    var result = await dbMaster.rawQuery(sql.toString());

    for (var node in result) {
      valorChave =
          node.values.toString().replaceAll("(", "").replaceAll(")", "");
    }

    return valorChave;
  }

  Future<double> getValorTotal(String id_cliente) async {
    sql = new StringBuffer();
    double saldoTotal = 0.0;

    sql.write(" SELECT saldototal FROM banco_horas");
    sql.write(" WHERE idusuario = $id_cliente");

    var result = await dbMaster.rawQuery(sql.toString());

    for (var node in result) {
      saldoTotal = double.parse(node.values.first);
    }

    return saldoTotal;
  }
}
