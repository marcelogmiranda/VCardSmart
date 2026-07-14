import 'package:intl/intl.dart';

class AppUtils {
  AppUtils._();

  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays > 365) {
      return '${(diff.inDays / 365).floor()} ano(s) atrás';
    } else if (diff.inDays > 30) {
      return '${(diff.inDays / 30).floor()} mês(es) atrás';
    } else if (diff.inDays > 0) {
      return '${diff.inDays} dia(s) atrás';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hora(s) atrás';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minuto(s) atrás';
    } else {
      return 'Agora';
    }
  }

  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }
}
