import 'dart:io' show stdout;

import 'package:get_it/get_it.dart' show GetIt;

import 'package:zerothreesix_dart/lang/lang.dart';
import 'package:zerothreesix_dart/system/colorize.dart';
import 'package:zerothreesix_dart/system/io.dart';
import 'package:zerothreesix_dart/system/storage.dart';

void setup() {
  GetIt.I.registerFactory(() => Colorize(stdout));
  GetIt.I.registerFactory(() => InputOutput(InputOutputWrapper()));
  GetIt.I.registerFactory(() => Storage(GetIt.I<InputOutput>()));
  GetIt.I.registerSingleton(
    Lang(GetIt.I<Colorize>(), ConsoleWrapper(), GetIt.I<InputOutput>()),
  );
}
