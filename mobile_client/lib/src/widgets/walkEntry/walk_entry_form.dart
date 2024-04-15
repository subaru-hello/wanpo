import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For input formatters
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class WalkEntryForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final ValueChanged<String> onTitleSaved;
  final ValueChanged<String> onDeacriptionSaved;
  final ValueChanged<String> onSummaryImagePathSaved;
  final ValueChanged<int> onStepCountSaved;
  final ValueChanged<int> onDurationSaved;
  final ValueChanged<DateTime> onDateSaved;
  final Future<dynamic> Function() onSubmitForm;

  const WalkEntryForm({
    Key? key,
    required this.formKey,
    required this.onTitleSaved,
    required this.onDeacriptionSaved,
    required this.onStepCountSaved,
    required this.onDurationSaved,
    required this.onDateSaved,
    required this.onSummaryImagePathSaved,
    required this.onSubmitForm,
  }) : super(key: key);

  @override
  WalkEntryFormState createState() => WalkEntryFormState();
}

class WalkEntryFormState extends State<WalkEntryForm> {
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
                hintText: 'ポチの散歩日誌...',
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? 'タイトルを入力してください' : null,
              onChanged: widget.onTitleSaved,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: '今日は元気にお散歩をしました',
              ),
              validator: (value) =>
                  value == null || value.isEmpty ? '記録を入力してください' : null,
              onChanged: widget.onDeacriptionSaved,
            ),
            // Example for a Step Count field
            TextFormField(
              decoration: InputDecoration(
                hintText: '歩数',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) =>
                  value == null || value.isEmpty ? '歩数を入力してください' : null,
              onChanged: (value) =>
                  widget.onStepCountSaved(int.tryParse(value) ?? 0),
            ),
            // Example for a Duration field
            TextFormField(
              decoration: InputDecoration(
                hintText: '散歩の時間（分）',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (value) =>
                  value == null || value.isEmpty ? '時間を入力してください' : null,
              onChanged: (value) =>
                  widget.onDurationSaved(int.tryParse(value) ?? 0),
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
            // ImageField(
            //   texts: const {'fieldFormText'},
            // )
            // ImageField(
            //   texts: const {
            //     'fieldFormText': 'Upload to server',
            //     'titleText': 'Upload to server'
            //   },
            //   onSave: (List<ImageAndCaptionModel>? imageAndCaptionList) {
            //     //you can save imageAndCaptionList using local storage
            //     //or in a simple variable
            //   },
            // ),
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
