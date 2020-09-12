import 'package:estudiantes/services/data_service.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QR extends StatelessWidget {
  const QR({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          height: double.maxFinite,
          alignment: Alignment.center,
          child: QrImage(
            data: DataService.personalCodigoGrupo,
            version: QrVersions.auto,
            size: 250.0,
          )
        ),
      )
    );
  }
}