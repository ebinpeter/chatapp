import 'package:flutter/material.dart';
import 'package:chattick/feature/presentation/widget/textfeild.dart';
import 'package:flutter/services.dart';
import '../../../core/colors.dart';
import '../../../core/media_query.dart';
import '../widget/elevated_button.dart';
import 'contact.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();

class _DetailsPageState extends State<DetailsPage> {
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
      appBar: AppBar(
        backgroundColor: Coloure().BackGround,
        title: Text('Your Profile',),
        automaticallyImplyLeading: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon:Icon(Icons.arrow_back)),
      ),
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
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: isPortrait ? 50 : 40,
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              Icons.person,
                              size: isPortrait ? 50 : 40,
                              color: Colors.black54,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 24,
                              width: 24,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQueryUtil.heightPercentage(context, isPortrait ? 5 : 3)),
                    CustomTextField(
                      labelText: "First Name",
                      controller: firstNameController,
                      isRequired: true,
                      height: MediaQueryUtil.heightPercentage(context, isPortrait ? 8 : 16),
                      width: MediaQueryUtil.widthPercentage(context, isPortrait ? 90 : 70),
                    ),
                    SizedBox(height: MediaQueryUtil.heightPercentage(context, isPortrait ? 3 : 2)),
                    CustomTextField(
                      labelText: "Last Name",
                      controller: lastNameController,
                      isRequired: false,
                      height: MediaQueryUtil.heightPercentage(context, isPortrait ? 8 : 16),
                      width: MediaQueryUtil.widthPercentage(context, isPortrait ? 90 : 70),
                    ),
                    SizedBox(
                      height: MediaQueryUtil.heightPercentage(context, isPortrait ? 35 : 18),
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
                              MaterialPageRoute(builder: (context) => ContactsList()),
                            );
                          },
                        ),
                      ),
                    )
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
