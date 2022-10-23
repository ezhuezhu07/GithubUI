// To parse this JSON data, do
//
//     final collaboratorModel = collaboratorModelFromJson(jsonString);

import 'dart:convert';

class CollaboratorModel {
  CollaboratorModel({
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
    this.permissions,
    this.roleName,
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
  Permissions? permissions;
  String? roleName;

  factory CollaboratorModel.fromRawJson(String str) =>
      CollaboratorModel.fromJson(json.decode(str));

  String? toRawJson() => json.encode(toJson());

  factory CollaboratorModel.fromJson(Map<String?, dynamic> json) =>
      CollaboratorModel(
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
        permissions: json["permissions"] == null
            ? null
            : Permissions.fromJson(json["permissions"]),
        roleName: json["role_name"],
      );

  Map<String?, dynamic> toJson() => {
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
        "permissions": permissions == null ? null : permissions!.toJson(),
        "role_name": roleName,
      };
}

class Permissions {
  Permissions({
    this.admin,
    this.maintain,
    this.push,
    this.triage,
    this.pull,
  });

  bool? admin;
  bool? maintain;
  bool? push;
  bool? triage;
  bool? pull;

  factory Permissions.fromRawJson(String str) =>
      Permissions.fromJson(json.decode(str));

  String? toRawJson() => json.encode(toJson());

  factory Permissions.fromJson(Map<String?, dynamic> json) => Permissions(
        admin: json["admin"],
        maintain: json["maintain"],
        push: json["push"],
        triage: json["triage"],
        pull: json["pull"],
      );

  Map<String?, dynamic> toJson() => {
        "admin": admin,
        "maintain": maintain,
        "push": push,
        "triage": triage,
        "pull": pull,
      };
}
