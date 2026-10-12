
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ============================================================
// الصوت
// ============================================================

final FlutterTts flutterTts = FlutterTts();

Future<void> speakText(String text) async {
  if (text.trim().isEmpty) return;

  await flutterTts.stop();
  await flutterTts.setLanguage('en-US');
  await flutterTts.setSpeechRate(0.4);
  await flutterTts.setPitch(1.0);
  await flutterTts.speak(text);
}

// ============================================================
// صفحة تفاصيل الحرف
// ============================================================

class LetterDetailScreen extends StatelessWidget {
  final String letterId;

  const LetterDetailScreen({
    super.key,
    required this.letterId,
  });

  @override
  Widget build(BuildContext context) {
    return LetterRulesPage(letterId: letterId);
  }
}

class LetterRulesPage extends StatelessWidget {
  final String letterId;

  const LetterRulesPage({
    super.key,
    required this.letterId,
  });

  static const Color background = Color(0xFFFAF4EE);
  static const Color orange = Color(0xFFF4510B);
  static const Color darkText = Color(0xFF291414);
  static const Color ruleTitlePeach = Color(0xFFFFE9DC);
  static const Color ruleBackground = Color(0xFFFFFCF8);
  static const Color cardColor = Color(0xFFFFFEFC);
  static const Color borderColor = Color(0xFFE8DED4);
  static const Color noteColor = Color(0xFFFFE5D3);
  static const Color inactiveDotColor = Color(0xFFFFDAB9);

  // ============================================================
  // جلب بيانات الحرف من Firebase
  // ============================================================

