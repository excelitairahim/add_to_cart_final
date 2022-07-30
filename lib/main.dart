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
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.getdata();

    super.initState();
  }

  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(
      context,
    );
    List men = productProvider.data_list
        .where(
          (element) => element['category'] == 'men\'s clothing',
        )
        .toList();
    List women = productProvider.data_list
        .where(
          (element) => element['category'] == 'women\'s clothing',
        )
        .toList();
    List jewelery = productProvider.data_list
        .where(
          (element) => element['category'] == 'jewelery',
        )
        .toList();
    List electrics = productProvider.data_list
        .where(
          (element) => element['category'] == 'electronics',
        )
        .toList();

    // print('women ${data}');
    // print('women ${data.length}');
    // print(data[0]['title']);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey,
            elevation: 0,
            title: Text("BPPSHOP "),
          ),
          body: Padding(
            padding: EdgeInsets.all(3.0),
            child: Column(
              children: [
                Container(width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0)),
                  child: TabBar(padding: EdgeInsets.symmetric(horizontal: 0),
                   // isScrollable: true,
                    indicator: BoxDecoration(
                        color: Color.fromRGBO(102, 117, 102, 1),
                        borderRadius: BorderRadius.circular(5.0)),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    tabs: const [
                      Tab(text: 'All'),
                      Tab(text: 'Men'),
                      Tab(text: 'Jewelery'),
                      Tab(text: 'Women'),
                      Tab(text: 'Electics'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                              itemCount: productProvider.data_list.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                productProvider.data_list.sort(
                                    (a, b) => a['price'].compareTo(b['price']));
                                for (var p in productProvider.data_list) {
                                  print(p['price']);
                                }
                                return Card(
                                    child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          child: Image.network(productProvider
                                              .data_list[index]['image']
                                              .toString())),
                                    ),
                                    Text(
                                      productProvider.data_list[index]['title']
                                          .toString(),
                                      style: TextStyle(),
                                    ),
                                    Text(
                                      'Price ${productProvider.data_list[index]['price'].toString()}',
                                      style: TextStyle(),
                                    )
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
                              itemCount: men.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                // men.sort((a, b) => a['price'].compareTo(b['price']));
                                // for (var p in men) {
                                //  // print(p['price']);
                                // }
                                return Card(
                                    child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          child: Image.network(
                                              men[index]['image'].toString())),
                                    ),
                                    Text(
                                      men[index]['title'].toString(),
                                      style: TextStyle(),
                                    ),
                                    Text(
                                      'Price ${men[index]['price'].toString()}',
                                      style: TextStyle(),
                                    )
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
                              itemCount: jewelery.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Column(
                                    children: [
                                      Container(
                                          child: Expanded(
                                        child: Image.network(jewelery[index]
                                                ['image']
                                            .toString()),
                                      )),
                                      Text(jewelery[index]['title'].toString()),
                                      Text(
                                        'Price ${jewelery[index]['price'].toString()}',
                                        style: TextStyle(),
                                      )
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
                          GridView.builder(
                              itemCount: women.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            child: Image.network(women[index]
                                                    ['image']
                                                .toString())),
                                      ),
                                      Text(women[index]['title'].toString()),
                                      Text(
                                        'Price ${women[index]['price'].toString()}',
                                        style: TextStyle(),
                                      )
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
                          GridView.builder(
                              itemCount: electrics.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1,
                              ),
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            child: Image.network(
                                                electrics[index]['image']
                                                    .toString())),
                                      ),
                                      Text(
                                          electrics[index]['title'].toString()),
                                      Text(
                                        'Price ${electrics[index]['price'].toString()}',
                                        style: TextStyle(),
                                      )
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    ),
                  ]),
                )
              ],
            ),
          )),
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
  //List<Map<String, dynamic>> juwerieslist = [];

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
    List men = productProvider.data_list
        .where(
          (element) => element['category'] == 'men\'s clothing',
        )
        .toList();
    List women = productProvider.data_list
        .where(
          (element) => element['category'] == 'women\'s clothing',
        )
        .toList();
    List jewelery = productProvider.data_list
        .where(
          (element) => element['category'] == 'jewelery',
        )
        .toList();
    List electrics = productProvider.data_list
        .where(
          (element) => element['category'] == 'electronics',
        )
        .toList();

    // print('women ${data}');
    // print('women ${data.length}');
    // print(data[0]['title']);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        // toolbarHeight: 80,
        // flexibleSpace: Container(decoration: BoxDecoration(
        //  // color: LinearGradient(colors: [])
        // ),),
        // backgroundColor:Color(0xffFF6000),
        title: AppBar(
          title: Text(' BPPSHOP'),
        ),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 220.0,
          floating: true,
          pinned: true,
          snap: true,
          elevation: 50,
          backgroundColor: Colors.pink,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Title',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  )),
              background: Image.network(
                'https://images.pexels.com/photos/443356/pexels-photo-443356.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                fit: BoxFit.cover,
              )),
        ),

        //   TabBarView(controller: _tabController, children: [
        //   SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         GridView.builder(
        //             itemCount: productProvider.data_list.length,
        //             physics: NeverScrollableScrollPhysics(),
        //             shrinkWrap: true,
        //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //               crossAxisCount: 2,
        //               childAspectRatio: 1,
        //             ),
        //             itemBuilder: (context, index) {
        //               productProvider.data_list
        //                   .sort((a, b) => a['price'].compareTo(b['price']));
        //               for (var p in productProvider.data_list) {
        //                 print(p['price']);
        //               }
        //               return Card(
        //                   child: Column(
        //                 children: [
        //                   Expanded(
        //                     child: Container(
        //                         child: Image.network(productProvider
        //                             .data_list[index]['image']
        //                             .toString())),
        //                   ),
        //                   Text(
        //                     productProvider.data_list[index]['title'].toString(),
        //                     style: TextStyle(),
        //                   ),
        //                   Text(
        //                     'Price ${productProvider.data_list[index]['price'].toString()}',
        //                     style: TextStyle(),
        //                   )
        //                 ],
        //               ));
        //             })
        //       ],
        //     ),
        //   ),
        //   SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         GridView.builder(
        //             itemCount: men.length,
        //             physics: NeverScrollableScrollPhysics(),
        //             shrinkWrap: true,
        //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //               crossAxisCount: 2,
        //               childAspectRatio: 1,
        //             ),
        //             itemBuilder: (context, index) {
        //               // men.sort((a, b) => a['price'].compareTo(b['price']));
        //               // for (var p in men) {
        //               //  // print(p['price']);
        //               // }
        //               return Card(
        //                   child: Column(
        //                 children: [
        //                   Expanded(
        //                     child: Container(
        //                         child: Image.network(
        //                             men[index]['image'].toString())),
        //                   ),
        //                   Text(
        //                     men[index]['title'].toString(),
        //                     style: TextStyle(),
        //                   ),
        //                   Text(
        //                     'Price ${men[index]['price'].toString()}',
        //                     style: TextStyle(),
        //                   )
        //                 ],
        //               ));
        //             })
        //       ],
        //     ),
        //   ),
        //   SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         GridView.builder(
        //             itemCount: jewelery.length,
        //             shrinkWrap: true,
        //             physics: NeverScrollableScrollPhysics(),
        //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //               crossAxisCount: 2,
        //               childAspectRatio: 1,
        //             ),
        //             itemBuilder: (context, index) {
        //               return Card(
        //                 child: Column(
        //                   children: [
        //                     Container(
        //                         child: Expanded(
        //                       child: Image.network(
        //                           jewelery[index]['image'].toString()),
        //                     )),
        //                     Text(jewelery[index]['title'].toString()),
        //                     Text(
        //                       'Price ${jewelery[index]['price'].toString()}',
        //                       style: TextStyle(),
        //                     )
        //                   ],
        //                 ),
        //               );
        //             })
        //       ],
        //     ),
        //   ),
        //   SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         GridView.builder(
        //             itemCount: women.length,
        //             physics: NeverScrollableScrollPhysics(),
        //             shrinkWrap: true,
        //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //               crossAxisCount: 2,
        //               childAspectRatio: 1,
        //             ),
        //             itemBuilder: (context, index) {
        //               return Card(
        //                 child: Column(
        //                   children: [
        //                     Expanded(
        //                       child: Container(
        //                           child: Image.network(
        //                               women[index]['image'].toString())),
        //                     ),
        //                     Text(women[index]['title'].toString()),
        //                     Text(
        //                       'Price ${women[index]['price'].toString()}',
        //                       style: TextStyle(),
        //                     )
        //                   ],
        //                 ),
        //               );
        //             })
        //       ],
        //     ),
        //   ),
        //   SingleChildScrollView(
        //     child: Column(
        //       children: [
        //         GridView.builder(
        //             itemCount: electrics.length,
        //             physics: NeverScrollableScrollPhysics(),
        //             shrinkWrap: true,
        //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //               crossAxisCount: 2,
        //               childAspectRatio: 1,
        //             ),
        //             itemBuilder: (context, index) {
        //               return Card(
        //                 child: Column(
        //                   children: [
        //                     Expanded(
        //                       child: Container(
        //                           child: Image.network(
        //                               electrics[index]['image'].toString())),
        //                     ),
        //                     Text(electrics[index]['title'].toString()),
        //                     Text(
        //                       'Price ${electrics[index]['price'].toString()}',
        //                       style: TextStyle(),
        //                     )
        //                   ],
        //                 ),
        //               );
        //             })
        //       ],
        //     ),
        //   ),
        // ]),
      ]),
    );
  }
}
