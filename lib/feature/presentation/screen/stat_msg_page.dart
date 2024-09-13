import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chattick/core/colors.dart';
import 'package:chattick/core/textstyle.dart';
import 'package:chattick/core/media_query.dart';
import 'package:chattick/feature/presentation/widget/elevated_button.dart';
import 'package:chattick/feature/presentation/screen/phone_numberpage.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:rive/rive.dart';

import '../../../config/access_firebase_token.dart';

class StartMsgPage extends StatelessWidget {
  const StartMsgPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloure().BackGround,
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
                    SizedBox(
                      height: isPortrait
                          ? MediaQueryUtil.heightPercentage(context, 30)
                          : MediaQueryUtil.heightPercentage(context, 30),
                      child:  RiveAnimation.asset(
                        'asset/animation/untitled.riv',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: isPortrait
                          ? MediaQueryUtil.heightPercentage(context, 5)
                          : MediaQueryUtil.heightPercentage(context, 2),
                    ),
                    Text(
                      'Connect easily with your family and friends over countries',
                      textAlign: TextAlign.center,
                      style: style().TheBigHead(context),
                    ),
                    SizedBox(
                      height: isPortrait
                          ? MediaQueryUtil.heightPercentage(context, 16)
                          : MediaQueryUtil.heightPercentage(context, 8),
                    ),
                    TextButton(
                      onPressed: () {
                      },
                      child: Text(
                        'Terms & Privacy Policy',
                        style: style().TheSmallHead(context),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: CustomButton(
                          text: "Continue",
                          onPressed: ()async {
                            // AccessToken accessetokengetter = AccessToken();
                            AccessTokenFirebase tokenFetcher = AccessTokenFirebase();
                            String token = await tokenFetcher.getAccessToke();
                            print("Access Token: $token");
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneNumberPage()));
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
