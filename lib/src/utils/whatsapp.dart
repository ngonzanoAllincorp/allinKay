import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsApp extends StatelessWidget {
  const WhatsApp({Key? key}) : super(key: key);

  void launchWhatsapp({required number, required message}) async {
    String url =
        'https://chat.whatsapp.com/LNhc4a24EqY8akpJ2PA6F5'; //"whatsapp://send?phone=$number&text=$message"
    await canLaunchUrl(Uri.parse(url))
        ? launchUrl(Uri.parse(url))
        : print('No puede abrir WhatsApp.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
