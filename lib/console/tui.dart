import 'dart:async' show Timer;
import 'dart:io';

import 'package:fpdart/fpdart.dart';

import 'package:zerothreesix_dart/utils/utils.dart';

class TuiWrapper {
  Stdout get tuiStdout => stdout;

  Future<Process> showDialog(
    final String title,
    final String body,
    final String height,
    final String width,
  ) =>
      Process.start(
        'bash',
        [
          '-c',
          // ignore: no_adjacent_strings_in_list
          "whiptail --title '$title' --msgbox "
              "'$body' '$height' '$width'"
        ],
        mode: ProcessStartMode.inheritStdio,
      );
}

class Tui {
  const Tui(this._tui);

  final TuiWrapper _tui;

  Future<int> dialog(
    final String title,
    final String body,
    final String height,
    final String width,
  ) async {
    final dialogBox = await _tui.showDialog(title, body, height, width);

    return TaskEither.tryCatch(
      () async {
        await dialogBox.stdout.pipe(stdout);
        await stdin.pipe(dialogBox.stdin);

        return dialogBox.exitCode;
      },
      (final e, final __) => e,
    ).getOrElse((final _) => 1).run();
  }

  Timer spin() => 0.let(
        (cursor) => Timer.periodic(
          const Duration(milliseconds: 100),
          (final _) {
            _tui.tuiStdout.write("\r${['|', '/', '-', r'\'][cursor]}");
            cursor++;
            if (cursor == 4) cursor = 0;
          },
        ),
      );
}
