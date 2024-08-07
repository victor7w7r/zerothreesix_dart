import 'dart:io';

import 'package:dart_console2/dart_console2.dart' show Console;
import 'package:fpdart/fpdart.dart' show Task;

class InputOutputWrapper {
  void clear() => Console().clearScreen();

  Future<ProcessResult> run(final String cmd) => Process.run(
        'bash',
        ['-c', cmd],
        runInShell: true,
      );

  Future<Process> runInherit(final String cmd) => Process.start(
        'bash',
        ['-c', cmd],
        runInShell: true,
        mode: ProcessStartMode.inheritStdio,
      );

  ProcessResult syncCall(final String cmd) =>
      Process.runSync('bash', ['-c', cmd]);
}

class InputOutput {
  const InputOutput(this.io);

  final InputOutputWrapper io;

  Future<int> call(final String cmd) =>
      Task(() => io.run(cmd)).map((final res) => res.exitCode).run();

  Future<bool> checkUid() => Task(() => io.run(r'echo $EUID'))
      .map((final res) => res.stdout.toString().trim() == '0')
      .run();

  void clear() => Console().clearScreen();

  Future<List<String>> codeout(final String cmd) => Task(() => io.run(cmd))
      .map((final res) => [res.exitCode.toString(), res.stdout.toString()])
      .run();

  Future<int> coderes(final String cmd) => Task(() => io.runInherit(cmd))
      .flatMap((final res) => Task(() => res.exitCode))
      .run();

  Future<bool> success(final String cmd) => Task(() => io.run('type $cmd'))
      .map((final res) => res.exitCode == 0)
      .run();

  ProcessResult syncCall(final String cmd) => io.syncCall(cmd);

  Future<String> sys(final String cmd) => Task(() => io.run(cmd))
      .map((final res) => res.stdout.toString().trim())
      .run();

  Future<List<String>> syssplit(final String cmd) => Task(() => io.run(cmd))
      .map((final res) => res.stdout.toString().split('\n'))
      .run();

  Future<String> syswline(final String cmd) =>
      Task(() => syssplit(cmd)).map((final sys) => sys.first).run();
}
