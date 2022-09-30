import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jadu_ride_driver/utills/extensions.dart';

import '../custom_widgets/my_app_bar_without_logo.dart';
import '../stores/refund_policy_view_model.dart';
import '../ui/app_text_style.dart';
import '../ui/string_provider.dart';
import '../ui/theme.dart';

class RefundPolicyScreen extends StatefulWidget {
  const RefundPolicyScreen({Key? key}) : super(key: key);

  @override
  State<RefundPolicyScreen> createState() => _RefundPolicyScreenState();
}

class _RefundPolicyScreenState extends State<RefundPolicyScreen> {

  late final RefundPolicyStore refundPolicyStore;

  @override
  void initState() {
    refundPolicyStore = RefundPolicyStore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarWithOutLogo(),
      body: SafeArea(
        child: Column(
          children: [
            expand(flex: 2, child: _upperSideContent()),
            expand(flex: 8, child: _lowerSideContent())
          ],
        ),
      ),
    );
  }

  Widget _upperSideContent() {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(100.r))),
      child: Align(
        alignment: Alignment.topLeft,
        child: fitBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StringProvider.refundPolicy
                  .text(AppTextStyle.enterNumberStyle),
              StringProvider.accountSummaryDescription
                  .text(AppTextStyle.enterNumberSubHeadingStyle)
            ],
          ).padding(
              insets:
              EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.02.sw)),
        ),
      ),
    );
  }

  Widget _lowerSideContent() {
    return Observer(
      builder: (BuildContext context) {
        if (refundPolicyStore.isLoader) {
          return Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 0.10.sw,
              width: 0.10.sw,
              child: const CircularProgressIndicator(),
            ),
          );
        } else {
          return Padding(
            padding:
            EdgeInsets.symmetric(vertical: 0.05.sw, horizontal: 0.05.sw),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x1a000000),
                            blurRadius: 20,
                            spreadRadius: 0,
                            offset: Offset(0, 10))
                      ]),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 0.05.sw, horizontal: 0.05.sw),
                    child: Column(
                      children: [
                        refundPolicyStore.refundPolicyTxt
                            .text(AppTextStyle.enterNumberSubHeadingStyle)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }
}