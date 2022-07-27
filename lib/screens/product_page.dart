import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/provider/product_provider.dart';

class Product_screen extends StatefulWidget {
  const Product_screen({Key? key}) : super(key: key);

  @override
  State<Product_screen> createState() => _Product_screenState();
}

class _Product_screenState extends State<Product_screen> {
  @override
  void initState() {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.getdata();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(
      context,
    );
    return Center(
        child: Scaffold(
      body: SingleChildScrollView(
        child: 
   
            ListView.builder(
               // itemCount:4, //productProvider.data_list.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemExtent: 120,
                itemBuilder: ((context, index) {
                  return Card(
                    child: Row(
                      children: [
                        Container(
                            child: Image.network(
                                productProvider.data_list[index]['image'].toString())),
                 Text(productProvider.data_list[index]['category'].toString())  ]   ,
                    ),
                  );
                }))
          
        )),
      
    );
  }
}
