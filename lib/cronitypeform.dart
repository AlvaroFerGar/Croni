import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:emoji_keyboard_flutter/emoji_keyboard_flutter.dart';
import 'package:flutter/services.dart';

class CroniTypeForm extends StatefulWidget {
  CroniTypeForm({super.key});

  @override
  State<CroniTypeForm> createState() => _CroniTypeFormState();
}

class _CroniTypeFormState extends State<CroniTypeForm> {
  String _croniType = "";

  String _croniName = '';

  String _croniDescription = "";

  final Key _formKey = Key("");

  final TextEditingController _emojicontroller = TextEditingController();
  bool _showEmojiKeyboard = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Croni Type!'),
      ),
      body: ListView(children: [
        TextFormField(
          initialValue: _croniName,
          onChanged: (newValue) => _croniName = newValue,
          decoration: const InputDecoration(
            icon: Icon(Icons.color_lens_rounded),
            labelText: 'Color *',
          ),
          onSaved: (String? value) {
            _croniName = value!;

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
          //initialValue: _croniName,
          readOnly: true,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          //maxLength: 1,
          controller: _emojicontroller,
          //onChanged: (newValue) => _croniName = newValue,
          decoration: const InputDecoration(
            icon: Icon(Icons.tag_faces_rounded),
            labelText: 'Emoji *',
          ),
          onSaved: (String? value) {
            _croniName = value!;

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
        /*Align(
            child:EmojiKeyboard(
                emotionController: _emojicontroller,
                emojiKeyboardHeight: 200,
                showEmojiKeyboard: _showEmojiKeyboard,
                darkMode: false,
            ),),
        */
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
          initialValue: _croniName,
          onChanged: (newValue) => _croniName = newValue,
          decoration: const InputDecoration(
            icon: Icon(Icons.drive_file_rename_outline_rounded),
            labelText: 'Name *',
          ),
          onSaved: (String? value) {
            _croniName = value!;

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
          initialValue: _croniDescription,
          onChanged: (newValue) => _croniDescription = newValue,
          decoration: const InputDecoration(
            icon: Icon(Icons.textsms),
            labelText: 'Description *',
          ),
          onSaved: (String? value) {
            _croniDescription = value!;
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
          onPressed: () {
            //_formKey.currentState.save();
            setState(() {});
            Navigator.pop(context, [_croniType, _croniName, _croniDescription]);
            // Navigate back to first route when tapped.
          },
          child: const Text('Done!'),
        ),
      ]),
    );
  }

  void onTapEmojiField() {
    setState(() {
      _showEmojiKeyboard = !_showEmojiKeyboard;
    });
  }

  Future<void> onChangedEmojiField(category, Emoji emoji) async
  {
    print("onChanged");

     _emojicontroller.text = emoji.emoji.toString();
    setState(() {
      _showEmojiKeyboard = false;
    });
    }
  }

