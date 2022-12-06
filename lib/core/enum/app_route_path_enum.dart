enum RoutePath {
  splash('/splash'),
  welcome('/welcome'),
  auth('/auth'),
  home('/home'),
  chat('/chat'),
  helpCenterList('/helpCenterList'),
  nationalitySelectionMain('/nationalitySelectionMain');

  final String value;
  const RoutePath(this.value);
}
