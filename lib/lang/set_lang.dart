import 'package:console/console.dart' show Chooser;
import 'package:dcli/dcli.dart' show cyan, green;
import 'package:fpdart/fpdart.dart' show IO;

import 'package:zerothreesix_dart/lang/lang.dart';

void setLang() {
  print(green('Bienvenido / Welcome'));
  print(cyan(
    'Please, choose your language / Por favor selecciona tu idioma'
  ));

  IO(Chooser<String>(
    ['English', 'Espanol'],
    message: 'Number/Numero: '
  ).chooseSync)
    .map((final sel) => english = sel == 'English')
    .run();
}
