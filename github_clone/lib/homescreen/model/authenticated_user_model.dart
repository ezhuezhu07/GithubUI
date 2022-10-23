// To parse this JSON data, do
//
//     final authenticatedUserModel = authenticatedUserModelFromJson(jsonString);

import 'dart:convert';

class AuthenticatedUserModel {
  AuthenticatedUserModel({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.siteAdmin,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.hireable,
    this.bio,
    this.twitterUsername,
    this.publicRepos,
    this.publicGists,
    this.followers,
    this.following,
    this.createdAt,
    this.updatedAt,
    this.privateGists,
    this.totalPrivateRepos,
    this.ownedPrivateRepos,
    this.diskUsage,
    this.collaborators,
    this.twoFactorAuthentication,
    this.plan,
  });

  String? login;
  int? id;
  String? nodeId;
  String? avatarUrl;
  String? gravatarId;
  String? url;
  String? htmlUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? starredUrl;
  String? subscriptionsUrl;
  String? organizationsUrl;
  String? reposUrl;
  String? eventsUrl;
  String? receivedEventsUrl;
  String? type;
  bool? siteAdmin;
  String? name;
  String? company;
  String? blog;
  String? location;
  String? email;
  bool? hireable;
  String? bio;
  String? twitterUsername;
  int? publicRepos;
  int? publicGists;
  int? followers;
  int? following;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? privateGists;
  int? totalPrivateRepos;
  int? ownedPrivateRepos;
  int? diskUsage;
  int? collaborators;
  bool? twoFactorAuthentication;
  Plan? plan;

  factory AuthenticatedUserModel.fromRawJson(String str) =>
      AuthenticatedUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthenticatedUserModel.fromJson(Map<String, dynamic> json) =>
      AuthenticatedUserModel(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
        avatarUrl: json["avatar_url"],
        gravatarId: json["gravatar_id"],
        url: json["url"],
        htmlUrl: json["html_url"],
        followersUrl: json["followers_url"],
        followingUrl: json["following_url"],
        gistsUrl: json["gists_url"],
        starredUrl: json["starred_url"],
        subscriptionsUrl: json["subscriptions_url"],
        organizationsUrl: json["organizations_url"],
        reposUrl: json["repos_url"],
        eventsUrl: json["events_url"],
        receivedEventsUrl: json["received_events_url"],
        type: json["type"],
        siteAdmin: json["site_admin"],
        name: json["name"],
        company: json["company"],
        blog: json["blog"],
        location: json["location"],
        email: json["email"],
        hireable: json["hireable"],
        bio: json["bio"],
        twitterUsername: json["twitter_username"],
        publicRepos: json["public_repos"],
        publicGists: json["public_gists"],
        followers: json["followers"],
        following: json["following"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        privateGists: json["private_gists"],
        totalPrivateRepos: json["total_private_repos"],
        ownedPrivateRepos: json["owned_private_repos"],
        diskUsage: json["disk_usage"],
        collaborators: json["collaborators"],
        twoFactorAuthentication: json["two_factor_authentication"],
        plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "node_id": nodeId,
        "avatar_url": avatarUrl,
        "gravatar_id": gravatarId,
        "url": url,
        "html_url": htmlUrl,
        "followers_url": followersUrl,
        "following_url": followingUrl,
        "gists_url": gistsUrl,
        "starred_url": starredUrl,
        "subscriptions_url": subscriptionsUrl,
        "organizations_url": organizationsUrl,
        "repos_url": reposUrl,
        "events_url": eventsUrl,
        "received_events_url": receivedEventsUrl,
        "type": type,
        "site_admin": siteAdmin,
        "name": name,
        "company": company,
        "blog": blog,
        "location": location,
        "email": email,
        "hireable": hireable,
        "bio": bio,
        "twitter_username": twitterUsername,
        "public_repos": publicRepos,
        "public_gists": publicGists,
        "followers": followers,
        "following": following,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "private_gists": privateGists,
        "total_private_repos": totalPrivateRepos,
        "owned_private_repos": ownedPrivateRepos,
        "disk_usage": diskUsage,
        "collaborators": collaborators,
        "two_factor_authentication": twoFactorAuthentication,
        "plan": plan == null ? null : plan!.toJson(),
      };
}

class Plan {
  Plan({
    this.name,
    this.space,
    this.privateRepos,
    this.collaborators,
  });

  String? name;
  int? space;
  int? privateRepos;
  int? collaborators;

  factory Plan.fromRawJson(String str) => Plan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        name: json["name"],
        space: json["space"],
        privateRepos: json["private_repos"],
        collaborators: json["collaborators"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "space": space,
        "private_repos": privateRepos,
        "collaborators": collaborators,
      };
}
