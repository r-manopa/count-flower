import 'package:count_flower/providers/sum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:count_flower/helpers/update_count_args.dart';
import 'package:count_flower/providers/order.dart';

class UpdateCountScreen extends StatefulWidget {

    final UpdateCountArgs args;

    const UpdateCountScreen({ super.key, required this.args });

    @override
    State<UpdateCountScreen> createState() => _UpdateCountScreenState();
}

class _UpdateCountScreenState extends State<UpdateCountScreen> {

    @override
    Widget build(BuildContext context) {

        OrderProvider orderState = Provider.of<OrderProvider>(context);
        SumProvider sumState = Provider.of<SumProvider>(context);
        OrderProvider orderAction = Provider.of<OrderProvider>(context, listen: false);

        return Scaffold(
            appBar: AppBar(
                title: Text(orderState.orders[widget.args.orderIndex].subject),
                centerTitle: true,
            ),
            body: Column(
                children: [
                    Expanded(
                        child: Center(
                            child: Text(
                                orderState.orders[widget.args.orderIndex].total.toString(),
                                style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
                            ),
                        ),
                    ),
                    Expanded(
                        child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            padding: const EdgeInsets.all(16.0),
                            mainAxisSpacing: 16.0,
                            crossAxisSpacing: 16.0,
                            children: [
                                for(var item in sumState.nums)
                                    ElevatedButton(
                                        onPressed: () {
                                            orderAction.plus(widget.args.orderIndex, item.num);
                                        },
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                                        child: Text("+ ${item.num.toString()}", style: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),),
                                    )
                            ],
                        ),
                    ),
                    Expanded(
                        child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            padding: const EdgeInsets.all(16.0),
                            mainAxisSpacing: 16.0,
                            crossAxisSpacing: 16.0,
                            children: [
                                for(var item in sumState.nums)
                                    ElevatedButton(
                                        onPressed: () {
                                            orderAction.minus(widget.args.orderIndex, item.num);
                                        },
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                                        child: Text("- ${item.num.toString()}", style: const TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),),
                                    )
                            ],
                        ),
                    )
                ],
            ),
        );
    }

}