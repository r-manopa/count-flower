import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:count_flower/providers/providers.dart';
import 'package:count_flower/app.dart';

void main() {

    final app = MultiProvider(
        providers: providers,
        child: const CountFlower(),
    );

    runApp(app);

}
