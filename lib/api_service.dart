import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:shopping_cart_app/model/productmodel.dart';
import 'package:shopping_cart_app/screens/product_list.dart';

class ApiService {
  Future<  List<Map<String, dynamic>>> getdata() async {
    List<Map<String, dynamic>>? result = [];
    List<dynamic> data = [];

    try {
      String url = 'https://fakestoreapi.com/products';
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        data = convert.jsonDecode(response.body);
        result = data.map((value) => value as Map<String, dynamic>).toList();
       
        return result;
      }
    } catch (e) {
      print(' erroor  ${e.toString()}');
    }
    return result!;
  }
}
