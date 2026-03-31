# Flutter About Page - 需求符合檢查

本專案已符合你列出的 UI 與結構需求，以下是對照清單。

## 一定要使用的 Widget

- `Text`：有使用
- `Image`：有使用（`Image.asset`）
- `Icon`：有使用（含 `Icon` 與 `FaIcon`）
- `Column`：有使用
- `Row`：有使用
- `Color`：有使用（`Color(0xFF...)`）
- `Stack`：有使用
- `SingleChildScrollView`：有使用（暗月大劍頁）

## 其它可考慮的 Widget（已使用）

- `Container`
- `Padding`
- `SizedBox`
- `Expanded`
- `Positioned`
- `SafeArea`
- `Transform`
- `Divider`
- `ClipRRect`
- `Align`
- `Wrap`

## 多個 StatelessWidget 類別

已定義多個 `StatelessWidget`，例如：
- `RanniAboutApp`
- `_IntroPage`
- `_QuestPage`
- `_DarkMoonSwordPage`
- `_InGameSwordPanel`
- `_SectionTitle`
- `_Tag`
- `_AppCard`

## 程式碼片段（節錄）

### 1) `SingleChildScrollView` + `Column`（可上下捲動）

```dart
return SingleChildScrollView(
  key: const ValueKey('sword-page'),
  physics: const BouncingScrollPhysics(),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 12),
      _TopBar(title: '暗月大劍(老婆大劍)', onBackToWelcome: onBackToWelcome),
      const SizedBox(height: 12),
      _AppCard(child: ...),
    ],
  ),
);
```

### 2) `Stack` + `Image` + `Positioned`（歡迎頁滿版 GIF）

```dart
child: Stack(
  fit: StackFit.expand,
  children: [
    Image.asset('assets/images/rannigif.gif', fit: BoxFit.cover),
    Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(...),
    ),
  ],
),
```

### 3) `Row` + `Icon` + `Text`（標題列）

```dart
return Row(
  children: [
    Container(
      padding: const EdgeInsets.all(10),
      child: const Icon(Icons.nightlight_round, size: 18),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: Text(title, style: const TextStyle(fontSize: 20)),
    ),
  ],
);
```

---

如需我再補一版「對照表含檔案行號（line number）」我可以直接加上。
