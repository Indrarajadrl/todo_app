import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final title;
  final hinttext;
  final FormFieldSetter? onSaved;

  final value;

  final ValueChanged? onChanged;
  const TextFieldWidget({
    Key? key,
    this.title,
    this.hinttext,
    this.onSaved,
    this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 5,
        top: 5,
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              '$title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
            child: TextFormField(
              onChanged: onChanged,
              onSaved: onSaved,
              controller: TextEditingController(text: value),
              decoration: InputDecoration(
                hintText: hinttext + ' ' + title + '..',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 0.5),
                  //  when the TextFormField in focused
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  //  when the TextFormField in focused
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 0.5),
                  //  when the TextFormField in focused
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 0.5),
                  //  when the TextFormField in focused
                ),
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              minLines: 1,
              maxLines: null,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please add $title.';
                } else {
                  return null;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
