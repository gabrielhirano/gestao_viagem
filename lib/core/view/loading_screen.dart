import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestao_viajem/core/theme/theme_global.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(seconds: 4), // Ajuste a duração conforme necessário
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.colorBackgroundWhite,
      body: Center(
        child: SizedBox(
          width: 160,
          height: 160,
          child: Stack(
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/svgs/world.svg',
                  color: appColors.colorBrandPrimaryBlue,
                  height: 120,
                ),
              ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: RotationTransition(
                  turns: _animationController,
                  child: Container(
                    child: SvgPicture.asset(
                      'assets/svgs/circular.svg',
                      color: appColors.colorBrandPrimaryBlue,
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   right: 0,
              //   top: 0,
              //   bottom: 0,
              //   child: Container(
              //     color: Colors.black,
              //     child: SvgPicture.asset(
              //       'assets/svgs/world.svg',
              //       color: appColors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
