import 'package:cli_menu/cli_menu.dart' show Menu;
import 'package:fpdart/fpdart.dart' show IO;

import 'package:zerothreesix_dart/lang/lang.dart';
import 'package:zerothreesix_dart/system/system.dart';

void setLang() {
  green('Bienvenido / Welcome \n');
  cyan('Please, choose your language / Por favor selecciona tu idioma \n');

  IO(
    Menu(['English', 'Espanol']).choose,
  ).map((final op) => english = op.value == 'English').run();
}
