import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subiquity_client/subiquity_client.dart';
import 'package:ubuntu_desktop_installer/pages/allocate_disk_space/storage_selector.dart';

void main() {
  testWidgets('initial selection', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: StorageSelector(
            title: '',
            storages: [
              for (var i = 0; i < 3; i++)
                Disk(model: 'model$i', vendor: 'vendor$i'),
            ],
            selected: 1,
            onSelected: (_) {},
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();

    final dropdown =
        tester.widget<DropdownButton<int>>(find.byType(DropdownButton<int>));
    expect(dropdown.value, equals(1));
  });

  testWidgets('selection', (tester) async {
    int? selected;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: StorageSelector(
            title: '',
            storages: [
              for (var i = 0; i < 3; i++)
                Disk(model: 'model$i', vendor: 'vendor$i'),
            ],
            onSelected: (v) => selected = v,
          ),
        ),
      ),
    ));

    await tester.tap(find.byType(DropdownButton<int>));
    await tester.pumpAndSettle();

    final dropdownItem = find.descendant(
      of: find.byType(DropdownMenuItem<int>),
      matching: find.byKey(ValueKey(1)),
    );
    await tester.ensureVisible(dropdownItem.last);
    await tester.tap(dropdownItem.last);

    expect(selected, equals(1));
  });
}
