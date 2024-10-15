class ItemModel {
  ItemModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.releaseDate,
  });

  final String id;
  final String title;
  final String imageUrl;
  final DateTime releaseDate;

  String daysLeft() {
    return ((releaseDate.difference(DateTime.now()).inDays) + 0.5)
        .round()
        .toString();
  }
}
