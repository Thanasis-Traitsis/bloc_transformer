import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';

part 'transformer_event.dart';
part 'transformer_state.dart';

class TransformerBloc extends Bloc<TransformerEvent, TransformerState> {
  TransformerBloc() : super(const TransformerState(count: 0)) {
    on<IncrementPressed>(
      _onIncrement,
      transformer: concurrent(),
    );
    on<DecrementPressed>(
      _onDecrement,
      transformer: concurrent()
    );
    on<ResetPressed>(_onReset);
  }

  Future<void> _onIncrement(
      IncrementPressed event, Emitter<TransformerState> emit) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(count: state.count + 1));
  }

  Future<void> _onDecrement(
      DecrementPressed event, Emitter<TransformerState> emit) async {
    await Future.delayed(const Duration(seconds: 2)); 
    emit(state.copyWith(count: state.count - 1));
  }

  void _onReset(ResetPressed event, Emitter<TransformerState> emit) {
    emit(const TransformerState(count: 0));
  }
}