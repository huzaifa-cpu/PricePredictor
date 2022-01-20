part of 'history_bloc.dart';

@immutable
abstract class HistoryState {
  const HistoryState();
}

class HistoryInitial extends HistoryState {
  const HistoryInitial();
}

class HistoryLoadingState extends HistoryState {
  const HistoryLoadingState();
}

class HistoryLoadedState extends HistoryState {
  final List<HistoryModel> historyModel;
  const HistoryLoadedState(this.historyModel);
}

class HistoryFailureState extends HistoryState {
  final String msg;
  const HistoryFailureState(this.msg);
}
