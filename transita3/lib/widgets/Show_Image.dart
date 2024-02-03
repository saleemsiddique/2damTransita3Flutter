import 'package:flutter/material.dart';
import 'package:transita3/AppConfig.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/provider/Utils.dart';

Widget showImage(Incidencia incidence) {
  print(incidence.punto.foto);
  final Widget fromFTP = Image.network(
    '${AppConfig.FTPHost}${AppConfig.FTPRoute}${incidence.punto.foto}',
    fit: BoxFit.cover,
    height: 80,
    width: 60,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
      print('Failed to load image: $error');
      return FadeInImage(
        fit: BoxFit.cover,
        height: 80,
        width: 60,
        placeholder: AssetImage('assets/loading.gif'),
        image: AssetImage('assets/no-image.jpg'),
      );
    },
  );
  if (incidence.fotos != null && incidence.estado == 'ENVIADO') {
    return FadeInImage(
      fit: BoxFit.cover,
      width: 60,
      height: 80,
      placeholder: AssetImage('assets/loading.gif'),
      //Le pasamos la imagen en base 64
      image: MemoryImage(Utils.dataFromBase64String(incidence.fotos!)),
    );
  } else if (incidence.fotos == null && incidence.estado != 'ENVIADO')
    return fromFTP;
  else {
    return FadeInImage(
        fit: BoxFit.cover,
        width: 60,
        height: 80,
        placeholder: AssetImage('assets/loading.gif'),
        image: AssetImage('assets/no-image.jpg'));
  }
}

Widget showImagePunto(Punto punto) {
  return Image.network(
    '${AppConfig.FTPHost}${AppConfig.FTPRoute}${punto.foto}',
    fit: BoxFit.cover,
    height: 200,
    width: 150,
    loadingBuilder:
        (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) {
        return child;
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
      print('Failed to load image: $error');
      return FadeInImage(
        fit: BoxFit.cover,
        height: 200,
        width: 150,
        placeholder: AssetImage('assets/loading.gif'),
        image: AssetImage('assets/no-image.jpg'),
      );
    },
  );
}
