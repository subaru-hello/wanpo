// protected_page.dart
import 'package:flutter/material.dart';
import 'package:mobile_client/src/widgets/auth/login_required_modal.dart';

class RequireLoginProvider extends StatefulWidget {
  final Widget child;
  const RequireLoginProvider({Key? key, required this.child}) : super(key: key);

  @override
  State<RequireLoginProvider> createState() => _RequireLoginProviderState();
}

class _RequireLoginProviderState extends State<RequireLoginProvider> {
  bool _isLoggedIn = false;
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    print("build");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ログインしているかを確認
      _checkLoginStatus();
    });
  }

  void _checkLoginStatus() async {
    _isLoggedIn = await checkTokenAndShowModalIfNeeded();
    print("^^^^^^^");
    if (!mounted) return;
    if (!_isLoggedIn) {
      showModalIfNeeded(context);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    // Once loading is complete, show the appropriate screen
    return _isLoggedIn
        ? widget.child
        : Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
