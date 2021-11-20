import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextAreaWidget extends StatelessWidget {
  final title;

  final FormFieldSetter? onSaved;
  final ValueChanged? onChanged;
  final value;
  TextAreaWidget({
    Key? key,
    this.title,
    this.onSaved,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
      child: new Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              '$title',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: TextFormField(
              controller: TextEditingController(text: value),
              onChanged: onChanged,
              onSaved: onSaved,
              decoration: InputDecoration(
                hintText: 'Input descriptions here..',
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.5, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.5, color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.5, color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.5, color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              minLines: 2,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'please add $title.';
                } else if (value.length < 5) {
                  return ' value length is too short. Min 5.';
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
