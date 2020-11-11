class Failure {
  const Failure(this.message);
  final String message;
}

class InnerFailure extends Failure {
  const InnerFailure(message) : super(message);
}
