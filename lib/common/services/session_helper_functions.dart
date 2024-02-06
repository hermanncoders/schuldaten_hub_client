import 'package:jwt_decoder/jwt_decoder.dart';

String tokenLifetimeLeft(String token) {
  Duration remainingTime = JwtDecoder.getRemainingTime(token);
  String days = remainingTime.inDays == 1 ? 'Tag' : 'Tage';
  String hours = remainingTime.inHours == 1 ? 'Stunde' : 'Stunden';
  String minutes = remainingTime.inMinutes == 1 ? 'Minute' : 'Minuten';
  String timeLeft =
      '${remainingTime.inDays} $days, ${remainingTime.inHours % 24} $hours, ${remainingTime.inMinutes % 60} $minutes';
  return timeLeft;
}
