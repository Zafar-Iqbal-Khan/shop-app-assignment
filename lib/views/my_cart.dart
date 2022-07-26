// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/controller/controller.dart';

import 'home_page.dart';

class MyCartScreen extends StatefulWidget {
  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  ShoppingController shoppingController = Get.find<ShoppingController>();

  var quantity = 1.obs;
  List items = [].obs;
  var itemPrices = 0.obs;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < shoppingController.addToCartList.length; i++) {
      items.add(1);
    }
    shoppingController.addToCartList.forEach((element) {
      itemPrices.value = (itemPrices.value + element.price!.toInt());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.14,
              padding: EdgeInsets.only(top: 40),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Text(
                    'MyCart',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.red[100],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock,
                    color: Colors.redAccent[100],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'You have ${shoppingController.addToCartList.length} items in your cart',
                    style: TextStyle(
                      color: Colors.redAccent[100],
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Image.network(
                            shoppingController.addToCartList[index].image
                                .toString(),
                            height: 80,
                            width: 80,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          SizedBox(
                            height: 88,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * .6,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          shoppingController
                                              .addToCartList[index].title
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          int ind = items[index];
                                          int val = shoppingController
                                              .addToCartList[index].price!
                                              .toInt();
                                          itemPrices.value =
                                              (itemPrices.value - (val * ind));
                                          shoppingController.addToCartList
                                              .removeAt(index);
                                          items.removeAt(index);
                                          setState(() {});
                                          shoppingController.cartLength();
                                        },
                                        child: Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Obx(
                                  () => SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .6,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$${shoppingController.addToCartList[index].price}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (items[index] > 1) {
                                                  items[index]--;
                                                  itemPrices.value = (itemPrices
                                                          .value -
                                                      shoppingController
                                                          .addToCartList[index]
                                                          .price!
                                                          .toInt());
                                                }
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.remove),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              items[index].toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            GestureDetector(
                                              onTap: () {
                                                items[index]++;
                                                itemPrices.value = itemPrices
                                                        .value +
                                                    shoppingController
                                                        .addToCartList[index]
                                                        .price!
                                                        .toInt();
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(Icons.add),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 15),
              child: Column(
                children: [
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "items",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${itemPrices.value}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Discounts",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${(itemPrices * .1).toInt()}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\$${itemPrices.value - (itemPrices * .1).toInt()}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Confirm Order"),
                              content: Text("Are you sure you want to order?"),
                              actions: [
                                FlatButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                FlatButton(
                                  child: Text("Confirm"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Get.snackbar(
                                      'Success',
                                      'Order Placed Successfully',
                                    );
                                    shoppingController.addToCartList.clear();
                                    shoppingController.cartLength();
                                    Get.to(HomePage());
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(
                            35,
                          )),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      child: Text(
                        "Checkout",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
