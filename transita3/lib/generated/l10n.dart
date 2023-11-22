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

  /// `Correo Electrónico`
  String get email {
    return Intl.message(
      'Correo Electrónico',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña`
  String get password {
    return Intl.message(
      'Contraseña',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Iniciar Sesión`
  String get signIn {
    return Intl.message(
      'Iniciar Sesión',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Mostrar Contraseña`
  String get showPassword {
    return Intl.message(
      'Mostrar Contraseña',
      name: 'showPassword',
      desc: '',
      args: [],
    );
  }

  /// `Error de Inicio de Sesión`
  String get loginErrorTitle {
    return Intl.message(
      'Error de Inicio de Sesión',
      name: 'loginErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Usuario o contraseña incorrectos. Por favor, inténtelo de nuevo.`
  String get loginErrorMessage {
    return Intl.message(
      'Usuario o contraseña incorrectos. Por favor, inténtelo de nuevo.',
      name: 'loginErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `¿No tienes cuenta? Pulsa`
  String get createAccountText {
    return Intl.message(
      '¿No tienes cuenta? Pulsa',
      name: 'createAccountText',
      desc: '',
      args: [],
    );
  }

  /// `AQUÍ`
  String get createAccountLink {
    return Intl.message(
      'AQUÍ',
      name: 'createAccountLink',
      desc: '',
      args: [],
    );
  }

  /// ` para crearla.`
  String get createAccountLinkText {
    return Intl.message(
      ' para crearla.',
      name: 'createAccountLinkText',
      desc: '',
      args: [],
    );
  }

  /// `Iniciar Sesión`
  String get loginButton {
    return Intl.message(
      'Iniciar Sesión',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Iniciar Sesión con Google`
  String get loginWithGoogleButton {
    return Intl.message(
      'Iniciar Sesión con Google',
      name: 'loginWithGoogleButton',
      desc: '',
      args: [],
    );
  }

  /// `Aceptar`
  String get acceptIncorrectLoginData {
    return Intl.message(
      'Aceptar',
      name: 'acceptIncorrectLoginData',
      desc: '',
      args: [],
    );
  }

  /// `La contraseña debe contener al menos 6 caracteres`
  String get validatorPassword {
    return Intl.message(
      'La contraseña debe contener al menos 6 caracteres',
      name: 'validatorPassword',
      desc: '',
      args: [],
    );
  }

  /// `Introduce un email válido`
  String get validatorEmail {
    return Intl.message(
      'Introduce un email válido',
      name: 'validatorEmail',
      desc: '',
      args: [],
    );
  }

  /// `Por favor ingresa un correo electrónico`
  String get enterEmailPlease {
    return Intl.message(
      'Por favor ingresa un correo electrónico',
      name: 'enterEmailPlease',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'en'),
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
