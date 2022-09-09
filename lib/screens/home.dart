import 'package:count_flower/helpers/update_count_args.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:count_flower/providers/order.dart';

class HomeScreen extends StatelessWidget {

    const HomeScreen({super.key});

    @override
    Widget build(BuildContext context) {

        OrderProvider orderState = Provider.of<OrderProvider>(context);
        OrderProvider orderAction = Provider.of<OrderProvider>(context, listen: false);

        return Scaffold(
            appBar: AppBar(
                title: const Text("นับดอกไม้"),
                centerTitle: true,
                actions: [
                    IconButton(
                        onPressed: () {
                            orderAction.reset();
                        }, 
                        icon: const Icon(Icons.restore)
                    )
                ],
            ),
            drawer: _drawer(context),
            body: ListView.builder(
                itemCount: orderState.orders.length,
                itemBuilder: (context, index) => _orderList(
                    onUpdatePressed: () {
                        Navigator.pushNamed(context, "update_count", arguments: UpdateCountArgs(orderIndex: index));
                    },
                    onSuccessPressed: () {
                        orderAction.toggleSuccess(index);
                    },
                    onResetPressed: () {
                        orderAction.resetByIndex(index);
                    },
                    title: orderState.orders[index].subject,
                    success: orderState.orders[index].success,
                    total: orderState.orders[index].total.toString(),
                ),
            ),
        );

    }

    Widget _drawer(BuildContext context) {
        return Drawer(
            
            child: ListView(
                padding: EdgeInsets.zero,
                children: [
                    DrawerHeader(
                        child: Image.asset("assets/images/sunflower.png"),
                    ),
                    // SizedBox(height: MediaQuery.of(context).padding.top,),
                    _navItem(
                        title: "รายการดอกไม้",
                        onTap: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, "order");
                        }
                    ),
                    _navItem(
                        title: "จำนวนนับ",
                        onTap: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, "sum");
                        }
                    )
                ],
            ),
        );
    }

    Widget _navItem({ required String title, Function()? onTap }) {
        return ListTile(
            title: Text(title, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
            onTap: onTap,
        );
    }

    Widget _orderList({
        required String title, 
        required String total, 
        bool? success,
        required Function() onUpdatePressed,
        required Function() onSuccessPressed,
        required Function() onResetPressed,
    }) {
        return Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade200))
            ),
            child: Slidable(
                endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.4,
                    children: [
                        SlidableAction(
                            onPressed: (_) {
                                onSuccessPressed();
                            },
                            backgroundColor: success == true ? Colors.orange : Colors.green,
                            icon: success == true ? Icons.close : Icons.check,
                        ),
                        SlidableAction(
                            onPressed: (_) {
                                onResetPressed();
                            },
                            backgroundColor: Colors.red,
                            icon: Icons.restore,
                        )
                    ],
                ),
                child: SizedBox(
                    height: 80.0,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: GestureDetector(
                            onTap: onUpdatePressed,
                            child: Row(
                                children: [
                                    Expanded(
                                        child: Row(
                                            children: [
                                                Text(title, style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
                                                const SizedBox(width: 16.0,),
                                                if(success == true) const Icon(Icons.check, color: Colors.green,)
                                            ],
                                        )
                                    ),
                                    Text(total, style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.green),)
                                ],
                            ),
                        ),
                    ),
                ),
            )
        );
    }

}