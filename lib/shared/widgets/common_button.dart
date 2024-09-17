import '../../shared.dart';

class CommonButton extends StatelessWidget {
  void Function() onTap;
  final String title;
  final Color? color;
  CommonButton(
      {super.key, required this.title, this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: color ?? Colors.red),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp),
        )),
      ),
    );
  }
}
