import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintext;
  final TextInputType? keyboardtype;
  final bool? readonly;
  final Color? color;
  final double focusborderwidth;
  final double enableborderwidth;
  final Color bordercolor;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final VoidCallback? onTap;
  final int maxline;
  final void Function(String?)? onchanged;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
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
    this.prefixIcon,
    this.onTap,
    this.onchanged,
    this.validator, this.sufixIcon
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
        height: 53.h,
        width: 343.w,
      decoration:  BoxDecoration(

        borderRadius: BorderRadius.circular(8.r),
      ),
        child: TextFormField(
          maxLines: maxline,
          controller:controller,
          style: const TextStyle(
            color: Colors.black,
          ),
          readOnly: readonly!,
          keyboardType:keyboardtype,
          validator: validator,
          onChanged: onchanged,
          decoration: InputDecoration(
            labelText:hintext ,
            prefixIcon: prefixIcon,
            suffixIcon: sufixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey,
                width: 2,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: const EdgeInsets.only(
                left: 16, right: 10, bottom: 10, top: 20),

          ),
        ),);
  }
}
