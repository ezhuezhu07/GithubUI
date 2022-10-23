import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:github_clone/colors.dart';
import 'package:github_clone/consts.dart';
import 'package:github_clone/homescreen/model/repository_model.dart';
import 'package:github_clone/login/controller/screen_size_controller.dart';
import 'package:github_clone/reposcreen/controller/repository_page_controller.dart';
import 'package:github_clone/reposcreen/model/branch_model.dart';
import 'package:github_clone/reposcreen/model/collaborator_model.dart';
import 'package:shimmer/shimmer.dart';

class RepositoryPage extends StatelessWidget {
  final RepositoryModel repositoryModel;

  RepositoryPage({super.key, required this.repositoryModel});

  @override
  Widget build(BuildContext context) {
    Get.put(RepositoryPageController(repositoryModel: repositoryModel));
    return GetBuilder<RepositoryPageController>(
        id: 'repositoryPage',
        builder: (controller) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: Stack(
              children: [
                _buildRepoInfo(context, controller.sizeController, controller,
                    repositoryModel),
                GetBuilder<RepositoryPageController>(
                    id: controller.indexedStack,
                    builder: (controller) {
                      return IndexedStack(
                        index: controller.activeIndex,
                        children: [
                          _buildCollaboratorList(
                              context, controller.sizeController, controller),
                          _buildBranchList(
                              context, controller.sizeController, controller)
                        ],
                      );
                    }),
              ],
            ),
            bottomNavigationBar: _buildBottomNavigationBar(controller),
          );
        });
  }
}

AppBar _buildAppBar() {
  return AppBar(
      /*actions: [
      */ /*IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(Icons.close),
      ),*/ /*
    ],*/
      );
}

Widget _buildRepoInfo(BuildContext context, ScreenSizeController sizeController,
    RepositoryPageController controller, RepositoryModel repo) {
  return GetBuilder<RepositoryPageController>(
      id: controller.repositoryInfo,
      builder: (controller) {
        return Positioned(
          top: sizeController.repoInfoContainerTop,
          left: sizeController.repoInfoContainerLeft,
          child: Container(
            height: sizeController.repoInfoContainerHeight,
            width: sizeController.repoInfoContainerWidth,
            color: dark,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: sizeController.screenHeight * 0.045,
                        width: sizeController.screenHeight * 0.045,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(repo.owner!.avatarUrl!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: defaultPadding,
                      ),
                      Text(repo.owner!.login!,
                          style: titleStyle.copyWith(fontSize: 20)),
                    ],
                  ),
                  const SizedBox(
                    height: defaultPadding,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(repo.name!,
                            style: titleStyle.copyWith(fontSize: 20)),
                        const SizedBox(
                          height: defaultPadding / 2,
                        ),
                        Text(repo.description ?? '',
                            style: titleStyle.copyWith(color: grey)),
                        const SizedBox(
                          height: defaultPadding / 2,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star_border,
                              color: grey,
                            ),
                            const SizedBox(
                              width: defaultPadding / 2,
                            ),
                            Text('${repo.stargazersCount ?? 0}',
                                style: titleStyle),
                            const SizedBox(
                              width: defaultPadding / 2,
                            ),
                            Text("stars",
                                style: titleStyle.copyWith(
                                    fontWeight: FontWeight.normal)),
                            const SizedBox(
                              width: defaultPadding,
                            ),
                            const FaIcon(
                              FontAwesomeIcons.gitAlt,
                              color: grey,
                            ),
                            const SizedBox(
                              width: defaultPadding / 2,
                            ),
                            Text('${repo.forksCount ?? 0}', style: titleStyle),
                            const SizedBox(
                              width: defaultPadding / 2,
                            ),
                            Text("forks",
                                style: titleStyle.copyWith(
                                    fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

Widget _buildCollaboratorList(BuildContext context,
    ScreenSizeController sizeController, RepositoryPageController controller) {
  return GetBuilder<RepositoryPageController>(
      id: controller.collaboratorListView,
      builder: (controller) {
        return FutureBuilder<List<CollaboratorModel>>(
          future: controller.collaboratorList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Positioned(
                top: sizeController.repoListViewContainerTop,
                left: sizeController.repoListViewContainerLeft,
                child: Container(
                  height: sizeController.repoListViewContainerHeight,
                  width: sizeController.repoListViewContainerWidth,
                  color: dark,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return _collaboratorListItem(
                            sizeController, snapshot.data![i]);
                      }),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Failed to fetch Repository Data'),
              );
            } else {
              /*return GetBuilder<RepositoryPageController>(
                  id: controller.shimmerRepoListView,
                  builder: (controller) {*/
              return Positioned(
                top: sizeController.repoListViewContainerTop,
                left: sizeController.repoListViewContainerLeft,
                child: Container(
                  height: sizeController.repoListViewContainerHeight,
                  width: sizeController.repoListViewContainerWidth,
                  color: dark,
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, i) {
                        return _shimmerListItem(
                            sizeController, controller.repoShimmer);
                      }),
                ),
              );
              /*});*/
            }
          },
        );
      });
}

Widget _buildBranchList(BuildContext context,
    ScreenSizeController sizeController, RepositoryPageController controller) {
  return GetBuilder<RepositoryPageController>(
      id: controller.branchListView,
      builder: (controller) {
        return FutureBuilder<List<BranchModel>>(
          future: controller.branchList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Positioned(
                top: sizeController.repoListViewContainerTop,
                left: sizeController.repoListViewContainerLeft,
                child: Container(
                  height: sizeController.repoListViewContainerHeight,
                  width: sizeController.repoListViewContainerWidth,
                  color: dark,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return branchListItem(
                            sizeController, snapshot.data![i]);
                      }),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Failed to fetch Organization Data'),
              );
            } else {
              return GetBuilder<RepositoryPageController>(
                  id: controller.shimmerOrgListView,
                  builder: (controller) {
                    return Positioned(
                      top: sizeController.repoListViewContainerTop,
                      left: sizeController.repoListViewContainerLeft,
                      child: Container(
                        height: sizeController.repoListViewContainerHeight,
                        width: sizeController.repoListViewContainerWidth,
                        color: dark,
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, i) {
                              return _shimmerListItem(
                                  sizeController, controller.orgShimmer);
                            }),
                      ),
                    );
                  });
            }
          },
        );
      });
}

