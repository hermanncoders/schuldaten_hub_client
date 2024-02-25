import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';
import 'package:schuldaten_hub/common/services/session_manager.dart';
import 'package:schuldaten_hub/common/utils/custom_encrypter.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/pupil/services/pupil_filter_manager.dart';
import 'package:schuldaten_hub/features/workbooks/models/workbook.dart';

class WorkbookManager {
  ValueListenable<List<Workbook>> get workbooks => _workbooks;

  final _workbooks = ValueNotifier<List<Workbook>>([]);

  WorkbookManager();
  final client = locator.get<ApiManager>().dioClient.value;
  final session = locator.get<SessionManager>().credentials.value;

  Future<WorkbookManager> init() async {
    await getWorkbooks();
    return this;
  }

  Future getWorkbooks() async {
    try {
      final response = await client.get(EndpointsWorkbook.getWorkbooks);
      final workbooks =
          (response.data as List).map((e) => Workbook.fromJson(e)).toList();
      debug.success(
          'WorkbookRepository fetched ${workbooks.length} workbooks! | ${StackTrace.current}');
      _workbooks.value = workbooks;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
  }

  Future postWorkbook(
      String name, int isbn, String subject, String level) async {
    final data = jsonEncode({
      "name": name,
      "isbn": isbn,
      "subject": subject,
      "level": level,
      "image_url": null
    });
    final Response response = await client.post(
      EndpointsWorkbook.postWorkbook,
      data: data,
    );
    if (response.statusCode != 200) {
      // handle errors
    }
    debug.success('Workbook created! | ${StackTrace.current}');
    Workbook newWorkbook = Workbook.fromJson(response.data);
    _workbooks.value = [..._workbooks.value, newWorkbook];
  }

  postWorkbookFile(File imageFile, int isbn) async {
    final encryptedFile = await customEncrypter.encryptFile(imageFile);

    String fileName = encryptedFile.path.split('/').last;
    // Prepare the form data for the request.
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        encryptedFile.path,
        filename: fileName,
      ),
    });
    // send request
    final Response response = await client.patch(
      EndpointsWorkbook().patchWorkbookWithImage(isbn),
      data: formData,
    );
    // Handle errors.
    if (response.statusCode != 200) {
      debug.warning('Something went wrong with the multipart request');
    }
    // Success! We have a pupil response - let's patch the pupil with the data
    final Map<String, dynamic> pupilResponse = response.data;
    final Workbook workbook = Workbook.fromJson(pupilResponse);
    updateWorkbookInRepositoryWithResponse(workbook);
  }

  updateWorkbookInRepositoryWithResponse(Workbook workbook) {
    List<Workbook> workbooks = List.from(_workbooks.value);
    int index = workbooks.indexWhere((wb) => wb.isbn == workbook.isbn);
    workbooks[index] = workbook;
    _workbooks.value = workbooks;
  }
}
