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
  String get changepass {
    return Intl.message(
      'Change Password',
      name: 'changepass',
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
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get changelen {
    return Intl.message(
      'Change Language',
      name: 'changelen',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get incidencedesc {
    return Intl.message(
      'Incidence Description',
      name: 'incidencedesc',
      desc: '',
      args: [],
    );
  }

  /// `No hay incidencias`
  String get noIncidences {
    return Intl.message(
      'No incidences',
      name: 'noIncidences',
      desc: '',
      args: [],
    );
  }

  /// `Crear Ruta`
  String get createRoute {
    return Intl.message(
      'Create Route',
      name: 'createRoute',
      desc: '',
      args: [],
    );
  }

  /// `Duracion Estimada`
  String get estimatedDuration {
    return Intl.message(
      'Estimated Duration',
      name: 'estimatedDuration',
      desc: '',
      args: [],
    );
  }

  /// `Accesibilidad`
  String get accessibility {
    return Intl.message(
      'Accessibility',
      name: 'accessibility',
      desc: '',
      args: [],
    );
  }

  /// `Crear`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Ingrese la duracion`
  String get enterDuration {
    return Intl.message(
      'Enter duration',
      name: 'enterDuration',
      desc: '',
      args: [],
    );
  }

  /// `Indique una duracion`
  String get specifyDuration {
    return Intl.message(
      'Specify duration',
      name: 'specifyDuration',
      desc: '',
      args: [],
    );
  }

  /// `La descripcion debe contener mas informacion`
  String get descriptionInfo {
    return Intl.message(
      'Description must contain more information',
      name: 'descriptionInfo',
      desc: '',
      args: [],
    );
  }

  /// `Seleccione el grado de accesibilidad`
  String get selectAccessibilityLevel {
    return Intl.message(
      'Select accessibility level',
      name: 'selectAccessibilityLevel',
      desc: '',
      args: [],
    );
  }

  /// `Guardar Cambios`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Nueva Contraseña`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Nueva Contraseña`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar Nueva contraseña`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Las contraseñas no coinciden`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Las contraseñas no coinciden',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Por favor, ingresa la nueva contraseña`
  String get enterNewPassword {
    return Intl.message(
      'Por favor, ingresa la nueva contraseña',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Contraseña modificada con éxito`
  String get passwordChangedSuccessfully {
    return Intl.message(
      'Contraseña modificada con éxito',
      name: 'passwordChangedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Tu cuenta ha expirado`
  String get accountExpired {
    return Intl.message(
      'Tu cuenta ha expirado',
      name: 'accountExpired',
      desc: '',
      args: [],
    );
  }

  /// `Ha ocurrido un error al crear la incidencia.`
  String get errorCreatingIncident {
    return Intl.message(
      'Ha ocurrido un error al crear la incidencia.',
      name: 'errorCreatingIncident',
      desc: '',
      args: [],
    );
  }

  /// `Incidencia creada exitosamente`
  String get incidentCreatedSuccessfully {
    return Intl.message(
      'Incidencia creada exitosamente',
      name: 'incidentCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Seleccionar de la galería`
  String get selectFromGallery {
    return Intl.message(
      'Seleccionar de la galería',
      name: 'selectFromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Sacar una foto`
  String get takeAPhoto {
    return Intl.message(
      'Sacar una foto',
      name: 'takeAPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Cambiar Imagen`
  String get changeImage {
    return Intl.message(
      'Cambiar Imagen',
      name: 'changeImage',
      desc: '',
      args: [],
    );
  }

  /// `Subir Foto`
  String get uploadPhoto {
    return Intl.message(
      'Subir Foto',
      name: 'uploadPhoto',
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