Widget _buildBottomNavigationBar(RepositoryPageController controller) {
  return GetBuilder<RepositoryPageController>(
      id: controller.bottomNavigationBar,
      builder: (context) {
        return BottomNavigationBar(
            currentIndex: controller.activeIndex,
            onTap: controller.onSelectedTab,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: primary,
            unselectedItemColor: grey,
            items: const [
              BottomNavigationBarItem(
                  label: 'Collaborators',
                  icon: FaIcon(
                    FontAwesomeIcons.peopleGroup,
                    size: 18,
                  )),
              BottomNavigationBarItem(
                  label: 'Branches',
                  icon: FaIcon(
                    FontAwesomeIcons.gitAlt,
                    size: 18,
                  )),
            ]);
      });
}

Widget _shimmerListItem(ScreenSizeController sizeController, bool isEnabled) {
  return SizedBox(
    height: sizeController.screenHeight * 0.1,
    width: sizeController.screenWidth,
    child: Row(
      children: [
        Shimmer.fromColors(
          baseColor: dark,
          highlightColor: grey,
          enabled: isEnabled,
          child: Container(
            height: sizeController.screenHeight * 0.08,
            width: sizeController.screenHeight * 0.08,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: white),
          ),
        ),
        const SizedBox(
          width: defaultPadding,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: dark,
                highlightColor: grey,
                enabled: isEnabled,
                child: Container(
                  height: defaultPadding * 1.2,
                  width: sizeController.screenWidth * 0.5,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: white,
                  ),
                ),
              ),
              const SizedBox(
                height: defaultPadding / 2,
              ),
              Shimmer.fromColors(
                  baseColor: dark,
                  highlightColor: grey,
                  enabled: isEnabled,
                  child: Container(
                    height: defaultPadding * 1,
                    width: sizeController.screenWidth * 0.7,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: white,
                    ),
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _collaboratorListItem(
    ScreenSizeController sizeController, CollaboratorModel collab) {
  return SizedBox(
    height: sizeController.screenHeight * 0.1,
    width: sizeController.screenWidth,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        children: [
          Container(
            height: sizeController.screenHeight * 0.05,
            width: sizeController.screenHeight * 0.05,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(collab.avatarUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: defaultPadding,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(collab.login!, style: titleStyle.copyWith(fontSize: 20)),
                const SizedBox(
                  height: defaultPadding / 2,
                ),
                Text(collab.roleName ?? '',
                    style: titleStyle.copyWith(color: grey)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget branchListItem(ScreenSizeController sizeController, BranchModel branch) {
  return Container(
    height: sizeController.screenHeight * 0.075,
    width: sizeController.screenWidth,
    color: dark,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(branch.name ?? '', style: titleStyle.copyWith(color: grey)),
        ],
      ),
    ),
  );
}
