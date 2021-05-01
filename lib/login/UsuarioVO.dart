class UsuarioVO {
  int id;
  String login;
  String senha;
  String nome;

  UsuarioVO({
    this.id,
    this.login,
    this.nome,
    this.senha,
  });

  factory UsuarioVO.fromJson(Map<String, dynamic> json) {
    return UsuarioVO(
      id: json['id'],
      login: json['login'],
      senha: json['senha'],
      nome: json['nome'],
    );
  }
}
