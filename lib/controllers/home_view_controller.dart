// ignore_for_file: invalid_use_of_protected_member, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/api_service_controller.dart';
import 'package:veda_nidhi_v2/models/get_cat_model.dart';
import 'package:veda_nidhi_v2/models/user_model.dart';

import '../models/banner_model.dart';
import '../models/category_model.dart';

class HomeViewController extends GetxController {
  final _apiClient = Get.find<ApiServiceController>();
  final scrollController = ScrollController();
  RxInt _carouselIndex = 0.obs;
  RxBool _catLoad = false.obs;
  RxBool _reachedEnd = false.obs;
  RxList<Category> _categories = <Category>[].obs;
  final _limit = 3;
  int _offSet = 0;
  RxBool _isNewCategoryLoading = false.obs;
  int categoryLength = 0;
  int get index => _carouselIndex.value;
  List<Category> get categories => _categories.value;
  bool get isCatergoryLoading => _catLoad.value;
  bool get isNewCatergoryLoading => _isNewCategoryLoading.value;
  bool get isCategoryEnd => _reachedEnd.value;
  void setCarouselIndex(int index) {
    _carouselIndex.value = index;
  }

  Future<UserModel> getUserData() async {
    final res = await _apiClient.fetchData(fetchUrl: "users/me");

    return userModelFromMap(res.toString());
  }

  Future<GetBannerModel> getBanners() async {
  
    final res =
        await _apiClient.fetchData(fetchUrl: 'items/home_banners?fields[]=*.*');

    final model = getBannerModelFromMap(res.toString());
    return model;
  }

  Future<GetCategoryModel> getCategories() async {
    _switchCatLoad(true);
    final res = await _apiClient.fetchData(
        fetchUrl: 'items/categories?limit=$_limit&offset=0&sort[]=rank');

    _switchCatLoad(false);
    final model = getCategoryModelFromMap(res.toString());

    _categories.value.addAll(model.data);
    categoryLength = _categories.value.length;
    return model;
  }

  Future<GetCategoryModel> getNewCategories() async {
    _switchNewCatLoad(true);
    final res = await _apiClient.fetchData(
        fetchUrl: 'items/categories?limit=$_limit&offset=$_offSet&sort[]=rank');

    _switchNewCatLoad(false);
    final model = getCategoryModelFromMap(res.toString());

    _categories.value.addAll(model.data);

    _checkIfReachedEnd(_categories.value.length);
    return model;
  }

  Future<Category> getCategory(String id) async {
    final res = await _apiClient.fetchData(fetchUrl: 'items/categories/$id');
    final model = getCatModelFromMap(res.toString());
    return model.data;
  }

  addScrollListener() {
    scrollController.addListener(scrollListener);
  }

  void scrollListener() async {
    if (_isNewCategoryLoading.value || _catLoad.value || _reachedEnd.value) {
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      _updateOffSet();
      // print("offset updated $_offSet");
      await getNewCategories();
    }
  }

  void clearCategories() {
    _categories.clear();
    _offSet = 0;
    _reachedEnd.value = false;
    categoryLength = 0;
  }

  void _updateOffSet() {
    _offSet = _offSet + _limit;
  }

  _switchCatLoad(bool val) {
    _catLoad.value = val;
  }

  _switchNewCatLoad(bool val) {
    if (_reachedEnd.value) {
      return;
    } else {
      _isNewCategoryLoading.value = val;
    }
  }

  void _checkIfReachedEnd(int length) {
    if (categoryLength == length) {
      _reachedEnd.value = true;
    
    } else {
      categoryLength = length;
      _reachedEnd.value = false;
    }
  }
}
