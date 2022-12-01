import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

import 'pages/home_page.dart';
import 'redux/app_middleware.dart';
import 'redux/app_reducer.dart';
import 'redux/app_state.dart';

late final Store<AppState> store;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  final initialState = await persistor.load();

  store = Store<AppState>(
    reducer,
    initialState: initialState ?? AppState.initial(),
    middleware: [persistor.createMiddleware(), ...appMiddleware()],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Redux Persistor',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
