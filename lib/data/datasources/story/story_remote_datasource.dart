import 'package:dio/dio.dart';
import 'package:story_app/data/model/base_response.dart';
import 'package:story_app/data/model/story_model.dart';
import 'package:story_app/utils/app_constants.dart';

abstract class StoryRemoteDataSource {
  Future<List<StoryModel>> getStories(String token);
  Future<StoryModel> getDetailStory(String token, String id);
  Future<BaseResponse> addStory(
    String token,
    List<int> bytes,
    String filename,
    String description,
  );
}

class StoryRemoteDataSourceImpl implements StoryRemoteDataSource {
  final Dio _dio;

  const StoryRemoteDataSourceImpl(this._dio);

  @override
  Future<BaseResponse> addStory(String token, List<int> bytes, String filename,
      String description) async {
    final headers = {
      'Authorization': 'Bearer $token',
      "Content-Type": "multipart/form-data"
    };

    FormData formData = FormData();

    formData.fields.add(MapEntry('description', description));
    formData.files.add(
      MapEntry(
        'photo',
        MultipartFile.fromBytes(bytes, filename: filename),
      ),
    );

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
  Future<List<StoryModel>> getStories(String token) async {
    final headers = {'Authorization': 'Bearer $token'};
    final response = await _dio.get(
      '${AppConstants.baseUrl}${AppConstants.storiesPath}',
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      final result = List<StoryModel>.from(
          response.data["listStory"].map((x) => StoryModel.fromJson(x)));
      return result;
    } else {
      throw Exception();
    }
  }
}
