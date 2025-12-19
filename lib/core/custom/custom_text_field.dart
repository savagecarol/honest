import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final bool showLabel;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final Color? focusedBorderColor;
  final double borderRadius;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.showLabel = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.fillColor,
    this.focusedBorderColor,
    this.borderRadius = 12.0,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label (optional)
        if (widget.showLabel && widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
        ],

        // TextField
        TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          textAlign: widget.textAlign,
          style: widget.textStyle ??
              TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 16.sp,
            ),
            filled: true,
            fillColor: widget.fillColor ?? Colors.white.withOpacity(0.1),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            
            // Border styling
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
              borderSide: BorderSide(
                color: widget.focusedBorderColor ?? Colors.white,
                width: 2.w,
              ),
            ),
            
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
        ),
      ],
    );
  }
}