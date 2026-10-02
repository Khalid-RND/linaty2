import 'package:flutter/material.dart';
import 'package:linaty/settings_screen.dart';
import 'Detils_Litter.dart';


// =============================
// Linaty - صفحة الحرف فقط
// ==============================
// التعديلات الجديدة:
// 1) تنسيق ألوان جميع البطاقات لتتناوب بالتساوي بين الألوان الثلاثة.
// 2) تخفيف ارتفاع الشريط السفلي ليكون أنيقاً وغير مرتفع.
// 3) إضافة ملاحظات باللغة العربية على جميع القياسات.
// ============================================================
//ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo

// ============================================================
// قياسات التصميم (Design Dimensions & Measurements)
// ============================================================

// ------------------------------------------------------------
// شعار Linaty (Logo Dimensions)
// ------------------------------------------------------------
// logoWidth: العرض الكلي للشعار بالبكسل.
// logoHeight: الارتفاع الكلي للشعار.
// ------------------------------------------------------------
const double logoWidth = 250;
const double logoHeight = 96;


// ------------------------------------------------------------
// النصوص والعناوين (Typography Measurements)
// ------------------------------------------------------------
// titleFontSize: حجم خط العنوان الرئيسي في أعلى الصفحة.
const double titleFontSize = 26;

// subtitleFontSize: حجم خط الوصف الفرعي (اختر حرف للبدء).
const double subtitleFontSize = 15;


// ------------------------------------------------------------
// بطاقات ومربعات الأحرف (Letter Card Measurements)
// ------------------------------------------------------------
// letterBoxHeight: ارتفاع بطاقة الحرف الواحدة.
const double letterBoxHeight = 52;

// letterBoxRadius: درجة تدوير زوايا البطاقات (Border Radius).
const double letterBoxRadius = 14;

// boxHorizontalSpacing: المسافة الأفقية بين البطاقات المجاورة.
const double boxHorizontalSpacing = 10;

// boxVerticalSpacing: المسافة الرأسية بين أسطر البطاقات.
const double boxVerticalSpacing = 14;


// ------------------------------------------------------------
// أحجام الخطوط داخل المربعات (Letter Font Sizes)
// ------------------------------------------------------------
const double singleLetterFontSize = 26; // حرف واحد (A, B, C)
const double doubleLetterFontSize = 19; // حرفان (SH, TH, CH)
const double tripleLetterFontSize = 16; // ثلاثة أحرف (IGH, AIR)
const double fourLetterFontSize = 14;   // أربعة أحرف (IGHT, TION)
const double fiveLetterFontSize = 13;   // خمسة أحرف (OUGHT, THERE)


// ------------------------------------------------------------
// المسافات بين الأقسام (Section Spacing)
// ------------------------------------------------------------
// sectionSpacing: الفراغ بين كل قسم أحرف والقسم الذي يليه.
const double sectionSpacing = 24;


// ------------------------------------------------------------
// قياسات الشريط السفلي (Bottom Navigation Bar Measurements)
// ------------------------------------------------------------
// bottomNavHeight: ارتفاع الشريط السفلي تم تخفيضه إلى 50 ليكون نحيفاً ومناسباً.
const double bottomNavHeight = 42;

// bottomIconSize: حجم الأيقونات في الشريط السفلي.
const double bottomIconSize = 25;

// bottomTextSize: حجم النص التوضيحي أسفل كل أيقونة في الشريط السفلي.
const double bottomTextSize = 10;

// fabSize: حجم زر الرئيسية الدائري المنتصف.
const double fabSize = 48;


// ============================================================
// الألوان الأربعة الرئيسية في التصميم (Color Palette)
// ============================================================

// 1. لون خلفية التطبيق (أوف وايت دافئ)
const Color backgroundColor = Color(0xFFFAF4EE);

// 2. اللون البرتقالي
const Color orangeColor = Color(0xFFFF7827);

// 3. اللون الداكن (رمادي غامق/أسود ناعم)
const Color darkColor = Color(0xFF3F3D43);

// 4. اللون البيج الفاتح (للبطاقات الثالثة بدلاً من الأبيض)
const Color lightBoxColor = Color(0xFFF5E4C9);


