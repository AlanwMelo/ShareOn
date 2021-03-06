import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';


class ProductBloc extends BlocBase{

  final _dataController = BehaviorSubject<Map>();

  Stream<Map> get outData=> _dataController.stream;

  String categoryId;
  DocumentSnapshot product;

  Map<String, dynamic> unsavedData;

  ProductBloc({this.categoryId, this.product}){
    if(product != null){
      unsavedData = Map.of(product.data);
      unsavedData["images"] = List.of(product.data["images"]);
      unsavedData["sizes"] = List.of(product.data["sizes"]);
    } else {

      unsavedData = {
        "title": null, "description": null, "price":null, "images": [], "sizes":[]
      };
    }

    _dataController.add(unsavedData);
  }

  void salvarImagens(List imagens){
    unsavedData["images"] = imagens;
  }

  void salvarTitulo(String titulo){
    unsavedData["title"] = titulo;
  }

  void salvarDescricao(String descricao){
    unsavedData["description"] = descricao;
  }

  void salvarPreco(String preco){
    unsavedData["price"] = double.parse(preco);
  }

  @override
  void dispose() {

  }


}