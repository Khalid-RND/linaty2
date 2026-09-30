import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'Regstration_Page.dart';
import 'homePage.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ألوان Linaty
  static const Color backgroundColor = Color(0xFFFAF4EE);
  static const Color orangeColor = Color(0xFFF07827);
  static const Color darkColor = Color(0xFF1E1E1E);

  // إظهار / إخفاء كلمة المرور
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController email =TextEditingController();
    TextEditingController Password =TextEditingController();
    final size = MediaQuery.of(context).size;

    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      backgroundColor: backgroundColor,

      body: Stack(
        children: [

          // ============================================================
          // الباترن
          // ============================================================

          Positioned.fill(
            child: Image.asset(
              'Images/Background.png',
              fit: BoxFit.cover,
            ),
          ),

          // طبقة خفيفة حتى يبقى الباترن هادئاً خلف الواجهة
          Positioned.fill(
            child: Container(
              color: backgroundColor.withOpacity(0.08),
            ),
          ),

          // ============================================================
          // المحتوى
          // ============================================================

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.065,
                  vertical: height * 0.000,
                ),

                child: Column(
                  children: [

                    // ==================================================
                    // شعار Linaty
                    // ==================================================

                    Transform.translate(
                      offset: const Offset(
                        0,
                        -34,
                      ), // قم بتكبير الرقم بالسالب لرفعه أكثر (مثلاً -40 أو -50)
                      child: SizedBox(
                        height: height * 0.20,
                        child: Image.asset(
                          'Images/linaty.png',
                          width: width * 0.60,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // ==================================================
                    // الصندوق الأبيض + الوجه
                    // ==================================================

                    Stack(
                      clipBehavior: Clip.none,

                      children: [

                        // ------------------------------------------------
                        // الصندوق الأبيض
                        // ------------------------------------------------

                        Container(
                          width: double.infinity,

                          padding: EdgeInsets.fromLTRB(
                            width * 0.065,
                            height * 0.105,
                            width * 0.065,
                            height * 0.035,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius:
                            BorderRadius.circular(30),

                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFE5D2C2)
                                    .withOpacity(0.55),

                                blurRadius: 22,

                                spreadRadius: 1,

                                offset: const Offset(0, 9),
                              ),
                            ],
                          ),

                          child: Column(
                            children: [

                              // ==========================================
                              // Welcome عدلت عليه
                              // ==========================================

                              Text(
                                'مرحبا بك',

                                textAlign: TextAlign.center,

                                style: TextStyle(
                                  fontSize: width * 0.062,

                                  fontWeight:
                                  FontWeight.w600,

                                  color:
                                  const Color(0xFF653719),
                                ),
                              ),

                              SizedBox(
                                height: height * 0.025,
                              ),

                              // ==========================================
                              // Email
                              // ==========================================

                              TextField(
                                controller: email,

                                decoration: InputDecoration(
                                  hintText: "البريد الاكتروني",

                                  prefixIcon: Icon(Icons.email_outlined,),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),









                              SizedBox(
                                height: height * 0.018,
                              ),

                              // ==========================================
                              // Password
                              // ==========================================

                              TextField(
                                controller: Password,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: "كلمة المرور",


                                  prefixIcon: Icon(Icons.lock_outline,),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),



                              SizedBox(
                                height: height * 0.025,
                              ),

                              // ==========================================
                              // LOG IN
                              // ==========================================

                              SizedBox(
                                width: double.infinity,

                                height: height * 0.062,

                                child: ElevatedButton(
                                  onPressed: ()  async {


                                    showDialog(context: context,barrierDismissible: false, builder: (context) => Center(child: CircularProgressIndicator()));

                                    try {
                                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                        email: email.text.trim(),
                                        password: Password.text.trim(),
                                      );
                                      Navigator.of(context, rootNavigator: true).pop();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => HomeScreen()),
                                      );


                                      if (userCredential.user!.emailVerified) {
                                        // اذا نجح تسجيل الدخول

                                      }else{

                                        Fluttertoast.showToast(msg: "الحساب غير مفعل",toastLength: Toast.LENGTH_LONG,backgroundColor: Colors.red,gravity: ToastGravity.CENTER ,textColor: Colors.white,fontSize: 18.0);}
                                    }
                                    on FirebaseAuthException catch (e) {
                                      print(e.message);

                                      Navigator.of(context, rootNavigator: true).pop();
                                      Fluttertoast.showToast(
                                          msg: "خطأ في الابريد او كلمة المرور",
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor: Colors.red,
                                          gravity: ToastGravity.CENTER,
                                          textColor: Colors.black,
                                          fontSize: 18.0);
                                    }


                                  },

                                  style:
                                  ElevatedButton.styleFrom(
                                    backgroundColor:
                                    orangeColor,

                                    foregroundColor:
                                    Colors.white,

                                    elevation: 0,

                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                        35,
                                      ),
                                    ),
                                  ),

                                  child: Text(
                                    'تسجيل الدخول',

                                    style: TextStyle(
                                      fontSize:
                                      width * 0.045,

                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              // =================================================
                              // SIGN UP - تمت الإضافة فقط
                              // =================================================

                              SizedBox(
                                height: height * 0.012,
                              ),

                              SizedBox(
                                width: double.infinity,

                                height: height * 0.062,


                                //هنا  ضفت كود  انشاء الحساب
                                child: ElevatedButton(
                                  onPressed: () {Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const SignUpScreen()),
                                  );},

                                  style:
                                  ElevatedButton.styleFrom(
                                    backgroundColor:
                                    const Color(0xFF653719),

                                    foregroundColor:
                                    Colors.white,

                                    elevation: 0,

                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                        35,
                                      ),
                                    ),
                                  ),

                                  child: Text(
                                    'انشاء حساب',

                                    style: TextStyle(
                                      fontSize:
                                      width * 0.045,

                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: height * 0.019,
                              ),

                              // ==========================================
                              // Forgot Password
                              // ==========================================

                              TextButton(
                                onPressed: () {},

                                child: Text(
                                  'هل نسيت كلمة المرور?',

                                  style: TextStyle(
                                    color:
                                    orangeColor,

                                    fontSize:
                                    width * 0.042,

                                    fontWeight:
                                    FontWeight.w500,
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: height * 0.008,
                              ),

                              // ==========================================
                              // OR
                              // ==========================================

                              Row(
                                children: [

                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color:
                                      const Color(
                                        0xFFD7D0C9,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding:
                                    const EdgeInsets
                                        .symmetric(
                                      horizontal: 14,
                                    ),

                                    child: Text(
                                      'or',

                                      style: TextStyle(
                                        color:
                                        Colors.grey[700],

                                        fontSize:
                                        width * 0.04,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Container(
                                      height: 1,
                                      color:
                                      const Color(
                                        0xFFD7D0C9,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: height * 0.02,
                              ),

                              // ==========================================
                              // Google
                              // ==========================================

                              SizedBox(
                                width: double.infinity,

                                height: height * 0.06,

                                child: OutlinedButton(
                                  onPressed: () {},

                                  style:
                                  OutlinedButton.styleFrom(
                                    backgroundColor:
                                    Colors.white,

                                    side:
                                    const BorderSide(
                                      color:
                                      Color(0xFFD0D0D0),

                                      width: 1.2,
                                    ),

                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                        35,
                                      ),
                                    ),
                                  ),

                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,

                                    children: [

                                      // --------------------------------
                                      // شعار كوكل
                                      // --------------------------------

                                      Image.asset(
                                        'Images/google.png',
                                        width: 24,
                                        height: 24,
                                      ),

                                      const SizedBox(
                                        width: 10,
                                      ),

                                      Text(
                                        'Google المتابعة باستخدام',

                                        style: TextStyle(
                                          color:
                                          darkColor,

                                          fontSize:
                                          width * 0.039,

                                          fontWeight:
                                          FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // =================================================
                        // الوجه البرتقالي
                        // =================================================

                        Positioned(
                          top: -height * 0.125,
                          // هنا ارتفاع او انخفاض الوجه البرتقالي

                          left: 0,

                          right: 0,

                          child: Center(
                            child: Container(
                              decoration:
                              const BoxDecoration(
                                shape: BoxShape.circle,
                              ),

                              child: Image.asset(
                                'Images/login.png',

                                //هنا قياس حجم الوجه البرتقالي
                                width: width * 0.50,

                                height: width * 0.50,

                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(
                      height: height * 0.035,
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

  // ==============================================================
  // إنشاء حقل إدخال
  // ==============================================================

  Widget _inputField({
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      obscureText: obscure,

      style: const TextStyle(
        color: darkColor,
        fontSize: 16,
      ),

      decoration: InputDecoration(
        hintText: hint,

        hintStyle: const TextStyle(
          color: Color(0xFF666666),
          fontSize: 16,
        ),

        prefixIcon: Icon(
          icon,
          color: darkColor,
          size: 24,
        ),

        suffixIcon: suffix,

        filled: true,

        fillColor: Colors.white,

        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),

        enabledBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(35),

          borderSide:
          const BorderSide(
            color: Color(0xFF707070),
            width: 1.3,
          ),
        ),

        focusedBorder:
        OutlineInputBorder(
          borderRadius:
          BorderRadius.circular(35),

          borderSide:
          const BorderSide(
            color: orangeColor,
            width: 2,
          ),
        ),
      ),
    );
  }
}