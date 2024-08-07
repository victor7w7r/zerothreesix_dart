import 'dart:async' show FutureOr;

extension ScopeFunctionExt<T> on T {
  T also(final void Function(T it) block) {
    block(this);

    return this;
  }

  Future<T> alsoAsync(final FutureOr<void> Function(T it) block) async {
    await block(this);

    return this;
  }

  R let<R>(final R Function(T it) block) => block(this);

  Future<R> letAsync<R>(final FutureOr<R> Function(T it) block) async =>
      block(this);

  T? takeIf(final bool Function(T it) predicament) =>
      predicament(this) ? this : null;

  T? takeUnless(final bool Function(T it) predicament) =>
      !predicament(this) ? this : null;
}

extension ScopeFunctionExtFuture<T> on Future<T> {
  Future<T> also(final FutureOr<void> Function(T it) block) async {
    final value = await this;
    await block(value);

    return value;
  }

  Future<R> let<R>(final FutureOr<R> Function(T it) block) async =>
      block(await this);
}

extension ScopeFunctionNullableExt<T> on T? {
  R letWithElse<R>(final R Function(T it) block, {required final R orElse}) =>
      this?.let(block.call) ?? orElse;

  R letWithElseCall<R>(
    final R Function(T it) block,
    final R Function() orElse,
  ) =>
      this?.let(block) ?? orElse();

  T withDefault(final T defaultValue) => this ?? defaultValue;
}
