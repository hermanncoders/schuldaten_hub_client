part of '../endpoints.dart';

class EndpointsWorkbook {
  static const getWorkbooks = '/workbook/all/flat';

  static const postWorkbook = '/workbook/new';

  String patchWorkbook(String isbn) {
    return '/workbook/$isbn';
  }

  String patchWorkbookWithImage(int isbn) {
    return '/workbook/$isbn/image';
  }

  String getWorkbookImage(int isbn) {
    return '/workbook/$isbn/image';
  }

  String deleteWorkbook(int isbn) {
    return '/workbook/$isbn';
  }
}
