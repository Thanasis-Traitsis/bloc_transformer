part of 'transformer_bloc.dart';

@immutable
class TransformerState {
  final int count;
  final bool isLoading;

  const TransformerState({
    required this.count,
    this.isLoading = false,
  });

  TransformerState copyWith({
    int? count,
    bool? isLoading,
  }) {
    return TransformerState(
      count: count ?? this.count,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
