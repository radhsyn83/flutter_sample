import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class ServerException extends Failure {
  final String message;
  const ServerException(this.message) : super(message);
}

class FormException extends Failure {
  final String message;
  const FormException(this.message) : super(message);
}
