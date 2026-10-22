import 'package:flutter_test/flutter_test.dart';
import 'package:campus_event_explorer/main.dart';
import 'package:campus_event_explorer/data/event_data.dart';

void main() {
  test('Demo data follows capacity, ID and date rules', () {
    final events = createDemoEvents();
    expect(events.length, greaterThanOrEqualTo(6));
    expect(events.map((e) => e.id).toSet().length, events.length);
    expect(events.map((e) => e.category).toSet().length,
        greaterThanOrEqualTo(3));
    expect(events.any((e) => e.availablePlaces == 0), isTrue);
    expect(events.any((e) => e.availablePlaces == 1), isTrue);

    for (final event in events) {
      expect(event.availablePlaces, greaterThanOrEqualTo(0));
      expect(event.availablePlaces, lessThanOrEqualTo(event.capacity));
      expect(event.dateTime.isAfter(DateTime(2026, 10, 25, 23, 59)), isTrue);
    }
  });

  testWidgets('Explore screen loads', (tester) async {
    await tester.pumpWidget(const CampusEventExplorerApp());
    expect(find.text('Campus Event Explorer'), findsOneWidget);
    expect(find.text('8 matching events'), findsOneWidget);
  });
}
