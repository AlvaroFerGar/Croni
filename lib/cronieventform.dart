import 'package:Croni/cronibase.dart';
import 'package:flutter/material.dart';


class CroniEventResult {

  CroniEventResult({
    required this.typeId,
    required this.name,
    required this.description,
  });

  final int typeId;
  final String name;
  final String description;

}

class CroniEventForm extends StatefulWidget {
  CroniEventForm({required this.croniTypesList,super.key});


  List<String> croniTypesList=[];
  @override
  State<CroniEventForm> createState() => _CroniEventFormState(croniTypesList:croniTypesList);
}

class _CroniEventFormState extends State<CroniEventForm> {
  _CroniEventFormState({
    required this.croniTypesList,
  });

  List<String> croniTypesList=[];

  int _croniTypeId=0;
  String _croniType="";
  String _croniName='';
  String _croniDescription="";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child:Scaffold(

      appBar: AppBar(
        title: const Text('New Croni Event!'),
      ),
      body: ListView(children: [
        DropdownButtonFormField<String>(
          value:croniTypesList.first,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_tree_sharp),
          ),
          elevation: 16,
          //style: const TextStyle(color: Colors.deepPurple),
          onChanged: (String? newValue) {
            int id=0;
            for(String typename in croniTypesList)
              {

                if(typename==newValue)
                  {
                    print(typename);
                    print(id);
                    _croniTypeId=id;
                    return;
                  }
                id++;
              }
            //setState();
          },
          // setState(() {
          // dropdownValue = newValue!;
          // });
          //},
          items: croniTypesList
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
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
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
          /*
          validator: (String? value) {

            return (value != null && value.contains('@'))
                ? 'Do not use the @ char.'
                : null;
          },
          */
        ),
        ElevatedButton(
          onPressed: () {
            print("onpressed");

            if (_formKey.currentState!.validate()) {
              setState(() {});
              Navigator.pop(context,CroniEventResult(typeId:_croniTypeId,name:_croniName,description: _croniDescription));
              return;
            }
            print("no validado");
;
            //Navigator.pop(context,[CroniEvent(type: _croniType, name: _croniName)]);

            // Navigate back to first route when tapped.
          },
          child: const Text('Ok'),
        ),
      ]),
    ),
    );
  }
}
