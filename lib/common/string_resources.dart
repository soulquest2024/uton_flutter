


class StringRes {


  static bool matchPattern(String? pattern, String? searched) {
    if(pattern == null && searched == null) {
      return true;
    }
    if(pattern == null || searched == null) {
      return false;
    }
    List<String> searchedPatterns = pattern.split("*");
    for(String searchPattern in searchedPatterns) {
      String find = searchPattern.replaceAll('*', '');
      if(find.isEmpty) {
        continue;
      }
      if(!RegExp(find).hasMatch(searched)) {
        return false;
      }
    }
    return true;
  }
}

