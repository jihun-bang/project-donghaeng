abstract class NavigationService {
  get key;

  void pop({Object? arguments});

  Future<void> pushNamed(String routeName, {Object? arguments});

  pushNamedAndRemoveAll(String routeName, {Object? arguments});
}
