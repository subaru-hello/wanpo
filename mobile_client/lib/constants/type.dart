enum Country { japan, france }

extension CountryExtension on Country {
  static Country fromString(String countryString) {
    switch (countryString.toUpperCase()) {
      case 'JAPAN':
        return Country.japan;
      case 'FRANCE':
        return Country.france;
      default:
        throw ArgumentError('Unknown country string: $countryString');
    }
  }

  String toShortString() {
    return toString().split('.').last;
  }
}
