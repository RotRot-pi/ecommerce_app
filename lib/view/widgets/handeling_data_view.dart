import 'package:ecommercecourse/core/constants/image_assets.dart';
import 'package:flutter/material.dart';

import 'package:ecommercecourse/core/classes/request_status.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HandelingDataView extends StatelessWidget {
  final RequestStatus requestStatus;
  final Widget child;
  const HandelingDataView({
    super.key,
    required this.requestStatus,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return _handleRequestStatus(requestStatus);
  }

  //First approach

  Widget _handleRequestStatus(RequestStatus requestStatus) {
    switch (requestStatus) {
      case RequestStatus.success:
        return child;
      case RequestStatus.loading:
        return Center(child: Lottie.asset(AppImageAssets.loading, width: 150));

      case RequestStatus.offline:
        return Center(
            child: Lottie.asset(AppImageAssets.offline,
                width: 250, repeat: false));
      case RequestStatus.unknownError:
        return Center(child: Text("unknown_error".tr));
      case RequestStatus.serverError:
        return Center(
            child: Lottie.asset(
          AppImageAssets.server,
          width: 250,
          repeat: false,
        ));
      case RequestStatus.formatError:
        return Center(child: Text('format_error'.tr));
      case RequestStatus.failure:
        return Center(
            child:
                Lottie.asset(AppImageAssets.noData, width: 250, repeat: false));
      case RequestStatus.notInitialized:
        return child;
    }
  }

  //Another approach using map
  //
  // Widget handleRequestStatus(RequestStatus requestStatus) {
  //   final statusWidgets = <RequestStatus, Widget>{
  //     RequestStatus.offline: const Center(child: Text('Offline')),
  //     RequestStatus.unknownError: const Center(child: Text('Unknown Error')),
  //     RequestStatus.serverError: const Center(child: Text('Server Error')),
  //     RequestStatus.formatError: const Center(child: Text('Format Error')),
  //     RequestStatus.failure: const Center(child: Text('No data')),
  //   };

  //   return statusWidgets[requestStatus] ?? Container(color: Colors.purple);
  // }
}
