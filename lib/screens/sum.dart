import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:count_flower/providers/sum.dart';
import 'package:count_flower/widgets/add_sum_dialog.dart';

class SumScreen extends StatelessWidget {

    const SumScreen({super.key});

    @override
    Widget build(BuildContext context) {

        SumProvider sumState = Provider.of<SumProvider>(context);
        SumProvider sumAction = Provider.of<SumProvider>(context, listen: false);

        return Scaffold(
            appBar: AppBar(
                title: const Text("จำนวนนับ"),
                centerTitle: true,
                actions: [
                    IconButton(
                        onPressed: () {
                            showDialog(context: context, builder: (context) => const AddSumDialog(),);
                        }, 
                        icon: const Icon(Icons.add)
                    )
                ],
            ),
            body: ReorderableListView.builder(
                itemCount: sumState.nums.length,
                onReorder: (oldIndex, newIndex) {
                    sumAction.updateIndex(oldIndex, newIndex);
                },
                itemBuilder: (context, index) => _orderList(
                    onPressed: () {
                        sumAction.remove(index);
                    },
                    key: ValueKey("key_$index"),
                    title: sumState.nums[index].num.toString(),
                ),
            ),
        );
    }

    Widget _orderList({
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
                    child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(
                            children: [
                                Text(title, style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),)
                            ],
                        ),
                    ),
                ),
            )
        );
    }
}