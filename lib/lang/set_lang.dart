import 'package:console/console.dart' show Chooser;
import 'package:fpdart/fpdart.dart' show IO;

import 'package:zerothreesix_dart/lang/lang.dart';
import 'package:zerothreesix_dart/system/system.dart';

void setLang() {
  green('Bienvenido / Welcome \n');
  cyan('Please, choose your language / Por favor selecciona tu idioma \n');

  IO(
    Chooser<String>(['English', 'Espanol'], message: 'Number/Numero: ')
        .chooseSync,
  ).map((final sel) => english = sel == 'English').run();
}
