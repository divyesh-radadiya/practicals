// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$User on _User, Store {
  final _$loginNameAtom = Atom(name: '_User.loginName');

  @override
  String get loginName {
    _$loginNameAtom.reportRead();
    return super.loginName;
  }

  @override
  set loginName(String value) {
    _$loginNameAtom.reportWrite(value, super.loginName, () {
      super.loginName = value;
    });
  }

  final _$avatarUrlAtom = Atom(name: '_User.avatarUrl');

  @override
  String get avatarUrl {
    _$avatarUrlAtom.reportRead();
    return super.avatarUrl;
  }

  @override
  set avatarUrl(String value) {
    _$avatarUrlAtom.reportWrite(value, super.avatarUrl, () {
      super.avatarUrl = value;
    });
  }

  final _$isCheckedAtom = Atom(name: '_User.isChecked');

  @override
  bool get isChecked {
    _$isCheckedAtom.reportRead();
    return super.isChecked;
  }

  @override
  set isChecked(bool value) {
    _$isCheckedAtom.reportWrite(value, super.isChecked, () {
      super.isChecked = value;
    });
  }

  @override
  String toString() {
    return '''
loginName: ${loginName},
avatarUrl: ${avatarUrl},
isChecked: ${isChecked}
    ''';
  }
}
