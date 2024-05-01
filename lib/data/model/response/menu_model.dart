class MenuModel {
  String icon;
  String title;
  String route;
  final void Function()? onTap;
  bool isBlocked;

  MenuModel(
      {required this.icon,
      required this.title,
      required this.route,
      this.isBlocked = false,
      this.onTap});
}
