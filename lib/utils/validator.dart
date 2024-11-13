import '../resource/constant_string.dart';

class AppValidator{

 static String? validateNumber(value) {
    if (value!.isEmpty) {
      return whatsappNumber;
    }
    if (value.length != 11) {
      return elevenDigitNumber;
    }
    return null;
  }
}