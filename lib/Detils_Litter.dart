import 'package:flutter/material.dart';

class LetterDetailScreen extends StatelessWidget {
  const LetterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: const Color(0xFFFEFBF5),
      ),
      home: const LetterRulesPage(),
    );
  }
}

class LetterRulesPage extends StatelessWidget {
  const LetterRulesPage({super.key});

  // ============================================================
  // الألوان
  // ============================================================

  static const Color background = Color(0xFFFEFBF5);

  // البرتقالي الأساسي للتطبيق
  static const Color orange = Color(0xFFF4510B);

  // اللون الداكن
  static const Color darkText = Color(0xFF29292F);

  // ألوان بطاقة القاعدة
  static const Color yellowCard = Color(0x33FFD600);
  static const Color yellowBorder = Color(0xFFD4A900);

  // خلفية عنوان الصفحة
  static const Color lightPeach = Color(0xFFFFEBDD);

  // بطاقات الكلمات
  static const Color cardColor = Color(0xFFFFFCF8);
  static const Color borderColor = Color(0xFFE9E0D8);

  // الملاحظة
  static const Color noteColor = Color(0xFFFFE5D3);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: background,

        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              final horizontalPadding = width * 0.035;
              final titleFont = width * 0.055;
              final sectionTitleFont = width * 0.050;
              final bodyFont = width * 0.032;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),

                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: 14,
                  ),

                  child: Column(
                    children: [

                      // ==================================================
                      // Header
                      // ==================================================

                      _buildHeader(
                        context,
                        width,
                        titleFont,
                      ),

                      const SizedBox(height: 22),

                      // ==================================================
                      // القاعدة الأولى
                      // ==================================================

                      _buildRuleSection(
                        number: '1',
                        pronunciation: '/eɪ/',
                        title: 'النطق',

                        description:
                        'يُلفظ الحرف A غالبًا بصوت طويل /eɪ/ كما في كلمة (A)،\n'
                            'وهو صوت مكون من حرفين: "أي".',

                        sectionTitleFont: sectionTitleFont,
                        bodyFont: bodyFont,

                        cards: const [
                          WordCardData(
                            word: 'Apple',
                            arabicPronunciation: 'أبل',
                            meaning: 'تفاحة',
                          ),

                          WordCardData(
                            word: 'Ant',
                            arabicPronunciation: 'أنت',
                            meaning: 'نملة',
                          ),

                          WordCardData(
                            word: 'Airplane',
                            arabicPronunciation: 'إيربلين',
                            meaning: 'طائرة',
                          ),
                        ],

                        activeDot: 0,
                      ),

                      const SizedBox(height: 22),

                      // ==================================================
                      // القاعدة الثانية
                      // ==================================================

                      _buildRuleSection(
                        number: '2',
                        pronunciation: '/æ/',
                        title: 'النطق',

                        description:
                        'يُلفظ الحرف A أحيانًا بصوت قصير /æ/ كما في بعض الكلمات،\n'
                            'وهو صوت قريب من "أ" المفتوحة.',

                        sectionTitleFont: sectionTitleFont,
                        bodyFont: bodyFont,

                        cards: const [
                          WordCardData(
                            word: 'Cat',
                            arabicPronunciation: 'كات',
                            meaning: 'قطة',
                          ),

                          WordCardData(
                            word: 'Bag',
                            arabicPronunciation: 'باغ',
                            meaning: 'حقيبة',
                          ),

                          WordCardData(
                            word: 'Map',
                            arabicPronunciation: 'ماب',
                            meaning: 'خريطة',
                          ),
                        ],

                        activeDot: 1,
                      ),

                      const SizedBox(height: 25),

                      // ==================================================
                      // الملاحظة
                      // ==================================================

                      _buildNote(width),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Header
  // ============================================================

  Widget _buildHeader(
      BuildContext context,
      double width,
      double titleFont,
      ) {
    return SizedBox(
      height: width * 0.22,

      child: Row(
        children: [

          // ======================================================
          // زر الرجوع
          // ======================================================

          Container(
            width: width * 0.075,
            height: width * 0.075,

            decoration: const BoxDecoration(
              color: Color(0xFFFFDCC8),
              shape: BoxShape.circle,
            ),

            child: IconButton(
              padding: EdgeInsets.zero,

              onPressed: () {
                Navigator.pop(context);
              },

              icon: Icon(
                Icons.chevron_left,
                color: darkText,
                size: width * 0.060,
              ),
            ),
          ),

          const Spacer(),

          // ======================================================
          // A a
          // ======================================================

          Row(
            children: [

              Text(
                'A',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: width * 0.135,
                  fontWeight: FontWeight.w900,
                  color: orange,
                  height: 0.9,
                ),
              ),

              SizedBox(
                width: width * 0.015,
              ),

              Text(
                'a',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: width * 0.115,
                  fontWeight: FontWeight.w900,
                  color: orange,
                  height: 0.9,
                ),
              ),
            ],
          ),

          SizedBox(
            width: width * 0.035,
          ),

          // ======================================================
          // الخط الفاصل
          // ======================================================

          Container(
            width: 2,
            height: width * 0.135,
            color: const Color(0xFFB44C2C),
          ),

          SizedBox(
            width: width * 0.035,
          ),

          // ======================================================
          // عنوان الصفحة
          // ======================================================

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.035,
              vertical: width * 0.025,
            ),

            decoration: BoxDecoration(
              color: lightPeach,
              borderRadius: BorderRadius.circular(25),
            ),

            child: Text(
              'قواعد نطق الحرف',

              style: TextStyle(
                fontFamily: 'Cairo',
                color: darkText,
                fontSize: titleFont,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // بطاقة القاعدة كاملة
  // ============================================================

  Widget _buildRuleSection({
    required String number,
    required String pronunciation,
    required String title,
    required String description,
    required double sectionTitleFont,
    required double bodyFont,
    required List<WordCardData> cards,
    required int activeDot,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.fromLTRB(
        14,
        16,
        14,
        18,
      ),

      decoration: BoxDecoration(
        color: yellowCard,

        border: Border.all(
          color: yellowBorder,
          width: 1.3,
        ),

        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [

          // ======================================================
          // عنوان القاعدة
          // ======================================================

          Align(
            alignment: Alignment.centerRight,

            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 7,
              ),

              decoration: BoxDecoration(
                color: const Color(0xFFFFE7A3),

                borderRadius: BorderRadius.circular(15),

                border: Border.all(
                  color: yellowBorder,
                  width: 1,
                ),
              ),

              child: Row(
                mainAxisSize: MainAxisSize.min,

                children: [

                  Text(
                    '$number.',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: darkText,
                      fontSize: sectionTitleFont,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(width: 7),

                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: darkText,
                      fontSize: sectionTitleFont,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  const SizedBox(width: 12),

                  // ==================================================
                  // زر الصوت
                  // ==================================================

                  Container(
                    width: 38,
                    height: 38,

                    decoration: const BoxDecoration(
                      color: orange,
                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.volume_up_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Text(
                    pronunciation,
                    textDirection: TextDirection.ltr,

                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: darkText,
                      fontSize: sectionTitleFont * 0.95,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // ======================================================
          // الشرح
          // ======================================================

          Container(
            width: double.infinity,

            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.45),
              borderRadius: BorderRadius.circular(14),
            ),

            child: Text(
              description,

              textAlign: TextAlign.right,

              style: TextStyle(
                fontFamily: 'Cairo',
                color: darkText,
                fontSize: bodyFont,
                height: 1.65,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // ======================================================
          // أمثلة
          // ======================================================

          Align(
            alignment: Alignment.centerRight,

            child: Text(
              'أمثلة:',

              style: TextStyle(
                fontFamily: 'Cairo',
                color: const Color(0xFF9C6500),
                fontSize: bodyFont * 1.15,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ======================================================
          // بطاقات الكلمات
          //
          // IMPORTANT:
          //
          // SingleChildScrollView أفقي.
          //
          // لا يوجد Wrap.
          // لا يوجد Expanded.
          //
          // جميع البطاقات تبقى في صف واحد.
          // ======================================================

          _buildHorizontalWordCards(cards),

          const SizedBox(height: 15),

          // ======================================================
          // النقاط
          // ======================================================

          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: List.generate(
              3,
                  (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),

                  width: 9,
                  height: 9,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,

                    color: index == activeDot
                        ? orange
                        : const Color(0xFFD8C9A5),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // السكرول الأفقي للكلمات
  // ============================================================

  Widget _buildHorizontalWordCards(
      List<WordCardData> cards,
      ) {
    return SizedBox(
      height: 125,

      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,

        physics: const BouncingScrollPhysics(),

        child: Row(
          textDirection: TextDirection.rtl,

          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            for (int i = cards.length - 1; i >= 0; i--) ...[
              _buildWordCard(cards[i]),

              if (i != 0)
                const SizedBox(width: 8),
            ],
          ],
        ),
      ),
    );
  }

  // ============================================================
  // بطاقة الكلمة
  // ============================================================

  Widget _buildWordCard(
      WordCardData data,
      ) {
    return Container(

      // ========================================================
      // مهم جدًا:
      //
      // لا يوجد width هنا.
      //
      // Flutter سيحسب عرض البطاقة حسب الكلمة والمحتوى.
      // ========================================================

      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 11,
      ),

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: borderColor,
          width: 1.1,
        ),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,

        mainAxisAlignment: MainAxisAlignment.start,

        children: [

          // ======================================================
          // الكلمة + السماعة
          // ======================================================

          Row(
            mainAxisSize: MainAxisSize.min,

            textDirection: TextDirection.ltr,

            mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              // ==================================================
              // الكلمة
              //
              // لا يوجد FittedBox.
              //
              // حجم الخط ثابت = 24
              // ==================================================

              RichText(
                textDirection: TextDirection.ltr,

                textAlign: TextAlign.center,

                text: TextSpan(
                  children: _coloredWord(
                    data.word,
                  ),
                ),
              ),

              const SizedBox(width: 6),

              // ==================================================
              // زر السماعة
              // ==================================================

              Container(
                width: 29,
                height: 29,

                decoration: const BoxDecoration(
                  color: orange,
                  shape: BoxShape.circle,
                ),

                child: const Icon(
                  Icons.volume_up_rounded,
                  color: Colors.white,
                  size: 19,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ======================================================
          // النطق العربي
          // ======================================================

          Text(
            data.arabicPronunciation,

            textAlign: TextAlign.center,

            style: const TextStyle(
              fontFamily: 'Cairo',
              color: Colors.black,
              fontSize: 21,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 3),

          // ======================================================
          // المعنى
          // ======================================================

          Text(
            data.meaning,

            textAlign: TextAlign.center,

            style: const TextStyle(
              fontFamily: 'Cairo',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // تلوين حرف A
  // ============================================================

  List<TextSpan> _coloredWord(
      String word,
      ) {
    final spans = <TextSpan>[];

    for (int i = 0; i < word.length; i++) {
      final char = word[i];

      spans.add(
        TextSpan(
          text: char,

          style: TextStyle(
            fontFamily: 'Cairo',

            color: char.toLowerCase() == 'a'
                ? orange
                : darkText,

            fontSize: 24,

            fontWeight: FontWeight.w800,
          ),
        ),
      );
    }

    return spans;
  }

  // ============================================================
  // الملاحظة
  // ============================================================

  Widget _buildNote(
      double width,
      ) {
    return Container(
      width: double.infinity,

      padding: EdgeInsets.symmetric(
        horizontal: width * 0.035,
        vertical: width * 0.035,
      ),

      decoration: BoxDecoration(
        color: noteColor,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          // ======================================================
          // أيقونة المصباح
          // ======================================================

          Container(
            width: width * 0.075,
            height: width * 0.075,

            decoration: const BoxDecoration(
              color: orange,
              shape: BoxShape.circle,
            ),

            child: Icon(
              Icons.lightbulb_outline_rounded,
              color: Colors.white,
              size: width * 0.045,
            ),
          ),

          const SizedBox(width: 12),

          // ======================================================
          // نص الملاحظة
          // ======================================================

          Expanded(
            child: RichText(
              textAlign: TextAlign.right,

              text: TextSpan(
                children: [

                  TextSpan(
                    text: 'ملاحظة: ',

                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: darkText,
                      fontSize: width * 0.039,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  TextSpan(
                    text:
                    'قد يختلف نطق الحرف A حسب الكلمة والموقع فيها،\n'
                        'لذلك من المهم الاستماع إلى الأمثلة والتدريب عليها.',

                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: darkText,
                      fontSize: width * 0.032,
                      height: 1.55,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// بيانات الكلمات
// ============================================================

class WordCardData {
  final String word;
  final String arabicPronunciation;
  final String meaning;

  const WordCardData({
    required this.word,
    required this.arabicPronunciation,
    required this.meaning,
  });
}