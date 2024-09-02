import 'package:flutter/material.dart';
import 'package:chattick/feature/presentation/widget/textfeild.dart';
import '../../../core/colors.dart';
import '../../../core/media_query.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

final TextEditingController firstNameController = TextEditingController();
final TextEditingController lastNameController = TextEditingController();

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Coloure().BackGround,
      appBar: AppBar(
        backgroundColor: Coloure().BackGround,
        title: Text('Your Profile'),
        automaticallyImplyLeading: true,

        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     // Navigator.pop(context); // Navigate back to the previous screen
        //   },
        // ),
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
