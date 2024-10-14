import 'package:flutter/material.dart';

class DialogHelper {
  static Future dialogTemplate(BuildContext context,
      {required String message,
      String? title,
      required String buttonTitle,
      required Color colorButton,
      required VoidCallback callback,
      bool? confirm,
      int? delay}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // Untuk menutup dialog secara otomatis setelah 5 detik, kecuali jika ini adalah dialog konfirmasi
        if (delay != null) {
          Future.delayed(Duration(seconds: delay), () {
            Navigator.of(context).pop(); // Menutup dialog otomatis
          });
        }

        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message, style: const TextStyle(fontSize: 18.0)),
          actions: <Widget>[
            if (confirm == true) ...[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buttonDialog(colorButton, buttonTitle, () {
                      Navigator.pop(context);
                      callback();
                    }),
                    _buttonDialog(
                        Colors.grey, "Cancel", () => Navigator.pop(context)),
                  ])
            ] else ...[
              _buttonDialog(colorButton, buttonTitle, callback),
            ]
          ],
        );
      },
    ); // Kembalikan false jika dialog ditutup tanpa konfirmasi
  }

  static Widget _buttonDialog(Color color, String title, callback) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      onPressed: () => callback(), // Menutup dialog tanpa menghapus
      child: Text(title, style: const TextStyle(color: Colors.white)),
    );
  }
}
