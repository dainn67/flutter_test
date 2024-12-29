import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_app/blocs/counter/counter_event.dart';
import 'package:routing_app/blocs/counter/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0)) {
    on<IncrementCounterEvent>(_handleIncrementCounter);
    on<DecrementCounterEvent>(_handleDecrementCounter);
  }

  _handleIncrementCounter(CounterEvent event, Emitter<CounterState> emit) {
    emit(CounterState(state.counter + 1));
  }

  _handleDecrementCounter(CounterEvent event, Emitter<CounterState> emit) {
    emit(CounterState(state.counter - 1));
  }
}
