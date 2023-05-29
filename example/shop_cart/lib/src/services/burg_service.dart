import 'package:uno/uno.dart';

import '../models/burg_model.dart';

class BurgService {
  final Uno uno;

  BurgService(this.uno);

  Future<List<BurgModel>> fetchBurgs() async {
    final response = await uno.get('http://127.0.0.1:3031/products');
    final list = response.data as List;
    return list.map((e) => BurgModel.fromMap(e)).toList();
  }
}
