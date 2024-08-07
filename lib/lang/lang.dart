// ignore_for_file: avoid_function_literals_in_foreach_calls, lines_longer_than_80_chars
import 'dart:io' show exit;

import 'package:cli_menu/cli_menu.dart' show Menu;
import 'package:console/console.dart' show Console;
import 'package:fpdart/fpdart.dart' show IO;

import 'package:zerothreesix_dart/system/system.dart';

enum PrintQuery { normal, inline, warn, error }

class ConsoleWrapper {
  void write(final String content) => Console.write(content);
}

class Lang {
  Lang(this._colorize, this._console, this._io)
      : dictDialogEng = [],
        dictDialogEsp = [],
        dictEng = [],
        dictEsp = [],
        isEnglish = false;

  final Colorize _colorize;
  final ConsoleWrapper _console;
  final InputOutput _io;

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

    Menu(['English', 'Espanol'])
        .choose()
        .let((final op) => isEnglish = op.value == 'English');
  }

  IO<String> chooser(
    final String message,
    final List<String> options,
  ) =>
      IO(
        Menu(options).choose,
      ).map((final op) => op.value);

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
    exit(1);
  }

  bool isYesNo(
    final String message,
  ) =>
      chooser(
        message,
        isEnglish ? ['Yes', 'No'] : ['Si', 'No'],
      ).map((final sel) => sel == 'Yes' || sel == 'Si').run();

  void ok(final int index) {
    _io.clear();
    write(index, PrintQuery.normal);
    exit(0);
  }

  void okLine() {
    print('\n =============== OK =============== \n');
    write(5, PrintQuery.normal);
    exit(0);
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
                        _console.write(_replaceCustom(sel, custom)),
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
