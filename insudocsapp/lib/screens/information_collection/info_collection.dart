import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insudox_app/classes/file_model.dart';
import 'package:insudox_app/common_widgets/backgrounds/bigOneSmallOneBg.dart';
import 'package:insudox_app/common_widgets/formfields.dart';
import 'package:insudox_app/enums/insurance_enums.dart';
import 'package:insudox_app/screens/main_page.dart';
import 'package:insudox_app/services/Firebase/firestore/firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class InformationCollection extends StatefulWidget {
  const InformationCollection({Key? key}) : super(key: key);

  @override
  State<InformationCollection> createState() => _InformationCollectionState();
}

class _InformationCollectionState extends State<InformationCollection> {
  final TextEditingController insuranceTypeController = TextEditingController();
  final TextEditingController claimTrackController = TextEditingController();
  final TextEditingController insuranceCompanyNameController =
      TextEditingController();
  final TextEditingController extraQueriesController = TextEditingController();

  final List<FileDetails> uploadedFiles = [];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyBoardOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;
    final List<double> tempDimensions = [
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height
    ];
    final double screenHeight = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[0]
        : tempDimensions[1];
    final double screenWidth = tempDimensions[0] > tempDimensions[1]
        ? tempDimensions[1]
        : tempDimensions[0];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: (!isLoading && !isKeyBoardOpen)
          ? SizedBox(
              width: screenWidth * 0.9,
              height: screenHeight * 0.06,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff615793),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenHeight * 0.01),
                  ),
                ),
                onPressed: () async {
                  if (insuranceTypeController.text == "" ||
                      claimTrackController.text == "" ||
                      insuranceCompanyNameController.text == "" ||
                      extraQueriesController.text == "") {
                    return;
                  }
                  isLoading = true;
                  setState(() {});
                  List<String> uploadedFileUrls = [];
                  // Upload files from uploadedFiles list to Firebase Storage
                  for (int i = 0; i < uploadedFiles.length; i++) {
                    Reference firebaseStorageRef = FirebaseStorage.instance
                        .ref()
                        .child('client/uploads/${uploadedFiles[i].fileName}');
                    UploadTask uploadTask = firebaseStorageRef
                        .putFile(File(uploadedFiles[i].filePath));
                    final taskSnapshot =
                        await uploadTask.whenComplete(() => null);
                    await taskSnapshot.ref.getDownloadURL().then(
                          (value) => uploadedFileUrls.add(value),
                        );
                    print(uploadedFileUrls);
                  }

                  await userDocumentReference()
                      .collection("data")
                      .doc("userInfo")
                      .set({
                    "insuranceType": insuranceTypeController.text,
                    "claimTrack": claimTrackController.text,
                    "insuranceCompanyName": insuranceCompanyNameController.text,
                    "extraQueries": extraQueriesController.text,
                    "uploadedFilesUrl": uploadedFileUrls,
                  });
                  await userDocumentReference().collection("policies").add({
                    "insuranceType": insuranceTypeController.text,
                    "claimTrack": claimTrackController.text,
                    "insuranceCompanyName": insuranceCompanyNameController.text,
                    "extraQueries": extraQueriesController.text,
                    "uploadedFilesUrl": uploadedFileUrls,
                  });
                  await userDocumentReference().update({
                    "formFilled": true,
                  });

                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "NEXT",
                      style: TextStyle(
                        fontFamily: 'Cabin',
                        fontSize: screenWidth * 0.06,
                        color: const Color(0xffA5A5BA),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.28),
                      child: Icon(
                        CupertinoIcons.arrow_right,
                        color: const Color(0xffA5A5BA),
                        size: screenWidth * 0.07,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: (!isLoading)
          ? Container(
              height: screenHeight,
              width: screenWidth,
              color: Colors.white,
              child: Stack(
                children: [
                  Positioned(
                    height: screenHeight,
                    width: screenWidth,
                    child: const BigOneSmallOneBG(),
                  ),
                  Positioned(
                    top: 0,
                    width: screenWidth,
                    bottom: 0,
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.007),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Text(
                                  "BACK",
                                  style: TextStyle(
                                    fontFamily: "Cabin",
                                    fontSize: screenWidth * 0.06,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff615793),
                                  ),
                                ),
                              ),
                            ),
                            Image.asset(
                              'assets/images/post_login_images/studentPLInfoCollect.png',
                              width: screenWidth * 0.7,
                              fit: BoxFit.fitWidth,
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.05),
                              child: Text(
                                "Please help us in assisting you with your filing by providing us with these details:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "DM Sans",
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification: (overscroll) {
                                overscroll.disallowIndicator();
                                return true;
                              },
                              child: Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Form(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: CustomDropDownField(
                                                items: InsuranceType.values
                                                    .map((e) => e.data)
                                                    .toList(),
                                                selectedItem:
                                                    insuranceTypeController,
                                                hintText:
                                                    "Which insurance claim do you have?",
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: CustomDropDownField(
                                                items: InsuranceStatus.values
                                                    .map((e) => e.data)
                                                    .toList()
                                                    .sublist(0, 2),
                                                selectedItem:
                                                    claimTrackController,
                                                hintText:
                                                    "Do you wish to claim or track its status?",
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: normalformfield(
                                                  insuranceCompanyNameController,
                                                  screenWidth,
                                                  setState,
                                                  "Name of the insurance company",
                                                  TextInputType.name),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: Text(
                                                "Please upload your documents related to the insurance and your claim",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.05,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.005),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xff615793),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            screenHeight *
                                                                0.01),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  final FilePickerResult?
                                                      result = await FilePicker
                                                          .platform
                                                          .pickFiles(
                                                    type: FileType.custom,
                                                    allowedExtensions: [
                                                      'pdf',
                                                      'doc',
                                                      'docx',
                                                      'jpg',
                                                      'png',
                                                      'jpeg'
                                                    ],
                                                  );
                                                  if (result != null) {
                                                    final PlatformFile file =
                                                        result.files.first;
                                                    final String fileName =
                                                        file.name;
                                                    final String? filePath =
                                                        file.path;
                                                    final String fileExtension =
                                                        fileName
                                                            .split(".")
                                                            .last;
                                                    setState(() {
                                                      uploadedFiles.add(
                                                        FileDetails(
                                                          fileName: fileName,
                                                          filePath: filePath!,
                                                          fileExtension:
                                                              fileExtension,
                                                        ),
                                                      );
                                                    });
                                                  }
                                                },
                                                child: Text(
                                                  "UPLOAD",
                                                  style: TextStyle(
                                                    fontFamily: 'Cabin',
                                                    fontSize:
                                                        screenWidth * 0.06,
                                                    color:
                                                        const Color(0xffA5A5BA),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: Column(
                                                children: uploadedFiles
                                                    .map(
                                                      (file) => Padding(
                                                        padding: EdgeInsets.only(
                                                            top: screenHeight *
                                                                0.01),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                file.fileName,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "DM Sans",
                                                                  fontSize:
                                                                      screenWidth *
                                                                          0.04,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                setState(() {
                                                                  uploadedFiles
                                                                      .remove(
                                                                          file);
                                                                });
                                                              },
                                                              style:
                                                                  ButtonStyle(
                                                                overlayColor:
                                                                    MaterialStateProperty
                                                                        .all(Colors
                                                                            .transparent),
                                                              ),
                                                              child: Text(
                                                                "REMOVE",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Cabin",
                                                                  fontSize:
                                                                      screenWidth *
                                                                          0.06,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: const Color(
                                                                      0xff615793),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.02),
                                              child: mutliLineTestFormField(
                                                  extraQueriesController,
                                                  "Please write any extra queries you have",
                                                  screenWidth,
                                                  8),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
