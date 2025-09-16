abstract class GroupEvent {}

class SearchGroupByCodeEvent extends GroupEvent {
  final String code;

  SearchGroupByCodeEvent(this.code);
}

class LoadMemberGroupEvent extends GroupEvent {
}