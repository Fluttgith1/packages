// The code in this file (and all other dart files in the package) is
// analyzed using the rules activated in `analysis_options.yaml`.

// With the following syntax lint rules are deactivated for the entire file:
// ignore_for_file: avoid_renaming_method_parameters

void main() {
  const String partOne = 'Hello';
  const String partTwo = 'World';

  // With the following syntax lint rules are deactivated on a per-line basis:
  print('$partOne $partTwo'); // ignore: avoid_print
}

abstract class Base {
  int methodA(int foo);
  String methodB(String foo);
}

// Normally, the parameter renaming from `foo` to `bar` in this class would
// trigger the `avoid_renaming_method_parameters` lint, but it has been
// deactivated for the file with the `ignore_for_file` comment above.
class Sub extends Base {
  @override
  int methodA(int bar) => bar;

  @override
  String methodB(String bar) => bar;
}
