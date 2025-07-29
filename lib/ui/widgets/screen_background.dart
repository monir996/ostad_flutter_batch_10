import 'package:assignment_04/ui/utils/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;

class ScreenBackground extends StatelessWidget {
  final Widget child;

  const ScreenBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetPaths.backgroundSvg,
          fit: BoxFit.cover,
          height: double.maxFinite,
          width: double.maxFinite,
        ),
        SafeArea(child: child)
      ],
    );
  }
}
