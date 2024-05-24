String? validateName(String? value) => switch (value) {
      String(:final isEmpty) when isEmpty => 'Please enter role name',
      String(:final length) when length < 3 =>
        'Name must be at least 3 characters',
      _ => null
    };

String? validateDescription(String? value) => switch (value) {
      String(:final isEmpty) when isEmpty => 'Please enter role description',
      String(:final length) when length < 3 =>
        'Description must be at least 3 characters',
      _ => null
    };

String? validateEmail(String? value) => switch (value) {
      String(:final isEmpty) when isEmpty => 'Please enter user email',
      String()
          when !RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value) =>
        'Please enter a valid email address',
      _ => null
    };
