import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insudox/globals.dart';
import 'package:insudox/services/Firebase/notifications/send_notifications.dart';
import 'package:insudox/src/classes/insurance_enums.dart';
import 'package:insudox/src/classes/notification_model.dart';
import 'package:insudox/src/main/components/default.dart';

import 'package:insudox/src/main/components/search_fields.dart';
import 'package:insudox/src/main/tabs/notifications/notifications_page.dart';

class NotificationSendCard extends StatefulWidget {
  const NotificationSendCard({super.key});

  @override
  State<NotificationSendCard> createState() => _NotificationSendCardState();
}

class _NotificationSendCardState extends State<NotificationSendCard> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  ValueNotifier<int> optionValue = ValueNotifier<int>(0);

  void onAttach() {}

  Future<void> onPressSendNotification() async {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      return;
    }

    late NotificationModel notification;

    if (optionValue.value == 0) {
      notification = NotificationModel(
        sendTo: Filters.values[optionValue.value].name,
        title: _titleController.text,
        body: _descriptionController.text,
        isTopic: true,
      );
      // send to all
    } else {
      notification = NotificationModel(
        sendTo: Filters.values[optionValue.value].name,
        title: _titleController.text,
        body: _descriptionController.text,
        isTopic: true,
      );
    }
    // send to selected
    await sendNotification(notification: notification);

    _titleController.text = "";
    _descriptionController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.75,
      decoration: BoxDecoration(
        color: GlobalColor.notificationBg,
        borderRadius: BorderRadius.circular(screenHeight / 50),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.0075,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                cardTitle(
                    screenHeight: screenHeight,
                    title: 'Send a common notification to : '),
                SizedBox(
                  width: screenWidth * 0.1,
                  child: SearchDropDownFilter(
                    height: screenHeight * 0.05,
                    width: screenWidth,
                    items: Filters.values.map((e) => e.data).toList(),
                    optionValue: optionValue,
                    onChanged: (value) {
                      optionValue.value = value;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                formTitle(screenHeight: screenHeight, title: 'Title : '),
                SizedBox(
                  width: screenWidth * 0.5,
                  child: formField(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      hint: 'Enter title',
                      controller: _titleController,
                      validator: (a) {
                        return "";
                      },
                      setState: setState,
                      errorText: ""),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                formTitle(screenHeight: screenHeight, title: 'Description : '),
                SizedBox(
                  width: screenWidth * 0.5,
                  child: formField(
                      lines: 3,
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      hint: 'Enter description',
                      controller: _descriptionController,
                      validator: (validator) {
                        return "";
                      },
                      setState: setState,
                      errorText: ""),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: formButton(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                onAttach: onAttach,
                onPressed: onPressSendNotification,
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Common form field
Widget formField({
  required double screenWidth,
  required double screenHeight,
  required String hint,
  required TextEditingController controller,
  required String Function(String?)? validator,
  required Function setState,
  required String? errorText,
  int? lines,
}) {
  return Container(
    child: TextFormField(
      minLines: lines ?? 1,
      maxLines: lines ?? 1,
      style: TextStyle(
        fontSize: screenHeight * 0.02,
        fontFamily: 'DM Sans',
        color: Colors.black,
      ),
      controller: controller,
      onChanged: (value) {
        setState(() {});
      },
      validator: validator,
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: screenHeight * 0.02,
          fontFamily: 'DM Sans',
          color: Colors.grey.shade400,
        ),
        filled: true,
        fillColor: Colors.white,
        errorText: errorText == '' ? null : errorText,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          gapPadding: 1,
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenHeight / 80),
        ),
        errorBorder: OutlineInputBorder(
          gapPadding: 1,
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenHeight / 80),
        ),
        focusedErrorBorder: OutlineInputBorder(
          gapPadding: 1,
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenHeight / 80),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 1,
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(screenHeight / 80),
        ),
      ),
    ),
  );
}

Widget formTitle({required double screenHeight, required String title}) {
  return Container(
    child: Text(
      title,
      style: TextStyle(
        fontSize: screenHeight * 0.021,
        fontFamily: 'DM Sans',
        color: GlobalColor.primary,
      ),
    ),
  );
}

Widget cardTitle({required double screenHeight, required String title}) {
  return Container(
    child: Text(
      title,
      style: TextStyle(
        fontSize: screenHeight * 0.0225,
        fontFamily: 'DM Sans',
        color: GlobalColor.secondary,
      ),
    ),
  );
}

Widget formButton({
  required double screenWidth,
  required double screenHeight,
  required Function onPressed,
  required Function onAttach,
}) {
  return Container(
    width: screenWidth * 0.2,
    height: screenHeight * 0.05,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton.icon(
          onPressed: () {
            onAttach();
          },
          icon: const Icon(
            Icons.attach_file_rounded,
            color: GlobalColor.secondary,
          ),
          label: Text(
            "Attach",
            style: TextStyle(
              fontSize: screenHeight * 0.02,
              fontFamily: 'DM Sans',
              color: GlobalColor.secondary,
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(screenWidth / 100),
            backgroundColor: GlobalColor.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenHeight / 100),
            ),
          ),
        ),
        TextButton.icon(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(screenWidth / 100),
              backgroundColor: GlobalColor.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenHeight / 100),
              ),
            ),
            onPressed: () {
              onPressed();
            },
            icon: const Icon(
              Icons.send_rounded,
              color: GlobalColor.white,
            ),
            label: Text(
              'Send',
              style: TextStyle(
                fontSize: screenHeight * 0.02,
                fontFamily: 'DM Sans',
                color: GlobalColor.white,
              ),
            ))
      ],
    ),
  );
}
