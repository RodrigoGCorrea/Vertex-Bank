part of 'echeckform_cubit.dart';

enum ECheckFormStage { initial, selected }

class ECheckFormState extends Equatable {
  const ECheckFormState({
    @required this.amount,
    @required this.senderId,
    @required this.stage,
    @required this.userMoney,
  });

  final MoneyAmount amount;
  final String senderId;
  final ECheckFormStage stage;
  final int userMoney;

  static final empty = ECheckFormState(
    amount: MoneyAmount(value: 0),
    senderId: "",
    stage: ECheckFormStage.initial,
    userMoney: 0,
  );

  ECheckFormState copyWith({
    MoneyAmount amount,
    String senderId,
    ECheckFormStage stage,
    int userMoney,
  }) {
    return ECheckFormState(
      amount: amount ?? this.amount,
      senderId: senderId ?? this.senderId,
      stage: stage ?? this.stage,
      userMoney: userMoney ?? this.userMoney,
    );
  }

  @override
  List<Object> get props => [
        amount,
        senderId,
        stage,
        userMoney,
      ];
}
