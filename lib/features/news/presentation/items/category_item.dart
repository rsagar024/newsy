class CategoryItem {
  String text;
  double textSize;
  double radius;
  double? top;
  double? bottom;
  double? left;
  double? right;
  String? image;

  CategoryItem({
    required this.text,
    required this.textSize,
    required this.radius,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.image,
  });
}