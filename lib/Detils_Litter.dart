import 'package:flutter/material.dart';

class LetterDetailScreen extends StatelessWidget {
  const LetterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // ============================================================
      // اللغة واتجاه الصفحة
      // ============================================================

      locale: const Locale('ar', 'IQ'),

      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },

      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: const Color(0xFFFAF4EE),
      ),

      home: const LetterRulesPage(),
    );
  }
}

class LetterRulesPage extends StatelessWidget {
  const LetterRulesPage({super.key});

  // ============================================================
  // الألوان الرئيسية للتصميم
  // ============================================================

  static const Color background = Color(0xFFFAF4EE);
  static const Color orange = Color(0xFFF4510B);
  static const Color darkText = Color(0xFF291414);
  static const Color headerPeach = Color(0xFFFFE8D8);
  static const Color ruleTitlePeach = Color(0xFFFFE9DC);
  static const Color ruleBackground = Color(0xFFFFFCF8);
  static const Color cardColor = Color(0xFFFFFEFC);
  static const Color borderColor = Color(0xFFE8DED4);
  static const Color noteColor = Color(0xFFFFE5D3);
  static const Color inactiveDotColor = Color(0xFFFFDAB9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            final horizontalPadding = (width * 0.025).clamp(12.0, 28.0);
            final titleFont = (width * 0.055).clamp(22.0, 58.0);
            final sectionTitleFont = (width * 0.050).clamp(20.0, 48.0);
            final bodyFont = (width * 0.032).clamp(15.0, 31.0);

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ==================================================
                    // الهيدر
                    // ==================================================
                    _buildHeader(
                      context,
                      width,
                      titleFont,
                    ),

                    const SizedBox(height: 18),

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

                    const SizedBox(height: 18),

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

                    const SizedBox(height: 20),

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
    );
  }

  // ================================================================
  // الهيدر العلوي (تم توسيط حرف Aa والرمز)
  // ================================================================

  Widget _buildHeader(
      BuildContext context,
      double width,
      double titleFont,
      ) {
    final backSize = (width * 0.075).clamp(46.0, 76.0);

    return SizedBox(
      height: (width * 0.205).clamp(82.0, 170.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // زر الرجوع في أقصى اليسار
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
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
                  size: (width * 0.060).clamp(32.0, 58.0),
                ),
              ),
            ),
          ),

          // حرف Aa وصورة lll في منتصف الشاشة تماماً
          Row(
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'Images/lll.png',
                width: (width * 0.045).clamp(30.0, 48.0),
                height: (width * 0.030).clamp(40.0, 48.0),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    width: 25,
                    height: 30,
                  );
                },
              ),
              SizedBox(
                width: (width * 0.008).clamp(4.0, 10.0),
              ),
              Text(
                'A',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: (width * 0.125).clamp(70.0, 135.0),
                  fontWeight: FontWeight.w900,
                  color: orange,
                  height: 0.9,
                ),
              ),
              SizedBox(
                width: (width * 0.010).clamp(4.0, 12.0),
              ),
              Text(
                'a',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: (width * 0.105).clamp(70.0, 115.0),
                  fontWeight: FontWeight.w900,
                  color: orange,
                  height: 0.9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================================================================
  // صندوق القاعدة
  // ================================================================

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
      decoration: BoxDecoration(
        color: ruleBackground,
        borderRadius: BorderRadius.circular(22),
      ),
      padding: EdgeInsets.fromLTRB(
        (width * 0.022).clamp(10.0, 25.0),
        (width * 0.014).clamp(8.0, 18.0),
        (width * 0.022).clamp(10.0, 25.0),
        (width * 0.016).clamp(9.0, 20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ========================================================
          // عنوان القاعدة
          // ========================================================
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: (width * 0.016).clamp(8.0, 16.0),
                vertical: (width * 0.008).clamp(5.0, 10.0),
              ),
              decoration: BoxDecoration(
                color: ruleTitlePeach,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // الرقم وكلمة النطق
                  Text(
                    '$number. $title',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: darkText,
                      fontSize: sectionTitleFont,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 8),

                  // الصوت اللفظي
                  Text(
                    pronunciation,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: darkText,
                      fontSize: sectionTitleFont * 0.95,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 8),

                  // زر السماعة البرتقالي
                  Container(
                    width: (width * 0.052).clamp(36.0, 52.0),
                    height: (width * 0.052).clamp(36.0, 52.0),
                    decoration: const BoxDecoration(
                      color: orange,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.volume_up_rounded,
                      color: Colors.white,
                      size: (width * 0.030).clamp(20.0, 32.0),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // شرح القاعدة
          Text(
            description,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'Cairo',
              color: darkText,
              fontSize: bodyFont,
              height: 1.55,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 7),

          // كلمة أمثلة
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'أمثلة:',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: 'Cairo',
                color: const Color(0xFF9C4D20),
                fontSize: bodyFont * 1.05,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),

          const SizedBox(height: 5),

          // بطاقات الأمثلة
          _buildHorizontalWordCards(
            cards,
            width,
          ),

          const SizedBox(height: 8),

          // نقاط التنقل
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
                  (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == activeDot ? orange : inactiveDotColor,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // بطاقات الكلمات
  // ================================================================

  Widget _buildHorizontalWordCards(
      List<WordCardData> cards,
      double width,
      ) {
    return SizedBox(
      width: double.infinity,
      height: (width * 0.185).clamp(128.0, 175.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          textDirection: TextDirection.ltr,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < cards.length; i++) ...[
              _buildWordCard(
                cards[i],
                width,
              ),
              if (i != cards.length - 1)
                SizedBox(
                  width: (width * 0.008).clamp(6.0, 10.0),
                ),
            ],
          ],
        ),
      ),
    );
  }

  // ================================================================
  // بطاقة الكلمة
  // ================================================================

  Widget _buildWordCard(
      WordCardData data,
      double width,
      ) {
    double cardWidth;

    if (data.word.length <= 3) {
      cardWidth = (width * 0.275).clamp(96.0, 190.0);
    } else if (data.word.length <= 5) {
      cardWidth = (width * 0.285).clamp(110.0, 205.0);
    } else if (data.word.length <= 8) {
      cardWidth = (width * 0.345).clamp(135.0, 250.0);
    } else {
      cardWidth = (width * 0.390).clamp(155.0, 285.0);
    }

    final wordFont = (width * 0.026).clamp(20.0, 29.0);
    final arabicFont = (width * 0.020).clamp(16.0, 23.0);
    final speakerSize = (width * 0.027).clamp(27.0, 34.0);

    return SizedBox(
      width: cardWidth,
      height: (width * 0.175).clamp(120.0, 160.0),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: (width * 0.008).clamp(5.0, 10.0),
          vertical: (width * 0.007).clamp(5.0, 9.0),
        ),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  softWrap: false,
                  overflow: TextOverflow.visible,
                  text: TextSpan(
                    children: _coloredWord(
                      data.word,
                      wordFont,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
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
                    size: speakerSize * 0.62,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              data.arabicPronunciation,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.black,
                fontSize: arabicFont,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              data.meaning,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.black,
                fontSize: arabicFont,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // تلوين الحرف A داخل الكلمة
  // ================================================================

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
            color: char.toLowerCase() == 'a' ? orange : darkText,
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    }

    return spans;
  }

  // ================================================================
  // الملاحظة السفلية
  // ================================================================

  Widget _buildNote(
      double width,
      ) {
    final iconSize = (width * 0.070).clamp(48.0, 72.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: (width * 0.030).clamp(12.0, 28.0),
        vertical: (width * 0.020).clamp(10.0, 20.0),
      ),
      decoration: BoxDecoration(
        color: noteColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
              size: iconSize * 0.56,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'ملاحظة: ',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: darkText,
                      fontSize: (width * 0.037).clamp(
                        18.0,
                        40.0,
                      ),
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
                      fontSize: (width * 0.030).clamp(
                        14.0,
                        31.0,
                      ),
                      height: 1.45,
                      fontWeight: FontWeight.w700,
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