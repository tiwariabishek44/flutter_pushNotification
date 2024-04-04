class GroupApiResponse {
  String groupId;
  String groupCode;
  String groupName;
  String moderator;

  GroupApiResponse({
    required this.groupId,
    required this.groupCode,
    required this.groupName,
    required this.moderator,
  });

  factory GroupApiResponse.fromJson(Map<String, dynamic> json) {
    return GroupApiResponse(
      groupId: json['groupId'],
      groupCode: json['groupCode'],
      groupName: json['groupName'],
      moderator: json['moderator'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'groupCode': groupCode,
      'groupName': groupName,
      'moderator': moderator,
    };
  }
}
