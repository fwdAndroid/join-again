import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Function()? onPressed;
  final String? title;
  final String? image;
  const AuthButton({Key? key, this.onPressed, this.title, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Center(
        child: Container(
          height: 53,
          width: 343,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 30, color: Color(0xff8377C6).withOpacity(.11))],
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Colors.white, Colors.white],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "$image",
                  height: 23,
                  width: 23,
                ),
              ),
              Text(
                "$title",
                style: const TextStyle(color: Color(0xff160F29), fontWeight: FontWeight.w600, fontSize: 18, fontFamily: "ProximaNova"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
