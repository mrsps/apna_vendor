import 'package:av/dao/userStore.dart';
import 'package:av/models/appuser/appuser.dart';
import 'package:av/helpers/randomIdMaker.dart';
import 'package:av/helpers/sharedPreferences.dart';
import 'package:av/screens/dashboard/dashboard.dart';
import 'package:av/screens/authentication/login.dart';
import 'package:av/screens/authentication/otp_details.dart';
import 'package:av/screens/authentication/pin_login.dart';
import 'package:av/screens/authentication/signup_login.dart';
import 'package:av/widgets/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuth with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Initiated after checking user registered or not
  late bool registered;
  late String currentUserId;

  // Initiated when otp is generated
  late String verifyId;
  late int resendOtpToken;

  // Initiated after authentication in case of registered user
  // Or after getting details from the signup flow
  late AppUser currentUser;

  // Checks if phone registered or not
  Future<void> checkIfPhoneInUse(String phone, BuildContext context) async {
    try {
      String? userId = await UserStore().getUserIdByPhone(phone);
      if (userId != null) {
        // If registered
        registered = true;
        currentUserId = userId;
        Navigator.push(context, MaterialPageRoute(builder: (context) => PinLoginScreen(phone: phone)));
      } else {
        // If not registered
        registered = false;
        currentUserId = await getRandomID('AppUser');
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpLoginScreen(phone: phone)));
      }
    } catch (error) {
      throw (error);
    }
  }

  // Authentication function for an appUser
  Future<String?> login(String phone, String pin, BuildContext context) async {
    try {
      if (registered) {
        // Initiated for registered user
        currentUser = (await UserStore().getUser(currentUserId))!;
        if (currentUser.userPin != pin) return 'Wrong Pin';
      } else {
        // Initiated for a new user
        await UserStore().setUser(currentUser);
      }
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.of(context).popAndPushNamed(DashboardScreen.id);
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (error) {
      throw error;
    }
  }

  // Setting the currentUser
  Future<void> setCurrentUser(AppUser appUser) async {
    currentUser = appUser;
    try {
      await UserStore().setUser(appUser);
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  // First time otp generating function
  Future<void> sendOtpAuth(String phone, String pin, String name, UserRole userRole, BuildContext context) async {
    // Initializing currentUser for a new user flow
    currentUser = AppUser(userId: currentUserId, userPhone: phone, userName: name, userPin: pin, userRole: userRole);
    Navigator.push(context, MaterialPageRoute(builder: (context) => OtpDetailsScreen(phone: phone)));
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // After completion of verification user is signed in and onboarded
        await auth.signInWithCredential(credential);
        onBoard(context);
      },
      verificationFailed: (FirebaseAuthException e) {
        // In case otp verification failed
        showSnack(e.code, context);
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Tokens needed to verify the manually entered code and resend the code
        verifyId = verificationId;
        resendOtpToken = resendToken!;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // Manually entered otp code authentication function
  Future<void> otpAuth(String otp, BuildContext context) async {
    try {
      PhoneAuthCredential credential = await PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
      await auth.signInWithCredential(credential);
      // On boarding of the user
      await onBoard(context);
    } on FirebaseAuthException catch (e) {
      // In case otp verification failed
      showSnack(e.code, context);
    }
  }

  // Resend otp generating function
  Future<void> resendOtpAuth(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + currentUser.userPhone!,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // After completion of verification user is signed in and onboarded
          await auth.signInWithCredential(credential);
          onBoard(context);
        },
        verificationFailed: (FirebaseAuthException e) {
          // In case otp verification failed
          showSnack(e.code, context);
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Tokens needed to verify the manually entered code and resend the code
          verifyId = verificationId;
          resendOtpToken = resendToken!;
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        forceResendingToken: resendOtpToken);
  }

  Future<void> onBoard(BuildContext context) async {
    if (registered) {
      // If registered user came through sign up flow
      // User forgets the pin, thus resetting it
      String newPin = currentUser.userPin!;
      String newName = currentUser.userName!;
      currentUser = (await UserStore().getUser(currentUserId))!;
      await setCurrentUser(currentUser.copyWith(userPin: newPin).copyWith(userName: newName));
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.of(context).popAndPushNamed(DashboardScreen.id);
    } else {
      // For new user
      await login(currentUser.userPhone!, currentUser.userPin!, context);
    }
  }

  // Function to logout
  Future<void> signOut(BuildContext context) async {
    try {
      await SharedCache().logout();
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.popAndPushNamed(context, LoginScreen.id);
    } catch (error) {
      throw error;
    }
  }
}
