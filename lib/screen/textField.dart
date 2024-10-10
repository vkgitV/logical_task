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
        amount;
      }
      List<String> parts = amount.split('.');

      String newText = parts[0].replaceAll(',', '');

      String reversed = newText.split('').reversed.join('');

      String formattedReversed = '';
      for (int i = 0; i < reversed.length; i++) {
        if (i > 0 && i % 3 == 0) {
          formattedReversed += ',';
        }
        formattedReversed += reversed[i];
      }


      String finalText = formattedReversed.split('').reversed.join('');

      if (parts.length>1) {
        String decimalPart = parts[1].substring(0, parts[1].length > 2 ? 2 : parts[1].length);
        finalText += '.$decimalPart';
      }
    _amountController.value = TextEditingValue(
      text: finalText,
      selection: TextSelection.collapsed(offset: finalText.length),
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
