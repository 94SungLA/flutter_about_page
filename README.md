# 菈妮主題 About 頁面（Flutter）

以《艾爾登法環》菈妮（Ranni）為主題，製作一個具備歡迎頁、角色介紹、任務流程與暗月大劍資訊的 About 型 App。

## 簡介

這個作品的目標是把遊戲角色介紹頁做成「可閱讀、可捲動、可導覽」的 App。

目前內容包含：
- 滿版 GIF 歡迎畫面（點擊淡出後進入主頁）
- 拉妮角色介紹與語錄
- 菈妮任務線詳細流程（多步驟 + 圖片預留）
- 暗月大劍資訊頁（遊戲面板風格）

## 成果展示

- 主要頁面：歡迎頁、拉妮介紹、任務介紹、暗月大劍
- 導覽方式：底部 `NavigationBar`
- 畫面滾動：`CustomScrollView` + `SingleChildScrollView`

## 作業要求對照

所有要求皆有完成，以下每個 widget 都附上實際程式碼證明。

### 1. 一定要使用的 widget

- `Text`
```dart
const Text('暗月大劍', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700));
```

- `Image`
```dart
Image.asset('assets/images/rannigif.gif', fit: BoxFit.cover);
```

- `Icon`
```dart
const Icon(Icons.nightlight_round, size: 18, color: Color(0xFFEEF3FF));
```

- `Column`
```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [const SizedBox(height: 12), _AppCard(child: ...)],
);
```

- `Row`
```dart
Row(
  children: [
    Expanded(child: Text(title)),
    TextButton.icon(onPressed: onBackToWelcome, icon: const Icon(Icons.home_outlined), label: const Text('回歡迎頁')),
  ],
);
```

- `Color`
```dart
scaffoldBackgroundColor: const Color(0xFF060A16),
```

- `Stack`
```dart
Stack(
  fit: StackFit.expand,
  children: [Image.asset('assets/images/rannigif.gif'), Positioned(bottom: 0, child: Container())],
);
```

- `SingleChildScrollView`
```dart
return SingleChildScrollView(
  key: const ValueKey('sword-page'),
  child: Column(children: [...]),
);
```

### 2. 定義多個 StatelessWidget 類別

本專案有多個 `StatelessWidget`，例如：
- `RanniAboutApp`
- `_IntroPage`
- `_QuestPage`
- `_DarkMoonSwordPage`
- `_QuestStepCard`
- `_InGameSwordPanel`
- `_SectionTitle`
- `_Tag`
- `_AppCard`

使用範例：

```dart
class _QuestStepCard extends StatelessWidget {
  final int index;
  final _QuestStepData data;

  const _QuestStepCard({required this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(...),
    );
  }
}
```

### 3. 畫面可以上下捲動，搭配 SingleChildScrollView

本專案同時使用 `CustomScrollView` 與 `SingleChildScrollView`。  
任務頁（`CustomScrollView`）示例：

```dart
return CustomScrollView(
  key: const ValueKey('quest-page'),
  physics: const BouncingScrollPhysics(),
  slivers: [
    const SliverToBoxAdapter(child: SizedBox(height: 12)),
    SliverToBoxAdapter(child: _TopBar(...)),
    SliverToBoxAdapter(child: _AppCard(...)),
  ],
);
```

暗月大劍頁（`SingleChildScrollView`）示例：

```dart
return SingleChildScrollView(
  key: const ValueKey('sword-page'),
  physics: const BouncingScrollPhysics(),
  child: Column(children: [...]),
);
```

## 其他有使用到的 widget（逐項證明）

- `Container`
```dart
Container(
  padding: const EdgeInsets.fromLTRB(20, 40, 20, 34),
  decoration: BoxDecoration(gradient: LinearGradient(colors: [...]))
);
```

- `Padding`
```dart
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child: Row(children: [...]),
);
```

- `SizedBox`
```dart
const SizedBox(height: 12);
```

- `Expanded`
```dart
Expanded(child: Text(title));
```

- `Positioned`
```dart
Positioned(
  left: 0,
  right: 0,
  bottom: 0,
  child: Container(...),
);
```

- `SafeArea`
```dart
SafeArea(
  child: AnimatedSwitcher(duration: const Duration(milliseconds: 250), child: _buildPage()),
);
```

- `Transform`
```dart
Transform.scale(
  scale: 1,
  child: Image.asset('assets/images/rannigif.gif', fit: BoxFit.cover),
);
```

- `Divider`
```dart
Divider(color: Colors.white.withValues(alpha: 0.14), height: 24);
```

- `ClipRRect`
```dart
ClipRRect(
  borderRadius: BorderRadius.circular(14),
  child: Image.asset('assets/images/ranniprofile.webp', fit: BoxFit.cover),
);
```

- `Align`
```dart
Align(
  alignment: Alignment.centerRight,
  child: Text(right),
);
```

- `Wrap`
```dart
Wrap(
  spacing: 8,
  runSpacing: 8,
  children: const [_Tag(text: '神祕'), _Tag(text: '孤高')],
);
```

## 專案執行方式

```bash
flutter pub get
flutter run
```

測試與檢查：

```bash
flutter test
flutter analyze
```