import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_screen.dart';


//صفحة انشاء الحساب
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // ============================================================
  // الألوان الرئيسية للتصميم
  // ============================================================

  // لون الخلفية الأساسي القريب من التصميم
  static const Color backgroundColor = Color(0xFFFAF4EE);

  // اللون البرتقالي المستخدم في زر SIGN UP
  static const Color orangeColor = Color(0xFFF07827);

  // اللون البني المستخدم في عنوان Create Account
  static const Color brownColor = Color(0xFF653719);

  // لون النصوص الثانوية
  static const Color greyColor = Color(0xFF777777);

  // ============================================================
  // المتغيرات الخاصة بكلمات المرور
  // ============================================================

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  // ============================================================
  // Controllers
  // ============================================================

  final TextEditingController Email = TextEditingController();
  final TextEditingController User = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController Password = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  @override
  void dispose() {
Email.dispose();
User.dispose();
    _ageController.dispose();
Password.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  // ============================================================
  // دالة إنشاء الحساب
  // ============================================================



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // ==========================================================
      // منع ظهور AppBar حتى تكون الصفحة مطابقة للتصميم
      // ==========================================================

      body: SafeArea(
        child: Stack(
          children: [

            // ======================================================
            // 1. الباترن في الخلفية
            // ======================================================

            Positioned.fill(
              child: Image.asset(
                'Images/Background.png',

                // جعل الصورة تغطي كامل الشاشة
                fit: BoxFit.cover,

                // تقليل وضوح الباترن حتى لا يطغى على الصفحة
                opacity: const AlwaysStoppedAnimation(0.50),
              ),
            ),

            // ======================================================
            // 2. المحتوى الرئيسي
            // ======================================================

            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),

                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      // أقل ارتفاع للمحتوى حتى يملأ الشاشة
                      minHeight: constraints.maxHeight,
                    ),

                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,//تم التعديل جان 18
                        ),

                        child: Column(
                          children: [

                            // ==================================================
                            // المسافة العلوية
                            //
                            // القياس: 20px
                            //
                            // يمكنك زيادة الرقم إذا أردت إنزال التصميم
                            // إلى الأسفل.
                            // ==================================================

                            const SizedBox(height: 1),

                            // ==================================================
                            // شعار Linaty
                            // ==================================================

                            Image.asset(
                              'Images/linaty.png',

                              // عرض الشعار
                              // القياس الأصلي المقترح: 165px
                              //
                              // يمكنك تغيير 165 إلى:
                              // 140 = أصغر
                              // 180 = أكبر
                              // 200 = أكبر بكثير
                              width: 150,

                              // الارتفاع يحدد تلقائيًا حسب أبعاد الصورة
                              fit: BoxFit.contain,
                            ),

                            // ==================================================
                            // المسافة بين الشعار والبطاقة
                            //
                            // القياس: 45px
                            //
                            // هذه المسافة تسمح للوجه البرتقالي أن يتداخل
                            // مع أعلى البطاقة.
                            // ==================================================

                            const SizedBox(height: 18),

                            // ==================================================
                            // البطاقة البيضاء
                            // ==================================================

                            Container(
                              width: double.infinity,

                              // أقصى عرض للبطاقة على الشاشات الكبيرة
                              //
                              // الهاتف سيستخدم العرض المتاح،
                              // أما التابلت أو الشاشة الكبيرة فلن تصبح
                              // البطاقة عريضة جدًا.
                              constraints: const BoxConstraints(
                                maxWidth: 480,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.white,

                                // تدوير زوايا البطاقة
                                //
                                // القياس: 30px
                                borderRadius: BorderRadius.circular(30),

                                // ظل البطاقة
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),

                                    // مقدار انتشار الظل
                                    spreadRadius: 1,

                                    // مقدار نعومة الظل
                                    blurRadius: 12,

                                    // نزول الظل إلى الأسفل
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),

                              child: Stack(
                                clipBehavior: Clip.none,

                                children: [

                                  // =================================================
                                  // محتوى البطاقة
                                  // =================================================

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      34, // المسافة من اليسار
                                      34, // المسافة من الأعلى
                                      34, // المسافة من اليمين
                                      28, // المسافة من الأسفل
                                    ),

                                    child: Column(
                                      children: [

                                        // =========================================
                                        // مساحة فارغة أعلى البطاقة للوجه
                                        //
                                        // القياس: 45px
                                        //
                                        // إذا كبرت الوجه، قم بزيادة هذه القيمة.
                                        // =========================================

                                        const SizedBox(height: 25),

                                        // =========================================
                                        // عنوان Create Account
                                        // =========================================

                                        const Text(
                                          'انشاء حساب',

                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                            color: brownColor,

                                            // حجم الخط: 30px
                                            fontSize: 28,

                                            fontWeight: FontWeight.w700,

                                            // نوع الخط الافتراضي
                                            fontFamily: 'serif',
                                          ),
                                        ),

                                        // =========================================
                                        // المسافة بعد العنوان
                                        //
                                        // القياس: 34px
                                        // =========================================

                                        const SizedBox(height: 34),

                                        // =========================================
                                        // Email
                                        // =========================================

                                        _buildTextField(
                                          controller: Email,

                                          hintText: 'البريد الاكتروني',

                                          icon: Icons.mail_outline,

                                          keyboardType:
                                          TextInputType.emailAddress,
                                        ),

                                        // =========================================
                                        // المسافة بين الحقول
                                        //
                                        // القياس: 1px
                                        // =========================================

                                        const SizedBox(height: 1),

                                        // =========================================
                                        // Username
                                        // =========================================

                                        _buildTextField(
                                          controller: User,

                                          hintText: 'اسم المستخدم',

                                          icon: Icons.person_outline,
                                        ),

                                        const SizedBox(height: 1),

                                        // =========================================
                                        // Age
                                        // =========================================

                                        _buildTextField(
                                          controller: _ageController,

                                          hintText: 'العمر',

                                          icon: Icons.calendar_month_outlined,

                                          keyboardType:
                                          TextInputType.number,
                                        ),

                                        const SizedBox(height: 1),

                                        // =========================================
                                        // Password
                                        // =========================================

                                        _buildTextField(
                                          controller: Password,

                                          hintText: 'كلمه المرور',

                                          icon: Icons.lock_outline,

                                          obscureText: _hidePassword,

                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _hidePassword =
                                                !_hidePassword;
                                              });
                                            },

                                            icon: Icon(
                                              _hidePassword
                                                  ? Icons.visibility_off_outlined
                                                  : Icons.visibility_outlined,

                                              // حجم أيقونة إظهار كلمة المرور
                                              //
                                              // القياس: 25px
                                              size: 25,

                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 1),

                                        // =========================================
                                        // Confirm Password
                                        // =========================================

                                        _buildTextField(
                                          controller:
                                          _confirmPasswordController,

                                          hintText: 'تأكيد كلمة المرور',

                                          icon: Icons.lock_outline,

                                          obscureText:
                                          _hideConfirmPassword,

                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _hideConfirmPassword =
                                                !_hideConfirmPassword;
                                              });
                                            },

                                            icon: Icon(
                                              _hideConfirmPassword
                                                  ? Icons.visibility_off_outlined
                                                  : Icons.visibility_outlined,

                                              // حجم أيقونة العين
                                              //
                                              // القياس: 25px
                                              size: 25,

                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),

                                        // =========================================
                                        // المسافة قبل زر SIGN UP
                                        //
                                        // القياس: 32px
                                        // =========================================

                                        const SizedBox(height: 20),

                                        // =========================================
                                        // زر SIGN UP
                                        // =========================================

                                        SizedBox(
                                          width: double.infinity,

                                          // ارتفاع الزر
                                          //
                                          // القياس: 66px
                                          //
                                          // التصميم الأصلي قريب من هذا الحجم.
                                          height: 50,

                                          child: ElevatedButton(
                                            onPressed: () async {
if(Email.text.isEmpty|| User.text.isEmpty||_ageController.text.isEmpty ||Password.text.isEmpty ||_confirmPasswordController.text.isEmpty) {

  Fluttertoast.showToast(msg: "يرجى تعبئة جميع الحقول.",toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.red,textColor: Colors.black,gravity: ToastGravity.CENTER);
}else{
  try {
    UserCredential kha = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: Email.text.trim(), password: Password.text.trim(),

    );
    await kha.user!.updateDisplayName(User.text);
    await kha.user!.reload();


    await kha.user!.sendEmailVerification();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    Fluttertoast.showToast(
      msg: " تمت تسجيل بنجاح ",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } catch (e){

    Fluttertoast.showToast(
      msg: e.toString(),
      gravity: ToastGravity.CENTER,);


  }


}
                                            },


                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                              orangeColor,

                                              foregroundColor:
                                              Colors.white,

                                              elevation: 0,

                                              // تدوير زوايا الزر
                                              //
                                              // القياس: 35px
                                              //
                                              // يجعل الزر بشكل كبسولة.
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                  35,
                                                ),
                                              ),
                                            ),

                                            child: const Text(
                                              'تسجيل الحساب',

                                              style: TextStyle(
                                                color: Colors.white,

                                                // حجم كلمة SIGN UP
                                                //
                                                // القياس: 22px
                                                fontSize: 22,

                                                fontWeight:
                                                FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),

                                        // =========================================
                                        // المسافة بين الزر والنص السفلي
                                        //
                                        // القياس: 24px
                                        // =========================================

                                        const SizedBox(height: 24),

                                        // =========================================
                                        // Already have an account?
                                        // =========================================

                                        Wrap(
                                          alignment:
                                          WrapAlignment.center,

                                          children: [

                                            const Text(
                                              ' هل لديك حساب بالفعل?',

                                              style: TextStyle(
                                                color: greyColor,

                                                // حجم النص: 17px
                                                fontSize: 17,
                                              ),
                                            ),

                                            GestureDetector(
                                              onTap: () {
                                                // =================================================
                                                // هنا نرجع إلى صفحة Login
                                                //
                                                // إذا كانت صفحة Login موجودة عندك
                                                // نستبدل الكود التالي بصفحة Login الخاصة بك.
                                                // =================================================

                                                Navigator.pop(context);
                                              },

                                              child: const Text(
                                                'تسجيل الدخول',

                                                style: TextStyle(
                                                  color: orangeColor,

                                                  // حجم كلمة Log in
                                                  //
                                                  // القياس: 17px
                                                  fontSize: 17,

                                                  fontWeight:
                                                  FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        // =========================================
                                        // المسافة السفلية
                                        //
                                        // القياس: 5px
                                        // =========================================

                                        const SizedBox(height: 6),
                                      ],
                                    ),
                                  ),

                                  // ==================================================
                                  // الوجه البرتقالي
                                  // ==================================================

                                  Positioned(
                                    top: -30,

                                    // وضع الوجه في منتصف البطاقة
                                    left: 0,
                                    right: 0,

                                    child: Center(
                                      child: Image.asset(
                                        'Images/login.png',

                                        // =================================================
                                        // حجم الوجه البرتقالي
                                        //
                                        // القياس الحالي: 72px
                                        //
                                        // لتصغيره:
                                        // 60
                                        //
                                        // لتكبيره:
                                        // 80 أو 90
                                        //
                                        // =================================================

                                        width: 85,
                                        height: 80,

                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // ==================================================
                            // المسافة السفلية خارج البطاقة
                            //
                            // القياس: 25px
                            // ==================================================

                            const SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // Widget إنشاء حقول الإدخال
  // ==============================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return SizedBox(
      width: double.infinity,

      // ============================================================
      // ارتفاع حقل الإدخال
      //
      // القياس: 78px
      //
      // إذا أردت الحقول أصغر:
      // 68px
      //
      // إذا أردتها أكبر:
      // 82px
      // ============================================================

      height: 75,

      child: TextField(
        controller: controller,

        obscureText: obscureText,

        keyboardType: keyboardType,

        style: const TextStyle(
          color: Colors.black87,

          // حجم النص الذي يكتبه المستخدم
          //
          // القياس: 18px
          fontSize: 18,
        ),

        decoration: InputDecoration(
          hintText: hintText,

          hintStyle: const TextStyle(
            color: Color(0xFF888888),

            // حجم النص داخل الحقل
            //
            // القياس: 18px
            fontSize: 18,
          ),

          // الأيقونة الموجودة في بداية الحقل
          prefixIcon: Icon(
            icon,

            // حجم الأيقونة
            //
            // القياس: 30px
            size: 30,

            color: Colors.black87,
          ),

          suffixIcon: suffixIcon,

          // ========================================================
          // المسافة الداخلية للحقل
          //
          // horizontal: 18px
          // vertical: 0px
          // ========================================================

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 0,
          ),

          // ========================================================
          // الحد الخارجي للحقل
          // ========================================================

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),

            borderSide: const BorderSide(
              color: Color(0xFFD0D0D0),

              // سمك الحدود
              //
              // القياس: 1.5px
              width: 1.5,
            ),
          ),

          // الحد عند الضغط داخل الحقل
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),

            borderSide: const BorderSide(
              color: orangeColor,

              // سمك الحدود عند التركيز
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}