import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldScreen extends StatefulWidget {
  const TextFieldScreen({super.key});

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {
  final TextEditingController _amountController = TextEditingController();

  void onChangeText(String amount) {
    if (amount.isEmpty) {
      return;
    }

    List<String> parts = amount.split('.');

    String newText = parts[0].replaceAll(',', '');

    String formatted = '';

    print('length ${newText.length}');

    if (newText.length > 3) {
      formatted = newText.substring(newText.length - 3);
      print('formatted $formatted');

      newText = newText.substring(0, newText.length - 3);
      print('newText $newText');
    } else {

      print('newText $newText');
      formatted = newText;
      newText = '';
    }

    while (newText.isNotEmpty) {
      if (newText.length > 2) {
        formatted = '${newText.substring(newText.length - 2)},$formatted';
        newText = newText.substring(0, newText.length - 2);
        print('newText $newText and $formatted');
      } else {
        formatted = '$newText,$formatted';
        newText = '';
        print('elseNewText $newText and $formatted');

      }
    }


    if (parts.length > 1) {
      String decimalPart = parts[1].substring(0, parts[1].length > 2 ? 2 : parts[1].length);
      formatted += '.$decimalPart';
    }

    _amountController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  void onSubmitText(String amount) {
    if (amount.endsWith('.')) {
      List<String> parts = amount.split('.');

      if (parts.length > 1 && parts[1].isEmpty) {
        amount = parts[0];
      }
    }

    // Update the text controller with the modified amount
    _amountController.value = TextEditingValue(
      text: amount,
      selection: TextSelection.collapsed(offset: amount.length),
    );
  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Text Field'),
        backgroundColor: Colors.black54,
      ),
      body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Container(
            padding: const EdgeInsets.only(top: 20,bottom: 20),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(3, 3),
                    blurRadius: 6,
                    spreadRadius: 2,
                  ),
                ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Add Funds',style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                Padding(
                  padding: const EdgeInsets.all(50),

                  child: TextField(
                    // inputFormatters: [
                    //   CommaFormatter()
                    // ],
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration:  const InputDecoration(
                      hintText: 'Enter amount',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    prefix: Text('₹ ',style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                    ),
                    onChanged: onChangeText,
                    onSubmitted: onSubmitText,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
