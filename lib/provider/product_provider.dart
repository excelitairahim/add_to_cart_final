import 'package:flutter/material.dart';
import 'package:shopping_cart_app/api_service.dart';
import 'package:shopping_cart_app/model/productmodel.dart';

class ProductProvider extends ChangeNotifier{
  List <Map<String,dynamic>> data_list=[];
  bool isloading=false;
getdata()async{
var  data= await ApiService().getdata();
data_list=data;
notifyListeners();
  }
}