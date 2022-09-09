import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:count_flower/providers/order.dart';
import 'package:count_flower/widgets/add_order_dialog.dart';

class OrderScreen extends StatelessWidget {

    const OrderScreen({super.key});

    @override
    Widget build(BuildContext context) {

        OrderProvider orderState = Provider.of<OrderProvider>(context);
        OrderProvider orderAction = Provider.of<OrderProvider>(context, listen: false);

        return Scaffold(
            appBar: AppBar(
                title: const Text("รายการดอกไม้"),
                centerTitle: true,
                actions: [
                    IconButton(
                        onPressed: () {
                            showDialog(context: context, builder: (context) => const AddOrderDialog(),);
                        }, 
                        icon: const Icon(Icons.add)
                    )
                ],
            ),
            body: ReorderableListView.builder(
                itemCount: orderState.orders.length,
                onReorder: (oldIndex, newIndex) {
                    orderAction.updateIndex(oldIndex, newIndex);
                },
                itemBuilder: (context, index) => _orderList(
                    onPressed: () {
                        orderAction.remove(index);
                    },
                    context: context,
                    key: ValueKey("key_$index"),
                    title: orderState.orders[index].subject,
                ),
            )
        );
    }

    Widget _orderList({
        required BuildContext context,
        required Key key,
        required String title, 
        required Function() onPressed
    }) {
        return Container(
            key: key,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade200))
            ),
            child: Slidable(
                endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.2,
                    children: [
                        SlidableAction(
                            onPressed: (_) {
                                onPressed();
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                        )
                    ],
                ),
                child: SizedBox(
                    height: 60.0,
                    child: Row(
                        children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width - 45.0,
                                    child: Text(
                                        title, 
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: false,
                                        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                    ),
                                ),
                            )
                        ],
                    ),
                ),
            )
        );
    }
}