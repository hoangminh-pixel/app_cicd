import 'package:bt_management_flutter/core/configs/auth_store.dart';
import 'package:bt_management_flutter/routes/app_routes.dart';
import 'package:bt_management_flutter/data/services/nav_service.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() async {
        if (_controller.isCompleted) {
          await _onSplashFinished();
        }
      });

    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.decelerate);

    _colorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.white,
    ).animate(_controller);

    _controller.forward();
  }

  Future<void> _onSplashFinished() async {
    /// 3️⃣ Check token
    final token = await AuthStorage.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.main);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _colorAnimation.value,
          body: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.symmetric(
              vertical: isPortrait
                  ? _curvedAnimation.value * (size.height / 3.1)
                  : _curvedAnimation.value * (size.height / 10.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(
                  opacity: _curvedAnimation.value,
                  child: Icon(Icons.abc),
                ),
                Opacity(
                  opacity: _curvedAnimation.value,
                  child: Text(
                    'BT Management',
                    style: TextStyle(
                      fontSize: 28 * _curvedAnimation.value,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
