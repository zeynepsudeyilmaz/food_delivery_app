import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EncryptionService {
  // Anahtarınızı güvenli bir yerden almanızı öneririm.
  final String _key =
      "tPX8tKdwprRXqrc40CmEBVK8LoredGBE"; // 32 byte (256 bit) anahtar
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Şifreleme işlemi
  String encryptData(String data) {
    // Anahtarı doğrudan kullan
    final key = encrypt.Key.fromUtf8(_key);

    // Rastgele bir IV oluşturma
    final iv = encrypt.IV.fromLength(16); // 16 byte uzunluğunda

    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(data, iv: iv);
    return '${encrypted.base64}:${base64.encode(iv.bytes)}'; // Şifreli veriyi ve IV'yi döndür
  }

  // Deşifreleme
  String decryptData(String encryptedData) {
    final parts = encryptedData.split(':');
    final encryptedString = parts[0];
    final iv = encrypt.IV.fromBase64(parts[1]);

    final key = encrypt.Key.fromUtf8(_key);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final decrypted = encrypter.decrypt64(encryptedString, iv: iv);
    return decrypted; // Şifreli veriyi döndür
  }
}
