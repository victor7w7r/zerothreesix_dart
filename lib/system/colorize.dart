import 'dart:io' show stdout;

import 'package:console/console.dart' show Color, Console;

void colorize(final Color color, final String text) {
  final buffer = StringBuffer()
    ..write(color.toString())
    ..write(text)
    ..write('${Console.ANSI_ESCAPE}0m');
  stdout.write(buffer.toString());
}

void cyan(final String text) => colorize(Color.CYAN, text);

void cyanMix(final String cyanText, final String text) {
  cyan(cyanText);
  print(text);
}

void green(final String text) => colorize(Color.GREEN, text);

void greenMix(final String greenText, final String text) {
  green(greenText);
  print(text);
}

void red(final String text) => colorize(Color.RED, text);

void redMix(final String redText, final String text) {
  red(redText);
  print(text);
}
