import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:count_flower/models/sum.dart';

class SumProvider extends ChangeNotifier {

    final _storeKey = "_sum";
    final _storage = const FlutterSecureStorage();

    final List<SumModel> _nums = [
        // SumModel(num: 1),
        // SumModel(num: 10),
        // SumModel(num: 25),
        // SumModel(num: 50),
        // SumModel(num: 70),
    ];

    List<SumModel> get nums => _nums;

    void add(int num) {

        _nums.add(
            SumModel(num: num)
        );

        saveData();

        notifyListeners();
    }

    void remove(int index) {

        _nums.removeAt(index);

        saveData();

        notifyListeners();
        
    }

    Future<void> loadData() async {

        final result = await _storage.read(
            key: _storeKey, 
            aOptions: const AndroidOptions(encryptedSharedPreferences: true)
        );

        if(_nums.isEmpty && result != null) {

            List<dynamic> itemData = jsonDecode(result);
            for (var element in itemData) { 
                _nums.add(SumModel.fromJson(element));
            }

            notifyListeners();
        }
    }

    Future<void> saveData() async {
        await _storage.write(
            key: _storeKey,
            value: jsonEncode(_nums),
            aOptions: const AndroidOptions(encryptedSharedPreferences: true)
        );
    }

}