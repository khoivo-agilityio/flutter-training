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

  // If the value is not a valid email, return error message
  static String? email(String? value) {
    // Regular expression for validating an email address
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    // If the value is null or does not match the regex, return error message
    if (value == null || !emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    }

    // If the value is a valid email, return null
    return null;
  }

  // If the value is not a valid password, return error message
  static String? password(String? value) {
    // Regular expression for validating a password
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );

    // If the value is null or does not match the regex, return error message
    if (value == null || !passwordRegex.hasMatch(value)) {
      return 'Invalid password';
    }

    // If the value is a valid password, return null
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
