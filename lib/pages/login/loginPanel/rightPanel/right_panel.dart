import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sharing_files/theme/app_styles.dart';

import '../../../../main.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/responsive_widget.dart';

class RightPanel extends StatefulHookConsumerWidget {
  const RightPanel({Key? key}) : super(key: key);

  @override
  _RightPanelState createState() => _RightPanelState();
}

class _RightPanelState extends ConsumerState<RightPanel>
    with TickerProviderStateMixin {
  late bool _isObscured = true;

  var loginNode = FocusNode();
  var passwordNode = FocusNode();
  var emailNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  handleLogin(ref) {
    loginNode.requestFocus();
    if (kDebugMode) {
      print('Login');
    }
    print(ref.read(showSuccessLoginProvider.notifier).state);
    ref.read(showSuccessLoginProvider.notifier).state = true;
  }

  focusPassword() {
    passwordNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    passwordNode.dispose();
    emailNode.dispose();
    loginNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: ResponsiveWidget.isMobile(context) ? 5 : 4,
      child: Container(
        color: AppColors.backgroundColor,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Hey, welcome ',
                            style: robotoStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'back 👋',
                            style: robotoStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 250),
                      child: Text(
                        'Enter your details below to access your data',
                        style: robotoStyle(fontSize: 14.0).copyWith(
                          color: AppColors.textLightColor,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: ResponsiveWidget.isMobile(context)
                              ? 0
                              : ResponsiveWidget.isTablet(context)
                                  ? 100
                                  : 150),
                      child: RawKeyboardListener(
                        focusNode: emailNode,
                        onKey: (RawKeyEvent event) {
                          if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                            focusPassword();
                          }
                        },
                        child: TextField(
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: 'john@doe.com',
                            hintStyle: robotoStyle(
                              fontSize: 14.0,
                              color: AppColors.textColor.withOpacity(0.25),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.textColor,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.textColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: ResponsiveWidget.isMobile(context)
                              ? 0
                              : ResponsiveWidget.isTablet(context)
                                  ? 50
                                  : 100),
                      child: RawKeyboardListener(
                        focusNode: passwordNode,
                        onKey: (event) {
                          if (FocusScope.of(context).isFirstFocus &&
                              event.isKeyPressed(LogicalKeyboardKey.enter)) {
                            handleLogin(ref);
                          }
                        },
                        child: TextField(
                          obscureText: _isObscured,
                          decoration: InputDecoration(
                            hintText: 'password123!',
                            hintStyle: robotoStyle(
                              fontSize: 14.0,
                              color: AppColors.textColor.withOpacity(0.25),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscured
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.textColor,
                                size: 18,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.textColor,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.textColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: ResponsiveWidget.isMobile(context)
                              ? 0
                              : ResponsiveWidget.isTablet(context)
                                  ? 50
                                  : 100),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            transform: Matrix4.translationValues(10, 0, 0),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot password?',
                                style: robotoStyle(
                                  fontSize: 12.0,
                                  color: AppColors.textLightColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      focusNode: loginNode,
                      onPressed: () => {
                        handleLogin(ref),
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                        child: Text(
                          'Leeet\'s browse !',
                          style: robotoStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ]),
        ),
      ),
    );
  }
}
