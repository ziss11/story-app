class LocalizationConfig {
  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return "${String.fromCharCode(0x1F1FA)}${String.fromCharCode(0x1F1F8)}";
      case 'ar':
        return "${String.fromCharCode(0x1F1F8)}${String.fromCharCode(0x1F1E6)}";
      case 'id':
      default:
        return "${String.fromCharCode(0x1F1EE)}${String.fromCharCode(0x1F1E9)}";
    }
  }
}
