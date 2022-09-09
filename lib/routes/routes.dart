import 'package:count_flower/helpers/update_count_args.dart';
import 'package:flutter/material.dart';
import 'package:count_flower/screens/home.dart';
import 'package:count_flower/screens/update_count.dart';
import 'package:count_flower/screens/order.dart';
import 'package:count_flower/screens/sum.dart';

class Routes {

    static Map<String, Widget Function(BuildContext)> routes() {
        return {
            "/" : (context) => const HomeScreen(),
            // "update_count": (context) => const UpdateCountScreen(),
            "order": (context) => const OrderScreen(),
            "sum": (context) => const SumScreen()
        };
    }

    static Route<dynamic>? generateRoute(RouteSettings settings) {

        if(settings.name == "update_count") {

            final args = settings.arguments as UpdateCountArgs;

            return MaterialPageRoute(builder: (context) {
                return UpdateCountScreen(args: args,);
            });
        }


        return null;
    }
}