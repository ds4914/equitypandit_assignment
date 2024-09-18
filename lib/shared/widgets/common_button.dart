import '../shared.dart';

class CommonButton extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final Color? color;
  final Color? textColor;

  CommonButton(
      {super.key, this.textColor,required this.title, this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey),
            color: color ?? Colors.red),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp),
        )),
      ),
    );
  }
}
