import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sharing_files/pages/login/loginPanel/login_panel.dart';
import 'package:responsive_sharing_files/pages/login/successLogin/success_login.dart';
import 'package:responsive_sharing_files/theme/app_colors.dart';

import '../../main.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(widget) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool showSuccessLogin = ref.watch(showSuccessLoginProvider);
    print("showSuccessLogin: $showSuccessLogin");
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundColor,
        body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 1500),
            transitionBuilder: __transitionBuilder,
            layoutBuilder: (widget, list) =>
                Stack(children: [widget!, ...list]),
            switchInCurve: Curves.easeInBack,
            switchOutCurve: Curves.easeInBack.flipped,
            child:
                showSuccessLogin ? const SuccessLogin() : const LoginPanel()),
      ),
    );
  }
}
