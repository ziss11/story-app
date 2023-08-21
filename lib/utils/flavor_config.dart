enum FlavorType { free, paid }

class FlavorConfig {
  final FlavorType flavorType;

  static FlavorConfig? _instance;

  static FlavorConfig get instance => _instance ?? FlavorConfig();

  FlavorConfig({this.flavorType = FlavorType.free}) {
    _instance = this;
  }
}
