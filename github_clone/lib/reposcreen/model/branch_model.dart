// To parse this JSON data, do
//
//     final branchModel = branchModelFromJson(jsonString);

import 'dart:convert';

class BranchModel {
  BranchModel({
    this.name,
    this.commit,
    this.protected,
    this.protection,
    this.protectionUrl,
  });

  String? name;
  Commit? commit;
  bool? protected;
  Protection? protection;
  String? protectionUrl;

  factory BranchModel.fromRawJson(String str) =>
      BranchModel.fromJson(json.decode(str));

  String? toRawJson() => json.encode(toJson());

  factory BranchModel.fromJson(Map<String?, dynamic> json) => BranchModel(
        name: json["name"],
        commit: json["commit"] == null ? null : Commit.fromJson(json["commit"]),
        protected: json["protected"],
        protection: json["protection"] == null
            ? null
            : Protection.fromJson(json["protection"]),
        protectionUrl: json["protection_url"],
      );

  Map<String?, dynamic> toJson() => {
        "name": name,
        "commit": commit == null ? null : commit!.toJson(),
        "protected": protected,
        "protection": protection == null ? null : protection!.toJson(),
        "protection_url": protectionUrl,
      };
}

class Commit {
  Commit({
    this.sha,
    this.url,
  });

  String? sha;
  String? url;

  factory Commit.fromRawJson(String str) => Commit.fromJson(json.decode(str));

  String? toRawJson() => json.encode(toJson());

  factory Commit.fromJson(Map<String?, dynamic> json) => Commit(
        sha: json["sha"],
        url: json["url"],
      );

  Map<String?, dynamic> toJson() => {
        "sha": sha,
        "url": url,
      };
}

class Protection {
  Protection({
    this.enabled,
    this.requiredStatusChecks,
  });

  bool? enabled;
  RequiredStatusChecks? requiredStatusChecks;

  factory Protection.fromRawJson(String str) =>
      Protection.fromJson(json.decode(str));

  String? toRawJson() => json.encode(toJson());

  factory Protection.fromJson(Map<String?, dynamic> json) => Protection(
        enabled: json["enabled"],
        requiredStatusChecks: json["required_status_checks"] == null
            ? null
            : RequiredStatusChecks.fromJson(json["required_status_checks"]),
      );

  Map<String?, dynamic> toJson() => {
        "enabled": enabled,
        "required_status_checks": requiredStatusChecks == null
            ? null
            : requiredStatusChecks!.toJson(),
      };
}

class RequiredStatusChecks {
  RequiredStatusChecks({
    this.enforcementLevel,
    this.contexts,
    this.checks,
  });

  String? enforcementLevel;
  List<dynamic>? contexts;
  List<dynamic>? checks;

  factory RequiredStatusChecks.fromRawJson(String str) =>
      RequiredStatusChecks.fromJson(json.decode(str));

  String? toRawJson() => json.encode(toJson());

  factory RequiredStatusChecks.fromJson(Map<String?, dynamic> json) =>
      RequiredStatusChecks(
        enforcementLevel: json["enforcement_level"],
        contexts: json["contexts"] == null
            ? null
            : List<dynamic>.from(json["contexts"].map((x) => x)),
        checks: json["checks"] == null
            ? null
            : List<dynamic>.from(json["checks"].map((x) => x)),
      );

  Map<String?, dynamic> toJson() => {
        "enforcement_level": enforcementLevel,
        "contexts": contexts == null
            ? null
            : List<dynamic>.from(contexts!.map((x) => x)),
        "checks":
            checks == null ? null : List<dynamic>.from(checks!.map((x) => x)),
      };
}
