import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cli_menu/cli_menu.dart' show Menu;
import 'package:zerothreesix_dart/system/chooser.dart';

class MockMenu extends Mock implements Menu<String> {}

void main() {
  group('chooser', () {
    test('returns the chosen option', () {
      final mockMenu = MockMenu();
      when(() => mockMenu.choose).thenReturn('Option 1');
      final result =
          chooser('Choose an option', ['Option 1', 'Option 2']).run();
      verify(() => mockMenu.choose).called(1);
      expect(result, equals('Option 1'));
    });
  });

  group('yesNo', () {
    test('returns true for "Yes" and "Si"', () {
      final result = yesNo('Continue?');
      expect(result, isTrue);
    });
  });
}
