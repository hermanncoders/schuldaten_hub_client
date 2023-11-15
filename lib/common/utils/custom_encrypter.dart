import 'package:encrypt/encrypt.dart' as enc;

import 'package:schuldaten_hub/common/services/env_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'debug_printer.dart';

final customEncrypter = CustomEncrypter();

class CustomEncrypter {
  // We get the encryption keys from the .env file
  final key = enc.Key.fromUtf8(locator<EnvManager>().env.value.key!);
  final iv = enc.IV.fromUtf8(locator<EnvManager>().env.value.iv!);

  Future<String?> encrypt(String nonEncryptedString) async {
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final encryptedString =
        encrypter.encrypt(nonEncryptedString, iv: iv).base64;
    return encryptedString;
  }

  Future<String?> decrypt(String encryptedString) async {
    final encrypter = enc.Encrypter(enc.AES(key, mode: enc.AESMode.cbc));
    final thisEncryptedString = enc.Encrypted.fromBase64(encryptedString);
    final decryptedString = encrypter.decrypt(thisEncryptedString, iv: iv);
    debug.info('Decrypted string is $decryptedString');
    return decryptedString;
  }
}
