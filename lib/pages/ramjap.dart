import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
class Ramnam extends StatefulWidget {
  const Ramnam({Key? key}) : super(key: key);

  @override
  State<Ramnam> createState() => _RamnamState();
}

Color myColor = Colors.lightBlue;
PickerFont? _selectedFont;
String editedText = "Edit me!";
List<String> fontList = ["Arial", "Helvetica", "Times New Roman", "Courier New"];
double fontSize = 16.0; // Initial font size
List<double> fontSizeOptions = [12.0, 16.0, 20.0, 24.0, 28.0,32.0,36.0,40.0,44.0,48.0]; // Font size options

class _RamnamState extends State<Ramnam> {
  String selectedFont = "Arial";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: Lottie.network('https://lottie.host/4453d657-d330-4b75-8cb2-06b4b3c068a7/BwtwdSVQoF.json'),
          title: Text("RamJap")

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(30),
          color: Colors.orange,
          child: Column(
            children: [
              Container(
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:  BorderRadius.circular(20),
                ),
                // color: Colors.white,
                child: Center(
                  child: Text(
                    editedText,
                    style: TextStyle(
                      fontFamily: selectedFont,
                      fontWeight: _selectedFont?.fontWeight,
                      fontStyle: _selectedFont?.fontStyle,
                      color: myColor,
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    child: Text('Pick a font'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Select a font'),
                            content: SizedBox(
                              height: 200,
                              child: ListView.builder(
                                itemCount: fontList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(fontList[index]),
                                    onTap: () {
                                      setState(() {
                                        selectedFont = fontList[index];
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String enteredText = ""; // Text entered by the user

                          return AlertDialog(
                            title: Text('Add Text'),
                            content: TextField(
                              onChanged: (text) {
                                enteredText = text;
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter text here',
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('DONE'),
                                onPressed: () {
                                  setState(() {
                                    editedText = enteredText;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: AvatarGlow(
                      child: Material(
                        elevation: 8.0,
                        color: Colors.black,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[100],
                          child: Icon(Icons.text_fields),
                          radius: 30.0,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Pick a color!'),
                            content: SingleChildScrollView(
                              child: ColorPicker(
                                pickerColor: myColor, //default color
                                onColorChanged: (Color color) {
                                  setState(() {
                                    myColor = color;
                                  });
                                },
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('DONE'),
                                onPressed: () {
                                  Navigator.of(context).pop(); //dismiss the color picker
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("Pick Color"),
                  ),

                ],
              ),
              SizedBox(height: 25),

              DropdownButton<double>(
                value: fontSize,
                items: fontSizeOptions.map((double value) {
                  return DropdownMenuItem<double>(
                    value: value,
                    child: Text(value.toString()),
                  );
                }).toList(),
                onChanged: (double? newValue) {
                  if (newValue != null) {
                    setState(() {
                      fontSize = newValue;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


