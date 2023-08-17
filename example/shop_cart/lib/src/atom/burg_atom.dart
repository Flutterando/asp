import 'package:asp/asp.dart';

import '../models/burg_model.dart';

// atoms
final burgs = <BurgModel>[].asAtom();
final burgLoading = Atom(true);

// actions
final fetchBurgs = Atom.action();
final addBurg = Atom<BurgModel?>(null);
