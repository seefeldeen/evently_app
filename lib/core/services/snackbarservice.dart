import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class snackbar{


 static void showCustomNotification({
    required String message,
    Duration duration = const Duration(seconds: 3),
    IconData icon = Icons.info,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
  }) {
    BotToast.showCustomNotification(
      duration: duration,
      toastBuilder: (cancelFunc) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(icon, color: textColor),
            title: Text(
              message,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: cancelFunc,
            ),
          ),
        );
      },
    );
  }

static void showCustomErrormessage({
    required String message,
    Duration duration = const Duration(seconds: 3),
    IconData icon = Icons.info,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
  }) {
    BotToast.showCustomNotification(
      duration: duration,
      toastBuilder: (cancelFunc) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: Icon(icon, color: textColor),
            title: Text(
              message,
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: cancelFunc,
            ),
          ),
        );
      },
    );
  }

static void newloading (){
  BotToast.showLoading(
    clickClose: true,
    allowClick: true,
    crossPage: true,
    backgroundColor: Colors.black45,
    backButtonBehavior: BackButtonBehavior.close,
  );
  BotToast.showText(
    text: "Loading...",
    textStyle: const TextStyle(color: Colors.white),
    contentColor: Colors.black87,
    duration: const Duration(seconds: 3),
  );


}

static void dismissloading() {
    BotToast.closeAllLoading();
  }

}