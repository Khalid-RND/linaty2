import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'change_password_screen.dart';
import 'main.dart';
import 'about_linaty.dart';


class SettingsScreen extends StatefulWidget {

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();

}

class _SettingsScreenState extends State<SettingsScreen> {
  // --- متغيّرات الحالة (State Variables) ---
  String selectedSpeechSpeed = 'عادي'; // خيار سرعة النطق المحدد
  bool isDailyReminderOn = true; // حالة مفتاح التذكير اليومي
  String reminderTime = '08:00 م'; // وقت التذكير المحدد

  User? user =FirebaseAuth.instance.currentUser;



  // --- الألوان المستخرجة من التصميم ---
  static const Color backgroundColor = Color(0xFFFAF7F2); // خلفية الصفحة (بيج فاتح جداً)
  static const Color cardBackgroundColor = Colors.white; // خلفية الكروت والأقسام
  static const Color primaryOrange = Color(0xFFEE8025); // اللون البرتقالي الأساسي للتحديد والتحكم
  static const Color lightOrangeBg = Color(0xFFFFF2E8); // خلفية الأيقونات الدائرية
  static const Color textColorPrimary = Color(0xFF1E1E1E); // لون النصوص الرئيسية
  static const Color textColorSecondary = Color(0xFF757575); // لون النصوص الفرعية والإيميل
  static const Color borderColor = Color(0xFFF0EAE1); // لون الحدود الخفيفة

  @override
  Widget build(BuildContext context) {

    // استخدام Directionality لضمان ترتيب العناصر من اليمين إلى اليسار (RTL)
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0, // إلغاء ظل الهيدر
          centerTitle: true,
          title: const Text(
            'الإعدادات',
            style: TextStyle(
              color: textColorPrimary,
              fontSize: 20, // حجم خط عنوان الصفحة
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          // حواشي خارجية متناسبة مع أطراف الشاشة
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              // 1. كارت الملف الشخصي (Profile Section)
              _buildProfileCard(),
              const SizedBox(height: 16), // مسافة فاصلة بين الكروت

              // 2. كارت الحساب والكلمة المرور (Account Section)
              _buildAccountCard(),
              const SizedBox(height: 16),

              // 3. كارت الصوت وسرعة النطق (Sound Section)
              _buildSoundCard(),
              const SizedBox(height: 16),

              // 4. كارت الإشعارات (Notifications Section)



              // 5. كارت عن التطبيق (About Section)
              _buildAboutCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // --- 1. كارت ملف المستخدم الشخصي ---
  // ==========================================
  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16), // الحشو الداخلي للكارت
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(20), // انحناء زوايا الكارت
      ),
      child: Row(
        children: [
          // الصورة الشخصية الدائرية مع إطار أسود خفيف
          Container(
            width: 70, // عرض الصورة
            height: 70, // ارتفاع الصورة
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black12, width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.asset(
                'assets/images/app_icon.png', // مسار صورة الشخصية من مجلد assets
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.person,
                  size: 40,
                  color: primaryOrange,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16), // مسافة فاصلة أفقيّة

          // تفاصيل الاسم والبريد الإلكتروني
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.displayName ??'' ,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColorPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                 Text(
                  user?.email ?? '',
                  style: TextStyle(
                    fontSize: 13,
                    color: textColorSecondary,
                  ),
                ),
              ],
            ),
          ),

          // سهم التنقل لليسار
          const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: textColorSecondary,
          ),
        ],
      ),
    );
  }

  // ==========================================
  // --- 2. كارت إدارة الحساب وكلمة المرور ---
  // ==========================================
  Widget _buildAccountCard() {
    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildListTile(
            title: 'تغيير كلمة المرور',
            icon: Icons.lock_outline_rounded,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChangePasswordScreen(),
                ),
              );
            },

          ),
          const Divider(height: 1, color: borderColor, indent: 16, endIndent: 16), // خط فاصل داخلي
          _buildListTile(
            title: 'تسجيل الخروج',
            icon: Icons.logout_rounded,
            iconColor: Colors.redAccent, // لون أيقونة الخروج
            onTap: () async {
              await FirebaseAuth.instance.signOut();

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LinatyApp(),),
            );},
          ),
        ],
      ),
    );
  }

  // ==========================================
  // --- 3. كارت إعدادات الصوت ---
  // ==========================================
  Widget _buildSoundCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // عنوان القسم مع الأيقونة البرتقالية الدائرية
          Row(
            children: [
              _buildSectionIcon(Icons.volume_up_outlined),
              const SizedBox(width: 10),
              const Text(
                'الصوت',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColorPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // عنوان التحكم بالسرعة
          const Text(
            'سرعة النطق',
            style: TextStyle(fontSize: 14, color: textColorSecondary),
          ),
          const SizedBox(height: 10),

          // شريط أزرار اختيار سرعة النطق (بطيء - عادي - سريع)
          Container(
            height: 48, // ارتفاع مجسم التحديد
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: backgroundColor, // خلفية الشريط الرمادية/البيج
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                _buildSpeedOption('بطيء'),
                _buildSpeedOption('عادي'),
                _buildSpeedOption('سريع'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // عنصر الخيار المفرد لشريط السرعة
  Widget _buildSpeedOption(String label) {
    bool isSelected = selectedSpeechSpeed == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedSpeechSpeed = label;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? primaryOrange : Colors.transparent, // لون الزر عند التحديد
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : textColorPrimary,
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // --- 4. كارت الإشعارات للتذكير اليومي ---
  // ==========================================


  // ==========================================
  // --- 5. كارت المعلومات "عن التطبيق" ---
  // ==========================================
  Widget _buildAboutCard() {
    return Container(
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // الهيدر الداخلي للقسم



          const Divider(height: 1, color: borderColor, indent: 16, endIndent: 16),
          _buildListTile(
            title: 'عن Linaty',
            icon: Icons.person_outline_rounded,

            // عند الضغط على "عن Linaty"
            // الانتقال إلى صفحة About Linaty
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutLinatyScreen(),
                ),
              );
            },
          ),




          const Divider(height: 1, color: borderColor, indent: 16, endIndent: 16),

          // عرض رقم الإصدار الحالي
          _buildListTile(
            title: 'الإصدار',
            icon: Icons.inventory_2_outlined,
            trailingWidget: const Text(
              '1.0.0',
              style: TextStyle(
                fontSize: 13,
                color: textColorSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // --- أدوية برمجية مساعدة (Helper Widgets) ---
  // ==========================================

  // بناء أيقونة عناوين الأقسام الدائرية (برتقالي فاتح مع أيقونة برتقالية)
  Widget _buildSectionIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: lightOrangeBg,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 20,
        color: primaryOrange,
      ),
    );
  }

  // بناء أسطر الخيارات القابلة للنقر (List Tile)
  Widget _buildListTile({
    required String title,
    required IconData icon,
    Color iconColor = textColorSecondary,
    VoidCallback? onTap,
    Widget? trailingWidget,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          color: textColorPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      // الأيقونة جهة اليمين
      trailing: Icon(icon, color: iconColor, size: 22),
      // السهم أو الرقم جهة اليسار
      leading: trailingWidget ??
          const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16,
            color: textColorSecondary,
          ),
    );
  }
}