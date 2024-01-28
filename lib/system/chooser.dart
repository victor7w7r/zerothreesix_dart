import 'package:console/console.dart' show Chooser;
import 'package:fpdart/fpdart.dart' show IO;

import 'package:zerothreesix_dart/lang/lang.dart';

IO<String> chooser(
  final String message,
  final List<String> options,
) =>
    IO(
      Chooser<String>(
        options,
        message: message,
      ).chooseSync,
    );

bool yesNo(final String message) => chooser(
      message,
      english ? ['Yes', 'No'] : ['Si', 'No'],
    ).map((final sel) => sel == 'Yes' || sel == 'Si').run();
