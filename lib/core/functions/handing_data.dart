import 'package:zingoshop/core/classes/request_status.dart';

handelingData(response) {
  if (response is RequestStatus) {
    return response;
  }
  return RequestStatus.success;
}
