import 'dart:async' show Timer;
import 'dart:io';

import 'package:dcli/dcli.dart' show waitForEx;

Future<int> dialog(
  final String title,
  final String body,
  final String height,
  final String width
) async {
  final dialogBox = waitForEx(Process.start(
    'bash',
    [
      // ignore: no_adjacent_strings_in_list
      '-c',"whiptail --title '$title' --msgbox "
      "'$body' '$height' '$width'"
    ],
    mode: ProcessStartMode.inheritStdio
  ));
  try {
    await dialogBox.stdout.pipe(stdout);
    await stdin.pipe(dialogBox.stdin);
    return dialogBox.exitCode;
  // ignore: avoid_catching_errors
  } on StateError catch(_) {
    return dialogBox.exitCode;
  }
}

Timer spin() {
  var cursor = 0;
  return Timer.periodic(
    Duration(milliseconds: 100),
    (final t) {
      stdout.write(
        "\r${['|', '/', '-', r'\'][cursor]}"
      );
      cursor++;
      if(cursor == 4) cursor = 0;
    }
  );
}
