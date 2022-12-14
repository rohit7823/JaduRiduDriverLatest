import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jadu_ride_driver/core/common/app_route.dart';
import 'package:jadu_ride_driver/core/common/bottom_menus.dart';
import 'package:jadu_ride_driver/core/common/dialog_state.dart';
import 'package:jadu_ride_driver/core/common/screen_wtih_extras.dart';
import 'package:jadu_ride_driver/helpers_impls/my_dialog_impl.dart';
import 'package:jadu_ride_driver/presentation/app_navigation/change_screen.dart';
import 'package:jadu_ride_driver/presentation/app_navigation/dashboard_nav.dart';
import 'package:jadu_ride_driver/presentation/stores/driver_bookings_store.dart';
import 'package:jadu_ride_driver/presentation/stores/shared_store.dart';
import 'package:jadu_ride_driver/presentation/ui/string_provider.dart';
import 'package:jadu_ride_driver/utills/dialog_controller.dart';
import 'package:jadu_ride_driver/utills/extensions.dart';
import 'package:mobx/mobx.dart';

import '../ui/theme.dart';

class DashboardScreen extends StatefulWidget {
  final SharedStore sharedStore;

  const DashboardScreen({Key? key, required this.sharedStore})
      : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver {
  late final List<ReactionDisposer> _disposers;
  late final DialogController _dialogController;
  late final GlobalKey<NavigatorState> dashBoardNavigator;
  late final ChangeScreen changeScreen;

  @override
  void initState() {
    widget.sharedStore.locationStatus();
    widget.sharedStore.driverBookings = DriverBookingStore();
    dashBoardNavigator = GlobalKey<NavigatorState>();
    changeScreen = ChangeScreen(dashBoardNavigator);
    _dialogController =
        DialogController(dialog: MyDialogImpl(buildContext: context));
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _disposers = [
      reaction((p0) => widget.sharedStore.dialogManager.currentState, (p0) {
        if (p0 is DialogState && p0 == DialogState.displaying) {
          _dialogController.show(
              widget.sharedStore.dialogManager.data!,
              p0,
              close: widget.sharedStore.dialogManager.closeDialog,
              positive: widget.sharedStore.onAction
          );
        }
      }),
      reaction((p0) => widget.sharedStore.currentChange, (p0) {
        if (p0 != null && p0 is ScreenWithExtras) {
          changeScreen.nestedTo(
              p0.screen,
              option: p0.option,
              onComplete: widget.sharedStore.clear
          );
        }
      })
    ];
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      widget.sharedStore.getDashBoardData();
    }
  }

  @override
  void dispose() {
    for (var element in _disposers) {
      element();
    }
    WidgetsBinding.instance.removeObserver(this);
    widget.sharedStore.driverBookings.disposers();
    widget.sharedStore.streamDisposer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Observer(builder: (BuildContext context) {
        return BottomNavigationBar(
            showUnselectedLabels: true,
            onTap: widget.sharedStore.onBottomMenu,
            currentIndex: widget.sharedStore.selectedMenu,
            unselectedFontSize: 10.sp,
            unselectedItemColor: AppColors.Acadia,
            selectedItemColor: AppColors.Amber,
            items: BottomMenus.values.map((menu) {
              return BottomNavigationBarItem(
                  tooltip: menu.name,
                  label: menu.name,
                  icon: SvgPicture.asset(menu.icon, color: AppColors.Gray),
                  activeIcon:
                      SvgPicture.asset(menu.icon, color: AppColors.Amber));
            }).toList());
      }),
      body: Navigator(
        initialRoute: AppRoute.duty,
        key: dashBoardNavigator,
        onGenerateRoute: (setting) {
          return DashboardNav.getRoutes(setting, widget.sharedStore);
        },
      ),
    );
  }
}
