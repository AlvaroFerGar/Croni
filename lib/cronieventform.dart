import 'package:flutter/material.dart';

class CroniEventForm extends StatefulWidget {
  CroniEventForm({super.key});

  @override
  State<CroniEventForm> createState() => _CroniEventFormState();
}

class _CroniEventFormState extends State<CroniEventForm> {
  String _croniType="";

  String _croniName='';

  String _croniDescription="";

  final Key _formKey = Key("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Croni Event!'),
      ),
      body: ListView(children: [
        DropdownButtonFormField<String>(
          value: '🏄🏽 Surf',
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_tree_sharp),
          ),
          elevation: 16,
          //style: const TextStyle(color: Colors.deepPurple),
          onChanged: (String? newValue) {
            //setState();
          },
          // setState(() {
          // dropdownValue = newValue!;
          // });
          //},
          items: <String>['🏄🏽 Surf', '📚 Books', '📽 Films']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        TextFormField(
          initialValue: _croniName,
          onChanged: (newValue) => _croniName = newValue,
          decoration: const InputDecoration(
            icon: Icon(Icons.drive_file_rename_outline_rounded),
            labelText: 'Name *',
          ),
          onSaved: (String? value) {
            _croniName=value!;

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
            _croniDescription=value!;
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
            Navigator.pop(context,[_croniType,_croniName,_croniDescription]);
            // Navigate back to first route when tapped.
          },
          child: const Text('Ok'),
        ),
      ]),
    );
  }
}
