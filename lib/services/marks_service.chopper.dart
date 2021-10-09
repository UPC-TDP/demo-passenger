// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marks_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$MarksService extends MarksService {
  _$MarksService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MarksService;

  @override
  Future<Response<dynamic>> getMarks() {
    final $url = '';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
