import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  final double size;
  const Logo({super.key, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Command Hub',
      style: GoogleFonts.shareTechMono(
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
