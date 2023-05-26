import 'package:auto_injector/auto_injector.dart';

import 'reducers/shop_reducer.dart';

final injector = AutoInjector(
  on: (i) {
    i.addSingleton(ShopReducer.new);
  },
);
