import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:insudox_app/common_widgets/customPageRouter.dart';
import 'package:insudox_app/screens/information_collection/have_insurance.dart';
// import 'package:lottie/lottie.dart';
import 'package:insudox_app/globals.dart';
import 'package:insudox_app/services/Firebase/fireauth/fireauth.dart';
import 'package:insudox_app/services/Firebase/firestore/firestore.dart';
import 'package:insudox_app/services/Firebase/push_notification/push_notification_service.dart';

class Splash extends StatefulWidget {
  /// Loading/Buffering screen when app intially starts and initializes.
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  /// This method is used to check the current status of the app authentication and redirect accrodingly.
  void check() async {
    if (checkLoggedIn()) {
      if (await checkFormFilled()) {
        String id = await userDocumentReference().get().then((value) =>
            value.data()!['role'] + value.data()!['question'].toString());
        PushNotificationService.registerCustomNotificationListeners(
            id: id, title: id, description: id);
        await Navigator.pushNamedAndRemoveUntil(
            context, '/main', (route) => false);
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) async {
          // wait for a 2 sec duration
          await Future.delayed(const Duration(seconds: 2));
          await Navigator.of(context)
              .push(CustomPageRouter(child: const HaveInsurance()));
        });
      }
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        // wait for a 2 sec duration
        await Future.delayed(const Duration(seconds: 2));
        await Navigator.pushNamedAndRemoveUntil(
            context, '/wt', (route) => false);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    check();
    // Adds a listener to the animation controller that reads the status.
    // _controller.addStatusListener((status) async {
    //   if (status == AnimationStatus.forward) {
    //     if (isFirst) {
    //       isFirst = false;
    //       await Future.delayed(
    //           const Duration(seconds: 5), () async => await check());
    //     }
    //     return;
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: COLOR_THEME['background'],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: screenWidth * 0.6,
              height: screenHeight * 0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/insudox.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
