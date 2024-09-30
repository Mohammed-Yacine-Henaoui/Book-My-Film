import 'package:front_end_gestion_cinema/data/models/category.dart';
import 'package:front_end_gestion_cinema/data/web_services/get_service.dart';

class GetCategory {
  final GetService getCategory;
  bool haveError = true;
  Category category = Category();

  GetCategory({required this.getCategory});

  Future<void> runService() async {
    await getCategory.runHttp();
    if (!getCategory.haveError) {
      haveError = false;
      Map<String, dynamic> categoryMap = getCategory.response;
      category = Category.fromJson(categoryMap);
    }
  }
}
