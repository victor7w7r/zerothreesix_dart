import 'dart:io' show Stdout;

import 'package:console/console.dart' show Color;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:zerothreesix_dart/zerothreesix_dart.dart';

final class MockStdout extends Mock implements Stdout {}

void main() {
  // ignore: close_sinks
  late MockStdout mockStdout;
  late Colorize colorize;

  setUpAll(() => registerFallbackValue(''));

  setUp(() {
    mockStdout = MockStdout();
    colorize = Colorize(mockStdout);
  });

  test('colorize', () {
    colorize.colorize(Color.CYAN, 'cyan');
    verify(() => mockStdout.write(any()));
  });

  test('cyan', () {
    colorize.cyan('cyan');
    verify(() => mockStdout.write(any()));
  });

  test('cyanMix', () {
    colorize.cyanMix('cyan', 'mix');
    verify(() => mockStdout.write(any()));
  });

  test('green', () {
    colorize.green('green');
    verify(() => mockStdout.write(any()));
  });

  test('greenMix', () {
    colorize.greenMix('green', 'mix');
    verify(() => mockStdout.write(any()));
  });

  test('red', () {
    colorize.red('red');
    verify(() => mockStdout.write(any()));
  });

  test('redMix', () {
    colorize.redMix('red', 'mix');
    verify(() => mockStdout.write(any()));
  });
}
