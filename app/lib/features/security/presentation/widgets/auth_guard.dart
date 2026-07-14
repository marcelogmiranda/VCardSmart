import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../pages/auth_page.dart';

class AuthGuard extends ConsumerWidget {
  final Widget child;

  const AuthGuard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authProvider);

    switch (authStatus.state) {
      case AuthState.authenticated:
        return child;
      case AuthState.checking:
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      case AuthState.unauthenticated:
      case AuthState.error:
        return const AuthPage();
    }
  }
}
