import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_about_page/main.dart';

void main() {
  testWidgets('Welcome to navigation flow works', (WidgetTester tester) async {
    await tester.pumpWidget(const RanniAboutApp());

    expect(find.text('點擊畫面進入拉妮介紹'), findsOneWidget);
    expect(find.byKey(const Key('ranni-gif-start')), findsOneWidget);

    await tester.tap(find.byKey(const Key('ranni-gif-start')));
    await tester.pumpAndSettle();

    expect(find.text('拉妮介紹'), findsWidgets);
    expect(find.text('菈妮 Ranni'), findsOneWidget);
    expect(find.text('回歡迎頁'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.route_outlined));
    await tester.pumpAndSettle();
    expect(find.text('菈妮任務線詳細流程'), findsOneWidget);

    await tester.tap(find.byIcon(FontAwesomeIcons.khanda));
    await tester.pumpAndSettle();
    expect(find.text('暗月大劍（Dark Moon Greatsword）'), findsOneWidget);
  });
}
