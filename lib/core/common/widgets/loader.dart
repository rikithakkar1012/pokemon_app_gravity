import 'package:flutter/material.dart';
import 'package:pokemon_app_gravity/core/theme/app_palette.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppPalette.primaryDark),
      ),
    );
  }
}
