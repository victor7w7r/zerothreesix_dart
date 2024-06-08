import 'dart:io' show Stdout;

import 'package:console/console.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:zerothreesix_dart/system/colorize.dart';

class MockStdout extends Mock implements Stdout {}

void main() {
  group('colorize', () {
    // ignore: close_sinks
    late MockStdout mockStdout;

    setUp(() => mockStdout = MockStdout());

    test('testColorize', () {
      colorize(
        Color.BLACK,
        'test',
        stdTest: mockStdout,
      );

      verify(
        () => mockStdout.write(any<String>()),
      ).called(1);
    });
  });
}
