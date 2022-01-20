part of 'feature_bloc.dart';

@immutable
abstract class FeatureState {
  const FeatureState();
}

class FeatureInitial extends FeatureState {
  const FeatureInitial();
}

class FeatureLoading extends FeatureState {
  const FeatureLoading();
}

class FeatureLoaded extends FeatureState {
  final String price;
  const FeatureLoaded(this.price);
}

class FeatureFailure extends FeatureState {
  final String msg;
  const FeatureFailure(this.msg);
}
