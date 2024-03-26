import 'package:cli_menu/cli_menu.dart' show Menu;
import 'package:fpdart/fpdart.dart' show IO;

import 'package:zerothreesix_dart/lang/lang.dart';

IO<String> chooser(
  final String message,
  final List<String> options,
) =>
    IO(
      Menu(options).choose,
    ).map((final op) => op.value);

bool yesNo(
  final String message,
) =>
    chooser(
      message,
      english ? ['Yes', 'No'] : ['Si', 'No'],
    ).map((final sel) => sel == 'Yes' || sel == 'Si').run();
