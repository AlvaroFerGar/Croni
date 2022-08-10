import 'package:Croni/cronibase.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/services.dart';

class CroniTypeForm extends StatefulWidget {
  CroniTypeForm({super.key});

  @override
  State<CroniTypeForm> createState() => _CroniTypeFormState();
}

class _CroniTypeFormState extends State<CroniTypeForm> {
  String _croniType = "";

  String _croniTypeName = '';
  late Emoji _croniTypeEmoji;
  Color _croniTypeColor=Colors.transparent;
  String _croniTypeDescription = "";

  final Key _formKey = Key("");

  final TextEditingController _emojicontroller = TextEditingController();
  bool _showEmojiKeyboard = false;
  bool _showColorPicker = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Croni Type!'),
      ),
      body: ListView(children: [
        TextFormField(
          readOnly: true,
          initialValue: _croniTypeName,
          onChanged: (newValue) => _croniTypeName = newValue,
          decoration: InputDecoration(
            icon: Icon(Icons.color_lens_rounded),
            labelText: 'Color',
            filled: true,
            fillColor: _croniTypeColor,
          ),
          onSaved: (String? value) {
            _croniTypeName = value!;

            // This optional block of code can be used to run
            // code when the user saves the form.
          },
          validator: (String? value) {
            return (value != null && value.contains('@'))
                ? 'Do not use the @ char.'
                : null;
          },
          onTap: onTapColorField,

        ),
      Visibility(
          visible: _showColorPicker,
          child: SizedBox(
            height: 400,
          child: MaterialPicker(
          pickerColor: Colors.red,
          onColorChanged: onChangedColor,
            enableLabel: false,
            portraitOnly: false,
          ),
          ),
        ),
        TextFormField(
          //initialValue: _croniName,
          readOnly: true,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          //maxLength: 1,
          style: TextStyle(fontSize: 24),
          controller: _emojicontroller,
          //onChanged: (newValue) => _croniName = newValue,
          decoration: const InputDecoration(
            icon: Icon(Icons.tag_faces_rounded),
            labelText: 'Emoji',
          ),
          onSaved: (String? value) {
            _croniTypeName = value!;

            // This optional block of code can be used to run
            // code when the user saves the form.
          },
          validator: (String? value) {
            return (value != null && value.contains('@'))
                ? 'Do not use the @ char.'
                : null;
          },
          onTap: onTapEmojiField,
        ),
        Visibility(
          visible: _showEmojiKeyboard,
          child: Align(
            child: SizedBox(
              height: 300,
              child: EmojiPicker(
                textEditingController: _emojicontroller,
                config: Config(
                  columns: 7,
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  gridPadding: EdgeInsets.zero,
                  initCategory: Category.RECENT,
                  bgColor: Color(0xFFF2F2F2),
                  indicatorColor: Colors.blue,
                  iconColor: Colors.grey,
                  iconColorSelected: Colors.blue,
                  progressIndicatorColor: Colors.blue,
                  backspaceColor: Colors.blue,
                  skinToneDialogBgColor: Colors.white,
                  skinToneIndicatorColor: Colors.grey,
                  enableSkinTones: true,
                  showRecentsTab: false,
                  tabIndicatorAnimDuration: kTabScrollDuration,
                  categoryIcons: const CategoryIcons(),
                  buttonMode: ButtonMode.MATERIAL,
                ),
                onEmojiSelected: onChangedEmojiField,
              ),
            ),
          ),
        ),
        TextFormField(
          initialValue: _croniTypeName,
          onChanged: (newValue) => _croniTypeName = newValue,
          decoration: const InputDecoration(
            icon: Icon(Icons.drive_file_rename_outline_rounded),
            labelText: 'Name',
          ),
          onSaved: (String? value) {
            _croniTypeName = value!;

            // This optional block of code can be used to run
            // code when the user saves the form.
          },
          validator: (String? value) {
            return (value != null && value.contains('@'))
                ? 'Do not use the @ char.'
                : null;
          },
        ),
        TextFormField(
          initialValue: _croniTypeDescription,
          onChanged: (newValue) => _croniTypeDescription = newValue,
          decoration: const InputDecoration(
            icon: Icon(Icons.textsms),
            labelText: 'Description',
          ),
          onSaved: (String? value) {
            _croniTypeDescription = value!;
            // This optional block of code can be used to run
            // code when the user saves the form.
          },
          validator: (String? value) {
            return (value != null && value.contains('@'))
                ? 'Do not use the @ char.'
                : null;
          },
        ),
        ElevatedButton(
          onPressed: onPressedDone,
          child: const Text('Done!'),
        ),
      ]),
    );
  }

  void onTapEmojiField() {
    setState(() {
      _showColorPicker=false;
      _showEmojiKeyboard = !_showEmojiKeyboard;
    });
  }

  void onTapColorField() {
    setState(() {
      _showEmojiKeyboard=false;
      _showColorPicker = !_showColorPicker;
    });
  }

  Future<void> onChangedEmojiField(category, Emoji emoji) async
  {
    print("onChanged");

    _emojicontroller.text = emoji.emoji.toString();
    _croniTypeEmoji=emoji;
    setState(() {
      _showEmojiKeyboard = false;
    });
  }


Future<void> onChangedColor(Color color) async
{
  print("onChanged");
  print(color);
  _croniTypeColor=color;
  setState(() {
    _showColorPicker = false;
  });
}

  Future<void> onPressedDone() async
  {
    print("onPressedDone");

    //TODO: Añadir comprobaciones

    print(_croniTypeName);
    print(_croniTypeEmoji);
    print(_croniTypeColor);
    print(_croniTypeDescription);
    //_formKey.currentState.save();
    setState(() {
      Navigator.pop(context, [CroniType(name: _croniTypeName, emoji: _croniTypeEmoji, color: _croniTypeColor)]);
    });
  }
}

