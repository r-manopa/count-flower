import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:count_flower/providers/order.dart';

class AddOrderDialog extends StatefulWidget {

    const AddOrderDialog({super.key});

    @override
    State<AddOrderDialog> createState() => _AddOrderDialogState();

}

class _AddOrderDialogState extends State<AddOrderDialog> {

    final _formKey = GlobalKey<FormState>();
    final _controller = TextEditingController(text: "");

    String subject = "";

    @override
    Widget build(BuildContext context) {

        OrderProvider orderAction = Provider.of<OrderProvider>(context, listen: false);

        return AlertDialog(
            title: const Text("เพิ่มรายการดอกไม้"),
            actions: [
                TextButton(
                    onPressed: () {
                        if(_formKey.currentState!.validate()) {
                            // print("subject: $subject");
                            orderAction.add(subject);
                            _controller.clear();
                        }
                    }, 
                    child: const Text("บันทึก", style: TextStyle(fontWeight: FontWeight.bold),)
                ),
                TextButton(
                    onPressed: () {
                        Navigator.pop(context);
                    }, 
                    child: const Text("ปิด", style: TextStyle(fontWeight: FontWeight.bold),)
                ),
            ],
            content: _form(),
        );

    }

    Widget _form() {
        return Form(
            key: _formKey,
            child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                    hintText: "ชื่อดอกไม้"
                ),
                validator: (value) {
                    if(value == null || value.isEmpty) {
                        return "โปรดระบุชื่อดอกไม้";
                    }
                    return null;
                },
                onChanged: (value) {
                    setState(() {
                        subject = value;
                    });
                },
            ),
        );
    }

}