import 'package:asp/asp.dart';

// atom
final counterState = Atom<int>(0);

// computed
String get countText => counterState.value.isEven ? 'Even' : 'Odd';
