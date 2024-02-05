import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'val';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "acceptIncorrectLoginData":
            MessageLookupByLibrary.simpleMessage("Acceptar"),
        "createAccountLink": MessageLookupByLibrary.simpleMessage("ACÍ"),
        "createAccountLinkText":
            MessageLookupByLibrary.simpleMessage(" per a crear-la."),
        "createAccountText":
            MessageLookupByLibrary.simpleMessage("¿No tens compte? Preme "),
        "email": MessageLookupByLibrary.simpleMessage("Correu Electrònic"),
        "enterEmailPlease": MessageLookupByLibrary.simpleMessage(
            "Si us plau, introdueix un correu electrònic"),
        "loginButton": MessageLookupByLibrary.simpleMessage("Iniciar Sessió"),
        "loginErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Usuari o contrasenya incorrectes. Si us plau, intenta-ho de nou."),
        "loginErrorTitle":
            MessageLookupByLibrary.simpleMessage("Error d'Inici de Sessió"),
        "loginWithGoogleButton":
            MessageLookupByLibrary.simpleMessage("Iniciar Sessió amb Google"),
        "password": MessageLookupByLibrary.simpleMessage("Contrasenya"),
        "registerAlreadyAccount": MessageLookupByLibrary.simpleMessage(
            "Ja tens un compte? Iniciar Sessió"),
        "registerButton": MessageLookupByLibrary.simpleMessage("Registrar-se"),
        "registerEmail":
            MessageLookupByLibrary.simpleMessage("Correu Electrònic"),
        "registerName": MessageLookupByLibrary.simpleMessage("Nom"),
        "registerPassword": MessageLookupByLibrary.simpleMessage("Contrasenya"),
        "registerSecondName": MessageLookupByLibrary.simpleMessage("Segon Nom"),
        "showPassword":
            MessageLookupByLibrary.simpleMessage("Mostrar Contrasenya"),
        "signIn": MessageLookupByLibrary.simpleMessage("Iniciar Sessió"),
        "validatorEmail":
            MessageLookupByLibrary.simpleMessage("Introdueix un email vàlid"),
        "validatorPassword": MessageLookupByLibrary.simpleMessage(
            "La contrasenya ha de contenir almenys 6 caràcters"),
        "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
            "Les contrasenyes no coincideixen"),
        "enterNewPassword": MessageLookupByLibrary.simpleMessage(
            "Si us plau, introdueix la nova contrasenya"),
        "passwordChangedSuccessfully": MessageLookupByLibrary.simpleMessage(
            "Contrasenya modificada amb èxit"),
        "accountExpired":
            MessageLookupByLibrary.simpleMessage("El teu compte ha expirat"),
        "description": MessageLookupByLibrary.simpleMessage("Descripció"),
        "errorCreatingIncident": MessageLookupByLibrary.simpleMessage(
            "Ha ocorregut un error en crear la incidència."),
        "incidentCreatedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Incidència creada amb èxit"),
        "create": MessageLookupByLibrary.simpleMessage("Crear"),
        "selectFromGallery":
            MessageLookupByLibrary.simpleMessage("Seleccionar de la galeria"),
        "takeAPhoto": MessageLookupByLibrary.simpleMessage("Fer una foto"),
        "changeImage": MessageLookupByLibrary.simpleMessage("Canviar Imatge"),
        "uploadPhoto": MessageLookupByLibrary.simpleMessage("Puja la Foto"),
        "profile": MessageLookupByLibrary.simpleMessage("Perfil"),
        "settings": MessageLookupByLibrary.simpleMessage("Ajustos"),
        "changelen": MessageLookupByLibrary.simpleMessage("Canviar Idioma"),
        "changepass":
            MessageLookupByLibrary.simpleMessage("Canviar Contrasenya"),
        "incidencedesc":
            MessageLookupByLibrary.simpleMessage("Descripció de la incidència"),
        "noIncidences":
            MessageLookupByLibrary.simpleMessage("No hi ha incidències"),
        "createRoute": MessageLookupByLibrary.simpleMessage("Crear Ruta"),
        "estimatedDuration":
            MessageLookupByLibrary.simpleMessage("Duració Estimada"),
        "accessibility": MessageLookupByLibrary.simpleMessage("Accessibilitat"),
        "create": MessageLookupByLibrary.simpleMessage("Crear"),
        "enterDuration":
            MessageLookupByLibrary.simpleMessage("Introduïx la duració"),
        "specifyDuration":
            MessageLookupByLibrary.simpleMessage("Indica una duració"),
        "descriptionInfo": MessageLookupByLibrary.simpleMessage(
            "La descripció ha de contenir més informació"),
        "selectAccessibilityLevel": MessageLookupByLibrary.simpleMessage(
            "Seleccioneu el grau d'accessibilitat"),
        "saveChanges": MessageLookupByLibrary.simpleMessage("Guardar Canvis"),
        "newPassword": MessageLookupByLibrary.simpleMessage("Nova Contrasenya"),
        "confirmNewPassword":
            MessageLookupByLibrary.simpleMessage("Confirmar Nova Contrasenya"),
        "currentpassword":
            MessageLookupByLibrary.simpleMessage("Contrasenya actual"),
        "actualpassincorrect": MessageLookupByLibrary.simpleMessage(
            "Contrasenya actual Incorrecta"),
        "incidenceNumber":
            MessageLookupByLibrary.simpleMessage("Incidència Nº"),
        "date": MessageLookupByLibrary.simpleMessage("Data"),
        "status": MessageLookupByLibrary.simpleMessage("Estat"),
        "duration": MessageLookupByLibrary.simpleMessage("Duració"),
        "client": MessageLookupByLibrary.simpleMessage("Client"),
        "logout": MessageLookupByLibrary.simpleMessage("Tancar Sessió"),
        "accept": MessageLookupByLibrary.simpleMessage("Acceptar"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "confirmLogout": MessageLookupByLibrary.simpleMessage(
            "¿Estàs segur que vols tancar sessió?"),
        "destinationReached":
            MessageLookupByLibrary.simpleMessage("¡Destí assolit!"),
        "currentLocation":
            MessageLookupByLibrary.simpleMessage("Ubicació Actual"),
        "arrivalMessage":
            MessageLookupByLibrary.simpleMessage("¡Has arribat al teu destí!"),
        "selectDestinationOnMapMessage":
            MessageLookupByLibrary.simpleMessage("Tria un destí"),
        "invalidDestination": MessageLookupByLibrary.simpleMessage(
            "Has de seleccionar un punt de destí vàlid"),
        "createRoute": MessageLookupByLibrary.simpleMessage("Crear ruta"),
        "currentLocation":
            MessageLookupByLibrary.simpleMessage("Ubicació Actual"),
        "selectDestinationOnMap":
            MessageLookupByLibrary.simpleMessage("Tria un destí"),
        "clearRoute": MessageLookupByLibrary.simpleMessage("Netejar Ruta"),
        "Attachroute": MessageLookupByLibrary.simpleMessage("Fixar ruta"),
        "confirmDelete":
            MessageLookupByLibrary.simpleMessage("Confirmar Eliminació"),
        "deleteIncidentError": MessageLookupByLibrary.simpleMessage(
            "S'ha produït un error en eliminar la incidència"),
        "delete": MessageLookupByLibrary.simpleMessage("Eliminar"),
        "noIncidences":
            MessageLookupByLibrary.simpleMessage("No hi ha incidències"),
        "retrieveIncidentsError": MessageLookupByLibrary.simpleMessage(
            "S'ha produït un error en recuperar les incidències"),
        "forgotPassword": MessageLookupByLibrary.simpleMessage(
            "¿Has oblidat la teua contrasenya?"),
        "retrievePointsError": MessageLookupByLibrary.simpleMessage(
            "S'ha produït un error en recuperar els punts per al mapa"),
        "emailSent": MessageLookupByLibrary.simpleMessage("Email enviat"),
        "recoverPassword":
            MessageLookupByLibrary.simpleMessage("Recuperar Contrasenya"),
        "newPasswordEmail": MessageLookupByLibrary.simpleMessage(
            "Hem enviat un correu electrònic amb la teua nova contrasenya"),
        "name": MessageLookupByLibrary.simpleMessage("Nom"),
        "enterName": MessageLookupByLibrary.simpleMessage(
            "Si us plau, introdueix el teu nom"),
        "enterSecondName": MessageLookupByLibrary.simpleMessage(
            "Si us plau, introdueix el teu segon nom"),
        "secondName": MessageLookupByLibrary.simpleMessage("Cognom"),
        "changesSaved": MessageLookupByLibrary.simpleMessage(
            "Canvis guardats correctament"),
        "saveChanges": MessageLookupByLibrary.simpleMessage("Guardar Canvis"),
        "saveChangesError": MessageLookupByLibrary.simpleMessage(
            "S'ha produït un error en guardar els canvis."),
        "passwordLengthError": MessageLookupByLibrary.simpleMessage(
            "La contrasenya ha de tindre almenys 6 caràcters"),
        "signupError": MessageLookupByLibrary.simpleMessage(
            "S'ha produït un error en registrar-se."),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirmar Contrasenya"),
        "forgotPassword": MessageLookupByLibrary.simpleMessage(
            "¿Has oblidat la teua contrasenya?"),
        "sessionExpired": MessageLookupByLibrary.simpleMessage(
            "Error, aquesta sessió ha expirat."),
        "enterValidEmail": MessageLookupByLibrary.simpleMessage(
            "Introdueix un correu electrònic vàlid"),
        "validEmailError": MessageLookupByLibrary.simpleMessage(
            "Si us plau, introdueix una adreça de correu electrònic vàlida"),
        "nameLengthError": MessageLookupByLibrary.simpleMessage(
            "El nom ha de tindre almenys 2 caràcters"),
        "longitude": MessageLookupByLibrary.simpleMessage("Longitud"),
        "latitude": MessageLookupByLibrary.simpleMessage("Latitud"),
        "incidence": MessageLookupByLibrary.simpleMessage("Incidencia"),
        "accessibilityDegree":
            MessageLookupByLibrary.simpleMessage("Grau d'accesibilidad"),
        "confirmDeleteIncidence": MessageLookupByLibrary.simpleMessage(
            "¿Segur que vols eliminar la incidencia?"),
      };
}
