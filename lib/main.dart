import 'dart:ui';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const RanniAboutApp());
}

class RanniAboutApp extends StatelessWidget {
  const RanniAboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '菈妮主題頁',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF060A16),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color(0xFF8FA7FF),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isLeaving = false;

  Future<void> _startIntro() async {
    if (_isLeaving) return;
    setState(() {
      _isLeaving = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 420));
    if (!mounted) return;

    await Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 420),
        pageBuilder: (routeContext, animation, secondaryAnimation) =>
            const RanniHomeScreen(),
        transitionsBuilder:
            (routeContext, animation, secondaryAnimation, child) =>
                FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 420),
        opacity: _isLeaving ? 0 : 1,
        curve: Curves.easeOutCubic,
        child: GestureDetector(
          key: const Key('ranni-gif-start'),
          onTap: _startIntro,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/images/rannigif.gif', fit: BoxFit.cover),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 40, 20, 34),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.35),
                        Colors.black.withValues(alpha: 0.62),
                      ],
                    ),
                  ),
                  child: Text(
                    '點擊畫面進入拉妮介紹',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.95),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RanniHomeScreen extends StatefulWidget {
  const RanniHomeScreen({super.key});

  @override
  State<RanniHomeScreen> createState() => _RanniHomeScreenState();
}

class _RanniHomeScreenState extends State<RanniHomeScreen> {
  int currentIndex = 0;

  Future<void> _backToWelcome() async {
    await Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 320),
        pageBuilder: (context, animation, secondaryAnimation) =>
            const WelcomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  Widget _buildPage() {
    switch (currentIndex) {
      case 0:
        return _IntroPage(onBackToWelcome: _backToWelcome);
      case 1:
        return _QuestPage(onBackToWelcome: _backToWelcome);
      case 2:
        return _DarkMoonSwordPage(onBackToWelcome: _backToWelcome);
      default:
        return _IntroPage(onBackToWelcome: _backToWelcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _MoonBackground(),
          SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _buildPage(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        backgroundColor: const Color(0xFF10172E),
        indicatorColor: const Color(0xFF9DB4FF).withValues(alpha: 0.28),
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '拉妮介紹',
          ),
          NavigationDestination(
            icon: Icon(Icons.route_outlined),
            selectedIcon: Icon(Icons.route),
            label: '任務介紹',
          ),
          NavigationDestination(
            icon: FaIcon(FontAwesomeIcons.khanda, size: 18),
            selectedIcon: FaIcon(FontAwesomeIcons.khanda, size: 18),
            label: '暗月大劍',
          ),
        ],
      ),
    );
  }
}

class _IntroPage extends StatelessWidget {
  final VoidCallback onBackToWelcome;

  const _IntroPage({required this.onBackToWelcome});

