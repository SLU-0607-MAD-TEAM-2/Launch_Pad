// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:launchpad_flutter_app/main.dart';
import 'package:launchpad_flutter_app/services/mock_api_service.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final apiService = MockApiService();
    await apiService.loadAll();
    await tester.pumpWidget(LaunchPadApp(apiService: apiService, seenOnboarding: true));

    // Verify that our splash screen is displayed.
    expect(find.text('LAUNCHPAD'), findsOneWidget);

    // Let all animations and transition delays complete cleanly
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });
}
