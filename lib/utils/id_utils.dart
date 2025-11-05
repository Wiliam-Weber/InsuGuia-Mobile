import 'package:uuid/uuid.dart';

class IdUtils {
  static final Uuid _uuid = Uuid();

  static String generateId() {
    return _uuid.v4();
  }
}
