// To parse this JSON data, do
//
//     final organizationModel = organizationModelFromJson(jsonString);

import 'dart:convert';

class OrganizationModel {
  OrganizationModel({
    this.login,
    this.id,
    this.nodeId,
    this.url,
    this.reposUrl,
    this.eventsUrl,
    this.hooksUrl,
    this.issuesUrl,
    this.membersUrl,
    this.publicMembersUrl,
    this.avatarUrl,
    this.description,
  });

  String? login;
  int? id;
  String? nodeId;
  String? url;
  String? reposUrl;
  String? eventsUrl;
  String? hooksUrl;
  String? issuesUrl;
  String? membersUrl;
  String? publicMembersUrl;
  String? avatarUrl;
  String? description;

  factory OrganizationModel.fromRawJson(String str) =>
      OrganizationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      OrganizationModel(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
        url: json["url"],
        reposUrl: json["repos_url"],
        eventsUrl: json["events_url"],
        hooksUrl: json["hooks_url"],
        issuesUrl: json["issues_url"],
        membersUrl: json["members_url"],
        publicMembersUrl: json["public_members_url"],
        avatarUrl: json["avatar_url"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "node_id": nodeId,
        "url": url,
        "repos_url": reposUrl,
        "events_url": eventsUrl,
        "hooks_url": hooksUrl,
        "issues_url": issuesUrl,
        "members_url": membersUrl,
        "public_members_url": publicMembersUrl,
        "avatar_url": avatarUrl,
        "description": description,
      };
}
