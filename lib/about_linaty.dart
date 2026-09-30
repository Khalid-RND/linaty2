import 'package:flutter/material.dart';

class AboutLinatyScreen extends StatelessWidget {
  const AboutLinatyScreen({super.key});

  // ============================================================
  // ألوان تطبيق Linaty
  // ============================================================

  // لون خلفية التطبيق الأساسي
  static const Color backgroundColor = Color(0xFFFAF4EE);

  // اللون البرتقالي الأساسي
  static const Color orangeColor = Color(0xFFF07827);

  // اللون البني المستخدم في العناوين
  static const Color brownColor = Color(0xFF653719);

  // لون النص الرئيسي
  static const Color textColor = Color(0xFF222222);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: Stack(
          children: [

            // ======================================================
            // الباترن
            // ======================================================

            Positioned.fill(
              child: Image.asset(
                'Images/Background.png',

                // يجعل الباترن يغطي الشاشة كاملة
                fit: BoxFit.cover,

                // ------------------------------------------------
                // شفافية الباترن
                //
                // 0.30 = خفيف
                // 0.40 = متوسط
                // 0.50 = أوضح
                // ------------------------------------------------

                opacity: const AlwaysStoppedAnimation(0.32),
              ),
            ),

            // ======================================================
            // المحتوى
            // ======================================================

            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),

                child: Column(
                  children: [

                    // =================================================
                    // زر الرجوع
                    // =================================================

                    Align(
                      alignment: Alignment.centerLeft,

                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                        ),

                        child: Container(
                          width: 54,
                          height: 54,

                          decoration: BoxDecoration(
                            color: Colors.white,

                            // تدوير الزوايا
                            borderRadius: BorderRadius.circular(27),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),

                                // نعومة الظل
                                blurRadius: 10,

                                // انتشار الظل
                                spreadRadius: 1,

                                // اتجاه الظل
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),

                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },

                            icon: const Icon(
                              Icons.arrow_back,

                              // حجم سهم الرجوع
                              size: 30,

                              color: orangeColor,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // =================================================
                    // المسافة بعد زر الرجوع
                    //
                    // القياس: 20px
                    // =================================================

                    const SizedBox(height: 20),

                    // =================================================
                    // البطاقة البيضاء الرئيسية
                    // =================================================

                    Container(
                      width: double.infinity,

                      // =================================================
                      // أقصى عرض للبطاقة
                      //
                      // على الهاتف ستأخذ المساحة المتاحة.
                      // على الأجهزة الكبيرة لن تصبح عريضة جدًا.
                      // =================================================

                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),

                      padding: const EdgeInsets.fromLTRB(
                        25, // يسار
                        30, // أعلى
                        25, // يمين
                        28, // أسفل
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        // =================================================
                        // تدوير زوايا البطاقة
                        //
                        // القياس: 32px
                        // =================================================

                        borderRadius: BorderRadius.circular(32),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.055),

                            blurRadius: 18,

                            spreadRadius: 1,

                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),

                      child: Column(
                        children: [

                          // =================================================
                          // الوجه البرتقالي
                          //
                          // ملاحظة:
                          // هذا الوجه موجود داخل محتوى الصفحة فقط.
                          // لا يوجد وجه برتقالي في أعلى الصفحة.
                          // =================================================

                          Container(
                            width: 105,
                            height: 105,

                            padding: const EdgeInsets.all(8),

                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF1E3),

                              borderRadius: BorderRadius.circular(52.5),
                            ),

                            child: Image.asset(
                              'Images/login.png',

                              // حجم الصورة داخل الدائرة
                              width: 89,
                              height: 89,

                              fit: BoxFit.contain,
                            ),
                          ),

                          // =================================================
                          // المسافة بعد الوجه
                          //
                          // القياس: 18px
                          // =================================================

                          const SizedBox(height: 18),

                          // =================================================
                          // عنوان عن Linaty
                          // =================================================

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              // الخط البرتقالي الأيسر
                              Container(
                                width: 45,
                                height: 3,

                                decoration: BoxDecoration(
                                  color: orangeColor,
                                  borderRadius:
                                  BorderRadius.circular(2),
                                ),
                              ),

                              // المسافة بين الخط والعنوان
                              const SizedBox(width: 14),

                              const Text(
                                'عن Linaty',

                                style: TextStyle(
                                  color: brownColor,

                                  // حجم عنوان الصفحة
                                  //
                                  // القياس: 30px
                                  fontSize: 30,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // المسافة بين العنوان والخط
                              const SizedBox(width: 14),

                              // الخط البرتقالي الأيمن
                              Container(
                                width: 45,
                                height: 3,

                                decoration: BoxDecoration(
                                  color: orangeColor,
                                  borderRadius:
                                  BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),

                          // =================================================
                          // المسافة بعد العنوان
                          //
                          // القياس: 25px
                          // =================================================

                          const SizedBox(height: 25),

                          // =================================================
                          // وصف التطبيق
                          // =================================================

                          const Text(
                            'Linaty هو تطبيق تعليمي يساعد على تعلم قراءة ونطق اللغة الإنجليزية بطريقة بسيطة وتفاعلية.',

                            textAlign: TextAlign.center,

                            textDirection: TextDirection.rtl,

                            style: TextStyle(
                              color: textColor,

                              // حجم النص
                              //
                              // القياس: 19px
                              fontSize: 19,

                              // ارتفاع السطر
                              height: 1.8,

                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          // =================================================
                          // المسافة قبل قسم طريقة التعلم
                          //
                          // القياس: 28px
                          // =================================================

                          const SizedBox(height: 28),

                          // =================================================
                          // بطاقة طريقة التعلم
                          // =================================================

                          Container(
                            width: double.infinity,

                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 22,
                            ),

                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3E6),

                              borderRadius:
                              BorderRadius.circular(25),
                            ),

                            child: Column(
                              children: [

                                // -----------------------------------------
                                // الأيقونة
                                // -----------------------------------------

                                Container(
                                  width: 62,
                                  height: 62,

                                  decoration: BoxDecoration(
                                    color: orangeColor,

                                    borderRadius:
                                    BorderRadius.circular(31),
                                  ),

                                  child: const Icon(
                                    Icons.menu_book_outlined,

                                    color: Colors.white,

                                    // حجم أيقونة الكتاب
                                    //
                                    // القياس: 32px
                                    size: 32,
                                  ),
                                ),

                                // -----------------------------------------
                                // المسافة بعد الأيقونة
                                //
                                // القياس: 12px
                                // -----------------------------------------

                                const SizedBox(height: 12),

                                // -----------------------------------------
                                // عنوان طريقة التعلم
                                // -----------------------------------------

                                const Text(
                                  'طريقة التعلم',

                                  textAlign: TextAlign.center,

                                  textDirection: TextDirection.rtl,

                                  style: TextStyle(
                                    color: brownColor,

                                    // حجم العنوان
                                    //
                                    // القياس: 25px
                                    fontSize: 25,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                // -----------------------------------------
                                // المسافة بعد العنوان
                                //
                                // القياس: 10px
                                // -----------------------------------------

                                const SizedBox(height: 10),

                                // -----------------------------------------
                                // شرح طريقة التعلم
                                // -----------------------------------------

                                const Text(
                                  'صُمم ليكون التعلم تدريجيًا وعمليًا، من الحروف إلى الكلمات والنطق الصحيح.',

                                  textAlign: TextAlign.center,

                                  textDirection: TextDirection.rtl,

                                  style: TextStyle(
                                    color: textColor,

                                    // حجم النص
                                    //
                                    // القياس: 17px
                                    fontSize: 17,

                                    // المسافة بين الأسطر
                                    height: 1.7,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // =================================================
                          // المسافة قبل الفاصل
                          //
                          // القياس: 25px
                          // =================================================

                          const SizedBox(height: 25),

                          // =================================================
                          // الفاصل مع النجمة
                          // =================================================

                          Row(
                            children: [

                              // الخط الأيسر
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: orangeColor.withOpacity(0.55),
                                ),
                              ),

                              // المسافة قبل النجمة
                              const SizedBox(width: 14),

                              const Icon(
                                Icons.star,

                                color: orangeColor,

                                // حجم النجمة
                                //
                                // القياس: 28px
                                size: 28,
                              ),

                              // المسافة بعد النجمة
                              const SizedBox(width: 14),

                              // الخط الأيمن
                              Expanded(
                                child: Container(
                                  height: 2,
                                  color: orangeColor.withOpacity(0.55),
                                ),
                              ),
                            ],
                          ),

                          // =================================================
                          // المسافة قبل التواصل
                          //
                          // القياس: 24px
                          // =================================================

                          const SizedBox(height: 24),

                          // =================================================
                          // صندوق التواصل
                          // =================================================

                          Container(
                            width: double.infinity,

                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 18,
                            ),

                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF3E6),

                              borderRadius:
                              BorderRadius.circular(25),
                            ),

                            child: Column(
                              children: [

                                // -----------------------------------------
                                // أيقونة البريد
                                // -----------------------------------------

                                Container(
                                  width: 58,
                                  height: 58,

                                  decoration: BoxDecoration(
                                    color: orangeColor,

                                    borderRadius:
                                    BorderRadius.circular(29),
                                  ),

                                  child: const Icon(
                                    Icons.mail_outline,

                                    color: Colors.white,

                                    // حجم أيقونة البريد
                                    //
                                    // القياس: 30px
                                    size: 30,
                                  ),
                                ),

                                // -----------------------------------------
                                // المسافة بعد الأيقونة
                                //
                                // القياس: 10px
                                // -----------------------------------------

                                const SizedBox(height: 10),

                                // -----------------------------------------
                                // عنوان التواصل
                                // -----------------------------------------

                                const Text(
                                  'للتواصل والدعم',

                                  textDirection: TextDirection.rtl,

                                  style: TextStyle(
                                    color: brownColor,

                                    // حجم العنوان
                                    //
                                    // القياس: 21px
                                    fontSize: 21,

                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                // -----------------------------------------
                                // المسافة قبل البريد
                                //
                                // القياس: 12px
                                // -----------------------------------------

                                const SizedBox(height: 12),

                                // -----------------------------------------
                                // زر / صندوق البريد
                                // -----------------------------------------

                                Container(
                                  width: double.infinity,

                                  height: 52,

                                  alignment: Alignment.center,

                                  decoration: BoxDecoration(
                                    color: orangeColor,

                                    borderRadius:
                                    BorderRadius.circular(26),
                                  ),

                                  child: const Text(
                                    'runexe.info',

                                    style: TextStyle(
                                      color: Colors.white,

                                      // حجم البريد
                                      //
                                      // القياس: 19px
                                      fontSize: 19,

                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // =================================================
                          // المسافة السفلية داخل البطاقة
                          //
                          // القياس: 5px
                          // =================================================

                          const SizedBox(height: 5),
                        ],
                      ),
                    ),

                    // =================================================
                    // المسافة أسفل البطاقة
                    //
                    // القياس: 25px
                    // =================================================

                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}