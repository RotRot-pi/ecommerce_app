import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:ecommercecourse/core/classes/request_status.dart';
import 'package:ecommercecourse/core/functions/check_internet.dart';
import 'package:http/http.dart' as http;

//Enhanced version of the code
//
//
// class Crud {
//   Future<Either<RequestStatus, T>> post<T>(
//       String urlLink, Map data, T Function(Map) fromJson) async {
//     try {
//       if (!await checkInternet()) {
//         return const Left(RequestStatus.offline);
//       }

//       var response = await http.post(
//         Uri.parse(urlLink),
//         body: jsonEncode(data),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         try {
//           var responseBody = jsonDecode(response.body);
//           return Right(fromJson(responseBody));
//         } on FormatException {
//           return const Left(RequestStatus.formatError);
//         }
//       } else {
//         return const Left(RequestStatus.serverError);
//       }
//     } catch (e) {
//       // Log the exception, e.g., using print or a logging package
//       print('Exception during POST request: $e');
//       return const Left(RequestStatus.unknownError);
//     }
//   }
// }

//My version of the code
//
//
class Crud {
  Future<Either<RequestStatus, Map>> post(String urlLink, Map data) async {
    try {
      if (!await checkInternet()) {
        print('check internet');
        return const Left(RequestStatus.offline);
      }
      var response = await http.post(

          //Note: some error requires you to use Uri.https() or Uri.http()
          Uri.parse(
            urlLink,
          ),
          body: data);
      print("response in crud:${response.statusCode}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print("response.statusCode:${response.statusCode}");
        try {
          print("response.body:${response.body}");
          //NOTE: I got a format error because the body was empty
          //      So I used the conditional statement inside jsonDecode
          var responseBody =
              jsonDecode(response.body.isNotEmpty ? response.body : "{}");
          print("CRUD:$responseBody");
          return Right(responseBody);
        } on FormatException catch (e) {
          print("response.message:${e.message}");
          return const Left(RequestStatus.formatError);
        }
      } else {
        return const Left(RequestStatus.serverError);
      }
    } catch (e) {
      print("Error in crud:$e");
      return const Left(RequestStatus.unknownError);
    }
  }
}
