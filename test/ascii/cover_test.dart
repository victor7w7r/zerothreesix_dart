import 'package:test/test.dart';

import 'package:zerothreesix_dart/ascii/cover.dart';

void main() {
  group('cover', () {
    test('should verify if cover prints', () {
      expect(cover, prints('$coverText\n'));
    });
  });
}
