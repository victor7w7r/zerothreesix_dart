// ignore_for_file: discarded_futures

import 'dart:io' show Process, ProcessResult;

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

final class MockInputOutputWrapper extends Mock implements InputOutputWrapper {}

void main() {
  group('Io', () {
    late MockInputOutputWrapper mockInputOutputWrapper;
    late InputOutput inputOutput;

    setUpAll(
      () => InputOutputWrapper()
        ..clear()
        ..run('echo test')
        ..runInherit('echo test')
        ..syncCall('echo test'),
    );

    setUp(() {
      mockInputOutputWrapper = MockInputOutputWrapper();
      inputOutput = InputOutput(mockInputOutputWrapper);
    });

    test('call', () async {
      when(() => mockInputOutputWrapper.run('echo test'))
          .thenAnswer((final _) async => ProcessResult(0, 0, 'test', ''));

      expect(await inputOutput('echo test'), 0);
    });

    test('checkUid', () async {
      when(() => mockInputOutputWrapper.run(r'echo $EUID'))
          .thenAnswer((final _) async => ProcessResult(0, 0, '0', ''));

      expect(await inputOutput.checkUid(), true);
    });

    test('clear', () {
      inputOutput.clear();
      verify(mockInputOutputWrapper.clear).called(1);
    });

    test('codeout', () async {
      when(() => mockInputOutputWrapper.run('echo test'))
          .thenAnswer((final _) async => ProcessResult(0, 0, 'test', ''));

      expect(await inputOutput.codeout('echo test'), ['0', 'test']);
    });

    test('coderes', () async {
      final process = await Process.start('dart', ['pub', 'get']);
      when(() => mockInputOutputWrapper.runInherit('echo test'))
          .thenAnswer((final _) async => process);
      final result = await inputOutput.coderes('echo test');
      expect(result, 0);
    });

    test('success', () async {
      when(() => mockInputOutputWrapper.run('type echo'))
          .thenAnswer((final _) async => ProcessResult(0, 0, '', ''));

      expect(await inputOutput.success('echo'), true);
    });

    test('syncCall', () {
      when(() => mockInputOutputWrapper.syncCall('echo test'))
          .thenReturn(ProcessResult(0, 0, 'test', ''));

      final result = inputOutput.syncCall('echo test');

      expect(result.exitCode, 0);
      expect(result.stdout, 'test');
    });

    test('sys', () async {
      when(() => mockInputOutputWrapper.run('echo test'))
          .thenAnswer((final _) async => ProcessResult(0, 0, 'test', ''));

      expect(await inputOutput.sys('echo test'), 'test');
    });

    test('syssplit', () async {
      when(() => mockInputOutputWrapper.run('echo test'))
          .thenAnswer((final _) async => ProcessResult(0, 0, 'test\n', ''));

      expect(await inputOutput.syssplit('echo test'), ['test', '']);
    });

    test('syswline', () async {
      when(() => mockInputOutputWrapper.run('echo test'))
          .thenAnswer((final _) async => ProcessResult(0, 0, 'test\n', ''));

      expect(await inputOutput.syswline('echo test'), 'test');
    });
  });
}
