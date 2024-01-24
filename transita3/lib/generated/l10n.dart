// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Show Password`
  String get showPassword {
    return Intl.message(
      'Show Password',
      name: 'showPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login Error`
  String get loginErrorTitle {
    return Intl.message(
      'Login Error',
      name: 'loginErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect username or password. Please try again.`
  String get loginErrorMessage {
    return Intl.message(
      'Incorrect username or password. Please try again.',
      name: 'loginErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Tap `
  String get createAccountText {
    return Intl.message(
      'Don\'t have an account? Tap ',
      name: 'createAccountText',
      desc: '',
      args: [],
    );
  }

  /// `HERE`
  String get createAccountLink {
    return Intl.message(
      'HERE',
      name: 'createAccountLink',
      desc: '',
      args: [],
    );
  }

  /// ` to create one.`
  String get createAccountLinkText {
    return Intl.message(
      ' to create one.',
      name: 'createAccountLinkText',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get loginButton {
    return Intl.message(
      'Sign In',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Sign In with Google`
  String get loginWithGoogleButton {
    return Intl.message(
      'Sign In with Google',
      name: 'loginWithGoogleButton',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get acceptIncorrectLoginData {
    return Intl.message(
      'Accept',
      name: 'acceptIncorrectLoginData',
      desc: '',
      args: [],
    );
  }

  /// `Password must have at least 6 characters`
  String get validatorPassword {
    return Intl.message(
      'Password must have at least 6 characters',
      name: 'validatorPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email`
  String get validatorEmail {
    return Intl.message(
      'Enter a valid email',
      name: 'validatorEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter an email please`
  String get enterEmailPlease {
    return Intl.message(
      'Enter an email please',
      name: 'enterEmailPlease',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get registerName {
    return Intl.message(
      'Name',
      name: 'registerName',
      desc: '',
      args: [],
    );
  }

  /// `Second Name`
  String get registerSecondName {
    return Intl.message(
      'Second Name',
      name: 'registerSecondName',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get registerEmail {
    return Intl.message(
      'Email',
      name: 'registerEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get registerPassword {
    return Intl.message(
      'Password',
      name: 'registerPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get registerButton {
    return Intl.message(
      'Sign Up',
      name: 'registerButton',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get registerAlreadyAccount {
    return Intl.message(
      '¿Already have an account? sign In',
      name: 'registerAlreadyAccount',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get changepass {
    return Intl.message(
      'Change Password',
      name: 'changepass',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get changelen {
    return Intl.message(
      'Change Lenguage',
      name: 'changelen',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get incidencedesc {
    return Intl.message(
      'Description of the incidence',
      name: 'incidencedesc',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get name {
    return Intl.message(
      'Nombre',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get apellido {
    return Intl.message(
      'Second Name',
      name: 'apellido',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
