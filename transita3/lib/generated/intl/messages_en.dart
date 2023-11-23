// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "acceptIncorrectLoginData":
            MessageLookupByLibrary.simpleMessage("Accept"),
        "createAccountLink": MessageLookupByLibrary.simpleMessage("HERE"),
        "createAccountLinkText":
            MessageLookupByLibrary.simpleMessage(" to create one."),
        "createAccountText": MessageLookupByLibrary.simpleMessage(
            "Don\'t have an account? Tap "),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "enterEmailPlease":
            MessageLookupByLibrary.simpleMessage("Enter an email please"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Sign In"),
        "loginErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Incorrect username or password. Please try again."),
        "loginErrorTitle": MessageLookupByLibrary.simpleMessage("Login Error"),
        "loginWithGoogleButton":
            MessageLookupByLibrary.simpleMessage("Sign In with Google"),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "registerAlreadyAccount": MessageLookupByLibrary.simpleMessage(
            "¿Already have an account? sign In"),
        "registerButton": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "registerEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "registerName": MessageLookupByLibrary.simpleMessage("Name"),
        "registerPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "registerSecondName":
            MessageLookupByLibrary.simpleMessage("Second Name"),
        "showPassword": MessageLookupByLibrary.simpleMessage("Show Password"),
        "signIn": MessageLookupByLibrary.simpleMessage("Sign In"),
        "validatorEmail":
            MessageLookupByLibrary.simpleMessage("Enter a valid email"),
        "validatorPassword": MessageLookupByLibrary.simpleMessage(
            "Password must have at least 6 characters")
      };
}
