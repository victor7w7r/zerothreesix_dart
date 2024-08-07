// ignore_for_file: avoid_function_literals_in_foreach_calls, lines_longer_than_80_chars
import 'dart:io' show exit;

import 'package:cli_menu/cli_menu.dart' show Menu;
import 'package:console/console.dart' show Console;
import 'package:fpdart/fpdart.dart' show IO;

import 'package:zerothreesix_dart/console/console.dart';
import 'package:zerothreesix_dart/utils/utils.dart';

enum PrintQuery { normal, inline, warn, error }

class LangWrapper {
  // coverage:ignore-start
  String chooser(
    final List<String> options,
  ) =>
      Menu(options).choose().let((final op) => op.value);
  void errorExit() => exit(1);
  void successExit() => exit(0);
  // coverage:ignore-end
  void write(final String content) => Console.write(content);
}

class Lang {
  Lang(this._colorize, this._langWrapper, this._io)
      : dictDialogEng = [],
        dictDialogEsp = [],
        dictEng = [],
        dictEsp = [],
        isEnglish = false;

  final Colorize _colorize;
  final InputOutput _io;
  final LangWrapper _langWrapper;

  final List<String> dictDialogEng;
  final List<String> dictDialogEsp;
  final List<String> dictEng;
  final List<String> dictEsp;
  bool isEnglish;

  String _replaceCustom(
    final String sel,
    final String? custom,
  ) =>
      custom != null ? sel.replaceAll('*', custom) : sel;

  void assignLang() {
    _colorize
      ..green('Bienvenido / Welcome \n')
      ..cyan(
        'Please, choose your language / Por favor selecciona tu idioma \n',
      );

    _langWrapper.chooser(['English', 'Espanol']).let(
      (final op) => isEnglish = op == 'English',
    );
  }

  String dialogLang(
    final int index, [
    final String? ins,
  ]) =>
      IO(() => isEnglish ? dictDialogEng[index] : dictDialogEsp[index])
          .map((final sel) => ins != null ? sel.replaceAll('*', ins) : sel)
          .run();

  void error(final int index) {
    _io.clear();
    write(index, PrintQuery.error);
    print('\n');
    _langWrapper.errorExit();
  }

  bool isYesNo(final String message) {
    print(_langWrapper);

    return _langWrapper
        .chooser(isEnglish ? ['Yes', 'No'] : ['Si', 'No'])
        .let((final sel) => sel == 'Yes' || sel == 'Si');
  }

  void ok(final int index) {
    _io.clear();
    write(index, PrintQuery.normal);
    _langWrapper.successExit();
  }

  void okLine() {
    print('\n =============== OK =============== \n');
    //write(5, PrintQuery.normal);
    _langWrapper.successExit();
  }

  String write(
    final int index, [
    final PrintQuery? typeQuery,
    final String? custom,
  ]) =>
      IO(() => isEnglish ? dictEng[index] : dictEsp[index])
          .map(
            (final sel) => typeQuery != null
                ? IO(
                    () => switch (typeQuery) {
                      PrintQuery.normal => print(_replaceCustom(sel, custom)),
                      PrintQuery.inline =>
                        _langWrapper.write(_replaceCustom(sel, custom)),
                      PrintQuery.warn => _colorize.cyanMix(
                          '[*] ',
                          'WARNING: ${_replaceCustom(sel, custom)}',
                        ),
                      PrintQuery.error => _colorize.redMix(
                          '[*] ',
                          'ERROR: ${_replaceCustom(sel, custom)}',
                        )
                    },
                  ).map((final _) => '').run()
                : _replaceCustom(sel, custom),
          )
          .run();
}
