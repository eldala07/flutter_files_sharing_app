import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_styles.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.secondaryColor,
      ),
      height: 50,
      child: Center(
        child: Text(
          'File manager',
          style: robotoStyle(fontSize: 14.0).copyWith(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
