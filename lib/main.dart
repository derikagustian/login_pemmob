import 'package:flutter/material.dart';

void main() {
  runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final Color accentColor = const Color(0xFF00C896);
  final Color primaryTextColor = const Color(0xFF333333);
  final Color secondaryTextColor = const Color(0xFF666666);

  late AnimationController _animationController;
  late Animation<AlignmentGeometry> _topAlignmentAnimation;
  late Animation<AlignmentGeometry> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _topAlignmentAnimation = TweenSequence<AlignmentGeometry>([
      TweenSequenceItem<AlignmentGeometry>(
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem<AlignmentGeometry>(
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem<AlignmentGeometry>(
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem<AlignmentGeometry>(
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
    ]).animate(_animationController);

    _bottomAlignmentAnimation = TweenSequence<AlignmentGeometry>([
      TweenSequenceItem<AlignmentGeometry>(
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem<AlignmentGeometry>(
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem<AlignmentGeometry>(
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem<AlignmentGeometry>(
        tween: Tween<AlignmentGeometry>(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
    ]).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: _topAlignmentAnimation.value,
                end: _bottomAlignmentAnimation.value,
                colors: [
                  const Color(0xFFE0F7FA),
                  const Color(0xFFB2EBF2),
                  const Color(0xFF80DEEA),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),

            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.lock_outline, size: 60.0, color: accentColor),
                    const SizedBox(height: 30.0),

                    Text(
                      'Siap. Masuk. Mulai.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: primaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    Text(
                      'Selamat datang kembali. Satu langkah menuju aktivitas Anda.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: secondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 40.0),

                    _buildInputField(
                      hintText: 'Email atau Username',
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 15.0),

                    _buildInputField(
                      hintText: 'Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    const SizedBox(height: 30.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          print('Tombol Login ditekan!');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),

                    TextButton(
                      onPressed: () {
                        print('Lupa Kata Sandi ditekan!');
                      },
                      child: Text(
                        'Lupa Kata Sandi?',
                        style: TextStyle(
                          color: secondaryTextColor,
                          fontSize: 14.0,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum punya akun? ',
                          style: TextStyle(color: secondaryTextColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            print('Daftar Sekarang ditekan!');
                          },
                          child: Text(
                            'Daftar Sekarang',
                            style: TextStyle(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField({
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: const Color(0xFFDDDDDD), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        obscureText: isPassword,
        style: TextStyle(color: primaryTextColor),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFFAAAAAA)),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: accentColor, width: 1.5),
          ),
        ),
      ),
    );
  }
}
