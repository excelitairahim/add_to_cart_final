import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/provider/cart_provider.dart';
import 'package:shopping_cart_app/provider/product_provider.dart';
import 'package:shopping_cart_app/screens/product_list.dart';
import 'package:shopping_cart_app/screens/product_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CartProvider>(
            create: ((context) => CartProvider())),
        ChangeNotifierProvider<ProductProvider>(
            create: ((context) => ProductProvider())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyTabbedPage(),
      ),
    );
  }
}

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key? key}) : super(key: key);
  @override
  State<MyTabbedPage> createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> juwerieslist = [];

  static const List<Tab> myTabs = <Tab>[

    
    Tab(text: 'All'),
    Tab(text: 'Men'),
    Tab(text: 'Jewelery'),
    Tab(text: 'Women'),
    Tab(text: 'Electics'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.getdata();

    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);

 
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(
      context,
    );
  var data=productProvider.data_list.where((element) => element['category']=='jewelery' );
    
    print('hhhhhhhhhhh${data}');
    Set<String> categoriesNames = {};
    List categories = [];
    productProvider.data_list
        .forEach((location) => categoriesNames.add(location['category']));
   // print('ssssssssssssssss$categoriesNames');

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                  itemCount: productProvider.data_list.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                        child: Column(
                      children: [
                        Expanded(
                          child: Container(
                              child: Image.network(productProvider
                                  .data_list[index]['image']
                                  .toString())),
                        ),
                        Text(productProvider.data_list[index]['title']
                            .toString())
                      ],
                    ));
                  })
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                itemCount: productProvider.data_list.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return productProvider.data_list[index]['category']
                              .toString() ==
                          'men\'s clothing'
                      ? Card(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                    child: productProvider.data_list[index]
                                                    ['category']
                                                .toString() ==
                                            'men\'s clothing'
                                        ? Image.network(productProvider
                                            .data_list[index]['image']
                                            .toString())
                                        : Container()),
                              ),
                              productProvider.data_list[index]['category']
                                          .toString() ==
                                      'men\'s clothing'
                                  ? Text(productProvider.data_list[index]
                                          ['title']
                                      .toString())
                                  : Container()
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 80,
                        );
                },
              )

              // ListView.builder(
              //     itemCount: productProvider.data_list.length,
              //     shrinkWrap: true,
              //     physics: NeverScrollableScrollPhysics(),
              //     itemExtent: 120,
              //     itemBuilder: ((context, index) {
              //       return productProvider.data_list[index]
              //                                 ['category']
              //                             .toString() ==
              //                         'men\'s clothing'
              //                     ?  Card(
              //         child: Row(
              //           children: [
              //             Container(
              //                 child: productProvider.data_list[index]
              //                                 ['category']
              //                             .toString() ==
              //                         'men\'s clothing'
              //                     ? Image.network(productProvider
              //                         .data_list[index]['image']
              //                         .toString())
              //                     : Container()),
              //              productProvider.data_list[index]
              //                                 ['category']
              //                             .toString() ==
              //                         'men\'s clothing'
              //                     ?  Text(productProvider.data_list[index]['title']
              //                  .toString()):Container()
              //           ],
              //         ),
              //       ):SizedBox(height: 80,);
              //     }))
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                  itemCount: juwerieslist.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          Container(
                              child: Expanded(
                            child: Image.network(
                                juwerieslist[index]['image'].toString()),
                          )),
                          Text(juwerieslist[index]['title'].toString())
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  itemCount: productProvider.data_list.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemExtent: 120,
                  itemBuilder: ((context, index) {
                    return Card(
                      child: Row(
                        children: [
                          Container(
                              child: productProvider.data_list[index]
                                              ['category']
                                          .toString() ==
                                      'women\'s clothing'
                                  ? Image.network(productProvider
                                      .data_list[index]['image']
                                      .toString())
                                  : SizedBox(
                                      height: 1,
                                    )),
                          // Text(productProvider.data_list[index]['title']
                          //     .toString())
                        ],
                      ),
                    );
                  }))
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemExtent: 120,
                  itemBuilder: ((context, index) {
                    return Container(
                        child: categoriesNames == 'men\'s clothing'
                            ? Text(categoriesNames.first)
                            : Container(
                                color: Colors.amber,
                              ));
                  }))
            ],
          ),
        ),
      ]),
    );
  }
}
