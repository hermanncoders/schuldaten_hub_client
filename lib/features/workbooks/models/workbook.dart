import 'package:freezed_annotation/freezed_annotation.dart';

part 'workbook.freezed.dart';
part 'workbook.g.dart';

@freezed
class Workbook with _$Workbook {
  factory Workbook({
    int? isbn,
    String? name,
    String? subject,
  }) = _Workbook;

  factory Workbook.fromJson(Map<String, dynamic> json) =>
      _$WorkbookFromJson(json);
}
