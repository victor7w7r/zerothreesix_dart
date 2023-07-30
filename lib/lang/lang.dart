import 'dart:io' show exit;

import 'package:console/console.dart' show Console;
import 'package:dcli/dcli.dart' show cyan, red;
import 'package:fpdart/fpdart.dart' show IO;

import 'package:zerothreesix_dart/system/io.dart';

enum PrintQuery {
  normal, inline, warn, error
}

bool english = false;

final _dictEsp = <String>[];
final _dictEng = <String>[];

void setDictEsp(final List<String> incEsp) =>
  _dictEsp.addAll(incEsp);

void setDictEng(final List<String> incEng) =>
  _dictEng.addAll(incEng);

String lang(
  final int index,
  [final PrintQuery? typeQuery]
) => IO(() =>
  english ? _dictEng[index] : _dictEsp[index]
).map((final sel) => typeQuery != null
  ? IO(() => switch(typeQuery) {
      PrintQuery.normal =>
        print(sel),
      PrintQuery.inline =>
        Console.write(sel),
      PrintQuery.warn =>
        print('${cyan('[*] ')} WARNING: $sel'),
      PrintQuery.error =>
        print('${red('[*] ')} ERROR: $sel')
    })
    .map((final _) => '').run()
  : sel
).run();

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
