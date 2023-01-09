import 'package:dio/dio.dart';
import 'package:rick_morty/constants/app_strings.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: AppStrings.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 10 * 1000, //20 second
      receiveTimeout: 10 * 1000,
    );
    dio = Dio(baseOptions);
  }

  Future<List<dynamic>> getAllCharacters() async {
      Response response = await dio.get('character');
      return response.data['results'];
  }
}
