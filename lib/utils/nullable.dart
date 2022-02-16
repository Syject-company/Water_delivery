class Nullable<T> {
  Nullable(T? value) : this._value = value;

  T? _value;

  T? get value => _value;
}
