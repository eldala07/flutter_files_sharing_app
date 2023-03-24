import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sharing_files/theme/app_colors.dart';
import 'package:responsive_sharing_files/theme/app_styles.dart';
import 'package:responsive_sharing_files/theme/responsive_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late bool _isObscured = true;
  late bool _animateTitle = false;

  late AnimationController _initAnimationController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _animation_2;
  late Animation<double> _initAnimation;

  var loginNode = FocusNode();
  var passwordNode = FocusNode();
  var emailNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _isObscured = true;
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
      setState(() {});
    });
    _initAnimationController.addListener(() {
      setState(() {});
    });
  }

  handleLogin() {
    loginNode.requestFocus();
    if (kDebugMode) {
      print('Login');
    }
  }

  focusPassword() {
    passwordNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _initAnimationController.dispose();
    passwordNode.dispose();
    emailNode.dispose();
    loginNode.dispose();
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
                    : Expanded(
                        flex: 3,
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
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    curve: Curves.easeInOut,
                                    transform: Matrix4.translationValues(
                                        0, _animateTitle ? 0 : 40, 0),
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
                                'assets/images/bubble_1.svg',
                              ),
                            ),
                            Positioned(
                              bottom: _animation_2.value - _initAnimation.value,
                              left: -125,
                              child: SvgPicture.asset(
                                'assets/images/bubble_2.svg',
                              ),
                            ),
                          ],
                        ),
                      ),
                Expanded(
                  flex: 4,
                  child: Container(
                    color: AppColors.backgroundColor,
                    child: Column(children: [
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 50,
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
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
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: 'back 👋',
                                        style: robotoStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 250),
                                  child: Text(
                                    'Let\'s sign in. Enter your details below to access your data',
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
                                      if (event.isKeyPressed(
                                          LogicalKeyboardKey.enter)) {
                                        focusPassword();
                                      }
                                    },
                                    child: TextField(
                                      autofocus: true,
                                      decoration: InputDecoration(
                                        hintText: 'john@doe.com',
                                        hintStyle: robotoStyle(
                                          fontSize: 14.0,
                                          color: AppColors.textColor
                                              .withOpacity(0.25),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
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
                                          event.isKeyPressed(
                                              LogicalKeyboardKey.enter)) {
                                        handleLogin();
                                      }
                                    },
                                    child: TextField(
                                      obscureText: _isObscured,
                                      decoration: InputDecoration(
                                        hintText: 'password123!',
                                        hintStyle: robotoStyle(
                                          fontSize: 14.0,
                                          color: AppColors.textColor
                                              .withOpacity(0.25),
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
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.textColor,
                                          ),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
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
                                      InkWell(
                                        onTap: () {},
                                        child: Text(
                                          'Forgot password?',
                                          style: robotoStyle(
                                            fontSize: 12.0,
                                            color: AppColors.textLightColor,
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
                                  onPressed: handleLogin,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16.0, 10.0, 16.0, 10.0),
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
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 50,
                        ),
                      ),
                    ]),
                  ),
                ),
                // Expanded(
                //   flex: 4,
                //   child: Container(
                //     color: AppColors.backgroundColor,
                //     child: Column(
                //       children: [
                //         const Expanded(
                //           flex: 2,
                //           child: Center(
                //             child: Text(
                //               'Login',
                //               style: TextStyle(
                //                 color: AppColors.primaryColor,
                //                 fontSize: 40,
                //                 fontWeight: FontWeight.bold,
                //               ),
                //             ),
                //           ),
                //         ),
                //         Expanded(
                //           flex: 3,
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.symmetric(
                //                     horizontal: 40, vertical: 10),
                //                 child: TextField(
                //                   decoration: InputDecoration(
                //                     hintText: 'Email',
                //                     hintStyle: const TextStyle(
                //                       color: AppColors.textLightColor,
                //                     ),
                //                     border: OutlineInputBorder(
                //                       borderRadius: BorderRadius.circular(10),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.symmetric(
                //                     horizontal: 40, vertical: 10),
                //                 child: TextField(
                //                   decoration: InputDecoration(
                //                     hintText: 'Password',
                //                     hintStyle: const TextStyle(
                //                       color: AppColors.textLightColor,
                //                     ),
                //                     border: OutlineInputBorder(
                //                       borderRadius: BorderRadius.circular(10),
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.symmetric(
                //                     horizontal: 40, vertical: 10),
                //                 child: SizedBox(
                //                   width: double.infinity,
                //                   child: ElevatedButton(
                //                     onPressed: () {},
                //                     style: ElevatedButton.styleFrom(
                //                       primary: AppColors.primaryColor,
                //                       shape: RoundedRectangleBorder(
                //                         borderRadius: BorderRadius.circular(10),
                //                       ),
                //                     ),
                //                     child: const Text('Login'),
                //                   ),
                //                 ),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.symmetric(
                //                     horizontal: 40, vertical: 10),
                //                 child: SizedBox(
                //                   width: double.infinity,
                //                   child: ElevatedButton(
                //                     onPressed: () {},
                //                     style: ElevatedButton.styleFrom(
                //                       primary: AppColors.primaryColor,
                //                       shape: RoundedRectangleBorder(
                //                         borderRadius: BorderRadius.circular(10),
                //                       ),
                //                     ),
                //                     child: const Text('Register'),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            )),
      ),
    );
  }
}
