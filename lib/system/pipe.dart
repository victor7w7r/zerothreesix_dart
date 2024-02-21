typedef Func1<A, B> = B Function(A);

// ```dart
// final pipe = pipe2(double.parse, (double v) => v.floor());
// pipe('123.456') // 123
// ```
Func1<S, U> pipe2<S, T, U>(final Func1<S, T> f1, final Func1<T, U> f2) =>
    (final value) => f2(f1(value));

// ```dart
// final pipe = pipe3(
//   double.parse,
//   (double v) => v.floor(),
//   (int v) => v.toString(),
// );
// pipe('123.456') // '123'
// ```
Func1<S, V> pipe3<S, T, U, V>(
  final Func1<S, T> f1,
  final Func1<T, U> f2,
  final Func1<U, V> f3,
) =>
    (final value) => f3(f2(f1(value)));

Func1<S, W> pipe4<S, T, U, V, W>(
  final Func1<S, T> f1,
  final Func1<T, U> f2,
  final Func1<U, V> f3,
  final Func1<V, W> f4,
) =>
    (final value) => f4(f3(f2(f1(value))));

Func1<S, X> pipe5<S, T, U, V, W, X>(
  final Func1<S, T> f1,
  final Func1<T, U> f2,
  final Func1<U, V> f3,
  final Func1<V, W> f4,
  final Func1<W, X> f5,
) =>
    (final value) => f5(f4(f3(f2(f1(value)))));

Func1<S, Y> pipe6<S, T, U, V, W, X, Y>(
  final Func1<S, T> f1,
  final Func1<T, U> f2,
  final Func1<U, V> f3,
  final Func1<V, W> f4,
  final Func1<W, X> f5,
  final Func1<X, Y> f6,
) =>
    (final value) => f6(f5(f4(f3(f2(f1(value))))));

extension Pipe<A, B> on Func1<A, B> {
  // ```dart
  // final pipe = double.parse.pipe((double v) => v.floor());
  // pipe('123.456') // 123
  // ```
  Func1<A, C> pipe<C>(final Func1<B, C> f) => pipe2(this, f);
}

void a() {}
