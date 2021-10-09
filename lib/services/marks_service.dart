import 'package:chopper/chopper.dart';

part 'marks_service.chopper.dart';

@ChopperApi()
abstract class MarksService extends ChopperService {
  @Get(path: '')
  Future<Response> getMarks();

  static MarksService create() {
    final chopperClient = ChopperClient(
      interceptors: [HttpLoggingInterceptor()],
      converter: JsonConverter(),
      errorConverter: JsonConverter(),
      baseUrl: 'https://run.mocky.io/v3/5a690edb-5e2e-430a-b539-cb835945853c',
      services: [
        _$MarksService(),
      ],
    );
    return _$MarksService(chopperClient);
  }
}
