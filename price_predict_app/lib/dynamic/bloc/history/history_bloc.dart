import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:price_predict_app/dynamic/API/history_repo.dart';
import 'package:price_predict_app/dynamic/models/history_model.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial());
  HistoryRepository _historyRepository = HistoryRepository();
  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
    if (event is GetHistoryEvent) {
      try {
        yield HistoryLoadingState();
        List<HistoryModel> historyModel =
            await _historyRepository.getHistoryByUserId();
        yield HistoryLoadedState(historyModel);
      } on Exception {
        yield HistoryFailureState('Network Error');
      }
    }
    if (event is PostHistoryEvent) {
      try {
        yield HistoryLoadingState();
        await _historyRepository.insertHistory(event.historyModel);
      } on Exception {
        yield HistoryFailureState('Network Error');
      }
    }
    if (event is DeleteHistoryEvent) {
      try {
        yield HistoryLoadingState();
        await _historyRepository.deleteHistoryById(event.id);
        List<HistoryModel> historyModel =
            await _historyRepository.getHistoryByUserId();
        yield HistoryLoadedState(historyModel);
      } on Exception {
        yield HistoryFailureState('Network Error');
      }
    }
  }
}
