// ignore_for_file: discarded_futures

import 'dart:io' show Process, Stdout;

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

final class MockTuiWrapper extends Mock implements TuiWrapper {}

final class MockStdout extends Mock implements Stdout {}

final class MockProcess extends Mock implements Process {}

void main() {
  group('Storage', () {
    late MockTuiWrapper mockTuiWrapper;
    late MockStdout mockStdout;
    late MockProcess mockProcess;
    late Tui tui;

    setUpAll(() {
      TuiWrapper()
        ..tuiStdout
        ..showDialog('title', 'body', '0', '0');
      registerFallbackValue('');
    });

    setUp(() {
      mockTuiWrapper = MockTuiWrapper();
      mockStdout = MockStdout();
      mockProcess = MockProcess();
      tui = Tui(mockTuiWrapper);
    });

    test('call dialog successfully', () async {
      final proc = await Process.start('echo', ['"test"']);
      when(() => mockTuiWrapper.showDialog(any(), any(), any(), any()))
          .thenAnswer((final _) async => proc);

      final result = await tui.dialog('title', 'body', '0', '0');

      expect(result, 127);
    });

    test('call dialog unsuccessfully', () async {
      when(() => mockProcess.stdout)
          .thenAnswer((final _) => const Stream.empty());
      when(() => mockProcess.stdin).thenThrow(Exception());
      when(() => mockProcess.exitCode).thenAnswer((final _) async => 1);

      when(() => mockTuiWrapper.showDialog(any(), any(), any(), any()))
          .thenAnswer((final _) async => mockProcess);

      final result = await tui.dialog('title', 'body', '0', '0');

      expect(result, 127);
    });

    test('spin', () async {
      when(() => mockTuiWrapper.tuiStdout).thenReturn(mockStdout);
      when(() => mockStdout.write(any())).thenReturn(null);

      final timer = tui.spin();
      await Future<void>.delayed(const Duration(milliseconds: 500));
      timer.cancel();

      verify(() => mockStdout.write(any())).called(5);
    });
  });
}
