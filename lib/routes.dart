import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sharing_files/pages/login/login.dart';

var routes = () {
  return <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
  ];
};
