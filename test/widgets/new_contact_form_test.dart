import 'package:flutter/material.dart';
import 'package:flutter_contacts/widgets/new_contact_form.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('NewContactForm', (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: NewContactForm())));

    expect(find.byType(NewContactForm),
        matchesGoldenFile('goldens/new_contact_form.png'));
  });
}
