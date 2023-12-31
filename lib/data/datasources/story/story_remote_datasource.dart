import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/data/model/base_response.dart';
import 'package:story_app/data/model/story_model.dart';
import 'package:story_app/data/model/story_response.dart';
import 'package:story_app/utils/app_constants.dart';

abstract class StoryRemoteDataSource {
  Future<List<StoryModel>> getStories(String token,
      {int page = 1, int size = 10});
  Future<StoryModel> getDetailStory(String token, String id);
  Future<BaseResponse> addStory(
    String token,
    List<int> bytes,
    String filename,
    String description,
    LatLng? latLng,
  );
}

class StoryRemoteDataSourceImpl implements StoryRemoteDataSource {
  final Dio _dio;

  const StoryRemoteDataSourceImpl(this._dio);

  @override
  Future<BaseResponse> addStory(String token, List<int> bytes, String filename,
      String description, LatLng? latLng) async {
    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "multipart/form-data"
    };

    Iterable<MapEntry<String, String>> fields = [
      MapEntry('description', description),
      if (latLng != null) MapEntry('lat', latLng.latitude.toString()),
      if (latLng != null) MapEntry('lon', latLng.longitude.toString()),
    ];

    MapEntry<String, MultipartFile> file = MapEntry(
      'photo',
      MultipartFile.fromBytes(bytes, filename: filename),
    );

    FormData formData = FormData();

    formData.fields.addAll(fields);
    formData.files.add(file);

    final response = await _dio.post(
      '${AppConstants.baseUrl}${AppConstants.storiesPath}',
      data: formData,
      options: Options(headers: headers),
    );

    if (response.statusCode == 201) {
      final result = BaseResponse.fromJson(response.data);
      return result;
    } else {
      throw Exception();
    }
  }

  @override
  Future<StoryModel> getDetailStory(String token, String id) async {
    final headers = {'Authorization': 'Bearer $token'};
    final params = {'location': 1};
    final response = await _dio.get(
      '${AppConstants.baseUrl}${AppConstants.storiesPath}/$id',
      queryParameters: params,
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      final result = StoryModel.fromJson(response.data['story']);
      return result;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<StoryModel>> getStories(String token,
      {int page = 1, int size = 10}) async {
    final headers = {'Authorization': 'Bearer $token'};
    final response = await _dio.get(
      '${AppConstants.baseUrl}${AppConstants.storiesPath}?page=$page&size=$size',
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      final result = StoryResponse.fromJson(response.data).stories;
      return result;
    } else {
      throw Exception();
    }
  }
}
