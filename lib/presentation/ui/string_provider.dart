import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:jadu_ride_driver/translations_generated_files/locale_keys.g.dart';

class StringProvider {
  static const appUpdate = "Version Update";

  static const appName = "Jadu Ride";

  static var appId = Random.secure().toString();

  static const okay = "Okay";

  static const notYet = "Not yet";

  static const noInternet = "No Internet";

  static const error = "Error";

  static const retry = "Retry";

  static const skip = "Skip";

  static const proceed = "Proceed";

  static const pleaseWait = "Please wait";

  static const register = "Register";

  static const login = "Login";

  static const enterMobileNumber = LocaleKeys.enter_your_phone_number;

  static const enterNumberDescription =
      "This number will be used to contact you and\ncommunicate all ride related details";

  static const mobileNumber = "Mobile Number";

  static const next = "NEXT";

  static const enterOtp = "Enter the OTP sent to\n";

  static const dintRecieveCode = "Didn't receive a code ?\t";

  static const recieveing = "Receiving...";

  static const recieve = "Receive";

  static const verifyNow = "VERIFY NOW";

  static const selectPrefferedLanguage = LocaleKeys.select_preffered_language;

  static const languageChangedSuccessfully =
      LocaleKeys.language_changed_successfully;

  static const welcomeToJaduRide =
      "Welcome new Jadu Ride\nPartner! Drive forward.";

  static const pleaseEnterPartnerDetails = "Please enter the partner details";

  static const continuee = "CONTINUE";

  static const enterYourName = "Your name";

  static const enterYourEmail = "Your email";

  static const notItems = "No items";

  static const referralCode = "Referral code";

  static const agreeToJaduRideTermsAndCondition =
      "Agree to Jadu Ride Terms & Conditions";

  static const thisFieldIsMandatory = "*This field is mandatory.";

  static const addYourVehicle = "Add your vehicle\nto Continue";

  static const pleaseEnterTheRequiredField =
      "Please enter the required details";

  static const vehicleNumber = "Vehicle Number";

  static const welcome = "Welcome";

  static const pleaseCompleteRequied =
      "Please complete the require steps and start\ndriving with Jadu Ride.";

  static const criticalError = "Critical Error";

  static const weAreFacingSomeError =
      "We are facing some error in our backend please retry. Sorry for this inconvenience.";

  static const indentifyDetails = "Identify Details";

  static const profilePicture = "Profile Picture";

  static const driverLicense = "Driver License";

  static const aadharCard = "Aadhar Card";

  static const vehicleInsurance = "Vehicle Insurance";

  static const registrationCertificate = "Registration Certificate (RC)";

  static const panCard = "Pan Card";

  static const vehiclePermit = "Vehicle Permit";

  static const vehicleAudit = "Vehicle Audit";

  static const paymentDetails = "Payment Details";

  static var necessarySteps = "Necessary Steps";

  static var optionalSteps = "Optional Steps";

  static var setting = "Setting";

  static var profileSetting = "Profile Setting";

  static const youHaveToCompleteRequiredFields =
      "You have to complete necessary steps to continue.";

  static var cancelOrReset = "Cancel & Reset";

  static var done = "Done";

  static var selectOrChoosePicture = "Select/Choose Picture";

  static var imageChooseGuidLine = "Image upload guideline 1";

  static var imageChooseGuidLine2 = "Image upload guideline 2";

  static var chooseImage = "Choose Image";

  static var camera = "Camera";

  static var gallery = "Gallery";

  static var crop = "Crop";

  static var pleaseEnterDrivingLicenseNumber =
      "Please Enter Driving License Number";

  static var driverLicenseNumber = "Driver License Number";

  static var reEnterDriverLicenseNumber = "Re-Enter Driver License number";

  static var dateOfBirth = "Date of Birth";

  static var uploadDriverLicense = "Upload Driver License";

  StringProvider._();

  static const appVersion = "AppVersion";
}