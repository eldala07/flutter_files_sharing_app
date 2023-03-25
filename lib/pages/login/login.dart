import 'package:flutter/material.dart';
import 'package:responsive_sharing_files/pages/login/leftPanel/left_panel.dart';
import 'package:responsive_sharing_files/pages/login/rightPanel/right_panel.dart';
import 'package:responsive_sharing_files/theme/app_colors.dart';
import 'package:responsive_sharing_files/theme/responsive_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundColor,
        body: SizedBox(
            height: height,
            width: width,
            child: Row(
              children: [
                ResponsiveWidget.isMobile(context)
                    ? const SizedBox()
                    : const LeftPanel(),
                const RightPanel()
              ],
            )),
      ),
    );
  }
}
