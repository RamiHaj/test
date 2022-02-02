import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/app/core/constants/colors.dart';
import 'package:untitled2/app/core/constants/local_keys.dart';
import 'package:untitled2/app/core/exceptions/exceptions.dart';

class CustomToast {
  CustomToast.showDefault(String message) {
    BotToast.closeAllLoading();
    showToast(message);
  }
  CustomToast.showError(CustomError error) {
    BotToast.closeAllLoading();
    String message = '';
    switch (error) {
      case CustomError.noInternet:
        message = LocaleKeys.checkInternet;
        break;

      case CustomError.conflict:
        message = LocaleKeys.wrongUserNameOrPassword;
        break;
      case CustomError.unKnown:
        message = LocaleKeys.somethingWentWrong;
        break;
      case CustomError.alreadyExists:
        message = LocaleKeys.alreadyExists;
        break;
      case CustomError.alreadySubscribed:
        message = "LocaleKeys.alreadySubscribed";
        break;
      case CustomError.wrongCode:
        message = " LocaleKeys.wrongCode";
        break;
      case CustomError.formatException:
        message = "LocaleKeys.wrongCode";
        break;
    }

    showToast(message);
  }
  CustomToast.showLoading() {
    showLoading();
  }
  void showToast(String message) {
    BotToast.showText(
      text: message,
      textStyle: TextStyle(
        overflow: TextOverflow.visible,
        color: ConstColors.primaryColor,
      ),
      contentColor: Colors.grey[700]!,
      crossPage: false,
      clickClose: true,
      duration: const Duration(seconds: 5),
    );
  }

  void showLoading() {
    BotToast.showLoading();
  }

  CustomToast.closeLoading() {
    closeLoading();
  }
  void closeLoading() {
    BotToast.closeAllLoading();
  }
}
