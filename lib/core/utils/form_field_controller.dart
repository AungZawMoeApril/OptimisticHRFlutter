import 'package:flutter/material.dart';

class FormFieldController<T> {
  T? _value;
  final List<VoidCallback> _listeners = [];

  FormFieldController([T? initialValue]) : _value = initialValue;

  T? get value => _value;

  set value(T? newValue) {
    if (_value == newValue) return;
    _value = newValue;
    notifyListeners();
  }

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }

  void reset() {
    value = null;
  }

  void dispose() {
    _listeners.clear();
  }
}