import 'package:instagram_clone/utils/colors.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final Function()? onTap;

  const AuthButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: const ShapeDecoration(
          color: AppColor.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
        ),
        child: !isLoading
            ? Text(
                text,
                style: const TextStyle(fontSize: 16),
              )
            : const Center(
                child: SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(
                    backgroundColor: AppColor.primary,
                    strokeWidth: 1.5,
                  ),
                ),
              ),
      ),
    );
  }
}
