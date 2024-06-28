import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? textController;
  final String? hintText;
  final String? errorText;
  final bool isPw;
  final bool isAutoFocus;
  final bool isReadOnly;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField(
      {this.hintText,
      this.errorText,
      this.textController,
      this.isPw = false,
      this.isAutoFocus = false,
      this.isReadOnly = false,
      required this.onChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        width: 0.5,
      ),
    );

    return TextFormField(
      controller: textController,
      //커서 색상 설정
      readOnly: isReadOnly,
      //비밀번호 스타일 적용여부
      obscureText: isPw,
      //화면 오픈 시 포커싱 여부
      autofocus: isAutoFocus,
      onChanged: onChanged,
      // decoration은 html에 style같은 느낌
      // input항목은 inputDecoration으로 관리하나봄
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          // html에 placeholder과 같은 기능
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.0,
          ),
          //배경색 지정
          //배경색 적용 여부
          filled: true,
          //idle한 border 스타일 지정
          border: baseBorder,
          enabledBorder: baseBorder,
          errorText: errorText),
    );
  }
}
