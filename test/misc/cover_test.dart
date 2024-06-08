import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zerothreesix_dart/misc/cover.dart';

void main() {
  group('cover', () {
    test('should verify if cover prints', () {
      expect(cover, prints('~>v??*^;rikD&MNBQku*;'));
    });
  });
}
