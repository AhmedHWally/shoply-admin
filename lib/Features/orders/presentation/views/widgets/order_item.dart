import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoply_admin/Features/orders/data/userOrders_model.dart';
import 'package:intl/intl.dart';
import 'package:shoply_admin/constants.dart';

class OrderItem extends StatefulWidget {
  OrderItem({super.key, required this.userOrder});
  final UserOrders userOrder;
  double currentHeight = 0.075;
  bool isOpened = false;
  bool startedDelevery = false;
  bool delevired = false;
  IconData currentIcon = Icons.arrow_drop_down_outlined;
  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: Colors.purple[200]),
        width: width * 0.8,
        height: height * widget.currentHeight,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        if (widget.isOpened) {
                          setState(() {
                            widget.currentHeight = 0.075;
                            widget.isOpened = false;
                            widget.currentIcon = Icons.arrow_drop_down_outlined;
                          });
                        } else {
                          setState(() {
                            widget.currentHeight = 0.3;
                            widget.isOpened = true;
                            widget.currentIcon = Icons.arrow_drop_up_outlined;
                          });
                        }
                      },
                      icon: CircleAvatar(
                        backgroundColor: Colors.white70,
                        child: Icon(
                          widget.currentIcon,
                          color: Colors.black,
                          size: 28,
                        ),
                      )),
                ),
                Expanded(child: Text(widget.userOrder.userName)),
                Expanded(
                  child: Text(DateFormat('yyyy-MM-dd HH:mm:ss')
                      .format(widget.userOrder.orderDate)),
                )
              ],
            ),
            if (widget.isOpened)
              Expanded(
                  child: Column(
                children: [
                  const Text(
                    '(Order Details)',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 1)
                        ]),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Row(
                        children: [
                          Expanded(
                              child: Text(
                                  widget.userOrder.orderItems[index].title)),
                          Expanded(
                              child: Text(
                                  "price: ${widget.userOrder.orderItems[index].price}")),
                          Expanded(
                              child: Text(
                                  "quantity: ${widget.userOrder.orderItems[index].quantity}"))
                        ],
                      ),
                      itemCount: widget.userOrder.orderItems.length,
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      children: [
                        const Text('Phone number:'),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(child: Text(widget.userOrder.userPhoneNumber)),
                        const Text('area :'),
                        Expanded(child: Text(widget.userOrder.userAddress))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      children: [
                        const Text('Order state:'),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(child: Text(widget.userOrder.orderState)),
                        const Text('total price:'),
                        Text("${widget.userOrder.total}\$")
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor),
                          onPressed: () {
                            showAdaptiveDialog(
                                context: context,
                                builder: (ctx) => AlertDialog.adaptive(
                                      content: const Text(
                                          "are you sure you want to delete this order ?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: const Text('no')),
                                        TextButton(
                                            onPressed: () async {
                                              final firebase = FirebaseFirestore
                                                  .instance
                                                  .collection('userOrders');
                                              await firebase
                                                  .doc(widget.userOrder.orderId)
                                                  .delete();
                                              Navigator.of(ctx).pop();
                                            },
                                            child: const Text('yes'))
                                      ],
                                    ));
                          },
                          child: const Text('Remove Order')),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor),
                          onPressed: () {
                            showAdaptiveDialog(
                                context: context,
                                builder: (context) => StatefulBuilder(
                                      builder: (context, setState) =>
                                          AlertDialog.adaptive(
                                        content: SizedBox(
                                          height: height * 0.25,
                                          child: Column(
                                            children: [
                                              CheckboxListTile(
                                                  value: widget.startedDelevery,
                                                  title: const Text(
                                                      "Order is being delevired"),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      widget.startedDelevery =
                                                          value!;
                                                      if (widget
                                                              .startedDelevery ==
                                                          true) {
                                                        widget.delevired =
                                                            false;
                                                      }
                                                    });
                                                  }),
                                              CheckboxListTile(
                                                  value: widget.delevired,
                                                  title:
                                                      const Text("delerived"),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      widget.delevired = value!;
                                                      if (widget.delevired ==
                                                          true) {
                                                        widget.startedDelevery =
                                                            false;
                                                      }
                                                    });
                                                  }),
                                              const Expanded(child: SizedBox()),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    final firebase =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'userOrders');

                                                    if (widget
                                                            .startedDelevery ==
                                                        true) {
                                                      try {
                                                        await firebase
                                                            .doc(widget
                                                                .userOrder
                                                                .orderId)
                                                            .update({
                                                          "orderstate":
                                                              "Product is being delivered"
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      } catch (e) {}
                                                    } else if (widget
                                                            .delevired ==
                                                        true) {
                                                      try {
                                                        await firebase
                                                            .doc(widget
                                                                .userOrder
                                                                .orderId)
                                                            .update({
                                                          "orderstate":
                                                              "Order delevired"
                                                        });
                                                        Navigator.of(context)
                                                            .pop();
                                                      } catch (e) {}
                                                    }
                                                  },
                                                  child: const Text('Submit'))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                          },
                          child: const Text('change order state')),
                    ],
                  )
                ],
              ))
          ],
        ),
      ),
    );
  }
}
