import 'package:flutter/material.dart';

import '../models/burg_model.dart';

class BurgCard extends StatelessWidget {
  final BurgModel model;
  final void Function()? onTap;
  const BurgCard({
    super.key,
    required this.model,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 7,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  model.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 45,
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 2, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(model.toMoney()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
