import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:price_predict_app/dynamic/API/prediction_repo.dart';
import 'package:price_predict_app/dynamic/models/feature_model.dart';

part 'feature_event.dart';
part 'feature_state.dart';

class FeatureBloc extends Bloc<FeatureEvent, FeatureState> {
  FeatureBloc() : super(FeatureInitial());
  PredictionRepository _predictionRepository = PredictionRepository();

  @override
  Stream<FeatureState> mapEventToState(FeatureEvent event) async* {
    if (event is GetPrice) {
      try {
        yield FeatureLoading();
        String price =
            await _predictionRepository.getPrediction(event.featureModel);
        yield FeatureLoaded(price);
      } on Exception {
        yield FeatureFailure('Network Error');
      }
    } else if (event is SetIntial) {
      try {
        yield FeatureInitial();
      } on Exception {
        yield FeatureFailure('Network Error');
      }
    }
  }
}
