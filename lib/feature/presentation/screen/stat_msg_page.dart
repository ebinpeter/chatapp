import 'package:flutter/material.dart';
import 'package:chattick/core/colors.dart';
import 'package:chattick/core/textstyle.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../core/media_query.dart';
import '../widget/elevated_button.dart';
import 'otp_page.dart';

class StatMsgPage extends StatefulWidget {
  const StatMsgPage({super.key});

  @override
  State<StatMsgPage> createState() => _StatMsgPageState();
}

class _StatMsgPageState extends State<StatMsgPage> {
  @override
  void initState() {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Coloure().BackGround,
      statusBarIconBrightness: Brightness.dark,
    ));

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloure().BackGround,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isPortrait = constraints.maxHeight > constraints.maxWidth;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                  isPortrait
                      ? MediaQueryUtil.widthPercentage(context, 4)
                      : MediaQueryUtil.widthPercentage(context, 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: isPortrait
                          ? MediaQueryUtil.heightPercentage(context, 10)
                          : MediaQueryUtil.heightPercentage(context, 5),
                    ),
                    Text(
                      "Enter Your Phone Number",
                      style: style().TheBigHead(context),
                    ),
                    SizedBox(
                      height: isPortrait
                          ? MediaQueryUtil.heightPercentage(context, 2)
                          : MediaQueryUtil.heightPercentage(context, 1),
                    ),
                    Text(
                      "Please confirm your country code and enter your phone number",
                      style: style().TheSmallHead(context),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: isPortrait
                          ? MediaQueryUtil.heightPercentage(context, 5)
                          : MediaQueryUtil.heightPercentage(context, 3),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        dialogBackgroundColor: Colors.red,
                      ),
                      child: Container(
                        color: Color(0xFFF7F7FC), // Background color for the container
                        child: InternationalPhoneNumberInput(
                          autoFocusSearch: true,
                          onInputChanged: (number) {
                            // Handle input change
                          },
                          onInputValidated: (bool value) {
                            print(value);
                          },
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            useBottomSheetSafeArea: true,
                            trailingSpace: true,
                            setSelectorButtonAsPrefixIcon: true,
                            useEmoji: true,
                            leadingPadding: 10.0,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle: style().FeildInput(context),
                          initialValue: PhoneNumber(isoCode: 'US'), // Replace with your initial value
                          formatInput: true,
                          cursorColor: Coloure().SmalHead,
                          textStyle: style().FeildInput(context),
                          inputDecoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: style().FeildInput(context),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 62, 63, 62),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(4.0), // Radius of 4
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(4.0), // Radius of 4
                            ),
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                          ),
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          onSaved: (number) {
                            print('On Saved: $number');
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: isPortrait
                          ? MediaQueryUtil.heightPercentage(context, 40)
                          : MediaQueryUtil.heightPercentage(context, 30),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                          text: "Continue",
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OtpPage()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
