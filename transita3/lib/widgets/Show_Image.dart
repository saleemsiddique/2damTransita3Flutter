import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/provider/Utils.dart';

Widget showImage(Incidencia incidence) {
  print(incidence.punto.foto);
  final Widget fromFTP = FadeInImage(
      fit: BoxFit.cover,
      width: 60,
      height: 80,
      placeholder: AssetImage('assets/loading.gif'),
      image:
          CachedNetworkImageProvider('http://10.0.2.2/img/puntos/${incidence.punto.foto}'));

  if (incidence.fotos != null && incidence.estado == 'ENVIADO') {
    return FadeInImage(
    fit: BoxFit.cover,
    width: 60,
    height: 80,
    placeholder: AssetImage('assets/loading.gif'),
    //Le pasamos la imagen en base 64
    image: MemoryImage(Utils.dataFromBase64String(incidence.fotos!)),
  );
  }
  else if (incidence.fotos == null && incidence.estado != 'ENVIADO') return fromFTP;
  else {
    return FadeInImage(
        fit: BoxFit.cover,
        width: 60,
        height: 80,
        placeholder: AssetImage('assets/loading.gif'),
        image: AssetImage('assets/no-image.jpg'));
  }
}