// ============================================================
// الصفحة الرئيسية (Home Screen Widget)
// ============================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // قائمة الأحرف المفردة (26)
  static const List<String> singleLetters = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
  ];

  // قائمة الحرفين المركبة
  static const List<String> twoLetters = [
    'SH', 'TH', 'PH', 'GH', 'CH', 'WH', 'CK', 'CC', 'NG', 'OO',
    'EA', 'ED', 'EW', 'EY', 'EO', 'KH', 'IN', 'IR', 'IO', 'IA',
    'IE', 'OU', 'UE', 'UI', 'AI', 'AY', 'OI', 'OY', 'OA', 'OW',
    'AR', 'ER', 'OR', 'UR', 'AU', 'AW'
  ];

  // قائمة 3 أحرف
  static const List<String> threeLetters = [
    'IOU', 'IEW', 'URE', 'IGH', 'AIR', 'TIO', 'SCH', 'ING', 'EAR',
    'EER', 'OOR', 'OUR', 'AUG', 'ALL', 'OOK', 'OOD', 'OUD',
  ];

  // قائمة 4 أحرف
  static const List<String> fourLetters = [
    'IGHT', 'OUGH', 'TION', 'SION', 'AUGH', 'EIGH', 'WARD', 'TURE', 'EARN',
  ];

  // قائمة 5 أحرف
  static const List<String> fiveLetters = [
    'OUGHT', 'THERE',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: SafeArea(
        child: Column(
          children: [
            // المحتوى القابل للتمرير
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  children: [
                    // العنوان الرئيسي
                    const Text(
                      'تعلم نطق الأحرف الإنجليزية',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: darkColor,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // العنوان الفرعي
                    const Text(
                      'اختر حرفاً للبدء',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: subtitleFontSize,
                        color: Color(0xFF66615B),
                      ),
                    ),

                    const SizedBox(height: sectionSpacing),

                    // أقسام الأحرف
                    _sectionTitle('أحرف مفردة'),
                    const SizedBox(height: 12),
                    _letterGrid(context, singleLetters, singleLetterFontSize),

                    const SizedBox(height: sectionSpacing),

                    _sectionTitle('أحرف مركبة من حرفين'),
                    const SizedBox(height: 12),
                    _letterGrid(context, twoLetters, doubleLetterFontSize),

                    const SizedBox(height: sectionSpacing),

                    _sectionTitle('أحرف مركبة من ثلاثة أحرف'),
                    const SizedBox(height: 12),
                    _letterGrid(context, threeLetters, tripleLetterFontSize),

                    const SizedBox(height: sectionSpacing),

                    _sectionTitle('أحرف مركبة من أربعة أحرف'),
                    const SizedBox(height: 12),
                    _letterGrid(context, fourLetters, fourLetterFontSize),

                    const SizedBox(height: sectionSpacing),

                    _sectionTitle('أحرف مركبة من خمسة أحرف'),
                    const SizedBox(height: 12),
                    _letterGrid(context, fiveLetters, fiveLetterFontSize),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ============================================================
      // الزر العائم المركزي (Floating Home Button)
      // ============================================================
      floatingActionButton: SizedBox(
        width: fabSize,
        height: fabSize,
        child: FloatingActionButton(
          elevation: 2,
          backgroundColor: Color(0xFFC14F01),//لون دائرة الهوم
          child: const Icon(
            Icons.home_rounded,
            size: 26,
            color: Colors.white,
          ),
          shape: const CircleBorder(),
          onPressed: () {
            // الانتقال للرئيسية
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // ============================================================
      // الشريط السفلي الخفيف والمرتب (Compact Bottom Navigation Bar)
      // ============================================================
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF29292F),
        elevation: 6,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0, // تقليل التقعر ليناسب الحجم المنخفض
        child: SizedBox(
          height: bottomNavHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // زر المشاركة
              _navBarItem(
                icon: Icons.share_outlined,
                label: 'مشاركة',
                isSelected: false,
                onTap: () {
                  // مشاركة التطبيق
                },
              ),

              // مسافة مخصصة للزر العائم في المنتصف
              const SizedBox(width: 60),

              // زر الإعدادات
              _navBarItem(
                icon: Icons.settings_outlined,
                label: 'الإعدادات',
                isSelected: false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // ودجت تبويب الشريط السفلي (Compact Nav Item)
  // ==========================================================
  static Widget _navBarItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    //]داله تغير اللوان الاعدادات والمشاركه
    final Color color = isSelected ? orangeColor : const Color(0xFFFFFFFF);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: bottomIconSize,
              color: color,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: bottomTextSize,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // عنوان كل قسم (Section Title)
  // ==========================================================
  static Widget _sectionTitle(String title) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Color(0xFFD8C5A7),
            thickness: 1.2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: darkColor,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Color(0xFFD8C5A7),
            thickness: 1.2,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // شبكة المربعات (Letter Grid)
  // ==========================================================
  static Widget _letterGrid(
      BuildContext context,
      List<String> letters,
      double fontSize,
      ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: boxHorizontalSpacing,
        mainAxisSpacing: boxVerticalSpacing,
        mainAxisExtent: letterBoxHeight,
      ),
      itemCount: letters.length,
      itemBuilder: (context, index) {
        final String letter = letters[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LetterDetailScreen(),
              ),
            );
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _boxColor(index), // الألوان تناوبية الآن بين الألوان الثلاثة
              borderRadius: BorderRadius.circular(letterBoxRadius),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x12000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              letter,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: _textColor(index),
              ),
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // توزيع الألوان الثلاثة بالتناوب المتناسق على المربعات
  // ==========================================================
  static Color _boxColor(int index) {
    // التناوب الدوري: 0 = بيج، 1 = برتقالي، 2 = داكن
    switch (index % 3) {
      case 0:
        return lightBoxColor; // البيج الفاتح (0xFFF5E4C9)
      case 1:
        return orangeColor;   // البرتقالي (0xFFFF7827)
      case 2:
        return darkColor;     // الداكن (0xFF3F3D43)
      default:
        return lightBoxColor;
    }
  }

  // ==========================================================
  // لون النص داخل المربع حسب لون الخلفية لتوضيح الخط
  // ==========================================================
  static Color _textColor(int index) {
    final Color boxColor = _boxColor(index);

    if (boxColor == orangeColor || boxColor == darkColor) {
      return Colors.white; // نص أبيض على الألوان الداكنة والبرتقالية
    }

    return const Color(0xFF202020); // نص داكن على اللون البيج الفاتح
  }
}