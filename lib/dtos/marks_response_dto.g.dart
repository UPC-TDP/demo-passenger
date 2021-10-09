// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marks_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarksResponseDto _$MarksResponseDtoFromJson(Map<String, dynamic> json) {
  return MarksResponseDto(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
        .toList(),
    error: json['error'] as bool?,
    message: json['message'] as String?,
    code: json['code'] as int?,
  );
}

Map<String, dynamic> _$MarksResponseDtoToJson(MarksResponseDto instance) =>
    <String, dynamic>{
      'data': instance.data,
      'error': instance.error,
      'message': instance.message,
      'code': instance.code,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) {
  return Datum(
    id: json['id'] as int?,
    name: json['nombre'] as String?,
    direction: json['direccion'] as String?,
    latitude: json['latitud'] as String?,
    longitude: json['longitud'] as String?,
    isBusStop: json['es_paredero'] as bool?,
    isStartPoint: json['es_inicio'] as bool?,
    isEndPoint: json['es_fin'] as bool?,
    status: json['estado'] as String?,
    creationDate: json['fecha_creacion'] == null
        ? null
        : DateTime.parse(json['fecha_creacion'] as String),
    route: json['rutas'] as int?,
  );
}

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'id': instance.id,
      'nombre': instance.name,
      'direccion': instance.direction,
      'latitud': instance.latitude,
      'longitud': instance.longitude,
      'es_paredero': instance.isBusStop,
      'es_inicio': instance.isStartPoint,
      'es_fin': instance.isEndPoint,
      'estado': instance.status,
      'fecha_creacion': instance.creationDate?.toIso8601String(),
      'rutas': instance.route,
    };
