String? validateEmail(String? value) => switch (value) {
  String(:final isEmpty) when isEmpty => 'Please enter user firstname',
  String(:final length) when length < 3 =>
  'Firstname must be at least 3 characters',
  _ => null
};

String? validatePassword(String? value) => switch (value) {
  String(:final isEmpty) when isEmpty => 'Please enter user lastname',
  String(:final length) when length < 3 =>
  'Lastname must be at least 3 characters',
  _ => null
};