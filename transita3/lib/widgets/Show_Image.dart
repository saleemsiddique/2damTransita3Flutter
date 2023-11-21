
    import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transita3/models/models.dart';
import 'package:transita3/provider/Utils.dart';

Widget showImage(Incidencia incidence) {
  print(incidence.fotos);
    final Widget fromFTP = FadeInImage(
      fit: BoxFit.cover,
      width: 60,
      height: 80,
      placeholder: AssetImage('assets/loading.gif'), 
      image: CachedNetworkImageProvider(incidence.fotos));
    
    final Widget fromDB = FadeInImage(
            fit: BoxFit.cover,
            width: 60,
            height: 80,
            placeholder: AssetImage('assets/loading.gif'),
            //Le pasamos la imagen en base 64
            image: MemoryImage(Utils.dataFromBase64String(incidence.fotos)),
          );

      if (incidence.estado == 'ENVIADO') return fromDB;
      else return fromFTP;
  }