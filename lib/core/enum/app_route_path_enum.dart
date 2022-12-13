enum RoutePath {
  splash('/splash'),
  welcome('/welcome'),
  auth('/auth'),
  home('/home'),
  chat('/chat'),
  call('/call'),
  helpCenterList('/helpCenterList'),
  nationalitySelectionMain('/nationalitySelectionMain');

  final String value;
  const RoutePath(this.value);
}
