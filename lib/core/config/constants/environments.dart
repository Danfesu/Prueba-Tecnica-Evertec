import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  static String clientFirbaseClientId =
      dotenv.env['SERVER_FIREBASE_CLIENT_ID'] ?? "No client ID";
  static String baseUrl = dotenv.env['BASE_URL'] ?? "No base URL";
}
