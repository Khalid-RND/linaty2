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
  static const Color orange = Color(0xFFF4510B);
  static const Color darkText = Color(0xFF29292F);

  static const Color lightPeach = Color(0xFFFFEBDD);
  static const Color cardColor = Color(0xFFFFFCF8);
  static const Color borderColor = Color(0xFFE9E0D8);
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

              // ==================================================
              // أحجام متجاوبة مع جميع الشاشات
              // ==================================================

              final horizontalPadding =
              (width * 0.025).clamp(14.0, 28.0);

              final titleFont =
              (width * 0.055).clamp(23.0, 58.0);

              final sectionTitleFont =
              (width * 0.050).clamp(21.0, 48.0);

              final bodyFont =
              (width * 0.032).clamp(14.0, 31.0);

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
                        width: width,
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
                        width: width,
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
    final backSize = (width * 0.075).clamp(48.0, 76.0);

    return SizedBox(
      height: (width * 0.22).clamp(90.0, 180.0),
      child: Row(
        children: [
          // ======================================================
          // زر الرجوع
          // ======================================================

          Container(
            width: backSize,
            height: backSize,
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
                size: (width * 0.060).clamp(34.0, 58.0),
              ),
            ),
          ),

          const Spacer(),

          // ======================================================
          // A a
          // ======================================================

          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'A',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: (width * 0.135).clamp(65.0, 145.0),
                  fontWeight: FontWeight.w900,
                  color: orange,
                  height: 0.9,
                ),
              ),

              SizedBox(
                width: (width * 0.015).clamp(7.0, 18.0),
              ),

              Text(
                'a',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: (width * 0.115).clamp(55.0, 125.0),
                  fontWeight: FontWeight.w900,
                  color: orange,
                  height: 0.9,
                ),
              ),
            ],
          ),

          SizedBox(
            width: (width * 0.035).clamp(14.0, 35.0),
          ),

          // ======================================================
          // الخط الفاصل
          // ======================================================

          Container(
            width: 2,
            height: (width * 0.135).clamp(70.0, 145.0),
            color: const Color(0xFFB44C2C),
          ),

          SizedBox(
            width: (width * 0.035).clamp(14.0, 35.0),
          ),

          // ======================================================
          // عنوان الصفحة
          // ======================================================

          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: (width * 0.035).clamp(14.0, 35.0),
                vertical: (width * 0.025).clamp(9.0, 25.0),
              ),
              decoration: BoxDecoration(
                color: lightPeach,
                borderRadius: BorderRadius.circular(
                  (width * 0.025).clamp(18.0, 30.0),
                ),
              ),
              child: Text(
                'قواعد نطق الحرف',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: darkText,
                  fontSize: titleFont,
                  fontWeight: FontWeight.w800,
                ),
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
    required double width,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        (width * 0.025).clamp(14.0, 26.0),
        (width * 0.018).clamp(13.0, 20.0),
        (width * 0.025).clamp(14.0, 26.0),
        (width * 0.020).clamp(14.0, 22.0),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFEFC),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ======================================================
          // عنوان القاعدة
          // ======================================================

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // رقم القاعدة
              Text(
                '$number.',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: darkText,
                  fontSize: sectionTitleFont,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(width: 8),

              // كلمة النطق
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: darkText,
                  fontSize: sectionTitleFont,
                  fontWeight: FontWeight.w900,
                ),
              ),

              SizedBox(
                width: (width * 0.018).clamp(8.0, 18.0),
              ),

              // زر الصوت
              Container(
                width: (width * 0.055).clamp(42.0, 58.0),
                height: (width * 0.055).clamp(42.0, 58.0),
                decoration: const BoxDecoration(
                  color: orange,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.volume_up_rounded,
                  color: Colors.white,
                  size: (width * 0.035).clamp(24.0, 36.0),
                ),
              ),

              SizedBox(
                width: (width * 0.018).clamp(8.0, 18.0),
              ),

              // النطق
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

          const SizedBox(height: 12),

          // ======================================================
          // الشرح
          // ======================================================

          Text(
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

          const SizedBox(height: 10),

          // ======================================================
          // أمثلة
          // ======================================================

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'أمثلة:',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: const Color(0xFF9C4D20),
                fontSize: bodyFont * 1.12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ======================================================
          // بطاقات الكلمات
          // السكرول الأفقي محفوظ
          // ======================================================

          _buildHorizontalWordCards(
            cards,
            width,
          ),

          const SizedBox(height: 12),

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
      double width,
      ) {
    final cardWidth =
    (width * 0.30).clamp(245.0, 310.0);

    return SizedBox(
      width: double.infinity,
      height: (width * 0.205).clamp(145.0, 180.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = cards.length - 1; i >= 0; i--) ...[
              _buildWordCard(
                cards[i],
                cardWidth,
                width,
              ),
              if (i != 0)
                SizedBox(
                  width: (width * 0.008).clamp(7.0, 10.0),
                ),
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
      double cardWidth,
      double width,
      ) {
    final wordFont =
    (width * 0.024).clamp(22.0, 27.0);

    final arabicFont =
    (width * 0.0205).clamp(19.0, 23.0);

    final speakerSize =
    (width * 0.028).clamp(28.0, 32.0);

    return SizedBox(
      width: cardWidth,
      height: (width * 0.185).clamp(135.0, 165.0),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: (width * 0.010).clamp(7.0, 11.0),
          vertical: (width * 0.010).clamp(8.0, 12.0),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // ==================================================
            // الكلمة + السماعة
            // ==================================================

            Expanded(
              flex: 4,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: RichText(
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: _coloredWord(
                            data.word,
                            wordFont,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 6),

                  Container(
                    width: speakerSize,
                    height: speakerSize,
                    decoration: const BoxDecoration(
                      color: orange,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.volume_up_rounded,
                      color: Colors.white,
                      size: speakerSize * 0.64,
                    ),
                  ),
                ],
              ),
            ),

            // ==================================================
            // النطق العربي
            // ==================================================

            Expanded(
              flex: 3,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  data.arabicPronunciation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.black,
                    fontSize: arabicFont,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            // ==================================================
            // المعنى
            // ==================================================

            Expanded(
              flex: 3,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  data.meaning,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.black,
                    fontSize: arabicFont,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // تلوين حرف A
  // ============================================================

  List<TextSpan> _coloredWord(
      String word,
      double fontSize,
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
            fontSize: fontSize,
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
    final iconSize =
    (width * 0.075).clamp(52.0, 75.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: (width * 0.035).clamp(14.0, 28.0),
        vertical: (width * 0.025).clamp(13.0, 22.0),
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
            width: iconSize,
            height: iconSize,
            decoration: const BoxDecoration(
              color: orange,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lightbulb_outline_rounded,
              color: Colors.white,
              size: iconSize * 0.58,
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
                      fontSize:
                      (width * 0.039).clamp(19.0, 40.0),
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
                      fontSize:
                      (width * 0.032).clamp(15.0, 32.0),
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