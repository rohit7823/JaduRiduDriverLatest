import 'package:flutter/material.dart';
import 'package:jadu_ride_driver/core/common/alert_action.dart';
import 'package:jadu_ride_driver/core/common/alert_data.dart';
import 'package:jadu_ride_driver/core/common/alert_option.dart';
import 'package:jadu_ride_driver/core/common/navigation_option.dart';
import 'package:jadu_ride_driver/core/common/response.dart';
import 'package:jadu_ride_driver/core/common/screen.dart';
import 'package:jadu_ride_driver/core/common/screen_wtih_extras.dart';
import 'package:jadu_ride_driver/core/common/user_status.dart';
import 'package:jadu_ride_driver/core/helpers/storage.dart';
import 'package:jadu_ride_driver/core/repository/number_input_repository.dart';
import 'package:jadu_ride_driver/modules/app_module.dart';
import 'package:jadu_ride_driver/presentation/stores/navigator.dart';
import 'package:jadu_ride_driver/presentation/ui/string_provider.dart';
import 'package:jadu_ride_driver/utills/dialog_manager.dart';
import 'package:mobx/mobx.dart';

import '../../core/common/alert_behaviour.dart';
import '../../core/repository/verify_otp_repository.dart';

part 'verify_otp_screen_store.g.dart';

class VerifyOtpStore = _VerifyOtpScreenStore with _$VerifyOtpStore;

abstract class _VerifyOtpScreenStore extends AppNavigator with Store {
  final _repository = dependency<VerifyOtpRepository>();
  final _numberInputRepo = dependency<NumberInputRepository>();
  final _storage = dependency<Storage>();
  final dialogManager = DialogManager();

  @observable
  bool reSendingOtpLoader = false;

  @observable
  bool enableBtn = false;

  @observable
  bool sendingLoader = false;

  @observable
  String showSnackbarMsg = "";

  String otp = "";

  String number;

  bool _isValid = false;

  _VerifyOtpScreenStore(this.number);

  @action
  reSendOtp() async {
    reSendingOtpLoader = true;
    var numberCodeId = _storage.numberCode();
    var response = await _numberInputRepo.sendOtp(number, numberCodeId);
    if (response is Success) {
      var data = response.data;
      reSendingOtpLoader = false;
      switch (data != null && data.status) {
        case true:
          if (data!.status) {
            showSnackbarMsg = data.message;
          } else {
            dialogManager.initErrorData(AlertData(
                StringProvider.error,
                null,
                StringProvider.appId,
                data.message,
                StringProvider.retry,
                null,
                null,
                AlertBehaviour(
                    option: AlertOption.none, action: AlertAction.none)));
          }
      }
    } else if (response is Error) {
      reSendingOtpLoader = false;
      dialogManager.initErrorData(AlertData(
          StringProvider.error,
          null,
          StringProvider.appId,
          response.message ?? "",
          StringProvider.retry,
          null,
          null,
          AlertBehaviour(option: AlertOption.none, action: AlertAction.none)));
    }
  }

  @action
  verify() async {
    sendingLoader = true;
    var response = await _repository.verifyOtp(number, otp);
    if (response is Success) {
      var data = response.data;
      sendingLoader = false;
      switch (data != null && data.status) {
        case true:
          if (data!.isVerified) {
            _storage.saveUserId(data.userId);

            if (data.userStatus == UserStatus.registered.value) {
              onChange(ScreenWithExtras(
                  screen: Screen.dashBoard,
                  option: NavigationOption(option: Option.popPrevious)));
            } else {
              onChange(ScreenWithExtras(
                  screen: Screen.changeLanguage,
                  option: NavigationOption(option: Option.popPrevious)));
            }
          } else {
            dialogManager.initErrorData(AlertData(
                StringProvider.error,
                null,
                StringProvider.appId,
                data.message,
                StringProvider.retry,
                null,
                null,
                AlertBehaviour(
                    option: AlertOption.none, action: AlertAction.none)));
          }
          break;
        default:
          dialogManager.initErrorData(AlertData(
              StringProvider.error,
              null,
              StringProvider.appId,
              data?.message ?? "",
              StringProvider.retry,
              null,
              null,
              AlertBehaviour(
                  option: AlertOption.none, action: AlertAction.none)));
      }
    } else if (response is Error) {
      sendingLoader = false;
      dialogManager.initErrorData(AlertData(
          StringProvider.error,
          null,
          StringProvider.appId,
          response.message ?? "",
          StringProvider.retry,
          null,
          null,
          AlertBehaviour(option: AlertOption.none, action: AlertAction.none)));
    }
  }

  @action
  otpEntered(String enteredOtp) {
    otp = enteredOtp;
    if (_isValid) {
      enableBtn = true;
    }
  }

  onRetry(AlertAction? action) {
    verify();
  }

  @action
  String? validateOtp(String? otp) {
    if (otp != null) {
      var regEp = RegExp(r"[0-9]{4}");
      enableBtn = regEp.hasMatch(otp);
    }
    return null;
  }
}
