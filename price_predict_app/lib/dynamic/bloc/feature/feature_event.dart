part of 'feature_bloc.dart';

@immutable
abstract class FeatureEvent {
  const FeatureEvent();
}

class GetPrice extends FeatureEvent {
  final FeatureModel featureModel;
  const GetPrice(this.featureModel);
}
class SetIntial extends FeatureEvent {
  const SetIntial();
}
