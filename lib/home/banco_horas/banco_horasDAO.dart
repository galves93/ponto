import 'package:dio/dio.dart';
import 'package:vr_ponto/global.dart';
import 'package:vr_ponto/home/banco_horas/banco_horasVO.dart';
import 'package:vr_ponto/login/login_mockado.dart';

class BancoHorasDAO {
  final dio = Dio();

  StringBuffer sql = new StringBuffer();

  Future getBancoHoras() async {
    List<BancoHorasVO> bancoHoras = [];

    dynamic data = JsonRead().getHorarioGeral();

    for (var node in data) {
      bancoHoras.add(BancoHorasVO.fromJson(node));
    }

    await deleteBancoHoras();
    await insertBancoHoras(bancoHoras);
  }

  Future deleteBancoHoras() async {
    sql = new StringBuffer();

    sql.write('banco_horas');

    dbMaster.delete(sql.toString());
  }

  Future insertBancoHoras(List<BancoHorasVO> bancoHoras) async {
    sql = new StringBuffer();
    sql.write(" INSERT INTO banco_horas (");
    sql.write(" idusuario, ");
    sql.write(" saldototal )");
    sql.write(" VALUES (?,?) ");

    for (var node in bancoHoras) {
      List params = [
        node.idUsuario,
        node.saldoTotal,
      ];
      await dbMaster.rawInsert(sql.toString(), params);
      await insertHorarios(node.horarios, node.idUsuario);
    }
  }

  Future insertHorarios(List<Horarios> horarios, int idUsuario) async {
    sql = new StringBuffer();
    sql.write(" INSERT INTO horarios_registrados (");
    sql.write(" idusuario,");
    sql.write(" data,");
    sql.write(" horario )");
    sql.write(" VALUES (?,?,?)");

    for (var node in horarios) {
      List params = [
        idUsuario,
        node.data,
        node.horario,
      ];

      await dbMaster.rawInsert(sql.toString(), params);
    }
  }
}
