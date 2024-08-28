import 'package:flutter/material.dart';
import 'package:ojo/core/extensions/padding_extension_on_widget.dart';

Future showWrongDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return const WrongDialog();
    },
  );
}

class WrongDialog extends StatelessWidget {
  const WrongDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 50),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          color: const Color(0xFF1F243F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Wrong answer!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ).paddingSymetric(vertical: 10),
            const Text(
              'Try again',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Inter',
              ),
            ).paddingSymetric(vertical: 24),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.maxFinite,
                height: 52,
                decoration: ShapeDecoration(
                  color: const Color(0xFF4BB030),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Try Again',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0.07,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
