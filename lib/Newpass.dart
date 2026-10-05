import 'package:flutter/material.dart';

// صفحة تغير كلمه المرور
class newpass extends StatelessWidget {
  const newpass({Key? key}) : super(key: const Key('linaty_app'));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Linaty App',
      // تعيين خط Cairo لكامل التطبيق
      theme: ThemeData(
        fontFamily: 'Cairo',
      ),
      home: const ResetPasswordScreen(),
    );
  }
}

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: const Key('reset_screen'));

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confController = TextEditingController();

  // متغيرات للتحكم في إخفاء وإظهار كلمة المرور
  bool _isObscurePass = true;
  bool _isObscureConf = true;

  @override
  void dispose() {
    _passController.dispose();
    _confController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. صورة الباترن خلفية بملء الشاشة
          Positioned.fill(
            child: Image.asset(
              'Images/Background.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: const Color(0xFFFFF7ED)),
            ),
          ),

          // 2. المحتوى العام
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // كلمة linaty فوق الوجه البرتقالي
                    Image.asset(
                      'Images/linaty.png',
                      height: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Text(
                        'linaty',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // البطاقة البيضاء
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        // Container البطاقة البيضاء
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(20, 45, 20, 25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 15,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'كلمة المرور الجديدة',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3E2723),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // حقل كلمة المرور الجديدة
                              _buildTextField(
                                controller: _passController,
                                hintText: 'كلمة المرور الجديدة',
                                leftIcon: Icons.lock_outline,
                                obscureText: _isObscurePass,
                                onToggleVisibility: () {
                                  setState(() {
                                    _isObscurePass = !_isObscurePass;
                                  });
                                },
                              ),

                              const SizedBox(height: 20),

                              // حقل تأكيد كلمة المرور
                              _buildTextField(
                                controller: _confController,
                                hintText: 'تأكيد كلمة المرور',
                                leftIcon: Icons.lock_outline,
                                obscureText: _isObscureConf,
                                onToggleVisibility: () {
                                  setState(() {
                                    _isObscureConf = !_isObscureConf;
                                  });
                                },
                              ),

                              const SizedBox(height: 20),

                              // زر التالي البرتقالي
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF26522),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: const Text(
                                    'التالي',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // الوجه البرتقالي بارز بدون أي إطار خلفي
                        Positioned(
                          top: -40,
                          child: Image.asset(
                            'Images/login.png',
                            height: 75,
                            width: 75,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ودجت حقول الإدخال المصممة بحواف انسيابية وتوجيه RTL
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData leftIcon,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
  }) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: TextInputType.visiblePassword,
        textAlign: TextAlign.right,
        style: const TextStyle(
          fontFamily: 'Cairo',
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Cairo',
            color: Colors.grey,
            fontSize: 13.5,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),

          // أيقونة القفل على اليمين عند استخدام اتجاه RTL
          prefixIcon: Icon(
            leftIcon,
            color: Colors.grey[700],
            size: 20,
          ),

          // أيقونة العين لإظهار/إخفاء كلمة المرور على اليسار
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: Colors.grey[600],
              size: 20,
            ),
            onPressed: onToggleVisibility,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.grey, width: 0.9),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Color(0xFFF26522), width: 1.4),
          ),
        ),
      ),
    );
  }
}