import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:zerothreesix_dart/console/console.dart';
import 'package:zerothreesix_dart/lang/lang.dart';

final class MockColorize extends Mock implements Colorize {}

final class MockInputOutput extends Mock implements InputOutput {}

final class MockLangWrapper extends Mock implements LangWrapper {}

void main() {
  late MockColorize mockColorize;
  late LangWrapper langWrapper;
  late MockInputOutput mockInputOutput;
  late Lang lang;

  setUpAll(() {
    LangWrapper().write('Hello');
    registerFallbackValue(<String>[]);
  });

  setUp(() {
    mockColorize = MockColorize();
    langWrapper = MockLangWrapper();
    mockInputOutput = MockInputOutput();
    lang = Lang(mockColorize, langWrapper, mockInputOutput);
  });

  group('Lang', () {
    test('assignLang', () {
      when(() => langWrapper.chooser(['English', 'Espanol']))
          .thenReturn('English');
      lang.assignLang();
      verify(() => mockColorize.green('Bienvenido / Welcome \n')).called(1);
      verify(
        () => mockColorize.cyan(
          'Please, choose your language / Por favor selecciona tu idioma \n',
        ),
      ).called(1);
      expect(lang.isEnglish, true);
    });

    test('dialogLang', () {
      lang.isEnglish = true;
      lang.dictDialogEng.add('Hello');
      expect(lang.dialogLang(0), 'Hello');

      lang.isEnglish = false;
      lang.dictDialogEsp.add('Hola *');
      expect(lang.dialogLang(0, 'Mundo'), 'Hola Mundo');
    });

    test('error', () {
      when(langWrapper.errorExit).thenReturn(null);
      lang.isEnglish = true;
      lang.dictEng.add('Hello');
      lang.error(0);
      verify(langWrapper.errorExit).called(1);
    });

    test('isYesNo', () {
      when(() => langWrapper.chooser(any())).thenReturn('Yes');
      expect(lang.isYesNo('test'), true);

      when(() => langWrapper.chooser(any())).thenReturn('No');
      expect(lang.isYesNo('test'), false);

      lang.isEnglish = false;

      when(() => langWrapper.chooser(any())).thenReturn('Si');
      expect(lang.isYesNo('test'), true);

      when(() => langWrapper.chooser(any())).thenReturn('No');
      expect(lang.isYesNo('test'), false);
    });

    test('ok', () {
      when(langWrapper.successExit).thenReturn(null);
      lang.isEnglish = true;
      lang.dictEng.add('Hello');
      lang.ok(0);
      verify(langWrapper.successExit).called(1);
    });

    test('okLine', () {
      when(langWrapper.successExit).thenReturn(null);
      lang.okLine();
      verify(langWrapper.successExit).called(1);
    });

    test('call write when is English and typeQuery is null', () {
      lang.isEnglish = true;
      lang.dictEng.add('Hello');
      expect(lang.write(0), 'Hello');
    });

    test('call write when is not English and typeQuery is null', () {
      lang.isEnglish = false;
      lang.dictEsp.add('Hello');
      expect(lang.write(0, null, '-'), 'Hello');
    });

    test('call write when is English with all typeQuery cases', () {
      lang.isEnglish = true;
      lang.dictEng.add('Hello');
      expect(lang.write(0, PrintQuery.error), '');
      expect(lang.write(0, PrintQuery.inline), '');
      expect(lang.write(0, PrintQuery.warn), '');
      expect(lang.write(0, PrintQuery.normal), '');
    });
  });
}
