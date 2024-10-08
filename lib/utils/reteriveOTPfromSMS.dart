// import 'package:pinput/pinput.dart';
// import 'package:smart_auth/smart_auth.dart';

// class RetrieveOTPFromSMS implements SmsRetriever {
//   RetrieveOTPFromSMS(this.smartAuth);

//   final SmartAuth smartAuth;

//   @override
//   Future<void> dispose() async {
//     await smartAuth.removeSmsListener();
//   }

//   @override
//   Future<String?> getSmsCode() async {
//     final res = await smartAuth.getSmsCode();
//     if (res.succeed && res.codeFound) {
//       return res.code;
//     }
//     return null;
//   }

//   @override
//   bool get listenForMultipleSms => false;
// }
