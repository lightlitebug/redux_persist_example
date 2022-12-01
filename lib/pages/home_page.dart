import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../redux/app_state.dart';
import '../redux/counter/counter_action.dart';
import '../redux/quote/quote_action.dart';
import '../redux/quote/quote_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: StoreConnector<AppState, ViewModel>(
        distinct: true,
        converter: (Store<AppState> store) => ViewModel.fromStore(store),
        builder: (BuildContext context, ViewModel vm) {
          return Center(
            child: Column(
              children: [
                const SizedBox(height: 60.0),
                Text(
                  '${vm.counter}',
                  style: const TextStyle(fontSize: 42),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: vm.increment,
                      child: const Text(
                        'INCREMENT',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: vm.decrement,
                      child: const Text(
                        'DECREMENT',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 80.0,
                  thickness: 5,
                ),
                ElevatedButton(
                  onPressed: vm.getQuote,
                  child: const Text(
                    'Get Quote',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                ShowQuote(vm: vm),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ShowQuote extends StatelessWidget {
  final ViewModel vm;
  const ShowQuote({
    Key? key,
    required this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (vm.quoteStatus == QuoteStatus.initial) {
      return Container();
    } else if (vm.quoteStatus == QuoteStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (vm.quoteStatus == QuoteStatus.failure) {
      return Center(
        child: Text(
          vm.error,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.red,
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          Text(
            "${vm.author.isEmpty ? 'Anonymous' : vm.author} said",
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            vm.content.isEmpty ? 'Good Luck!' : vm.content,
            style: const TextStyle(
              fontSize: 18.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ViewModel extends Equatable {
  final int counter;
  final void Function() increment;
  final void Function() decrement;
  final String author;
  final String content;
  final String error;
  final QuoteStatus quoteStatus;
  final void Function() getQuote;
  const ViewModel({
    required this.counter,
    required this.increment,
    required this.decrement,
    required this.author,
    required this.content,
    required this.error,
    required this.quoteStatus,
    required this.getQuote,
  });

  @override
  List<Object> get props {
    return [
      counter,
      author,
      content,
      error,
      quoteStatus,
    ];
  }

  static fromStore(Store<AppState> store) {
    return ViewModel(
      counter: store.state.counterState.counter,
      increment: () => store.dispatch(IncrementAction()),
      decrement: () => store.dispatch(DecrementAction()),
      author: store.state.quoteState.quote.author,
      content: store.state.quoteState.quote.content,
      error: store.state.quoteState.error,
      quoteStatus: store.state.quoteState.quoteStatus,
      getQuote: () => store.dispatch(getQuoteAndDispatch()),
    );
  }
}
