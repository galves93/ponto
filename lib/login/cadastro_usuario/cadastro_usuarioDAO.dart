import 'package:dio/dio.dart';
import 'package:vr_ponto/global.dart';

class CadastroUsuarioDAO {
  final dio = Dio();
  StringBuffer sql;

  Future<bool> getChaveGerente(String chave) async {
    sql = new StringBuffer();

    sql.write(" SELECT id FROM USUARIO");
    sql.write(" WHERE chaveGerente = '$chave'");
    sql.write(" LIMIT 1");

    var result = await dbMaster.rawQuery(sql.toString());

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setNovoCadastro(String nome, String sobrenome, String usuario,
      String senha, String chaveGerente) async {
    try {
      sql = new StringBuffer();
      bool gerente = false;

      sql.write(" SELECT id FROM USUARIO WHERE login = '$usuario'");
      var result = await dbMaster.rawQuery(sql.toString());

      if (result.isNotEmpty) {
        return false;
      } else {
        sql = new StringBuffer();

        sql.write(" INSERT INTO USUARIO (");
        sql.write(" login, ");
        sql.write(" senha, ");
        sql.write(" nome, ");
        sql.write(" chaveGerente, ");
        sql.write(" gerente ) ");
        sql.write(" VALUES (?,?,?,?,?) ");

        List<dynamic> params = [
          usuario,
          senha,
          nome + " " + sobrenome,
          chaveGerente,
          gerente
        ];

        await dbMaster.rawInsert(sql.toString(), params);

        return true;
      }
    } catch (ex) {
      print(ex);
      return false;
    }
  }
}
