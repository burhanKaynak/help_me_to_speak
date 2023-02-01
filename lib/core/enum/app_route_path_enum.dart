enum RoutePath {
  splash('/splash'),
  welcome('/welcome'),
  auth('/auth'),
  home('/home'),
  chat('/chat'),
  call('/call'),
  product('/product'),
  helpCenterList('/helpCenterList'),
  nationalitySelectionMain('/nationalitySelectionMain');

  final String value;
  const RoutePath(this.value);
}
