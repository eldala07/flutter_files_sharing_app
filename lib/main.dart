import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sharing_files/routes.dart';

final showSuccessLoginProvider = StateProvider<bool>((_) => false);

// inspired from https://www.youtube.com/watch?v=OjIQypbCK8I&t=690sf
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    GoRouter router = GoRouter(routes: routes());
    return MaterialApp.router(
      routerConfig: router,
      title: 'uxitude - Files sharing app',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
    );
  }

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.vigaTextTheme(baseTheme.textTheme),
    );
  }
}
