import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LanguageTranslationPageState createState() =>
      _LanguageTranslationPageState();
}

class _LanguageTranslationPageState extends State<LanguageTranslationPage> {
  var languages = ['Sinhala', 'English', 'Gujarati', 'Marathi', 'Tamil'];
  var originLanguage = '--';
  var destinationLanguage = '--';
  var output = '';
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    if (src == '--' || dest == '--') {
      setState(() {
        output = 'Please select language';
      });
      return;
    }

    GoogleTranslator translator = GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });
  }

  String getLanguageCode(String language) {
    switch (language) {
      case 'Sinhala':
        return 'si';
      case 'English':
        return 'en';
      case 'Gujarati':
        return 'gu';
      case 'Marathi':
        return 'mr';
      case 'Tamil':
        return 'ta';
      default:
        return 'en';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Language Translation',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff10223d),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.blue[700],
                    iconEnabledColor: Colors.blue[100],
                    hint: Text(
                      originLanguage,
                      style: TextStyle(color: Colors.blue[700]),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        child: Text(dropDownStringItem),
                        value: dropDownStringItem,
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLanguage = value!;
                      });
                    },
                  ),
                  SizedBox(width: 40),
                  Icon(Icons.arrow_right_alt_outlined,
                      color: Colors.white, size: 40),
                  const SizedBox(width: 40),
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.blue[700],
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage,
                      style: TextStyle(color: Colors.blue[700]),
                    ),
                    dropdownColor: Colors.white,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.black,
                  autofocus: false,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Enter your text here',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 15),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    errorStyle: TextStyle(color: Colors.red, fontSize: 50),
                  ),
                  controller: languageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  onPressed: () {
                    translate(
                        getLanguageCode(originLanguage),
                        getLanguageCode(destinationLanguage),
                        languageController.text.toString());
                  },
                  child: Text("Click to translate"),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                output,
                style: TextStyle(
                    color: Color(0xff10223d),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
