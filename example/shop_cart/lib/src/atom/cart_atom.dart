// atom
import 'package:asp/asp.dart';

import '../models/burg_model.dart';

// atom
final cartBurgs = <BurgModel>[].asAtom();
final finalValue = Atom<String>('R\$ 0.00');

// action
final removeBurg = Atom<BurgModel?>(null);
final cleanCart = Atom.action();
