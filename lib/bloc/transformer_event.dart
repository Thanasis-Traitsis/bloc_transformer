part of 'transformer_bloc.dart';

@immutable
abstract class TransformerEvent {}

class IncrementPressed extends TransformerEvent {}
class DecrementPressed extends TransformerEvent {}
class ResetPressed extends TransformerEvent {}