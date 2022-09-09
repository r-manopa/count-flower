import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:count_flower/providers/order.dart';
import 'package:count_flower/providers/sum.dart';

List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => OrderProvider(),),
    ChangeNotifierProvider(create: (context) => SumProvider(),),
];