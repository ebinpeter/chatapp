import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../core/colors.dart';
import '../../../core/textstyle.dart';
import '../../../core/media_query.dart';
import '../widget/elevated_button.dart';
import 'otp_page.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  PhoneNumber number = PhoneNumber(isoCode: 'IN');

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Coloure().BackGround,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Coloure().BackGround,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Coloure().BackGround,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isPortrait = constraints.maxHeight > constraints.maxWidth;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(
                  MediaQueryUtil.widthPercentage(context, isPortrait ? 4 : 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQueryUtil.heightPercentage(context, isPortrait ? 10 : 5),
                    ),
                    Text(
                      "Enter Your Phone Number",
                      style: style().TheBigHead(context),
                    ),
                    SizedBox(
                      height: MediaQueryUtil.heightPercentage(context, isPortrait ? 2 : 1),
                    ),
                    Text(
                      "Please confirm your country code and enter your phone number",
                      style: style().TheSmallHead(context),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: MediaQueryUtil.heightPercentage(context, isPortrait ? 5 : 3),
                    ),
                    Container(
                      height: MediaQueryUtil.heightPercentage(context, isPortrait ? 8 : 16),
                      width: MediaQueryUtil.widthPercentage(context, isPortrait ? 90 : 70),
                      decoration: BoxDecoration(
                        color: Coloure().FeildColor,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.all( MediaQueryUtil.heightPercentage(context, isPortrait ? 1 : 0),),
                      child: InternationalPhoneNumberInput(
                        autoFocusSearch: true,
                        onInputChanged: (number) {
                          // Handle input change
                        },
                        onInputValidated: (bool value) {
                          print("-----------------$value");
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
                        initialValue: number,
                        formatInput: true,
                        cursorColor: Coloure().SmalHead,
                        textStyle: style().FeildInput(context),
                        inputDecoration: InputDecoration(
                          filled: true,
                          fillColor: Coloure().FeildColor,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Phone Number',
                          hintStyle: style().FeildInput(context),
                        ),
                        keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                        onSaved: (number) {
                          print('On Saved: $number');
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQueryUtil.heightPercentage(context, isPortrait ? 38 : 18),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OtpPage()),
                            );
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
