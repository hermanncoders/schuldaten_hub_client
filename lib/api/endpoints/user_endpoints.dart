part of '../endpoints.dart';

class EndpointsUser {
  static const login = '/login';

  //- POST

  static const createUser = '/user';

  //- GET

  static const getAllUsers = '/user/all';

  //- PATCH

  String patchUser(String publicId) {
    return 'user/$publicId';
  }

  //- DELETE

  String deleteUser(String publicId) {
    return 'user/$publicId';
  }

  //- increase credit
  static const increaseCredit = '/user/all/credit';
}
