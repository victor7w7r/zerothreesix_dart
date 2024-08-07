// ignore_for_file: discarded_futures

import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:zerothreesix_dart/zerothreesix_dart.dart';

final class MockInputOutput extends Mock implements InputOutput {}

void main() {
  group('Storage', () {
    late MockInputOutput mockInputOutput;
    late Storage storage;

    setUpAll(() => registerFallbackValue(''));

    setUp(() {
      mockInputOutput = MockInputOutput();
      storage = Storage(mockInputOutput);
    });

    test('absoluteDev', () async {
      when(() => mockInputOutput.sys(any())).thenAnswer(
        (final _) async => 'test',
      );
      expect(await storage.absoluteDev('test'), 'test');
    });

    test('allDevs', () async {
      when(() => mockInputOutput.syssplit(any())).thenAnswer(
        (final _) async => ['test'],
      );
      expect(await storage.allDevs(), ['test']);
    });

    test('checkPartFs', () async {
      when(() => mockInputOutput.sys(any())).thenAnswer(
        (final _) async => 'test',
      );
      expect(await storage.checkPartFs('test'), 'test');
    });

    test('checkUsbDevices', () async {
      when(() => mockInputOutput.sys(any())).thenAnswer(
        (final _) async => '',
      );
      expect(await storage.checkUsbDevices(), true);
    });

    test('dirtyDev', () async {
      when(() => mockInputOutput.syswline(any())).thenAnswer(
        (final _) async => 'test',
      );
      expect(await storage.dirtyDev('test'), 'test');
    });

    test('getAllBlockDev', () async {
      when(() => mockInputOutput.syswline(any())).thenAnswer(
        (final _) async => 'test',
      );
      expect(await storage.getAllBlockDev('test'), 'test');
    });

    test('getBlockDev', () async {
      when(() => mockInputOutput.syswline(any())).thenAnswer(
        (final _) async => 'test',
      );
      expect(await storage.getBlockDev('test'), 'test');
    });

    test('getRootDev', () async {
      when(() => mockInputOutput.sys(any())).thenAnswer(
        (final _) async => 'test',
      );
      expect(await storage.getRootDev(), 'test');
    });

    test('mountUsbCheck', () async {
      when(() => mockInputOutput.sys(any())).thenAnswer(
        (final _) async => 'test',
      );
      expect(await storage.mountUsbCheck('test'), 'test');
    });

    test('usbDevices', () async {
      when(() => mockInputOutput.syssplit(any())).thenAnswer(
        (final _) async => ['test'],
      );
      expect(await storage.usbDevices(), ['test']);
    });
  });
}
