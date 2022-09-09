import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:count_flower/models/order.dart';

class OrderProvider extends ChangeNotifier {

    final _storeKey = "_order";
    final _storage = const FlutterSecureStorage();

    final List<OrderModel> _orders = [
        // OrderModel(
        //     subject: "ขาว",
        //     total: 320,
        // ),
        // OrderModel(
        //     subject: "แดง",
        //     total: 50,
        // ),
        // OrderModel(
        //     subject: "เหลือง",
        //     total: 73,
        // ),
        // OrderModel(
        //     subject: "ชมพูแซมขาว",
        //     total: 0,
        // ),
    ];

    List<OrderModel> get orders => _orders;

    void plus(int index, int num) {

        _orders[index].total = _orders[index].total + num;
        
        saveData();

        notifyListeners();
    }

    void minus(int index, int num) {

        _orders[index].total = _orders[index].total - num;

        saveData();

        notifyListeners();
    }

    void toggleSuccess(int index) {

        if(_orders[index].success == false) {
            _orders[index].success = true;
        }
        else {
            _orders[index].success = false;
        }

        saveData();

        notifyListeners();
    }

    void reset() {

        _orders.asMap().forEach((index, item) {
            _orders[index].total = 0;
            _orders[index].success = false;
        });

        saveData();

        notifyListeners();
    }

    void resetByIndex(int index) {
        _orders[index].total = 0;
        _orders[index].success = false;

        saveData();

        notifyListeners();
    }

    void add(String subject) {

        _orders.add(
            OrderModel(subject: subject, total: 0, success: false)
        );

        saveData();

        notifyListeners();
    }

    void remove(int index) {

        _orders.removeAt(index);

        saveData();

        notifyListeners();
        
    }

    void updateIndex(int oldIndex, int newIndex) {

        if (oldIndex < newIndex) {
            newIndex -= 1;
        }

        final item = _orders.removeAt(oldIndex);
        _orders.insert(newIndex, item);

        saveData();

        notifyListeners();
    }

    Future<void> loadData() async {

        final result = await _storage.read(
            key: _storeKey, 
            aOptions: const AndroidOptions(encryptedSharedPreferences: true)
        );

        if(_orders.isEmpty && result != null) {

            List<dynamic> itemData = jsonDecode(result);
            for (var element in itemData) { 
                _orders.add(OrderModel.fromJson(element));
            }

            notifyListeners();
        }
    }

    Future<void> saveData() async {
        await _storage.write(
            key: _storeKey,
            value: jsonEncode(_orders),
            aOptions: const AndroidOptions(encryptedSharedPreferences: true)
        );
    }
}