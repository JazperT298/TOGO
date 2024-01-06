// ignore_for_file: prefer_initializing_formals

class TontineGroupModel {
  String? groupId;
  String? groupName;

  TontineGroupModel();

  TontineGroupModel.withData(String groupId, String groupName) {
    this.groupId = groupId;
    this.groupName = groupName;
  }

  String? getGroupId() {
    return groupId;
  }

  void setGroupId(String? groupId) {
    this.groupId = groupId;
  }

  String? getGroupName() {
    return groupName;
  }

  void setGroupName(String? groupName) {
    this.groupName = groupName;
  }
}
