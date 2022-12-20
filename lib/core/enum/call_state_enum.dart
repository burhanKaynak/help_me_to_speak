enum CallState {
  calling('calling'),
  answered('answered'),
  rejected('rejected');

  final String value;
  const CallState(this.value);
}
