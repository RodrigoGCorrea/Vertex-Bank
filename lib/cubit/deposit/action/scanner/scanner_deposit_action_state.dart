part of 'scanner_deposit_action_cubit.dart';

abstract class ScannerDepositActionState extends Equatable {
  const ScannerDepositActionState();

  @override
  List<Object> get props => [];
}

class ScannerDepositActionInitial extends ScannerDepositActionState {}

class ScannerDepositActionLoading extends ScannerDepositActionState {}

class ScannerDepositActionError extends ScannerDepositActionState {
  const ScannerDepositActionError({
    @required this.error,
  });

  final Failure error;

  @override
  List<Object> get props => [
        error,
      ];
}

class ScannerDepositActionFinished extends ScannerDepositActionState {
  const ScannerDepositActionFinished({
    @required this.parsedECheck,
    @required this.senderName,
  });

  final ECheck parsedECheck;
  final String senderName;

  @override
  List<Object> get props => [
        parsedECheck,
        senderName,
      ];
}
