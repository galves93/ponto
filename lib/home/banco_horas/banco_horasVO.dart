class BancoHorasVO {
  int id;
  int idUsuario;
  double saldoTotal;
  List<Horarios> horarios;

  BancoHorasVO({this.id, this.idUsuario, this.saldoTotal, this.horarios});

  BancoHorasVO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUsuario = json['idusuario'];
    saldoTotal = json['saldototal'];
    if (json['horarios'] != null) {
      horarios = [];
      json['horarios'].forEach((v) {
        horarios.add(Horarios.fromJson(v));
      });
    }
  }
}

class Horarios {
  // int idUsuario;
  String data;
  String horario;

  Horarios({this.data, this.horario});

  Horarios.fromJson(Map<String, dynamic> json) {
    // idUsuario = json['idusuario'];
    data = json['data'];
    horario = json['horario'];
  }
}
