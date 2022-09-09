import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:count_flower/providers/sum.dart';

class AddSumDialog extends StatefulWidget {

    const AddSumDialog({super.key});

    @override
    State<AddSumDialog> createState() => _AddSumDialogState();

}

class _AddSumDialogState extends State<AddSumDialog> {

    final _formKey = GlobalKey<FormState>();
    final _controller = TextEditingController(text: "");

    String num = "";

    @override
    Widget build(BuildContext context) {

        SumProvider sumAction = Provider.of<SumProvider>(context, listen: false);

        return AlertDialog(
            title: const Text("เพิ่มจำนวนนับ"),
            actions: [
                TextButton(
                    onPressed: () {
                        if(_formKey.currentState!.validate()) {
                            sumAction.add(int.parse(num));
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
                    hintText: "จำนวนนับ"
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                    if(value == null || value.isEmpty) {
                        return "โปรดระบุจำนวนนับ";
                    }
                    return null;
                },
                onChanged: (value) {
                    setState(() {
                        num = value;
                    });
                },
            ),
        );
    }

}