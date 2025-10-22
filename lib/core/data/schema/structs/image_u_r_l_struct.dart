// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '../core/utils/app_utils.dart';;

class ImageURLStruct extends BaseStruct {
  ImageURLStruct({
    String? image,
  }) : _image = image;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  static ImageURLStruct fromMap(Map<String, dynamic> data) => ImageURLStruct(
        image: data['image'] as String?,
      );

  static ImageURLStruct? maybeFromMap(dynamic data) =>
      data is Map ? ImageURLStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'image': _image,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
      }.withoutNulls;

  static ImageURLStruct fromSerializableMap(Map<String, dynamic> data) =>
      ImageURLStruct(
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ImageURLStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ImageURLStruct && image == other.image;
  }

  @override
  int get hashCode => const ListEquality().hash([image]);
}

ImageURLStruct createImageURLStruct({
  String? image,
}) =>
    ImageURLStruct(
      image: image,
    );
