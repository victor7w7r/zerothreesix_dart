extension ScopeFunctionExt<T> on T {
  T also(final void Function(T) block) {
    block.call(this);
    return this;
  }

  R let<R>(final R Function(T) block) => block.call(this);

  T? takeIf(final bool Function(T it) predicament) =>
      predicament.call(this) ? this : null;

  T? takeUnless(final bool Function(T it) predicament) =>
      !predicament.call(this) ? this : null;
}

extension ScopeFunctionNullableExt<T> on T? {
  R letWithElse<R>(final R Function(T) block, {required final R orElse}) =>
      this?.let(block.call) ?? orElse;

  T withDefault(final T defaultValue) => this ?? defaultValue;
}

R run<R>(final R Function() block) => block.call();
