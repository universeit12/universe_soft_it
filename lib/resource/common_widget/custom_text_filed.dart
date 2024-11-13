import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintext;
  final TextInputType? keyboardType;
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
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintext,
    this.keyboardType,
    this.readonly = false,
    this.focusborderwidth = 2,
    this.enableborderwidth = 1,
    this.maxline = 1,
    this.color = Colors.blue,
    required this.bordercolor,
    this.prefixIcon,
    this.onTap,
    this.onchanged,
    this.validator, this.sufixIcon, this.focusNode, this.onFieldSubmitted
  });



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 25.h,right: 25.h,),
      child: TextFormField(
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        maxLines: maxline,
        controller:controller,
        style: const TextStyle(
          color: Colors.black,
        ),
        readOnly: readonly!,
        keyboardType:keyboardType,
        validator: validator,
        onChanged: onchanged,
        decoration: InputDecoration(
          labelText:hintext ,
          labelStyle: const TextStyle(fontFamily: "FontMain4",fontSize: 14,color: Colors.black38),
          prefixIcon: prefixIcon,
          suffixIcon: sufixIcon,
          focusedErrorBorder: OutlineInputBorder(
            borderSide:  const BorderSide(color: Colors.teal), // Normal state border color
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:  const BorderSide(color: Colors.teal), // Normal state border color
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:  const BorderSide(color: Colors.green), // Focused state border color
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide:  const BorderSide(color: Colors.red), // Error state border color
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.only(
              left: 16, right: 10, bottom: 10, top: 20),

        ),
      ),
    );
  }
}
