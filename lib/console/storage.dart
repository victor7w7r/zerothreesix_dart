import 'package:fpdart/fpdart.dart' show Task;

import 'package:zerothreesix_dart/console/io.dart';

const _usbList = "find /dev/disk/by-id/ -name 'usb*' "
    '| sort -n '
    r"| sed 's/^\/dev\/disk\/by-id\///'";

class Storage {
  const Storage(this._io);

  final InputOutput _io;

  Future<String> absoluteDev(
    final String dev,
  ) =>
      _io.sys(
        'echo $dev '
        r"| sed 's/^\.\.\/\.\.\//\/dev\//' "
        r"| sed '/.*[[:alpha:]]$/d' | sed '/blk[[:digit:]]$/d'",
      );

  Future<List<String>> allDevs() => _io.syssplit(
        'find /dev/disk/by-path/ '
        r"| sed 's/^\/dev\/disk\/by-path\///'",
      );

  Future<String> checkPartFs(
    final String part,
  ) =>
      _io.sys("lsblk -f /dev/$part | sed -ne '2p' | cut -d ' ' -f2");

  Future<bool> checkUsbDevices() =>
      Task(() => _io.sys(_usbList)).map((final res) => res == '').run();

  Future<String> dirtyDev(
    final String dev,
  ) =>
      _io.syswline('readlink "/dev/disk/by-id/$dev"');

  Future<String> getAllBlockDev(
    final String dev,
  ) =>
      _io.syswline(
        'echo $dev '
        r"| sed 's/^\.\.\/\.\.\///' "
        r"| sed '/.*[[:alpha:]]$/d' | sed '/blk[[:digit:]]$/d'",
      );

  Future<String> getBlockDev(
    final String dev,
  ) =>
      _io.syswline("echo $dev | sed 's/^\\.\\.\\/\\.\\.\\///'");

  Future<String> getRootDev() =>
      _io.sys(r"df -h | sed -ne '/\/$/p' | cut -d ' ' -f1");

  Future<String> mountUsbCheck(
    final String part,
  ) =>
      _io.sys("lsblk /dev/$part | sed -ne '/\\//p'");

  Future<List<String>> usbDevices() => _io.syssplit(_usbList);
}
