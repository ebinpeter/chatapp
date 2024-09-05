import 'package:chattick/feature/presentation/screen/details_page.dart';
import 'package:chattick/feature/presentation/screen/phone_numberpage.dart';
import 'package:chattick/feature/presentation/screen/stat_msg_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import '../../../core/colors.dart';
import '../../../core/media_query.dart';
import '../../../core/textstyle.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String _otpCode = '';
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
      appBar: AppBar(
        backgroundColor: Coloure().BackGround,
        automaticallyImplyLeading: true,
      ),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: isPortrait
                          ? MediaQueryUtil.heightPercentage(context, 10)
                          : MediaQueryUtil.heightPercentage(context, 5),
                    ),
                    Text(
                      "Enter Code",
                      style: style().TheBigHead(context),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: isPortrait
                          ? MediaQueryUtil.heightPercentage(context, 2)
                          : MediaQueryUtil.heightPercentage(context, 1),
                    ),
                    Text(
                      "We have sent you an SMS with the code to +91 55555 55555",
                      style: style().TheSmallHead(context),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: isPortrait
                          ? MediaQueryUtil.heightPercentage(context, 5)
                          : MediaQueryUtil.heightPercentage(context, 3),
                    ),
                    _buildOtpInput(),
                    SizedBox(
                      height: isPortrait
                          ? MediaQueryUtil.heightPercentage(context, 5)
                          : MediaQueryUtil.heightPercentage(context, 3),
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

  Widget _buildOtpInput() {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: style().TheBigHead(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Coloure().BigHead,
        ),
      ),
    );

    return Center(
      child: Pinput(
        length: 6,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Coloure().BigHead,
            ),
          ),
        ),
        onChanged: (value) {
          _otpCode = value;
        },
        onCompleted: (pin) {
          _otpCode = pin;

          // _navigateToNextPage();
        },
      ),
    );
  }

  void _navigateToNextPage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => DetailsPage(), // Replace with your target page
      ),
    );
  }
}
