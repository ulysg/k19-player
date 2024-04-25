class Tools {
  static List<T> getFirstXItems<T>(List<T> items, int x) {
    if (x == -1) {
      return items;
    } else {
      return items.sublist(0, x);
    }
  }
}
