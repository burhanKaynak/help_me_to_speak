enum RoutePath {
  splash('/splash'),
  welcome('/welcome'),
  auth('/auth'),
  home('/home');

  final String value;
  const RoutePath(this.value);
}
