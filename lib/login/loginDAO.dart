import 'package:dio/dio.dart';
import 'package:vr_ponto/database_creator.dart';
import 'package:vr_ponto/global.dart';
import 'package:vr_ponto/login/login_mockado.dart';

import 'UsuarioVO.dart';

class LoginDAO {
  final dio = Dio();
  StringBuffer sql = new StringBuffer();

  Future getUsuario() async {
    String servidor = "http://192.168.56.1:9000/getusuario";
    var response = await dio.get(servidor);
    List<UsuarioVO> usuario = [];

    // dynamic data = JsonRead().usuario();

    if (response.statusCode >= 200 && response.statusCode <= 250) {
      for (var node in response.data) {
        usuario.add(UsuarioVO.fromJson(node));
      }
    }

    // usuario.add();

    // List<UsuarioVO> usuario =
    //     (response.data as List).map((e) => UsuarioVO.fromJson(e)).toList();
    await deleteAllUsuario();
    await insertAllUsuario(usuario);
    // }
  }

  Future deleteAllUsuario() async {
    sql = new StringBuffer();

    sql.write('usuario');

    await dbMaster.delete(sql.toString());
  }

  Future insertAllUsuario(List<UsuarioVO> usuario) async {
    sql = new StringBuffer();
    sql.write(" INSERT INTO usuario ( ");
    sql.write(" login, ");
    sql.write(" senha, ");
    sql.write(" nome,  ");
    sql.write(" chaveGerente,  ");
    sql.write(" gerente ) ");
    sql.write("VALUES (?, ?, ?, ?, ?) ");

    for (UsuarioVO node in usuario) {
      List params = [
        node.login,
        node.senha,
        node.nome,
        node.chaveGerente,
        node.gerente
      ];

      await dbMaster.rawInsert(sql.toString(), params);
    }
  }

  Future<UsuarioLogadoVO> selectUsuario(String login, senha) async {
    sql = new StringBuffer();
    UsuarioLogadoVO usuarioVO = new UsuarioLogadoVO();

    sql.write(" SELECT * FROM USUARIO ");
    sql.write(" WHERE login = '$login' ");
    sql.write(" AND senha = '$senha' ");

    var data = await dbMaster.rawQuery(sql.toString());

    if (data.isNotEmpty) {
      for (final node in data) {
        final usuario = UsuarioLogadoVO.fromJson(node);
        usuarioVO = usuario;
      }
    }
    return usuarioVO;
  }
}
