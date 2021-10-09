import 'package:json_annotation/json_annotation.dart';

part 'marks_response_dto.g.dart';

@JsonSerializable()
class MarksResponseDto {
  MarksResponseDto({
    this.data,
    this.error,
    this.message,
    this.code,
  });

  @JsonKey(name: 'data')
  List<Datum>? data;
  @JsonKey(name: 'error')
  bool? error;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'code')
  int? code;

  factory MarksResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MarksResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MarksResponseDtoToJson(this);
}

@JsonSerializable()
class Datum {
  Datum({
    this.id,
    this.name,
    this.direction,
    this.latitude,
    this.longitude,
    this.isBusStop,
    this.isStartPoint,
    this.isEndPoint,
    this.status,
    this.creationDate,
    this.route,
  });

  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'nombre')
  String? name;
  @JsonKey(name: 'direccion')
  String? direction;
  @JsonKey(name: 'latitud')
  String? latitude;
  @JsonKey(name: 'longitud')
  String? longitude;
  @JsonKey(name: 'es_paredero')
  bool? isBusStop;
  @JsonKey(name: 'es_inicio')
  bool? isStartPoint;
  @JsonKey(name: 'es_fin')
  bool? isEndPoint;
  @JsonKey(name: 'estado')
  String? status;
  @JsonKey(name: 'fecha_creacion')
  DateTime? creationDate;
  @JsonKey(name: 'rutas')
  int? route;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
