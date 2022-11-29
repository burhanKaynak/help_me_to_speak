enum RoutePath {
  splash('/splash'),
  welcome('/welcome'),
  auth('/auth'),
  home('/home'),
  chat('/chat');

  final String value;
  const RoutePath(this.value);
}
