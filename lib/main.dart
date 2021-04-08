import 'package:flutter/material.dart';
import 'package:ex_extra/rotas.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
void main() {
  runApp(MyApp());
}

class Cliente {
  String nome;
  DateTime nasc;
  Cliente(this.nome,this.nasc);
}

class listaClientes{
  static List<Cliente> lista=[];
  void addCliente(Cliente c){
    lista.add(c);
  }
  void removeCliente(i){
    lista.removeAt(i);
  }
  void limpaLista(){
    lista.clear();
  }
  List map(){
    return lista.map((cliente) => templateCliente(cliente)).toList();
  }
}

String formataData(DateTime data) {
 return DateFormat('dd/MM/yyyy').format(data);
}


Widget templateCliente(Cliente cliente){
    return Card(
      margin: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
      child:Column(
        children:<Widget>[
          Text(
          cliente.nome!=null? cliente.nome:'',
          style: TextStyle(
            fontSize:18,
            color:Colors.grey[600]
          )
        ),
        SizedBox(height:6.0),
        Text(
            cliente.nasc!=null? formataData(cliente.nasc):'',
            style:TextStyle(
              fontSize:16,
              color:Colors.grey[600]
            )
          )
        ]
      )
    );
}

class MyApp extends StatelessWidget{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Usuarios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:TelaPrincipal(title:'Usuarios Cadastrados'),
      initialRoute: '/',
      onGenerateRoute: Rotas.geraRota,

    );
  }
}



class TelaPrincipal extends StatefulWidget {
  TelaPrincipal({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TelaPrincipal createState() => _TelaPrincipal();
}



class _TelaPrincipal extends State<TelaPrincipal> {
  int _counter = 0;
  listaClientes lista = listaClientes();




  @override
  Widget build(BuildContext context) {
    var listaCards = lista.map();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
      Container(
        child:ListView.builder(itemBuilder: (BuildContext context,index){
          return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              onDismissed: (_){
                setState(() {
                  lista.removeCliente(index);
                });
              },
              child: listaCards[index]
          );
        },
        itemCount: listaCards.length
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed('/telaCadastro').then((value) => setState((){}));
        },
        tooltip: 'Tela de Cadastro de Cliente',
        child: Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class telaCadastro extends StatefulWidget{
  telaCadastro({Key key}) : super(key: key);

  @override
  _telaCadastroState createState() => _telaCadastroState();
}

class _telaCadastroState extends State<telaCadastro> {
  String nome;
  DateTime data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Cadastro'),
      ),
      body:
      Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                      labelText: 'Nome do Usuario',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          )
                      )
                  ),
                  onChanged: (value) {
                    nome = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: DateTimeFormField(
                  decoration: InputDecoration(
                      labelText: 'Data de Nascimento',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                        )
                      )
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  onDateSelected: (DateTime value) {
                    data = value;
                  },
                ),
              ),


            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Cliente novo = Cliente(nome, data);
          listaClientes lista = listaClientes();
          lista.addCliente(novo);
          Navigator.of(context).pop();
        },
        tooltip: 'Adicionar Cliente',
        child: Icon(Icons.add),
      ),
    );
  }
}
