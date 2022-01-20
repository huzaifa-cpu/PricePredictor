import 'package:flutter/material.dart';
import 'package:price_predict_app/dynamic/firebase/auth_state/decider.dart';
import 'package:price_predict_app/dynamic/models/auth_model.dart';
import 'package:provider/provider.dart';

import '../auth_repository.dart';

class Collector extends StatefulWidget {
  @override
  _CollectorState createState() => _CollectorState();
}

class _CollectorState extends State<Collector> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AuthModel>.value(
        initialData: null,
        value: AuthRepository().getUserForState,
        child: Decider());
  }
}
