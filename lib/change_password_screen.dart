import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  // ============================================================
  // الألوان
  // ============================================================

  static const Color backgroundColor = Color(0xFFFAF4EE);
  static const Color orangeColor = Color(0xFFF07827);
  static const Color brownColor = Color(0xFF653719);
  static const Color blueColor = Color(0xFFF07827);

  // ============================================================
  // Controllers
  // ============================================================

  final TextEditingController currentPasswordController =
  TextEditingController();

  final TextEditingController newPasswordController =
  TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  // ============================================================
  // إظهار وإخفاء كلمات المرور
  // ============================================================

  bool hideCurrentPassword = true;
  bool hideNewPassword = true;
  bool hideConfirmPassword = true;

  // منع الضغط المتكرر
  bool isLoading = false;

  // ============================================================
  // التخلص من Controllers
  // ============================================================

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  // ============================================================
  // حفظ التغييرات
  // ============================================================

  Future<void> _saveChanges() async {

    // منع الضغط أكثر من مرة
    if (isLoading) return;

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      _showMessage('لم يتم العثور على المستخدم');
      return;
    }

    // ------------------------------------------------------------
    // التحقق من الحقول
    // ------------------------------------------------------------

    if (currentPasswordController.text.isEmpty) {
      _showMessage('أدخل كلمة المرور الحالية');
      return;
    }

    if (newPasswordController.text.isEmpty) {
      _showMessage('أدخل كلمة المرور الجديدة');
      return;
    }

    if (confirmPasswordController.text.isEmpty) {
      _showMessage('أكد كلمة المرور الجديدة');
      return;
    }

    // ------------------------------------------------------------
    // التأكد من تطابق كلمة المرور الجديدة
    // ------------------------------------------------------------

    if (newPasswordController.text !=
        confirmPasswordController.text) {

      _showMessage('كلمة المرور الجديدة غير متطابقة');
      return;
    }

    // ------------------------------------------------------------
    // التأكد من أن كلمة المرور الجديدة قوية بما يكفي
    // ------------------------------------------------------------

    if (newPasswordController.text.length < 6) {
      _showMessage(
        'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
      );
      return;
    }

    // ------------------------------------------------------------
    // التأكد من وجود البريد الإلكتروني
    // ------------------------------------------------------------

    final email = user.email;

    if (email == null || email.isEmpty) {
      _showMessage(
        'لا يوجد بريد إلكتروني مرتبط بهذا الحساب',
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      // ==========================================================
      // 1. إنشاء بيانات التحقق باستخدام البريد + الباسورد القديم
      // ==========================================================

      final credential = EmailAuthProvider.credential(
        email: email,
        password: currentPasswordController.text,
      );

      // ==========================================================
      // 2. إعادة التحقق من المستخدم
      // ==========================================================

      await user.reauthenticateWithCredential(
        credential,
      );

      // ==========================================================
      // 3. إذا كانت كلمة المرور القديمة صحيحة
      //    نقوم بتغيير كلمة المرور
      // ==========================================================

      await user.updatePassword(
        newPasswordController.text,
      );

      // ==========================================================
      // نجاح العملية
      // ==========================================================

      _showMessage(
        'تم تغيير كلمة المرور بنجاح',
      );

      // تنظيف الحقول
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      // الرجوع بعد نجاح العملية
      if (mounted) {
        Navigator.pop(context);
      }

    } on FirebaseAuthException catch (e) {

      // ==========================================================
      // أخطاء Firebase
      // ==========================================================

      if (e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {

        _showMessage(
          'كلمة المرور الحالية غير صحيحة',
        );

      } else if (e.code == 'requires-recent-login') {

        _showMessage(
          'انتهت صلاحية جلسة تسجيل الدخول، يرجى تسجيل الدخول مرة أخرى',
        );

      } else if (e.code == 'weak-password') {

        _showMessage(
          'كلمة المرور الجديدة ضعيفة',
        );

      } else if (e.code == 'network-request-failed') {

        _showMessage(
          'تحقق من اتصال الإنترنت',
        );

      } else {

        _showMessage(
          'حدث خطأ: ${e.message ?? e.code}',
        );
      }

    } catch (e) {

      _showMessage(
        'حدث خطأ غير متوقع',
      );

      print(e);

    } finally {

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // ============================================================
  // إظهار رسالة
  // ============================================================

  void _showMessage(String message) {

    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // خانة كلمة المرور
  // ============================================================

  Widget _passwordField({
    required String hintText,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onEyePressed,
  }) {

    return Container(
      height: 66,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(34),

        border: Border.all(
          color: const Color(0xFFD8D8D8),
          width: 1.4,
        ),
      ),

      child: TextField(
        controller: controller,

        obscureText: obscureText,

        textDirection: TextDirection.rtl,

        style: const TextStyle(
          fontSize: 17,
          color: Color(0xFF333333),
        ),

        decoration: InputDecoration(
          border: InputBorder.none,

          hintText: hintText,

          hintStyle: const TextStyle(
            fontSize: 17,
            color: Color(0xFF9A9A9A),
          ),

          suffixIcon: IconButton(
            onPressed: onEyePressed,

            icon: Icon(
              obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,

              color: const Color(0xFF333333),

              size: 25,
            ),
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 19,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // بناء الصفحة
  // ============================================================

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final double screenWidth = size.width;
    final double screenHeight = size.height;

    final double cardWidth =
    screenWidth > 600
        ? 480
        : screenWidth * 0.88;

    final double logoWidth =
    screenWidth < 360
        ? 145
        : 170;

    final double faceSize =
    screenWidth < 360
        ? 58
        : 68;

    return Scaffold(
      backgroundColor: backgroundColor,

      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          color: backgroundColor,

          image: DecorationImage(
            image: AssetImage(
              'Images/Background.png',
            ),

            fit: BoxFit.cover,

            opacity: 0.50,
          ),
        ),

        child: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,

            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),

                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.035,
                      vertical: 15,
                    ),

                    child: Column(
                      children: [

                        // ==================================================
                        // زر الرجوع
                        // ==================================================

                        Align(
                          alignment: Alignment.centerRight,

                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },

                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: brownColor,
                              size: 27,
                            ),
                          ),
                        ),

                        // ==================================================
                        // الشعار
                        // ==================================================

                        SizedBox(
                          height:
                          screenHeight < 700
                              ? 75
                              : 95,

                          child: Image.asset(
                            'Images/linaty.png',

                            width: logoWidth,

                            fit: BoxFit.contain,
                          ),
                        ),

                        SizedBox(
                          height:
                          screenHeight < 700
                              ? 10
                              : 22,
                        ),

                        // ==================================================
                        // البطاقة
                        // ==================================================

                        Stack(
                          clipBehavior: Clip.none,

                          children: [

                            Container(
                              width: cardWidth,

                              padding: EdgeInsets.fromLTRB(
                                28,

                                screenHeight < 700
                                    ? 55
                                    : 65,

                                28,

                                28,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.white,

                                borderRadius:
                                BorderRadius.circular(30),

                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    Colors.black.withOpacity(
                                      0.05,
                                    ),

                                    blurRadius: 15,

                                    offset:
                                    const Offset(0, 5),
                                  ),
                                ],
                              ),

                              child: Column(
                                children: [

                                  // ==================================================
                                  // العنوان
                                  // ==================================================

                                  Text(
                                    'تغيير كلمة المرور',

                                    textAlign:
                                    TextAlign.center,

                                    style: TextStyle(
                                      color: brownColor,

                                      fontSize:
                                      screenWidth < 360
                                          ? 25
                                          : 29,

                                      fontWeight:
                                      FontWeight.bold,

                                      height: 1.3,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 32,
                                  ),

                                  // ==================================================
                                  // كلمة المرور الحالية
                                  // ==================================================

                                  _passwordField(
                                    hintText:
                                    'كلمة المرور الحالية',

                                    controller:
                                    currentPasswordController,

                                    obscureText:
                                    hideCurrentPassword,

                                    onEyePressed: () {
                                      setState(() {
                                        hideCurrentPassword =
                                        !hideCurrentPassword;
                                      });
                                    },
                                  ),

                                  const SizedBox(
                                    height: 16,
                                  ),

                                  // ==================================================
                                  // كلمة المرور الجديدة
                                  // ==================================================

                                  _passwordField(
                                    hintText:
                                    'كلمة المرور الجديدة',

                                    controller:
                                    newPasswordController,

                                    obscureText:
                                    hideNewPassword,

                                    onEyePressed: () {
                                      setState(() {
                                        hideNewPassword =
                                        !hideNewPassword;
                                      });
                                    },
                                  ),

                                  const SizedBox(
                                    height: 16,
                                  ),

                                  // ==================================================
                                  // تأكيد كلمة المرور
                                  // ==================================================

                                  _passwordField(
                                    hintText:
                                    'تأكيد كلمة المرور الجديدة',

                                    controller:
                                    confirmPasswordController,

                                    obscureText:
                                    hideConfirmPassword,

                                    onEyePressed: () {
                                      setState(() {
                                        hideConfirmPassword =
                                        !hideConfirmPassword;
                                      });
                                    },
                                  ),

                                  const SizedBox(
                                    height: 30,
                                  ),

                                  // ==================================================
                                  // الأزرار
                                  // ==================================================

                                  Row(
                                    children: [

                                      // زر إلغاء
                                      Expanded(
                                        flex: 1,

                                        child: SizedBox(
                                          height: 58,

                                          child:
                                          OutlinedButton(
                                            onPressed:
                                            isLoading
                                                ? null
                                                : () {
                                              Navigator.pop(
                                                context,
                                              );
                                            },

                                            style:
                                            OutlinedButton
                                                .styleFrom(
                                              foregroundColor:
                                              blueColor,

                                              side:
                                              const BorderSide(
                                                color:
                                                blueColor,

                                                width: 1.8,
                                              ),

                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                  30,
                                                ),
                                              ),
                                            ),

                                            child:
                                            const Text(
                                              'إلغاء',

                                              style: TextStyle(
                                                fontSize: 17,

                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(
                                        width: 14,
                                      ),

                                      // زر حفظ
                                      Expanded(
                                        flex: 2,

                                        child: SizedBox(
                                          height: 58,

                                          child:
                                          ElevatedButton(
                                            onPressed:
                                            isLoading
                                                ? null
                                                : _saveChanges,

                                            style:
                                            ElevatedButton
                                                .styleFrom(
                                              backgroundColor:
                                              blueColor,

                                              foregroundColor:
                                              Colors.white,

                                              elevation: 0,

                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                  30,
                                                ),
                                              ),
                                            ),

                                            child: isLoading
                                                ? const SizedBox(
                                              width: 25,
                                              height: 25,

                                              child:
                                              CircularProgressIndicator(
                                                color:
                                                Colors.white,

                                                strokeWidth:
                                                2.5,
                                              ),
                                            )
                                                : const Text(
                                              'حفظ التغييرات',

                                              style:
                                              TextStyle(
                                                fontSize:
                                                18,

                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // =================================================
                            // الوجه البرتقالي
                            // =================================================

                            Positioned(
                              top: -(faceSize * 0.45),

                              left: 0,
                              right: 0,

                              child: Center(
                                child: SizedBox(
                                  width: faceSize,
                                  height: faceSize,

                                  child: Image.asset(
                                    'Images/login.png',

                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}