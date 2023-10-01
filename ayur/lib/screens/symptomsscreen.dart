import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../util/utility.dart';
// class SymptomsScreen extends StatelessWidget {
//   const SymptomsScreen({super.key});
//   static const routeName = '/symptomsscreen';

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

class SymptomsScreen extends StatefulWidget {
  static const routeName = '/symptomsscreen';

  @override
  _SymptomsScreenState createState() => _SymptomsScreenState();
}

class _SymptomsScreenState extends State<SymptomsScreen> {
  String _inputText = '';
  TextEditingController symptomsText = TextEditingController();

  Future<void> _makeApiCall() async {
    final response = await http.get(
      Uri.parse(
          '${Utility.URL}/symptoms/${Uri.encodeQueryComponent(symptomsText.text)}/find'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      String formatedtext = response.body;
      formatedtext = formatedtext.replaceAll('"', '');
      formatedtext = formatedtext.replaceAll('\\n', '\n');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('API Response'),
          content: Text(formatedtext),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
      // setState(() {
      //   _apiResponse = response.body;
      // });
    } else {
      print('API call failed: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('find about symptoms'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.blue))),
            keyboardType: TextInputType.text,
            controller: symptomsText,
            onChanged: (value) {
              if (value.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
          ElevatedButton(
            onPressed: _makeApiCall,
            child: const Text('Submit'),
          ),
          // Text(_apiResponse),
        ],
      ),
    );
  }
}
