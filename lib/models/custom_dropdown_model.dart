class CustomDropdownModel {
  final String label;
  final String value;

  CustomDropdownModel({required this.label, required this.value});

  @override
  bool operator ==(Object other) => identical(this, other) || (other is CustomDropdownModel && other.value == value);

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => label;
}
