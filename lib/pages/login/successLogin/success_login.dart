import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sharing_files/shared/app_animations.dart';

import '../../../theme/app_colors.dart';

class SuccessLogin extends StatefulWidget {
  const SuccessLogin({Key? key}) : super(key: key);

  @override
  State<SuccessLogin> createState() => _SuccessLoginState();
}

class _SuccessLoginState extends State<SuccessLogin>
    with TickerProviderStateMixin {
  late AnimationController lottieController;
  late AnimationController scaleController;
  late Animation<double> _animationScale;

  @override
  void initState() {
    super.initState();
    lottieController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationScale = Tween<double>(begin: 1, end: 100).animate(
      CurvedAnimation(parent: scaleController, curve: Curves.easeInOutCubic),
    );

    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        lottieController.forward();
      });
    });

    scaleController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        context.go('/home');
        scaleController.reset();
        lottieController.reset();
      }
      setState(() {});
    });
    scaleController.addListener(() {
      setState(() {});
    });

    lottieController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        scaleController.forward();
      }
    });
  }

  @override
  dispose() {
    lottieController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, 0),
            colors: [
              AppColors.secondaryColor,
              AppColors.primaryColor,
            ],
          ),
        ),
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              controller: lottieController,
              repeat: false,
              width: width * 0.4 / _animationScale.value,
              height: height * 0.4 / _animationScale.value,
              AppAnimations.success,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
