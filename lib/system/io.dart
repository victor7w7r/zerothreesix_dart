import 'dart:async';
import 'dart:io';

import 'package:dart_console2/dart_console2.dart' show Console;
import 'package:fpdart/fpdart.dart' show Task;

void clear() => Console().clearScreen();

Task<ProcessResult> _exec(
  final String cmd,
) =>
    Task(
      () async => Process.run(
        'bash',
        ['-c', cmd],
        runInShell: true,
      ),
    );

Task<Process> _sysExec(final String cmd) => Task(
      () async => Process.start(
        'bash',
        ['-c', cmd],
        runInShell: true,
        mode: ProcessStartMode.inheritStdio,
      ),
    );

ProcessResult syncCall(final String cmd) =>
    Process.runSync('bash', ['-c', cmd]);

Future<bool> checkUid() => _exec(r'echo $EUID')
    .map((final res) => res.stdout.toString().trim() == '0')
    .run();

Future<bool> success(final String cmd) =>
    _exec('type $cmd').map((final res) => res.exitCode == 0).run();

Future<int> call(final String cmd) =>
    _exec(cmd).map((final res) => res.exitCode).run();

Future<int> coderes(final String cmd) =>
    _sysExec(cmd).flatMap((final res) => Task(() => res.exitCode)).run();

Future<List<String>> codeout(final String cmd) => _exec(cmd)
    .map((final res) => [res.exitCode.toString(), res.stdout.toString()])
    .run();

Future<String> sys(final String cmd) =>
    _exec(cmd).map((final res) => res.stdout.toString().trim()).run();

Future<List<String>> syssplit(final String cmd) =>
    _exec(cmd).map((final res) => res.stdout.toString().split('\n')).run();

Future<String> syswline(final String cmd) =>
    Task(() => syssplit(cmd)).map((final sys) => sys.first).run();
