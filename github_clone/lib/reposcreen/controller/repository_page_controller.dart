import 'package:dio/dio.dart' as DIO;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:github_clone/LocalStorageService.dart';
import 'package:github_clone/consts.dart';
import 'package:github_clone/homescreen/model/repository_model.dart';
import 'package:github_clone/login/controller/screen_size_controller.dart';
import 'package:github_clone/reposcreen/model/branch_model.dart';
import 'package:github_clone/reposcreen/model/collaborator_model.dart';

class RepositoryPageController extends GetxController {
  RepositoryModel repositoryModel;

  RepositoryPageController({required this.repositoryModel});

  String repositoryPage = 'repositoryPage';
  String repositoryInfo = 'repositoryInfo';
  String indexedStack = 'indexedStack';
  String collaboratorListView = 'collaboratorListView';
  String branchListView = 'branchListView';
  String shimmerRepoListView = 'repoListView';
  String shimmerOrgListView = 'orgListView';
  String bottomNavigationBar = 'bottomNavigationBar';

  int activeIndex = 0;

  bool repoShimmer = true;

  bool orgShimmer = false;

  late String token;

  late ScreenSizeController sizeController;

  late Future<List<CollaboratorModel>> collaboratorList;

  late Future<List<BranchModel>> branchList;

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
    collaboratorList = getCollaboratorList();
    branchList = getBranchList();
    super.onInit();
  }

  Future<List<CollaboratorModel>> getCollaboratorList() async {
    headers.putIfAbsent("Authorization", () => 'Bearer $token');
    headers.putIfAbsent("Accept", () => ACCEPT);
    List<CollaboratorModel> tempRepoList = [];
    try {
      DIO.Response getResponseStatus = (await dio.request(
        '${BASEURL}/repos/${repositoryModel.owner!.login}/${repositoryModel.name!}/collaborators',
        queryParameters: queryParameters,
        options: DIO.Options(method: 'GET', headers: headers, extra: _extra),
      ));
      if (getResponseStatus.statusCode == 200) {
        for (var i in getResponseStatus.data) {
          tempRepoList.add(CollaboratorModel.fromJson(i));
        }
        queryParameters.clear();
        return tempRepoList;
      }
    } on DIO.DioError catch (ex) {
      queryParameters.clear();
    }
    queryParameters.clear();
    return [];
  }

  Future<List<BranchModel>> getBranchList() async {
    headers.putIfAbsent("Authorization", () => 'Bearer $token');
    headers.putIfAbsent("Accept", () => ACCEPT);
    List<BranchModel> tempOrgList = [];
    try {
      DIO.Response getResponseStatus = (await dio.request(
        '${BASEURL}/repos/${repositoryModel.owner!.login}/${repositoryModel.name!}/branches',
        queryParameters: queryParameters,
        options: DIO.Options(method: 'GET', headers: headers, extra: _extra),
      ));
      if (getResponseStatus.statusCode == 200) {
        for (var i in getResponseStatus.data) {
          tempOrgList.add(BranchModel.fromJson(i));
        }
        queryParameters.clear();
        return tempOrgList;
      }
    } on DIO.DioError catch (ex) {}
    return [];
  }

  onSelectedTab(int index) {
    activeIndex = index;
    switch (index) {
      case 0:
        collaboratorList = getCollaboratorList();
        update([collaboratorListView]);
        break;
      case 1:
        branchList = getBranchList();
        update([branchListView]);
        break;
    }

    update([bottomNavigationBar, indexedStack]);
  }
}
