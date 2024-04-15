import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DogForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ValueChanged<String> onNicknameSaved;
  final ValueChanged<String> onProfileImagePathSaved;
  final ValueChanged<String> onBirthAreaSaved;
  final ValueChanged<DateTime> onDateSaved;
  final Future<dynamic> Function() onSubmitForm;

  const DogForm({
    Key? key,
    required this.formKey,
    required this.onNicknameSaved,
    required this.onBirthAreaSaved,
    required this.onDateSaved,
    required this.onProfileImagePathSaved,
    required this.onSubmitForm,
  }) : super(key: key);

  @override
  DogFormState createState() => DogFormState();
}

class DogFormState extends State<DogForm> {
  final TextEditingController _dateController = TextEditingController();
  dynamic remoteFiles;
  bool isReqiuredLogin = false;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // ログインしているかを確認
    //   _initAsync();
    // });
  }

  // void _initAsync() async {
  //   bool tokenExists = await checkTokenAndShowModalIfNeeded();
  //   if (!mounted) return;

  //   if (!tokenExists) {
  //     showModalIfNeeded(context);
  //   }
  // }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date to be displayed in the picker
      firstDate: DateTime(2000), // First date that can be picked
      lastDate: DateTime(2025), // Last date that can be picked
    );
    if (picked != null) {
      setState(() {
        _dateController.text =
            DateFormat('yyyy-MM-dd').format(picked); // Formatting the date
        widget.onDateSaved(
            picked); // Passing the picked date back to the parent widget
      });
    }
  }

  Future<dynamic> uploadToServer(XFile? file, {Process? uploadProgress}) async {
    print(file);
    print(uploadProgress);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                hintText: '例：ポチ、チョコ',
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? '名前を入力してください' : null,
              onChanged: widget.onNicknameSaved,
            ),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                hintText: '日付を選択...',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true, // Prevents the keyboard from showing
              onTap: () => _selectDate(
                  context), // Opens the date picker when the field is tapped
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: '生まれた場所を入力...',
                // suffixIcon: Icon(Icons.calendar_today),
              ),
              onChanged: widget.onBirthAreaSaved,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    widget.onSubmitForm();
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
