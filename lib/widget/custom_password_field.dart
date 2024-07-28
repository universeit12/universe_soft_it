import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPassField extends StatefulWidget {
  final TextEditingController controller;
  final String hintext;
  final TextInputType? keyboardtype;
  final bool? readonly;
  final Color? color;
  final double focusborderwidth;
  final double enableborderwidth;
  final Color bordercolor;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final int maxline;
  final void Function(String?)? onchanged;
  final FormFieldValidator<String>? validator;

  const CustomPassField ({
    Key? key,
    required this.controller,
    required this.hintext,
    this.keyboardtype,
    this.readonly = false,
    this.focusborderwidth = 2,
    this.enableborderwidth = 1,
    this.maxline = 1,
    this.color = Colors.blue,
    required this.bordercolor,
    this.suffixIcon,
    this.onTap,
    this.onchanged, this.validator,
  }) : super(key: key);

  @override
  State<CustomPassField > createState() =>
      _PasswordTextInputWidgetState();
}

class _PasswordTextInputWidgetState extends State<CustomPassField > {
  bool isvisibility = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 53.h,
        width: 343.w,
        decoration:  BoxDecoration(

        borderRadius: BorderRadius.circular(8.r),
    ),
      child: TextFormField(
        maxLines: widget.maxline,
        controller: widget.controller,
        style: const TextStyle(
          color: Colors.black,
        ),
        readOnly: widget.readonly!,
        keyboardType: widget.keyboardtype,
        validator: widget.validator,
        onChanged: widget.onchanged,
        decoration: InputDecoration(
          labelText: widget.hintext,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide:  BorderSide(
              color: Colors.grey,
              width: 2.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueGrey,
              width: 2.w,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueGrey,
              width: 2.w,
            ),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding:  EdgeInsets.only(
              left: 16.h, right: 10.h, bottom: 10.h, top: 20.h),

          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isvisibility = !isvisibility;
                });
              },
              icon: Icon(
                isvisibility ? Icons.visibility_off : Icons.visibility,
                color: widget.color,
                size: 20.sp,
              )),
        ),
        obscureText: isvisibility,
      ),
    );
  }
}
