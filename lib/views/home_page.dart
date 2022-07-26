// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shop_app/controller/controller.dart';
import 'package:get/get.dart';
import 'package:shop_app/views/my_cart.dart';

class HomePage extends StatelessWidget {
  ShoppingController shoppingController = Get.put(ShoppingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(
        () => shoppingController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50),
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back_ios_new),
                                  onPressed: () {},
                                ),
                                Expanded(
                                  child: Text(
                                    'My Shop',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.shopping_cart),
                                  onPressed: () {
                                    shoppingController.addToCartList.isNotEmpty
                                        ? Get.to(MyCartScreen())
                                        : Get.snackbar('Cart is empty',
                                            'Please add some items to cart');
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(12),
                              child: StaggeredGridView.countBuilder(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 12,
                                  itemCount:
                                      shoppingController.shopping!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.only(
                                        left: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            child: Image.network(
                                              shoppingController
                                                  .shopping![index].image!,
                                              height: 150,
                                              width: 100,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "\$${shoppingController.shopping![index].price.toString()}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            shoppingController
                                                .shopping![index].title
                                                .toString(),
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            // "quantity",
                                            "Rating : ${shoppingController.shopping![index].rating!.rate.toString()}",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height: index % 2 == 0 ? 10 : 30,
                                          ),
                                          Container(
                                            alignment: Alignment.bottomRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                bool isPresent = false;
                                                shoppingController.addToCartList
                                                    .forEach((element) {
                                                  if (element.id ==
                                                      shoppingController
                                                          .shopping![index]
                                                          .id) {
                                                    isPresent = true;
                                                  }
                                                });
                                                if (isPresent == false) {
                                                  shoppingController
                                                      .addToCartList
                                                      .add(shoppingController
                                                          .shopping![index]);
                                                  Get.snackbar(
                                                    'Item  added',
                                                    'item has been added to cart',
                                                    duration:
                                                        Duration(seconds: 1),
                                                  );
                                                } else {
                                                  Get.snackbar(
                                                    'Item already added',
                                                    'item is already added to cart',
                                                    duration:
                                                        Duration(seconds: 1),
                                                  );
                                                }
                                                shoppingController.cartLength();
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  right: 10,
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(),
                                                ),
                                                child: Text("add to cart"),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  staggeredTileBuilder: (index) {
                                    return StaggeredTile.count(
                                        1, index.isEven ? 1.6 : 1.8);
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          shoppingController.addToCartList.isNotEmpty
                              ? Get.to(MyCartScreen())
                              : Get.snackbar('Cart is empty',
                                  'Please add some items to cart');
                        },
                        child: Container(
                          color: Colors.black,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 30),
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Cart',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        shoppingController.shopping!.isNotEmpty
                                            ? shoppingController
                                                .shopping![1].image!
                                            : ""),
                                  ),
                                ],
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.amber,
                                radius: 20,
                                child: Text(
                                  shoppingController.cartCount.value.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