  static const quotes = [
    '「你讓魔女菈妮蒙羞，我不允許你拒絕。」\nThe name of Ranni the Witch is already sullied by thee. I will not brook disobedience in this matter. ',
    '「其實，我很慶幸，我的王是你。」\nSo, it was thee, who would become my Lord. Perhaps I needn\'t have warned thee. I am pleased, however.',
    '「來吧，我親愛的、永恆的伴侶。」\nMy fair（dear） consort, eternal. ',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const ValueKey('intro-page'),
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverToBoxAdapter(
          child: _TopBar(title: '拉妮介紹', onBackToWelcome: onBackToWelcome),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverToBoxAdapter(
          child: _AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '菈妮 Ranni',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'assets/images/ranniprofile.webp',
                    width: double.infinity,
                    height: 500,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '月之公主，卡利亞王室後裔。她所追求的，是不受黃金律法束縛的群星時代。',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 15,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    _Tag(text: '神祕'),
                    _Tag(text: '孤高'),
                    _Tag(text: '月與星'),
                    _Tag(text: '群星結局'),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 14)),
        SliverToBoxAdapter(
          child: _AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle(icon: Icons.format_quote, title: '經典語錄'),
                const SizedBox(height: 10),
                for (final quote in quotes)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white.withValues(alpha: 0),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    child: Text(
                      quote,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.96),
                        fontSize: 14.5,
                        height: 1.6,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}

class _QuestPage extends StatelessWidget {
  final VoidCallback onBackToWelcome;

  const _QuestPage({required this.onBackToWelcome});

  static const steps = <_QuestStepData>[
    _QuestStepData(
      title: '前置條件',
      place: '卡利亞城寨 -> 三姊妹塔',
      detail:
          '先推進到利耶尼亞，通過卡利亞城寨並擊敗王家騎士蘿蕾塔，開啟三姊妹塔區域。'
          '建議至少先打完滿月女王再來，戰鬥壓力會低很多。',
      imagePath: 'assets/images/quest/step00_prerequisite.png',
    ),
    _QuestStepData(
      title: '在菈妮魔法師塔接任務',
      place: '菈妮魔法師塔（Ranni’s Rise）',
      detail: '上塔頂與菈妮對話，答應她的請求後就可以開始菈妮的專屬任務。接著到塔下與布萊澤、伊吉、塞爾維斯三人都對話完',
      imagePath: 'assets/images/quest/step01_ranni_rise.png',
    ),
    _QuestStepData(
      title: '前往希芙拉河找布萊澤',
      place: '霧林森林 -> 希芙拉河入口井',
      detail: '進入地下後找到布萊澤(狼哥)，他會提到關於永恆之城的線索，並引導你先去找塞爾維斯。',
      imagePath: 'assets/images/quest/step02_siofra.png',
    ),
    _QuestStepData(
      title: '塞爾維斯推薦去找瑟濂',
      place: '塞爾維斯魔法師塔 -> 驛站街遺跡地下室',
      detail: '與塞爾維斯對話取得推薦信，去找魔女瑟濂。瑟濂會指出必須先擊敗碎星拉塔恩，任務才會往下推進。',
      imagePath: 'assets/images/quest/step03_seluvis_sellen.png',
    ),
    _QuestStepData(
      title: '參加戰鬥祭典，擊敗拉塔恩',
      place: '蓋利德 -> 紅獅子城',
      detail: '打倒碎星拉塔恩後，天空流星墜落，諾克隆恩入口開啟。這是菈妮支線最關鍵的轉折點之一。',
      imagePath: 'assets/images/quest/step04_radahn.png',
    ),
    _QuestStepData(
      title: '進入諾克隆恩拿獵殺指頭刀',
      place: '寧姆格福（流星坑）-> 永恆之城諾克隆恩',
      detail: '從流星砸出的坑洞下去，在諾克隆恩拿到「獵殺指頭刀（Fingerslayer Blade）」，再回去交給菈妮。',
      imagePath: 'assets/images/quest/step05_fingerslayer.png',
    ),
    _QuestStepData(
      title: '取得顛倒雕像並開新路',
      place: '菈妮魔法師塔 -> 卡利亞書齋',
      detail: '交刀後可拿到「卡利亞顛倒雕像」。到卡利亞書齋使用後可開啟倒置區域，拿死咒痕等道具（此段常與其他支線交會）。',
      imagePath: 'assets/images/quest/step06_inverted_statue.png',
    ),
    _QuestStepData(
      title: '從蕾娜魔法師塔前往安瑟爾河主流',
      place: '蕾娜魔法師塔（Renna’s Rise）傳送門',
      detail: '開放蕾娜魔法師塔後，使用傳送門到安瑟爾河主流，撿到「嬌小菈妮」娃娃，並在賜福點反覆對話。',
      imagePath: 'assets/images/quest/step07_ainsel.png',
    ),
    _QuestStepData(
      title: '擊敗災厄影子拿鑰匙',
      place: '諾克史黛拉 -> 諾克史黛拉水潭',
      detail: '一路推進地下區域，打倒「災厄影子」後取得「被丟棄的王宮鑰匙」，可開啟雷亞盧卡利亞大書庫寶箱。',
      imagePath: 'assets/images/quest/step08_baleful_shadow.png',
    ),
    _QuestStepData(
      title: '拿暗月戒指',
      place: '雷亞盧卡利亞大書庫（滿月女王房間）',
      detail: '用王宮鑰匙打開寶箱，取得「暗月戒指（Dark Moon Ring）」，這是最後儀式必備道具。(結婚戒指UwU)',
      imagePath: 'assets/images/quest/step09_dark_moon_ring.png',
    ),
    _QuestStepData(
      title: '穿越腐敗湖，挑戰艾絲緹',
      place: '腐敗湖 -> 大迴廊 -> 黑暗棄子艾絲緹',
      detail: '經過腐敗湖與大迴廊，搭棺材前往首領戰，擊敗「黑暗棄子 艾絲緹（Astel）」才能上月光祭壇。',
      imagePath: 'assets/images/quest/step10_astel.png',
    ),
    _QuestStepData(
      title: '在瑪努斯・瑟利斯大教堂完成誓約',
      place: '月光祭壇 -> 瑪努斯・瑟利斯大教堂',
      detail: '到教堂洞穴底部找到菈妮本體，使用暗月戒指完成誓約，可獲得「暗月大劍」(老婆大劍)。菈妮主支線到此完成。',
      imagePath: 'assets/images/quest/step11_manus_celes.png',
    ),
    _QuestStepData(
      title: '收尾與可選後續',
      place: '三姊妹塔周邊',
      detail: '回菈妮塔附近可觸發布萊澤、伊吉、塞爾維斯相關收尾事件，能拿到對應套裝與道具，建議最後再一次性清完。',
      imagePath: 'assets/images/quest/step12_epilogue.png',
    ),
  ];

  static const tips = [
    '若你先觸發了拉塔恩祭典，菈妮有時不會立刻出現在塔頂；先打完拉塔恩再回來通常可解。',
    '塞爾維斯支線與部分 NPC 支線會互相影響，想全蒐集建議先備份存檔或先查分歧點。',
    '腐敗湖段落建議準備抗猩紅腐敗道具與快速穿越路線。',
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const ValueKey('quest-page'),
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverToBoxAdapter(
          child: _TopBar(title: '任務介紹', onBackToWelcome: onBackToWelcome),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverToBoxAdapter(
          child: _AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle(icon: Icons.route, title: '菈妮任務線詳細流程'),
                const SizedBox(height: 12),
                Text(
                  '此段整理自玩家攻略脈絡，並改寫成 App 閱讀版本。你可以往下滑動依序看每一步，'
                  '每步都預留了圖片欄位，後續可直接替換成你的截圖。',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.88),
                    fontSize: 14.5,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 14),
                for (int i = 0; i < steps.length; i++)
                  _QuestStepCard(index: i + 1, data: steps[i]),
                const SizedBox(height: 10),
                Divider(
                  color: Colors.white.withValues(alpha: 0.14),
                  height: 24,
                ),
                const _SectionTitle(
                  icon: Icons.tips_and_updates,
                  title: '流程提醒',
                ),
                const SizedBox(height: 10),
                for (final tip in tips)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 15,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            tip,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.9),
                              fontSize: 14.3,
                              height: 1.55,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}

class _QuestStepData {
  final String title;
  final String place;
  final String detail;
  final String imagePath;

  const _QuestStepData({
    required this.title,
    required this.place,
    required this.detail,
    required this.imagePath,
  });
}

class _QuestStepCard extends StatelessWidget {
  final int index;
  final _QuestStepData data;

  const _QuestStepCard({required this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withValues(alpha: 0.06),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF97ADFF).withValues(alpha: 0.28),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  '$index',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      data.place,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.75),
                        fontSize: 12.8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            data.detail,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 14.2,
              height: 1.55,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                data.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.white.withValues(alpha: 0.05),
                    alignment: Alignment.center,
                    child: Text(
                      '圖片預留：${data.imagePath}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12.5,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DarkMoonSwordPage extends StatelessWidget {
  final VoidCallback onBackToWelcome;

  const _DarkMoonSwordPage({required this.onBackToWelcome});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const ValueKey('sword-page'),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          _TopBar(title: '暗月大劍(老婆大劍)', onBackToWelcome: onBackToWelcome),
          const SizedBox(height: 12),
          _AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle(
                  icon: Icons.construction_outlined,
                  title: '暗月大劍（Dark Moon Greatsword）',
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      'assets/images/dark_moon_greatsword.webp',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.white.withValues(alpha: 0.05),
                          alignment: Alignment.center,
                          child: Text(
                            '圖片預留：assets/images/dark_moon_greatsword.webp',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12.5,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                const _InGameSwordPanel(),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.12),
                        const Color(0xFFA0B4FF).withValues(alpha: 0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.16),
                    ),
                  ),
                  child: Text(
                    '配裝建議：優先提高智力與專注值，搭配提升魔力輸出的護符與法術。'
                    '若你主打戰技 + 月光波循環，戰鬥手感會非常穩定。',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.96),
                      fontSize: 14,
                      height: 1.65,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _InGameSwordPanel extends StatelessWidget {
  const _InGameSwordPanel();

  @override
  Widget build(BuildContext context) {
    const panelTextColor = Color(0xFFE7E1CC);
    const subtleTextColor = Color(0xFFC8C2AE);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFF2A2B22).withValues(alpha: 0.78),
        border: Border.all(
          color: const Color(0xFF8E8568).withValues(alpha: 0.75),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: DefaultTextStyle(
        style: const TextStyle(
          color: panelTextColor,
          fontSize: 13.4,
          height: 1.45,
          letterSpacing: 0.2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '暗月大劍',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            const Text('大劍 / 普通・突刺', style: TextStyle(color: subtleTextColor)),
            const SizedBox(height: 8),
            Divider(
              color: const Color(0xFF8E8568).withValues(alpha: 0.45),
              height: 12,
            ),
            const SizedBox(height: 4),
            const Text('戰技：月光劍    FP 消耗：40    重量：10.0'),
            const SizedBox(height: 10),
            const _PanelSubTitle('攻擊力'),
            const SizedBox(height: 6),
            const _PanelStatRow(left: '物理 82', right: '魔力 98'),
            const _PanelStatRow(left: '火焰 0', right: '雷 0'),
            const _PanelStatRow(left: '聖 0', right: '致命一擊 100'),
            const SizedBox(height: 10),
            const _PanelSubTitle('防禦時減傷率'),
            const SizedBox(height: 6),
            const _PanelStatRow(left: '物理 42.0', right: '魔力 63.0'),
            const _PanelStatRow(left: '火焰 31.0', right: '雷 31.0'),
            const _PanelStatRow(left: '聖 31.0', right: '防禦強度 36'),
            const SizedBox(height: 10),
            const _PanelSubTitle('能力補正 / 能力需求'),
            const SizedBox(height: 6),
            const _PanelStatRow(
              left: '補正：力 D / 技 D / 智 C',
              right: '需求：力16 / 技11 / 智38',
            ),
            const SizedBox(height: 8),
            const Text('附加效果：凍傷累積 55'),
            const SizedBox(height: 6),
            const Text('強化類型：失色鍛造石'),
            const SizedBox(height: 8),
            Text(
              '高舉大劍後會附上暗月月光，強化魔力傷害並附寒氣；蓄力重攻擊可放出月光波。',
              style: const TextStyle(color: subtleTextColor),
            ),
          ],
        ),
      ),
    );
  }
}

class _PanelSubTitle extends StatelessWidget {
  final String text;

  const _PanelSubTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        color: Color(0xFFF1ECD6),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _PanelStatRow extends StatelessWidget {
  final String left;
  final String right;

  const _PanelStatRow({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Expanded(child: Text(left)),
          Expanded(
            child: Align(alignment: Alignment.centerRight, child: Text(right)),
          ),
        ],
      ),
    );
  }
}

class _MoonBackground extends StatelessWidget {
  const _MoonBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0A1022),
                  Color(0xFF060A16),
                  Color(0xFF02040B),
                ],
              ),
            ),
            child: Image.asset(
              'assets/images/ranni_bg.png',
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.35),
              colorBlendMode: BlendMode.darken,
            ),
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackToWelcome;

  const _TopBar({required this.title, this.onBackToWelcome});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: _glassDecoration(radius: 14),
            child: const Icon(
              Icons.nightlight_round,
              size: 18,
              color: Color(0xFFEEF3FF),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.4,
              ),
            ),
          ),
          if (onBackToWelcome != null)
            TextButton.icon(
              onPressed: onBackToWelcome,
              icon: const Icon(Icons.home_outlined, size: 18),
              label: const Text('回歡迎頁'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white.withValues(alpha: 0.9),
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white.withValues(alpha: 0.1),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFFEDF3FF)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;

  const _Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white.withValues(alpha: 0.09),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.92),
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AppCard extends StatelessWidget {
  final Widget child;

  const _AppCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: _glassDecoration(),
            child: child,
          ),
        ),
      ),
    );
  }
}

BoxDecoration _glassDecoration({double radius = 26}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: Colors.white.withValues(alpha: 0.04),
    border: Border.all(color: Colors.white.withValues(alpha: 0.09)),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF95ADFF).withValues(alpha: 0.08),
        blurRadius: 24,
        offset: const Offset(0, 16),
      ),
    ],
  );
}
