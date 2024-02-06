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

  /// `Descripción`
  String get description {
    return Intl.message(
      'Descripción',
      name: 'description',
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

  /// `Crear`
  String get create {
    return Intl.message(
      'Crear',
      name: 'create',
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
  String get confirmNewPassword {
    return Intl.message(
      'Confirm the new pasword',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get changelen {
    return Intl.message(
      'Change lenguage',
      name: 'changelen',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get accexpired {
    return Intl.message(
      'accexpired',
      name: 'accexpired',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get incidencedesc {
    return Intl.message(
      'Incidence description',
      name: 'incidencedesc',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get actualpassincorrect {
    return Intl.message(
      'actual password incorrect',
      name: 'actualpassincorrect',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get currentpassword {
    return Intl.message(
      'Current Password',
      name: 'currentpassword',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get descriptionInfo {
    return Intl.message(
      'Enter the incidence descrition',
      name: 'descriptionInfo',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get specifyDuration {
    return Intl.message(
      'specifyDuration',
      name: 'specifyDuration',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get enterDuration {
    return Intl.message(
      'Enter the Duration',
      name: 'enterDuration',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get accessibility {
    return Intl.message(
      'Enter the accessibility',
      name: 'accessibility',
      desc: '',
      args: [],
    );
  }

  /// `¿Already have an account? sign In`
  String get selectAccessibilityLevel {
    return Intl.message(
      'Select the Accessibility Level',
      name: 'selectAccessibilityLevel',
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

  /// `Incidencia Nº`
  String get incidentNumber {
    return Intl.message(
      'Incidence Nº',
      name: 'incidentNumber',
      desc: '',
      args: [],
    );
  }

  /// `Fecha`
  String get date {
    return Intl.message(
      'Fecha',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Estado`
  String get status {
    return Intl.message(
      'Estado',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Duracion`
  String get duration {
    return Intl.message(
      'Duracion',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Cliente`
  String get client {
    return Intl.message(
      'Cliente',
      name: 'client',
      desc: '',
      args: [],
    );
  }

  /// 'Cerrar Sesión'
  String get logout {
    return Intl.message(
      'Cerrar Sesión',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// 'Aceptar'
  String get accept {
    return Intl.message(
      'Aceptar',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// 'Cancelar'
  String get cancel {
    return Intl.message(
      'Cancelar',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// '¿Estás seguro de que quieres cerrar sesión?'
  String get confirmLogout {
    return Intl.message(
      '¿Estás seguro de que quieres cerrar sesión?',
      name: 'confirmLogout',
      desc: '',
      args: [],
    );
  }

  /// 'You have arrived at your destination!'
  String get arrivalMessage {
    return Intl.message(
      'You have arrived at your destination!',
      name: 'arrivalMessage',
      desc: '',
      args: [],
    );
  }

  /// 'Destination reached!'
  String get destinationReachedMessage {
    return Intl.message(
      'Destination reached!',
      name: 'destinationReachedMessage',
      desc: '',
      args: [],
    );
  }

  /// 'Current Location'
  String get currentLocation {
    return Intl.message(
      'Current Location',
      name: 'currentLocation',
      desc: '',
      args: [],
    );
  }

  String get selectDestinationOnMapMessage {
    return Intl.message(
      'Select destination',
      name: 'selectDestinationOnMapMessage',
      desc: '',
      args: [],
    );
  }

  String get invalidDestination {
    return Intl.message(
      'Select destination',
      name: 'invalidDestination',
      desc: '',
      args: [],
    );
  }

  String get Attachroute {
    return Intl.message(
      'Attach route',
      name: 'Attachroute',
      desc: '',
      args: [],
    );
  }

  String get clearRoute {
    return Intl.message(
      'Clear Route',
      name: 'clearRoute',
      desc: '',
      args: [],
    );
  }

  String get createRoute {
    return Intl.message(
      'Clear Route',
      name: 'createRoute',
      desc: '',
      args: [],
    );
  }

  /// 'Select a destination on the map'
  String get selectDestinationOnMap {
    return Intl.message(
      'Select destination',
      name: 'selectDestinationOnMap',
      desc: '',
      args: [],
    );
  }

  /// 'Select a destination on the map'
  String get confirmDeleteIncidence {
    return Intl.message(
      '¿Are you sure to delete the current incidence?',
      name: 'confirmDeleteIncidence',
      desc: '',
      args: [],
    );
  }

  /// 'Select a destination on the map'
  String get confirmDelete {
    return Intl.message(
      'Confirm Delete',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// 'Select a destination on the map'
  String get errordeletingincidence {
    return Intl.message(
      'An error occurred while deleting the incident',
      name: 'errordeletingincidence',
      desc: '',
      args: [],
    );
  }

  String get incidence {
    return Intl.message(
      'Incidence',
      name: 'incidence',
      desc: '',
      args: [],
    );
  }

  /// 'Select a destination on the map'
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// 'Select a destination on the map'
  String get noIncidences {
    return Intl.message(
      'There is no Incidences',
      name: 'noIncidences',
      desc: '',
      args: [],
    );
  }

  String get errorobtainingincidences {
    return Intl.message(
      'An error occurred while retrieving the incidents',
      name: 'errorobtainingincidences',
      desc: '',
      args: [],
    );
  }

  String get Didyouforgetyourpassword {
    return Intl.message(
      '¿Did you forget your password?',
      name: 'Didyouforgetyourpassword',
      desc: '',
      args: [],
    );
  }

  String get errorgetingpoints {
    return Intl.message(
      'An error occurred while retrieving the points for the map',
      name: 'errorgetingpoints',
      desc: '',
      args: [],
    );
  }

  String get emailsent {
    return Intl.message(
      'Email sent',
      name: 'emailsent',
      desc: '',
      args: [],
    );
  }

  String get recoverpassword {
    return Intl.message(
      'Recover Password',
      name: 'recoverpassword',
      desc: '',
      args: [],
    );
  }

  String get emailsendtouser {
    return Intl.message(
      'We have sent an email with your new password.',
      name: 'emailsendtouser',
      desc: '',
      args: [],
    );
  }

  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  String get pleaseentername {
    return Intl.message(
      'Please enter your name',
      name: 'pleaseentername',
      desc: '',
      args: [],
    );
  }

  String get pleaseentersecondname {
    return Intl.message(
      'Please enter your second name',
      name: 'pleaseentersecondname',
      desc: '',
      args: [],
    );
  }

  String get secondName {
    return Intl.message(
      'Second name',
      name: 'secondName',
      desc: '',
      args: [],
    );
  }

  String get changesSavedCorrectly {
    return Intl.message(
      'Changes saved correctly',
      name: 'changesSavedCorrectly',
      desc: '',
      args: [],
    );
  }

  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  String get errorsaveChanges {
    return Intl.message(
      'An error occurred while saving the changes.',
      name: 'errorsaveChanges',
      desc: '',
      args: [],
    );
  }

  String get errorsingup {
    return Intl.message(
      'An error occurred while signin up.',
      name: 'errorsingup',
      desc: '',
      args: [],
    );
  }

  String get passwordMinLength {
    return Intl.message(
      'Password must be at least 6 characters long',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  String get sessionExpiredError {
    return Intl.message(
      'Error, this session has expired.',
      name: 'sessionExpiredError',
      desc: '',
      args: [],
    );
  }

  String get invalidEmail {
    return Intl.message(
      'Enter a valid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  String get enterValidEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  String get nameMinLength {
    return Intl.message(
      'Name must be at least 2 characters long',
      name: 'nameMinLength',
      desc: '',
      args: [],
    );
  }

  String get longitude {
    return Intl.message(
      'Longitude',
      name: 'longitude',
      desc: '',
      args: [],
    );
  }

  String get latitude {
    return Intl.message(
      'Latitude',
      name: 'latitude',
      desc: '',
      args: [],
    );
  }

  String get accessibilityDegree {
    return Intl.message(
      'Accessibility Degree',
      name: 'accessibilityDegree',
      desc: '',
      args: [],
    );
  }

    /// `PARCIALMENTE ACCESIBLE`
  String get parcialmenteAccesible{
    return Intl.message(
      'PARCIALMENTE ACCESIBLE',
      name: 'parcialmenteAccesible',
      desc: '',
      args: [],
    );
  }

/// 'NO ACCESIBLE'
    String get noAccesible{
    return Intl.message(
      'NO ACCESIBLE',
      name: 'noAccesible',
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
