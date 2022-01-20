part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {
  const HistoryEvent();
}

class GetHistoryEvent extends HistoryEvent {
  const GetHistoryEvent();
}

class PostHistoryEvent extends HistoryEvent {
  final HistoryModel historyModel;
  const PostHistoryEvent(this.historyModel);
}

class DeleteHistoryEvent extends HistoryEvent {
  final int id;
  const DeleteHistoryEvent(this.id);
}
