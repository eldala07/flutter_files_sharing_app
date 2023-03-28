import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sharing_files/theme/app_colors.dart';
import 'package:responsive_sharing_files/theme/responsive_widget.dart';

import '../../../../shared/app_images.dart';

class LeftPanel extends StatefulWidget {
  const LeftPanel({Key? key}) : super(key: key);

  @override
  State<LeftPanel> createState() => _LeftPanelState();
}

class _LeftPanelState extends State<LeftPanel> with TickerProviderStateMixin {
  late bool _animateTitle = false;

  late AnimationController _initAnimationController;
  late AnimationController _animationController;

  late Animation<double> _animation;
  late Animation<double> _animation_2;
  late Animation<double> _initAnimation;

  @override
  void initState() {
    super.initState();
    _animateTitle = false;

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _animateTitle = true;
      });
    });

    _initAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    _initAnimation = Tween<double>(begin: 250, end: 0).animate(
      CurvedAnimation(
          parent: _initAnimationController, curve: Curves.easeInOutCubic),
    );
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _initAnimationController.forward();
      });
    });

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
    _animation = Tween<double>(begin: -135.0, end: -120.0).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.easeInOutCubic),
    );
    _animation_2 = Tween<double>(begin: -150.0, end: -135.0).animate(
      CurvedAnimation(
          parent: _animationController, curve: Curves.easeInOutCubic),
    );
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _animationController.forward();
      });
    });

    // The looping is done via listener.
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.reverse();
      }
      if (_animationController.isDismissed) {
        _animationController.forward();
      }
      // setState(() {});
    });

    _initAnimationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _initAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: ResponsiveWidget.isMobile(context) ? 2 : 3,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0, 0),
                colors: [
                  AppColors.secondaryColor,
                  AppColors.primaryColor,
                ],
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: AnimatedOpacity(
                opacity: _animateTitle ? 1 : 0,
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 1500),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeInOut,
                  transform:
                      Matrix4.translationValues(0, _animateTitle ? 0 : 40, 0),
                  child: const Text(
                    'Files sharing app',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: _animation.value - _initAnimation.value,
            right: -125,
            child: SvgPicture.asset(
              AppImages.bubble1,
            ),
          ),
          Positioned(
            bottom: _animation_2.value - _initAnimation.value,
            left: -125,
            child: SvgPicture.asset(
              AppImages.bubble2,
            ),
          ),
        ],
      ),
    );
  }
}
