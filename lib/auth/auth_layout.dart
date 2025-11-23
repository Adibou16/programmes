import 'package:flutter/material.dart';
import 'package:programmes/auth/auth_service.dart';
import 'package:programmes/auth/welcome_page.dart';
import 'package:programmes/widgets/loading_page.dart';
import 'package:programmes/widgets/navigation.dart';

class AuthLayout extends StatelessWidget {
  final Widget? pageIfNotConnected;

  const AuthLayout({super.key, this.pageIfNotConnected});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: authService, 
      builder: (context, authService, child) {
        return StreamBuilder(
          stream: authService.authStateChanges, 
          builder: (context, snapshot) {
            Widget widget;
            if (snapshot.connectionState ==  ConnectionState.waiting) {
              widget = const LoadingPage();
            } else if (snapshot.hasData ) {
              widget = const Navigation();
            } else {
              widget = pageIfNotConnected ?? const WelcomePage();
            }
            return widget;
          }
        );
      }
    );
  }
}