int determinePage(
  int itemCount,
  int currentIndex,
  int delta,
) {
  int newIndex = currentIndex + delta;
  if (newIndex < 0) {
    newIndex = itemCount - 1;
  } else if (newIndex >= itemCount) {
    newIndex = 0;
  }
  return newIndex;
}
