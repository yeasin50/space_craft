int getInt(b) {
  print("inner: $b");
  int ba;
  getInt(ba);
  return ba;
}

main(List<String> args) {
  var b = 2;
  print(getInt(b));
}
