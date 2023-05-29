import 'package:asp/asp.dart';

import '../models/burg_model.dart';

// atoms
final burgs = RxList<BurgModel>([]);
final burgLoading = Atom(true);

// actions
final fetchBurgs = Atom.action();
final addBurg = Atom<BurgModel?>(null);
