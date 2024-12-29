import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing_app/blocs/counter/counter_bloc.dart';
import 'package:routing_app/blocs/counter/counter_event.dart';
import 'package:routing_app/blocs/counter/counter_state.dart';
import 'package:routing_app/ui/components/main_button.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<CounterBloc, CounterState>(builder: (context, state) => Text('Counter: ${state.counter}')),
            MainButton(
                title: 'Increment',
                onPressed: () {
                  context.read<CounterBloc>().add(IncrementCounterEvent());
                }),
            MainButton(
                title: 'Decrement',
                onPressed: () {
                  context.read<CounterBloc>().add(DecrementCounterEvent());
                }),
          ],
        ),
      ),
    );
  }
}
