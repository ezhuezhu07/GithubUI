// import 'dart:developer' as devvtools show log;
import 'package:dio/dio.dart' as DIO;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:github_clone/LocalStorageService.dart';
import 'package:github_clone/consts.dart';
import 'package:github_clone/endpoint_string.dart';
import 'package:github_clone/homescreen/model/authenticated_user_model.dart';
import 'package:github_clone/homescreen/model/organization_model.dart';
import 'package:github_clone/homescreen/model/repository_model.dart';
import 'package:github_clone/login/controller/screen_size_controller.dart';

/*extension Log on Object {
  void log() => devvtools.log(toString());
}*/

class GithubHomePageController extends GetxController {
  String githubHomePage = 'githubHomePage';
  String profileData = 'profileData';
  String indexedStack = 'indexedStack';
  String repoListView = 'repoListView';
  String orgListView = 'orgListView';
  String shimmerRepoListView = 'repoListView';
  String shimmerOrgListView = 'orgListView';
  String bottomNavigationBar = 'bottomNavigationBar';

  int activeIndex = 0;

  bool repoShimmer = true;

  bool orgShimmer = false;

  late String token;

  late ScreenSizeController sizeController;

  late Future<AuthenticatedUserModel> authUser;

  late Future<List<RepositoryModel>> repoList;

  late Future<List<OrganizationModel>> orgList;

  DIO.Dio dio = DIO.Dio();

  Map<String, dynamic> queryParameters = <String, dynamic>{};

  Map<String, dynamic> headers = <String, dynamic>{};

  Map<String, dynamic> _extra = <String, dynamic>{};

  @override
  void onInit() async {
    sizeController = Get.find<ScreenSizeController>();
    token = Get.find<LocalStorageService>()
        .userCred
        .read(FirebaseAuth.instance.currentUser!.uid);
    print('Access token: $token');
    authUser = getAuthenticatedUser();
    repoList = getRepoList();
    orgList = getOrgList();
    super.onInit();
  }

  Future<AuthenticatedUserModel> getAuthenticatedUser() async {
    headers.putIfAbsent("Authorization", () => 'Bearer $token');
    headers.putIfAbsent("Accept", () => 'application/vnd.github+json');
    try {
      DIO.Response getResponseStatus = (await dio.request(
        '$BASEURL${Endpoints.getUser}',
        queryParameters: queryParameters,
        options: DIO.Options(method: 'GET', headers: headers, extra: _extra),
      ));
      if (getResponseStatus.statusCode == 200) {
        return AuthenticatedUserModel.fromJson(getResponseStatus.data);
      }
    } on DIO.DioError catch (ex) {
      print('Failed to fetch authenticated user details ${ex.response}');
    }
    return AuthenticatedUserModel();
  }

  Future<List<RepositoryModel>> getRepoList() async {
    queryParameters['visiblity'] = 'all';
    headers.putIfAbsent("Authorization", () => 'Bearer $token');
    headers.putIfAbsent("Accept", () => 'application/vnd.github+json');
    List<RepositoryModel> tempRepoList = [];
    try {
      DIO.Response getResponseStatus = (await dio.request(
        '$BASEURL${Endpoints.getRepo}',
        queryParameters: queryParameters,
        options: DIO.Options(method: 'GET', headers: headers, extra: _extra),
      ));
      if (getResponseStatus.statusCode == 200) {
        print('Fetching repos');
        for (var i in getResponseStatus.data) {
          tempRepoList.add(RepositoryModel.fromJson(i));
        }
        queryParameters.clear();
        return tempRepoList;
      }
    } on DIO.DioError catch (ex) {
      // print('Failed to fetch repos ${ex.response} ${ex.response!.statusCode}');
      queryParameters.clear();
    }
    queryParameters.clear();
    return [];
  }

  Future<List<OrganizationModel>> getOrgList() async {
    headers.putIfAbsent("Authorization", () => 'Bearer $token');
    headers.putIfAbsent("Accept", () => 'application/vnd.github+json');
    List<OrganizationModel> tempOrgList = [];
    try {
      DIO.Response getResponseStatus = (await dio.request(
        '$BASEURL${Endpoints.getOrg}',
        queryParameters: queryParameters,
        options: DIO.Options(method: 'GET', headers: headers, extra: _extra),
      ));
      if (getResponseStatus.statusCode == 200) {
        print('Fetching repos');
        for (var i in getResponseStatus.data) {
          tempOrgList.add(OrganizationModel.fromJson(i));
        }
        queryParameters.clear();
        return tempOrgList;
      }
    } on DIO.DioError catch (ex) {
      // print('Failed to fetch repos ${ex.response} ${ex.response!.statusCode}');
      queryParameters.clear();
    }
    queryParameters.clear();
    return [];
  }

  onSelectedTab(int index) {
    activeIndex = index;
    switch (index) {
      case 0:
        repoList = getRepoList();
        update([repoListView]);
        break;
      case 1:
        orgList = getOrgList();
        update([orgListView]);
        break;
    }

    update([bottomNavigationBar, indexedStack]);
  }
}
