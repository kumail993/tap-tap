part of 'setiings_bloc.dart';

sealed class SetiingsState extends Equatable {
  const SetiingsState();
  
  @override
  List<Object> get props => [];
}

final class SetiingsInitial extends SetiingsState {}
