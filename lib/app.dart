import 'package:count_flower/providers/order.dart';
import 'package:count_flower/providers/sum.dart';
import 'package:flutter/material.dart';
import 'package:count_flower/routes/routes.dart';
import 'package:provider/provider.dart';

class CountFlower extends StatelessWidget {

    const CountFlower({super.key});

    @override
    Widget build(BuildContext context) {

        OrderProvider orderAction = Provider.of<OrderProvider>(context, listen: false);
        SumProvider sumAction = Provider.of<SumProvider>(context, listen: false);
        
        orderAction.loadData();
        sumAction.loadData();

        return MaterialApp(
            title: "นับดอกไม้",
            theme: ThemeData(
                fontFamily: "kanit",
                primarySwatch: Colors.green,
                useMaterial3: true
            ),
            routes: Routes.routes(),
            onGenerateRoute: (settings) => Routes.generateRoute(settings),
            initialRoute: "/",
        );
    }
    
}