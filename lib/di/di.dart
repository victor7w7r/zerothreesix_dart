import 'dart:io' show stdout;

import 'package:get_it/get_it.dart' show GetIt;

import 'package:zerothreesix_dart/console/console.dart';
import 'package:zerothreesix_dart/lang/lang.dart';

void setupDartUtils() {
  GetIt.I.registerFactory(() => Colorize(stdout));
  GetIt.I.registerFactory(() => Tui(TuiWrapper()));
  GetIt.I.registerFactory(() => InputOutput(InputOutputWrapper()));
  GetIt.I.registerFactory(() => Storage(GetIt.I<InputOutput>()));
  GetIt.I.registerSingleton(
    Lang(GetIt.I<Colorize>(), LangWrapper(), GetIt.I<InputOutput>()),
  );
}
