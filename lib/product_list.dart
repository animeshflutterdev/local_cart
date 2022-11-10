import 'package:badges/badges.dart';
import 'package:flu_todo/cart_model.dart';
import 'package:flu_todo/cart_provider.dart';
import 'package:flu_todo/cart_screen.dart';
import 'package:flu_todo/de_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DBHelper? dbHelper = DBHelper();

    List<String> productName = [
      'Mango',
      'Orange',
      'Grapes',
      'Banana',
      'Chery',
      'Peach',
      'Mixed Fruit Basket',
    ];
    List<String> productUnit = [
      'KG',
      'Dozen',
      'KG',
      'Dozen',
      'KG',
      'KG',
      'KG',
    ];
    List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];
    List<String> productImage = [
      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
      "https://images.unsplash.com/photo-1551326844-58f5b65b33f3?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
      "https://images.unsplash.com/photo-1559181567-c3190ca9959b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
      "https://images.unsplash.com/photo-1553175005-a1129d5c188c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80",
      "https://images.unsplash.com/photo-1551193270-975ab3ad07e9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80",
      "https://images.unsplash.com/photo-1553175005-7100cfda9311?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=765&q=80",
      "https://images.unsplash.com/photo-1558035579-a10d04acf787?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80",
    ];
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) =>const CartScreen()));
            },
            child: Center(
              child: Badge(
                showBadge: true,
                badgeContent: Consumer<CartProvider>(builder: (_, value, __) {
                  return Text(
                    value.getCounter().toString(),
                    style: const TextStyle(color: Colors.white),
                  );
                }),
                animationType: BadgeAnimationType.fade,
                animationDuration: const Duration(milliseconds: 300),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
          const SizedBox(width: 20.0)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: 6,
                itemBuilder: (_, int index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image(
                                height: 100,
                                width: 100,
                                image: NetworkImage(
                                    productImage[index].toString()),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      productName[index].toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "${productUnit[index].toString()} "
                                      "\$${productPrice[index].toString()}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            dbHelper
                                                .insert(Cart(
                                                    id: index,
                                                    productId: index.toString(),
                                                    productName:
                                                        productName[index]
                                                            .toString(),
                                                    initialPrice:
                                                        productPrice[index],
                                                    productPrice:
                                                        productPrice[index],
                                                    quantity: 1,
                                                    unitTag: productUnit[index]
                                                        .toString(),
                                                    image: productImage[index]
                                                        .toString()))
                                                .then(
                                              (value) {
                                                cart.addTotalPrice(
                                                  double.parse(
                                                      productPrice[index]
                                                          .toString()),
                                                );
                                                cart.addCounter();
                                                print(
                                                    "product added value $value");
                                              },
                                            ).onError(
                                              (error, stackTrace) {
                                                print(
                                                    "product cart error $error $stackTrace");
                                              },
                                            );
                                          },
                                          child: Text("+"),
                                        ),
                                        Text("0"),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text("-"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
/*
  Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          /// TODO: ACTION INTO DB
                                          dbHelper
                                              .insert(
                                            Cart(
                                              id: index,
                                              productId: index.toString(),
                                              productName:
                                                  productName[index].toString(),
                                              initialPrice: productPrice[index],
                                              productPrice: productPrice[index],
                                              quantity: 1,
                                              unitTag:
                                                  productUnit[index].toString(),
                                              image: productImage[index]
                                                  .toString(),
                                            ),
                                          )
                                              .then(
                                            (value) {
                                              cart.addTotalPrice(
                                                double.parse(
                                                  productPrice[index]
                                                      .toString(),
                                                ),
                                              );
                                              cart.addCounter();
                                              print(
                                                  "product added value $value");
                                            },
                                          ).onError(
                                            (error, stackTrace) {
                                              print(
                                                  "product cart error $error $stackTrace");
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: const Center(
                                            child: Text(
                                              'Add to cart',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
* */