  Future<Map<String, dynamic>> _loadLetter() async {
    final doc = await FirebaseFirestore.instance
        .collection('letters')
        .doc(letterId.toUpperCase())
        .get();

    if (!doc.exists || doc.data() == null) {
      throw Exception(
        'لا توجد بيانات للحرف $letterId في Firestore',
      );
    }

    return doc.data()!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _loadLetter(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: orange,
                ),
              );
            }

            if (snapshot.hasError) {
              return _buildError(
                context,
                snapshot.error.toString(),
              );
            }

            final data = snapshot.data;

            if (data == null) {
              return _buildError(
                context,
                'لم يتم العثور على بيانات الحرف.',
              );
            }

            final letter = (data['letter'] ?? letterId).toString();
            final rules = _asMapList(data['rules']);

            return LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;

                final horizontalPadding =
                (width * 0.025).clamp(12.0, 28.0);

                final sectionTitleFont =
                (width * 0.050).clamp(20.0, 48.0);

                final bodyFont =
                (width * 0.032).clamp(15.0, 31.0);

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
                        _buildHeader(context, width, letter),
                        const SizedBox(height: 18),

                        if (rules.isEmpty)
                          _buildMessage(
                            'لا توجد قواعد نطق مضافة لهذا الحرف بعد.',
                          )
                        else
                          for (int i = 0; i < rules.length; i++) ...[
                            _buildRuleSection(
                              rule: rules[i],
                              index: i,
                              sectionTitleFont: sectionTitleFont,
                              bodyFont: bodyFont,
                              width: width,
                            ),
                            if (i != rules.length - 1)
                              const SizedBox(height: 18),
                          ],

                        const SizedBox(height: 20),

                        _buildNote(
                          width,
                          (data['note'] ??
                              'استمع إلى الكلمات وتدرّب على نطقها.')
                              .toString(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // تحويل القواعد القادمة من Firestore إلى قائمة
  // ============================================================

  List<Map<String, dynamic>> _asMapList(dynamic value) {
    if (value is! List) return [];

    return value
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  List<WordCardData> _parseExamples(dynamic value) {
    if (value is! List) return [];

    return value.whereType<Map>().map((item) {
      final map = Map<String, dynamic>.from(item);

      return WordCardData(
        word: (map['word'] ?? '').toString(),
        arabicPronunciation:
        (map['arabicPronunciation'] ?? '').toString(),
        meaning: (map['meaning'] ?? '').toString(),
      );
    }).where((item) => item.word.trim().isNotEmpty).toList();
  }

  // ============================================================
  // شاشة الخطأ
  // ============================================================

  Widget _buildError(BuildContext context, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cloud_off,
              color: orange,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(
              'تعذّر تحميل بيانات الحرف $letterId',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Cairo',
                color: darkText,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'تحقّق من اتصال الإنترنت ومن وجود المستند في '
                  'مجموعة letters في Cloud Firestore.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Cairo',
                color: darkText,
              ),
            ),
            const SizedBox(height: 12),
            TextButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        LetterDetailScreen(letterId: letterId),
                  ),
                );
              },
              icon: const Icon(
                Icons.refresh,
                color: orange,
              ),
              label: const Text(
                'إعادة المحاولة',
                style: TextStyle(
                  color: orange,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            if (error.isNotEmpty)
              Text(
                error,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // رسالة عامة
  // ============================================================

  Widget _buildMessage(String text) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ruleBackground,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Cairo',
          color: darkText,
          fontSize: 17,
        ),
      ),
    );
  }

  // ============================================================
  // الهيدر العلوي
  // ============================================================

  Widget _buildHeader(
      BuildContext context,
      double width,
      String letter,
      ) {
    final backSize = (width * 0.075).clamp(46.0, 76.0);
    final upperLetter = letter.toUpperCase();
    final lowerLetter = letter.toLowerCase();

    return SizedBox(
      height: (width * 0.205).clamp(82.0, 170.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
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
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.chevron_left,
                  color: darkText,
                  size: (width * 0.060).clamp(32.0, 58.0),
                ),
              ),
            ),
          ),
          Row(
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'Images/lll.png',
                width: (width * 0.042).clamp(25.0, 48.0),
                height: (width * 0.042).clamp(25.0, 48.0),
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) =>
                const SizedBox(width: 25, height: 25),
              ),
              SizedBox(width: (width * 0.008).clamp(4.0, 10.0)),
              Text(
                upperLetter,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: (width * 0.125).clamp(58.0, 135.0),
                  fontWeight: FontWeight.w900,
                  color: orange,
                  height: 0.9,
                ),
              ),
              SizedBox(width: (width * 0.010).clamp(4.0, 12.0)),
              Text(
                lowerLetter,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: (width * 0.105).clamp(50.0, 115.0),
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

  // ============================================================
  // صندوق القاعدة
  // ============================================================

  Widget _buildRuleSection({
    required Map<String, dynamic> rule,
    required int index,
    required double sectionTitleFont,
    required double bodyFont,
    required double width,
  }) {
    final pronunciation = (rule['pronunciation'] ?? '').toString();
    final title = (rule['title'] ?? 'النطق').toString();
    final description = (rule['description'] ?? '').toString();
    final examples = _parseExamples(rule['examples']);

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
                  Text(
                    '${index + 1}.',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: darkText,
                      fontSize: sectionTitleFont,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: darkText,
                        fontSize: sectionTitleFont,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  if (pronunciation.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        pronunciation,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: darkText,
                          fontSize: sectionTitleFont * 0.95,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(width: 8),
                  _speakerButton(
                    width: (width * 0.052).clamp(36.0, 52.0),
                    iconSize: (width * 0.030).clamp(20.0, 32.0),
                    onPressed: () {
                      final audioText =
                      (rule['audioText'] ?? pronunciation).toString();
                      speakText(audioText);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          if (description.isNotEmpty)
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
          if (examples.isEmpty)
            _buildMessage('لا توجد أمثلة لهذه القاعدة بعد.')
          else
            _buildHorizontalWordCards(examples, width),
          const SizedBox(height: 8),
          Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
                  (dotIndex) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dotIndex == index % 3
                      ? orange
                      : inactiveDotColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // زر النطق
  // ============================================================

  Widget _speakerButton({
    required double width,
    required double iconSize,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: width,
      height: width,
      decoration: const BoxDecoration(
        color: orange,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          Icons.volume_up_rounded,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    );
  }

  // ============================================================
  // بطاقات الكلمات مع السكرول الأفقي
  // ============================================================

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
              _buildWordCard(cards[i], width),
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

  // ============================================================
  // بطاقة الكلمة
  // ============================================================

  Widget _buildWordCard(WordCardData data, double width) {
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
                Flexible(
                  child: RichText(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: _coloredWord(data.word, wordFont),
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
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => speakText(data.word),
                    icon: Icon(
                      Icons.volume_up_rounded,
                      color: Colors.white,
                      size: speakerSize * 0.62,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            if (data.arabicPronunciation.isNotEmpty)
              Text(
                data.arabicPronunciation,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  color: Colors.black,
                  fontSize: arabicFont,
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (data.meaning.isNotEmpty)
              Text(
                data.meaning,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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

  // ============================================================
  // تلوين الحروف الإنجليزية التي تطابق حرف الصفحة
  // ============================================================

  List<TextSpan> _coloredWord(String word, double fontSize) {
    final spans = <TextSpan>[];
    final target = letterId.toLowerCase();

    for (int i = 0; i < word.length; i++) {
      final char = word[i];

      spans.add(
        TextSpan(
          text: char,
          style: TextStyle(
            fontFamily: 'Cairo',
            color: target.contains(char.toLowerCase())
                ? orange
                : darkText,
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    }

    return spans;
  }

  // ============================================================
  // الملاحظة السفلية
  // ============================================================

  Widget _buildNote(double width, String note) {
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
            child: Text(
              note,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Cairo',
                color: darkText,
                fontSize: (width * 0.030).clamp(14.0, 31.0),
                height: 1.45,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// نموذج بيانات بطاقة الكلمة - خارج LetterRulesPage
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
