import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/Screen/Log%20In/login.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  var verificationId = ''.obs;

  // Observable variable for loading state

  // Get the current user
  User? get user => _auth.currentUser;

  // Login method
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // Get.offAll(() => Homepage()); // Navigate to HomePage after login
    } catch (e) {
      Get.snackbar(
        "Login Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Registration method
  Future<void> register(String name, String email, String password) async {
    // if(password!= null && namecontroller.text!=""&& mailController.text!="")
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //Get.offAll(() => Homepage()); // Navigate to HomePage after signup
    } catch (e) {
      Get.snackbar(
        "Registration Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Logout method
  Future<void> logout() async {
    await _auth.signOut();
    Get.offAll(() => Login()); // Navigate back to LoginPage after logout
  }

  // ✅ Forgot Password Function
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Password Reset",
        "Check your email to reset your password",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Method to send OTP via phone
  Future<void> sendOTP(String phoneNumber) async {
    try {
      isLoading.value = true;
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Sign in automatically if verification is completed
          await _auth.signInWithCredential(credential);

          //page not final
          // Get.offAll(() => Sendotp());
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar(
            "Verification Failed",
            e.message ?? "Something went wrong.",
          );
        },
        codeSent: (String verId, int? resendToken) {
          verificationId.value = verId; // Store the verification ID
          Get.snackbar("OTP Sent", "OTP has been sent to your phone.");
        },
        codeAutoRetrievalTimeout: (String verId) {
          verificationId.value = verId;
        },
      );
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Method to verify OTP
  Future<void> verifyOTP(String otp) async {
    try {
      isLoading.value = true;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: otp,
      );
      await _auth.signInWithCredential(credential);
      // Get.offAll(() => VerifyOTP(phoneNumber: ''));
    } catch (e) {
      Get.snackbar("OTP Verification Failed", "The OTP is invalid or expired.");
    } finally {
      isLoading.value = false;
    }
  }
}
