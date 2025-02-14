import 'package:ai_weather/core/helper/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Cubit<int?> {
  final CacheHelper cacheHelper;

  UserBloc(this.cacheHelper) : super(null) {
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final userId = await cacheHelper.readUserId();
    emit(userId);
  }
}