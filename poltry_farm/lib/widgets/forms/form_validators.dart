typedef PfValidator = String? Function(String?);

class PfFormValidators {
  static String? required(String? value) {
    // If the value is null or empty, return error message
    if (value == null || value.isEmpty) {
      return 'Fill all the details';
    }

    // If the value is not null or empty, return null
    return null;
  }

  static PfValidator compose<T>(List<PfValidator> validators) {
    return (String? value) {
      for (final func in validators) {
        final result = func.call(value);

        if (result != null) {
          return result;
        }
      }

      return null;
    };
  }
}
