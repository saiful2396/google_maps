class TypesHelper {
  static int toInt(num val) {
    try {
      if (val == null) {
        return 0;
      }
      if (val is int) {
        return val;
      } else {
        return val.toInt();
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }
  static double toDouble(num val) {
    try {
      if (val == null) {
        return 0;
      }
      if (val is double) {
        return val;
      } else {
        return val.toDouble();
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }
}
