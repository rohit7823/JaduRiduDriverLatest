import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:jadu_ride_driver/core/common/socket_events.dart';
import 'package:jadu_ride_driver/core/domain/ride_id.dart';
import 'package:jadu_ride_driver/core/domain/ride_initiate_data.dart';
import 'package:jadu_ride_driver/core/repository/ride_navigation_repository.dart';

import '../utills/socket_io.dart';

class RideNavigationRepositoryImpl implements RideNavigationRepository {
  @override
  StreamController<Object> ride(RideId ids) {
    StreamController<Object> sender = StreamController();
    SocketIO.client.on(SocketEvents.rideNavigation.value, (data) {
      debugPrint("rideInitiateData $data");
      sender.add(RideInitiateData.fromJson(data));
    });

    return sender;
  }
}
