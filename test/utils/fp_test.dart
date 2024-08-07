import 'package:test/test.dart';

import 'package:zerothreesix_dart/utils/fp.dart';

void main() {
  group('conditionals', () {
    test('should call onlyIf and returns value when condition is true', () {
      final result = onlyIf(true, () => 42);
      expect(result, 42);
    });

    test('should call onlyIf and returns null when condition is false', () {
      final result = onlyIf(false, () => 42);
      expect(result, isNull);
    });

    test('should call onlyIfAsync and returns value when condition is true',
        () async {
      final result = await onlyIfAsync(true, () async => 42);
      expect(result, 42);
    });

    test('should call onlyIfAsync and returns null when condition is false',
        () async {
      final result = await onlyIfAsync(false, () async => 42);
      expect(result, isNull);
    });

    test('should call ifElse and returns ifTrue value when condition is true',
        () {
      final result = ifElse(true, () => 'true', () => 'false');
      expect(result, 'true');
    });

    test('should call ifElse returns ifFalse value when condition is false',
        () {
      final result = ifElse(false, () => 'true', () => 'false');
      expect(result, 'false');
    });

    test(
        'should call ifElseAsync and returns '
        'ifTrue value when condition is true', () async {
      final result =
          await ifElseAsync(true, () async => 'true', () async => 'false');
      expect(result, 'true');
    });

    test(
        'should call ifElseAsync returns ifFalse value when condition is false',
        () async {
      final result =
          await ifElseAsync(false, () async => 'true', () async => 'false');
      expect(result, 'false');
    });

    test('executes and returns  run the block value', () {
      final result = run(() => 'executed');
      expect(result, 'executed');
    });
  });

  group('chain', () {
    test('chain executes callbacks in order', () {
      final log = <String>[];

      void ch1() => log.add('ch1');
      void ch2() => log.add('ch2');

      chain(ch1, ch2);

      expect(log, ['ch1', 'ch2']);
    });

    test('chain3 executes callbacks in order', () {
      final log = <String>[];

      void ch1() => log.add('ch1');
      void ch2() => log.add('ch2');
      void ch3() => log.add('ch3');

      chain3(ch1, ch2, ch3);

      expect(log, ['ch1', 'ch2', 'ch3']);
    });

    test('chain4 executes callbacks in order', () {
      final log = <String>[];

      void ch1() => log.add('ch1');
      void ch2() => log.add('ch2');
      void ch3() => log.add('ch3');
      void ch4() => log.add('ch4');

      chain4(ch1, ch2, ch3, ch4);

      expect(log, ['ch1', 'ch2', 'ch3', 'ch4']);
    });

    test('chain5 executes callbacks in order', () {
      final log = <String>[];

      void ch1() => log.add('ch1');
      void ch2() => log.add('ch2');
      void ch3() => log.add('ch3');
      void ch4() => log.add('ch4');
      void ch5() => log.add('ch5');

      chain5(ch1, ch2, ch3, ch4, ch5);

      expect(log, ['ch1', 'ch2', 'ch3', 'ch4', 'ch5']);
    });

    test('chain6 executes callbacks in order', () {
      final log = <String>[];

      void ch1() => log.add('ch1');
      void ch2() => log.add('ch2');
      void ch3() => log.add('ch3');
      void ch4() => log.add('ch4');
      void ch5() => log.add('ch5');
      void ch6() => log.add('ch6');

      chain6(ch1, ch2, ch3, ch4, ch5, ch6);

      expect(log, ['ch1', 'ch2', 'ch3', 'ch4', 'ch5', 'ch6']);
    });

    test('chain7 executes callbacks in order', () {
      final log = <String>[];

      void ch1() => log.add('ch1');
      void ch2() => log.add('ch2');
      void ch3() => log.add('ch3');
      void ch4() => log.add('ch4');
      void ch5() => log.add('ch5');
      void ch6() => log.add('ch6');
      void ch7() => log.add('ch7');

      chain7(ch1, ch2, ch3, ch4, ch5, ch6, ch7);

      expect(log, ['ch1', 'ch2', 'ch3', 'ch4', 'ch5', 'ch6', 'ch7']);
    });

    test('chainAsync executes callbacks in order', () async {
      final log = <String>[];

      Future<void> ch1() async => log.add('ch1');
      Future<void> ch2() async => log.add('ch2');

      await chainAsync(ch1, ch2);

      expect(log, ['ch1', 'ch2']);
    });

    test('chain3Async executes callbacks in order', () async {
      final log = <String>[];

      Future<void> ch1() async => log.add('ch1');
      Future<void> ch2() async => log.add('ch2');
      Future<void> ch3() async => log.add('ch3');

      await chain3Async(ch1, ch2, ch3);

      expect(log, ['ch1', 'ch2', 'ch3']);
    });

    test('chain4Async executes callbacks in order', () async {
      final log = <String>[];

      Future<void> ch1() async => log.add('ch1');
      Future<void> ch2() async => log.add('ch2');
      Future<void> ch3() async => log.add('ch3');
      Future<void> ch4() async => log.add('ch4');

      await chain4Async(ch1, ch2, ch3, ch4);

      expect(log, ['ch1', 'ch2', 'ch3', 'ch4']);
    });

    test('chain5Async executes callbacks in order', () async {
      final log = <String>[];

      Future<void> ch1() async => log.add('ch1');
      Future<void> ch2() async => log.add('ch2');
      Future<void> ch3() async => log.add('ch3');
      Future<void> ch4() async => log.add('ch4');
      Future<void> ch5() async => log.add('ch5');

      await chain5Async(ch1, ch2, ch3, ch4, ch5);

      expect(log, ['ch1', 'ch2', 'ch3', 'ch4', 'ch5']);
    });

    test('chain6Async executes callbacks in order', () async {
      final log = <String>[];

      Future<void> ch1() async => log.add('ch1');
      Future<void> ch2() async => log.add('ch2');
      Future<void> ch3() async => log.add('ch3');
      Future<void> ch4() async => log.add('ch4');
      Future<void> ch5() async => log.add('ch5');
      Future<void> ch6() async => log.add('ch6');

      await chain6Async(ch1, ch2, ch3, ch4, ch5, ch6);

      expect(log, ['ch1', 'ch2', 'ch3', 'ch4', 'ch5', 'ch6']);
    });
  });
  group('pipe', () {
    test(
      'should call pipeFunc pipes functions correctly',
      () => expect(pipeFunc(() => 2, (final x) => x * 3), 6),
    );

    test(
      'should call pipe2Func with two functions correctly',
      () => expect(
        pipe2Func(() => 2, (final x) => x * 3, (final y) => y.toString()),
        '6',
      ),
    );

    test(
      'should call pipe3Func with three functions correctly',
      () => expect(
        pipe3Func(
          () => 2,
          (final x) => x * 3,
          (final y) => y.toString(),
          (final z) => 'Result: $z',
        ),
        'Result: 6',
      ),
    );

    test(
        'should call pipe2 and creates a new '
        'function that pipes two functions', () {
      final pipe = pipe2(double.parse, (final d) => d.floor());
      expect(pipe('123.456'), 123);
    });
  });

  test('extends a function to pipe with another function', () {
    final pipe = double.parse.pipe((final v) => v.floor());
    expect(pipe('123.456'), 123);
  });
}
