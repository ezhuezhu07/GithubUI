import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:github_clone/colors.dart';
import 'package:github_clone/consts.dart';
import 'package:github_clone/homescreen/controller/github_homepage_controller.dart';
import 'package:github_clone/homescreen/model/authenticated_user_model.dart';
import 'package:github_clone/homescreen/model/organization_model.dart';
import 'package:github_clone/homescreen/model/repository_model.dart';
import 'package:github_clone/login/controller/screen_size_controller.dart';
import 'package:shimmer/shimmer.dart';

class GitHubHomePage extends StatelessWidget {
  const GitHubHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GithubHomePageController());
    return GetBuilder<GithubHomePageController>(
        id: 'gitHubHomePage',
        init: GithubHomePageController(),
        builder: (controller) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: Stack(
              children: [
                _buildProfile(context, controller.sizeController, controller),
                GetBuilder<GithubHomePageController>(
                    id: controller.indexedStack,
                    builder: (controller) {
                      return IndexedStack(
                        index: controller.activeIndex,
                        children: [
                          _buildRepoList(
                              context, controller.sizeController, controller),
                          _buildOrgList(
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
    actions: [
      IconButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
        },
        icon: const Icon(Icons.logout),
      ),
    ],
  );
}

Widget _buildProfile(BuildContext context, ScreenSizeController sizeController,
    GithubHomePageController controller) {
  return GetBuilder<GithubHomePageController>(
      id: controller.profileData,
      builder: (controller) {
        return FutureBuilder<AuthenticatedUserModel>(
          future: controller.authUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Positioned(
                top: sizeController.profileInfoContainerTop,
                left: sizeController.profileInfoContainerLeft,
                child: Container(
                  height: sizeController.profileInfoContainerHeight,
                  width: sizeController.profileInfoContainerWidth,
                  color: dark,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: sizeController.screenHeight * 0.075,
                            width: sizeController.screenHeight * 0.075,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(FirebaseAuth
                                    .instance.currentUser!.photoURL!),
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
                              children: [
                                Text(snapshot.data!.login!,
                                    style: titleStyle.copyWith(fontSize: 20)),
                                SizedBox(
                                  height: defaultPadding / 2,
                                ),
                                Text(snapshot.data!.name!,
                                    style: titleStyle.copyWith(color: grey)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: grey,
                          ),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Text('${snapshot.data!.followers!}',
                              style: titleStyle),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Text("followers",
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.normal)),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          const Text("•", style: titleStyle),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Text('${snapshot.data!.following}',
                              style: titleStyle),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Text("following",
                              style: titleStyle.copyWith(
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Failed to fetch User Data'),
              );
            } else {
              return Positioned(
                top: sizeController.profileInfoContainerTop,
                left: sizeController.profileInfoContainerLeft,
                child: Container(
                  height: sizeController.profileInfoContainerHeight,
                  width: sizeController.profileInfoContainerWidth,
                  color: dark,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: dark,
                            highlightColor: grey,
                            enabled: true,
                            child: Container(
                              height: sizeController.screenHeight * 0.075,
                              width: sizeController.screenHeight * 0.075,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: white),
                            ),
                          ),
                          const SizedBox(
                            width: defaultPadding,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                  baseColor: dark,
                                  highlightColor: grey,
                                  enabled: true,
                                  child: Container(
                                    height: defaultPadding * 1.2,
                                    width: defaultPadding * 5,
                                    color: white,
                                  ),
                                ),
                                const SizedBox(
                                  height: defaultPadding / 2,
                                ),
                                Shimmer.fromColors(
                                    baseColor: dark,
                                    highlightColor: grey,
                                    enabled: true,
                                    child: Container(
                                      height: defaultPadding * 1,
                                      width: defaultPadding * 5,
                                      color: white,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Row(
                        children: [
                          Shimmer.fromColors(
                              baseColor: dark,
                              highlightColor: grey,
                              enabled: true,
                              child: Container(
                                height: defaultPadding * 1,
                                width: defaultPadding * 6,
                                color: white,
                              )),
                          const SizedBox(
                            width: defaultPadding / 2,
                          ),
                          Shimmer.fromColors(
                              baseColor: dark,
                              highlightColor: grey,
                              enabled: true,
                              child: Container(
                                height: defaultPadding * 1,
                                width: defaultPadding * 5,
                                color: white,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      });
}

Widget _buildRepoList(BuildContext context, ScreenSizeController sizeController,
    GithubHomePageController controller) {
  return GetBuilder<GithubHomePageController>(
      id: controller.repoListView,
      builder: (controller) {
        return FutureBuilder<List<RepositoryModel>>(
          future: controller.repoList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              controller.repoShimmer = false;
              return Positioned(
                top: sizeController.listViewContainerTop,
                left: sizeController.listViewContainerLeft,
                child: Container(
                  height: sizeController.listViewContainerHeight,
                  width: sizeController.listViewContainerWidth,
                  color: dark,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return _repoListItem(sizeController, snapshot.data![i]);
                      }),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Failed to fetch Repository Data'),
              );
            } else {
              return GetBuilder<GithubHomePageController>(
                  id: controller.shimmerRepoListView,
                  builder: (controller) {
                    return Positioned(
                      top: sizeController.listViewContainerTop,
                      left: sizeController.listViewContainerLeft,
                      child: Container(
                        height: sizeController.listViewContainerHeight,
                        width: sizeController.listViewContainerWidth,
                        color: dark,
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, i) {
                              return _shimmerListItem(
                                  sizeController, controller.repoShimmer);
                            }),
                      ),
                    );
                  });
            }
          },
        );
      });
}

Widget _buildOrgList(BuildContext context, ScreenSizeController sizeController,
    GithubHomePageController controller) {
  return GetBuilder<GithubHomePageController>(
      id: controller.orgListView,
      builder: (controller) {
        return FutureBuilder<List<OrganizationModel>>(
          future: controller.orgList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Positioned(
                top: sizeController.listViewContainerTop,
                left: sizeController.listViewContainerLeft,
                child: Container(
                  height: sizeController.listViewContainerHeight,
                  width: sizeController.listViewContainerWidth,
                  color: dark,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return _orgListItem(sizeController, snapshot.data![i]);
                      }),
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Failed to fetch Organization Data'),
              );
            } else {
              return GetBuilder<GithubHomePageController>(
                  id: controller.shimmerOrgListView,
                  builder: (controller) {
                    return Positioned(
                      top: sizeController.listViewContainerTop,
                      left: sizeController.listViewContainerLeft,
                      child: Container(
                        height: sizeController.listViewContainerHeight,
                        width: sizeController.listViewContainerWidth,
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

Widget _buildBottomNavigationBar(GithubHomePageController controller) {
  return GetBuilder<GithubHomePageController>(
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
                  label: 'Respositories',
                  icon: FaIcon(
                    FontAwesomeIcons.gitAlt,
                    size: 18,
                  )),
              BottomNavigationBarItem(
                  label: 'Organizations',
                  icon: FaIcon(
                    FontAwesomeIcons.building,
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

Widget _repoListItem(ScreenSizeController sizeController,
    RepositoryModel repo) {
  return SizedBox(
    height: sizeController.screenHeight * 0.1,
    width: sizeController.screenWidth,
    child: Row(
      children: [
        Container(
          height: sizeController.screenHeight * 0.08,
          width: sizeController.screenHeight * 0.08,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(repo.owner!.avatarUrl!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: defaultPadding * 2,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(repo.name ?? '', style: titleStyle.copyWith(fontSize: 20)),
              const SizedBox(
                height: defaultPadding / 2,
              ),
              Text(repo.description ?? '',
                  style: titleStyle.copyWith(color: grey)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _orgListItem(ScreenSizeController sizeController,
    OrganizationModel org) {
  return SizedBox(
    height: sizeController.screenHeight * 0.1,
    width: sizeController.screenWidth,
    child: Row(
      children: [
        Container(
          height: sizeController.screenHeight * 0.08,
          width: sizeController.screenHeight * 0.08,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: NetworkImage(org.avatarUrl!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: defaultPadding * 2,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(org.login!, style: titleStyle.copyWith(fontSize: 20)),
              const SizedBox(
                height: defaultPadding / 2,
              ),
              Text(org.description ?? '',
                  style: titleStyle.copyWith(color: grey)),
            ],
          ),
        ),
      ],
    ),
  );
}
