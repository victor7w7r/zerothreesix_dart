import 'dart:async' show Future, FutureOr;

typedef Func0<A> = A Function();
typedef Func1<A, B> = B Function(A);

T? onlyIf<T>(final bool condition, final T Function() block) {
  if (condition) return block();
  return null;
}

Future<T?> onlyIfAsync<T>(
  final bool condition,
  final FutureOr<T> Function() block,
) async {
  if (condition) return block();
  return Future.value();
}

T ifElse<T>(
  final bool condition,
  final T Function() ifTrue,
  final T Function() ifFalse,
) {
  if (condition) return ifTrue.call();
  return ifFalse.call();
}

Future<T> ifElseAsync<T>(
  final bool condition,
  final FutureOr<T> Function() ifTrue,
  final FutureOr<T> Function() ifFalse,
) async {
  if (condition) return ifTrue.call();
  return ifFalse.call();
}

R run<R>(final R Function() block) => block();

void chain(final void Function() ch1, final void Function() ch2) {
  ch1();
  ch2();
}

void chain3(
  final void Function() ch1,
  final void Function() ch2,
  final void Function() ch3,
) {
  ch1();
  ch2();
  ch3();
}

void chain4(
  final void Function() ch1,
  final void Function() ch2,
  final void Function() ch3,
  final void Function() ch4,
) {
  ch1();
  ch2();
  ch3();
  ch4();
}

void chain5(
  final void Function() ch1,
  final void Function() ch2,
  final void Function() ch3,
  final void Function() ch4,
  final void Function() ch5,
) {
  ch1();
  ch2();
  ch3();
  ch4();
  ch5();
}

void chain6(
  final void Function() ch1,
  final void Function() ch2,
  final void Function() ch3,
  final void Function() ch4,
  final void Function() ch5,
  final void Function() ch6,
) {
  ch1();
  ch2();
  ch3();
  ch4();
  ch5();
  ch6();
}

void chain7(
  final void Function() ch1,
  final void Function() ch2,
  final void Function() ch3,
  final void Function() ch4,
  final void Function() ch5,
  final void Function() ch6,
  final void Function() ch7,
) {
  ch1();
  ch2();
  ch3();
  ch4();
  ch5();
  ch6();
  ch7();
}

Future<void> chainAsync(
  final Future<void> Function() ch1,
  final Future<void> Function() ch2,
) async {
  await ch1();
  await ch2();
}

Future<void> chain3Async(
  final Future<void> Function() ch1,
  final Future<void> Function() ch2,
  final Future<void> Function() ch3,
) async {
  await ch1();
  await ch2();
  await ch3();
}

Future<void> chain4Async(
  final Future<void> Function() ch1,
  final Future<void> Function() ch2,
  final Future<void> Function() ch3,
  final Future<void> Function() ch4,
) async {
  await ch1();
  await ch2();
  await ch3();
  await ch4();
}

Future<void> chain5Async(
  final Future<void> Function() ch1,
  final Future<void> Function() ch2,
  final Future<void> Function() ch3,
  final Future<void> Function() ch4,
  final Future<void> Function() ch5,
) async {
  await ch1();
  await ch2();
  await ch3();
  await ch4();
  await ch5();
}

Future<void> chain6Async(
  final Future<void> Function() ch1,
  final Future<void> Function() ch2,
  final Future<void> Function() ch3,
  final Future<void> Function() ch4,
  final Future<void> Function() ch5,
  final Future<void> Function() ch6,
) async {
  await ch1();
  await ch2();
  await ch3();
  await ch4();
  await ch5();
  await ch6();
}

U pipeFunc<T, U>(final Func0<T> f1, final Func1<T, U> f2) => f2(f1());

V pipe2Func<T, U, V>(
  final Func0<T> f1,
  final Func1<T, U> f2,
  final Func1<U, V> f3,
) =>
    f3(f2(f1()));

W pipe3Func<T, U, V, W>(
  final Func0<T> f1,
  final Func1<T, U> f2,
  final Func1<U, V> f3,
  final Func1<V, W> f4,
) =>
    f4(f3(f2(f1())));

// ```dart
// final pipe = pipe2(double.parse, (double v) => v.floor());
// pipe('123.456') // 123
// ```
Func1<S, U> pipe2<S, T, U>(final Func1<S, T> f1, final Func1<T, U> f2) =>
    (final value) => f2(f1(value));

extension Pipe<A, B> on Func1<A, B> {
  // ```dart
  // final pipe = double.parse.pipe((double v) => v.floor());
  // pipe('123.456') // 123
  // ```
  Func1<A, C> pipe<C>(final Func1<B, C> f) => pipe2(this, f);
}
