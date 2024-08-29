import 'package:chattick/core/colors.dart';
import 'package:chattick/core/textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../widget/elevated_button.dart';


class StatMsgPage extends StatefulWidget {
  const StatMsgPage({super.key});

  @override
  State<StatMsgPage> createState() => _StatMsgPageState();
}

class _StatMsgPageState extends State<StatMsgPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloure().BackGround,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
             Text(
              "Enter Your Phone Number",
              style:style().TheBigHead(context)
            ),
            const SizedBox(height: 8),
             Text(
              "Please confirm your country code and enter your phone number",
              style: style().TheSmallHead(context),textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Theme(
              data: Theme.of(context).copyWith(
                dialogBackgroundColor: Colors.red,
              ),
              child: Container(
                color: const Color(0xFFF7F7FC), // Background color for the container
                child: InternationalPhoneNumberInput(
                  autoFocusSearch: true,
                  onInputChanged: (number) {
                    // Handle the change
                  },
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DROPDOWN, // Use dropdown to display the country code separately
                    setSelectorButtonAsPrefixIcon: false, // Avoid prefixing the code in the input field
                    leadingPadding: 10.0, // Padding between dropdown and input field
                    trailingSpace: false, // Adds space after the country code selector
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle: style().FeildInput(context), // Custom style for the country code selector
                  initialValue: PhoneNumber(isoCode: 'US'), // Replace with your initial value
                  formatInput: true,
                  cursorColor: Coloure().SmalHead,
                  textStyle: style().FeildInput(context),
                  inputDecoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: style().FeildInput(context),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: const Color.fromARGB(255, 62, 63, 62),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0), // Radius of 4
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        // color: ().greenColour,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(4.0), // Radius of 4
                    ),
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                  onSaved: (number) {
                    print('On Saved: $number');
                  },
                ),
              ),
            ),

            const SizedBox(height: 40),
            Center(
              child: CustomButton(
                text: "Continue",
                onPressed: () {
                  print("Continue Button Pressed");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
