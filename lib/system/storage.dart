import 'package:fpdart/fpdart.dart' show Task;

import 'package:zerothreesix_dart/system/io.dart';

const _usbList =
  "find /dev/disk/by-id/ -name 'usb*' "
  '| sort -n '
  r"| sed 's/^\/dev\/disk\/by-id\///'";

Future<List<String>> allDevs() => syssplit(
  'find /dev/disk/by-path/ '
  r"| sed 's/^\/dev\/disk\/by-path\///'"
);

Future<List<String>> usbDevices() =>
  syssplit(_usbList);

Future<bool> checkUsbDevices() =>
  Task(() => sys(_usbList))
    .map((final res) => res == '')
    .run();

Future<String> checkPartIsMounted(
  final String part
) => sys("lsblk /dev/$part | sed -ne '/\\//p'");

Future<String> checkPartFs(
  final String part
) => sys("lsblk -f /dev/$part | sed -ne '2p' | cut -d ' ' -f2");

Future<String> dirtyDev(
  final String dev
) => syswline(
  'readlink "/dev/disk/by-id/$dev"'
);

Future<String> absoluteDev(
  final String dev
) => sys(
  'echo $dev '
  r"| sed 's/^\.\.\/\.\.\//\/dev\//' "
  r"| sed '/.*[[:alpha:]]$/d' |d se '/blk[[:digit:]]$/d'"
);

Future<String> mountUsbCheck(
  final String part
) => sys("lsblk /dev/$part | sed -ne '/\\//p'");

Future<String> getRootDev() =>
  sys(r"df -h | sed -ne '/\/$/p' | cut -d ' ' -f1");

Future<String> getBlockDev(
  final String dev
) => syswline("echo $dev | sed 's/^\\.\\.\\/\\.\\.\\///'");

Future<String> getAllBlockDev(
  final String dev
) => syswline(
  'echo $dev '
  r"| sed 's/^\.\.\/\.\.\///' "
  r"| sed '/.*[[:alpha:]]$/d' | sed '/blk[[:digit:]]$/d'"
);
