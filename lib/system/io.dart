import 'dart:io';

import 'package:dcli/dcli.dart' show Terminal, waitForEx;
import 'package:fpdart/fpdart.dart' show Task;

void clear() =>
  Terminal().clearScreen();

Task<ProcessResult> _exec(
  final String cmd
) => Task(() async => Process.run(
  'bash',
  ['-c', cmd],
  runInShell: true
));

Task<Process> _sysExec(
  final String cmd
) => Task(() async => waitForEx(
  Process.start(
    'bash',
    ['-c', cmd],
    runInShell: true,
    mode: ProcessStartMode.inheritStdio
  ))
);

Future<bool> checkUid() =>
  _exec(r'echo $EUID')
    .map((final res) => res.stdout.toString().trim() == '0')
    .run();

Future<int> coderes(
  final String cmd
) => _sysExec(cmd)
  .flatMap((final res) => Task(() => res.exitCode))
  .run();

Future<List<String>> codeout(
  final String cmd
) => _exec(cmd)
  .map((final res) => [
    res.exitCode.toString(),
    res.stdout.toString()
  ])
  .run();

Future<int> call(
  final String cmd
) => _exec(cmd)
  .map((final res) => res.exitCode)
  .run();

Future<bool> success(
  final String cmd
) => _exec('type $cmd')
  .map((final res) => res.exitCode == 0)
  .run();

Future<String> sys(
  final String cmd
) => _exec(cmd)
  .map((final res) => res.stdout.toString().trim())
  .run();

Future<List<String>> syssplit(
  final String cmd
) => _exec(cmd)
  .map((final res) => res.stdout.toString().split('\n'))
  .run();

Future<String> syswline(
  final String cmd
) => _exec(cmd)
  .map((final res) => res.stdout.toString().split('\n')[0])
  .run();
