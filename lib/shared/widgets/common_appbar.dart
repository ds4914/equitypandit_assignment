import '../../shared.dart';

class CommonAppbar extends StatelessWidget {
  List<Widget>? actions;
  final String title;
  final bool? showBackIcon;
  CommonAppbar(
      {super.key,
      required this.showBackIcon,
      required this.title,
      this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.red,
      leading: showBackIcon == true
          ? GestureDetector(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
            )
          : SizedBox.shrink(),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      actions: actions,
    );
  }
}
