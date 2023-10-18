import 'package:zerothreesix_dart/system/io.dart';

Future<String> efiPart() => sys('diskutil list '
    "| sed -ne '/EFI/p' "
    r"| sed -ne 's/.*\(d.*\).*/\1/p'");

Future<String> efiCheck() => sys(r'EFIPART=$(diskutil list '
    "| sed -ne '/EFI/p' "
    r"| sed -ne 's/.*\(d.*\).*/\1/p') "
    r'MOUNTROOT=$(df -h | sed -ne "/$EFIPART/p"); '
    r'echo $MOUNTROOT');
