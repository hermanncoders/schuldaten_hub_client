import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:schuldaten_hub/api/dio/dio_exceptions.dart';
import 'package:schuldaten_hub/api/endpoints.dart';
import 'package:schuldaten_hub/common/utils/debug_printer.dart';
import 'package:schuldaten_hub/features/competence/models/competence.dart';
import 'package:schuldaten_hub/api/services/api_manager.dart';
import 'package:schuldaten_hub/features/competence/services/competence_filter_manager.dart';
//import 'package:schuldaten_hub/services/competence_services/competence_filter_manager.dart';
import 'package:schuldaten_hub/common/services/locator.dart';

class CompetenceManager {
  ValueListenable<List<Competence>> get competences => _competences;
  ValueListenable<bool> get isRunning => _isRunning;

  final _competences = ValueNotifier<List<Competence>>([]);
  final _isRunning = ValueNotifier<bool>(false);

  CompetenceManager() {
    debug.warning('CompetenceManager initialized');
  }
  Future<CompetenceManager> init() async {
    await firstFetchCompetences();
    return this;
  }

  Future firstFetchCompetences() async {
    final client = locator.get<ApiManager>().dioClient.value;
    _isRunning.value = true;
    try {
      final response = await client.get(Endpoints().fetchCompetences);
      final competences =
          (response.data as List).map((e) => Competence.fromJson(e)).toList();
      debug.success(
          'Fetched ${competences.length} competences! | ${StackTrace.current}');
      _competences.value = competences;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
    _isRunning.value = false;
    return;
  }

  Future fetchCompetences() async {
    final client = locator.get<ApiManager>().dioClient.value;
    _isRunning.value = true;
    try {
      final response = await client.get(Endpoints().fetchCompetences);
      final competences =
          (response.data as List).map((e) => Competence.fromJson(e)).toList();
      debug.success(
          'Fetched ${competences.length} competences! | ${StackTrace.current}');
      _competences.value = competences;
      locator<CompetenceFilterManager>()
          .refreshFilteredCompetences(competences);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
    _isRunning.value = false;
    return;
  }

  Future postNewCompetence(int? parentCompetence, String competenceName,
      String? competenceLevel, String? indicators) async {
    final client = locator.get<ApiManager>().dioClient.value;
    _isRunning.value = true;
    final data = jsonEncode({
      "parent_competence": parentCompetence,
      "competence_name": competenceName,
      "competence_level": competenceLevel == '' ? null : competenceLevel,
      "indicators": indicators == '' ? null : indicators
    });
    try {
      final response =
          await client.post(Endpoints().postNewCompetence, data: data);
      final newCompetences =
          (response.data as List).map((e) => Competence.fromJson(e)).toList();
      debug.success(
          'Posted ${newCompetences.length} competences | ${StackTrace.current}');
      _competences.value = [..._competences.value, ...newCompetences];
      locator<CompetenceFilterManager>()
          .refreshFilteredCompetences(_competences.value);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
    _isRunning.value = false;
    return;
  }

  Future patchCompetence(int competenceId, String competenceName,
      String? competenceLevel, String? indicators) async {
    final client = locator.get<ApiManager>().dioClient.value;
    _isRunning.value = true;
    final data = jsonEncode({
      "competence_name": competenceName,
      "competence_level": competenceLevel,
      "indicators": indicators
    });
    try {
      final response = await client
          .patch(Endpoints().patchCompetence(competenceId), data: data);
      final patchedCompetence = Competence.fromJson(response.data);
      final List<Competence> competences = List.from(_competences.value);
      final index = competences
          .indexWhere((element) => element.competenceId == competenceId);
      competences[index] = patchedCompetence;
      _competences.value = competences;
      locator<CompetenceFilterManager>()
          .refreshFilteredCompetences(_competences.value);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debug.error(
          'Dio error: ${errorMessage.toString()} | ${StackTrace.current}');

      rethrow;
    }
    _isRunning.value = false;
    return;
  }

  Competence getCompetence(int competenceId) {
    final Competence competence = _competences.value
        .firstWhere((element) => element.competenceId == competenceId);
    return competence;
  }
}
