import 'package:test/test.dart';

import 'package:zerothreesix_dart/system/scope_functions.dart';

void main() {
  group('scopeFunctions', () {
    test('also should execute block and return the object', () {
      final result = 5.also((final it) {
        expect(it, equals(5));
      });
      expect(result, equals(5));
    });

    test(
        'alsoAsync should execute block asynchronously '
        'and return the object', () async {
      final result = await Future.value(5).alsoAsync((final _) async => 5);
      expect(await result, equals(5));
    });

    test('let should execute block and return the result', () {
      final result = 5.let((final it) => it * 2);
      expect(result, equals(10));
    });

    test('letAsync should execute block asynchronously and return the result',
        () async {
      final result =
          await Future.value(5).letAsync((final it) async => (await it) * 2);
      expect(result, equals(10));
    });

    test('takeIf should return object if condition is true', () {
      final result = 5.takeIf((final it) => it > 0);
      expect(result, equals(5));
    });

    test('takeIf should return null if condition is false', () {
      final result = 5.takeIf((final it) => it < 0);
      expect(result, isNull);
    });

    test('takeUnless should return object if condition is false', () {
      final result = 5.takeUnless((final it) => it < 0);
      expect(result, equals(5));
    });

    test('takeUnless should return null if condition is true', () {
      final result = 5.takeUnless((final it) => it > 0);
      expect(result, isNull);
    });

    test(
        'also should execute block asynchronously on '
        'awaited Future and return the value', () async {
      final result = await Future.value(5).also((final it) async {
        expect(it, equals(5));
      });
      expect(result, equals(5));
    });

    test(
        'let should execute block asynchronously on awaited '
        'Future and return the result', () async {
      final result = await Future.value(5).let((final it) async => it * 2);
      expect(result, equals(10));
    });

    test('letWithElse should execute block if not null, otherwise return else',
        () {
      final result = 5.letWithElse((final it) => it * 2, orElse: 0);
      expect(result, equals(10));
    });

    test(
        'letWithElseCall should execute block if not null, '
        'otherwise call orElse function', () {
      final result = 5.letWithElseCall((final it) => it * 2, () => 0);
      expect(result, equals(10));
    });

    test(
        'withDefault should return value if not null, '
        'otherwise return default value', () {
      int? value;
      final result = value.withDefault(10);
      expect(result, equals(10));
    });
  });
}
