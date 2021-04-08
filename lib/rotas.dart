import 'package:flutter/material.dart';
import 'package:ex_extra/main.dart';

class Rotas {
  static Route<dynamic> geraRota(RouteSettings set){
    final args = set.arguments;
    if(set.name=='/telaCadastro'){
      return MaterialPageRoute(
        builder: (_)=>telaCadastro(),
      );
    }
    if(set.name=='/'){
      return MaterialPageRoute(
        builder:(_)=>TelaPrincipal(title:'Clientes Cadastrados'),
      );
    }
  }

}
