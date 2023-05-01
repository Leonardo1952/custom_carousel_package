// ignore_for_file: file_names

String converterNumAlp(int num) {
  const int lettersInAlphabet = 26;
  const int asc = 96;
  if (num > lettersInAlphabet) {
    return "";
  }
  String letra = String.fromCharCode(num + asc);
  return letra;
}
