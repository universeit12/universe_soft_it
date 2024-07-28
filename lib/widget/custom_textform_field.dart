import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final String hintext;
  final TextInputType? keyboardtype;
  final bool? readonly;
  final Color? color;
  final double focusborderwidth;
  final double enableborderwidth;

  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final VoidCallback? onTap;
  final int maxline;
  final void Function(String?)? onchanged;
  final FormFieldValidator<String>? validator;
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.hintext,
    this.keyboardtype,
    this.readonly = false,
    this.focusborderwidth = 2,
    this.enableborderwidth = 1,
    this.maxline = 1,
    this.color = Colors.blue,

    this.prefixIcon,
    this.onTap,
    this.onchanged,
    this.validator, this.sufixIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color:Colors.white,
        ),
        padding: const EdgeInsets.only(left: 10),
        child: TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardtype,

          decoration:  InputDecoration(
            border: InputBorder.none,
            hintText: hintext,

            suffixIcon: sufixIcon,

          ),));
  }
}
