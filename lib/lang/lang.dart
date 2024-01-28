// ignore_for_file: avoid_function_literals_in_foreach_calls, lines_longer_than_80_chars
import 'dart:io' show exit;

import 'package:console/console.dart' show Console;
import 'package:fpdart/fpdart.dart' show IO;

import 'package:zerothreesix_dart/system/system.dart';

enum PrintQuery { normal, inline, warn, error }

bool english = false;

final _dictEsp = <String>[];
final _dictEng = <String>[];

final _dictDialogEsp = <String>[];
final _dictDialogEng = <String>[];

String _replaceCustom(final String sel, final String? custom) =>
    custom != null ? sel.replaceAll('*', custom) : sel;

void setDictDialogEsp(final List<String> incEsp) =>
    _dictDialogEsp.addAll(incEsp);

void setDictDialogEng(final List<String> incEng) =>
    _dictDialogEng.addAll(incEng);

void setDictEsp(
  final List<String> incEsp,
) =>
    _dictEsp.addAll(incEsp);

void setDictEng(
  final List<String> incEng,
) =>
    _dictEng.addAll(incEng);

String dialogLang(
  final int index, [
  final String? ins,
]) =>
    IO(() => english ? _dictDialogEng[index] : _dictDialogEsp[index])
        .map((final sel) => ins != null ? sel.replaceAll('*', ins) : sel)
        .run();

String lang(
  final int index, [
  final PrintQuery? typeQuery,
  final String? custom,
]) =>
    IO(() => english ? _dictEng[index] : _dictEsp[index])
        .map(
          (final sel) => typeQuery != null
              ? IO(
                  () => switch (typeQuery) {
                    PrintQuery.normal => print(_replaceCustom(sel, custom)),
                    PrintQuery.inline =>
                      Console.write(_replaceCustom(sel, custom)),
                    PrintQuery.warn => cyanMix(
                        '[*] ',
                        'WARNING: ${_replaceCustom(sel, custom)}',
                      ),
                    PrintQuery.error => redMix(
                        '[*] ',
                        'ERROR: ${_replaceCustom(sel, custom)}',
                      )
                  },
                ).map((final _) => '').run()
              : _replaceCustom(sel, custom),
        )
        .run();

void error(final int index) {
  clear();
  lang(index, PrintQuery.error);
  print('\n');
  exit(1);
}

void ok(final int index) {
  clear();
  lang(index, PrintQuery.normal);
  exit(0);
}

void okLine() {
  print('\n =============== OK =============== \n');
  lang(5, PrintQuery.normal);
  exit(0);
}
