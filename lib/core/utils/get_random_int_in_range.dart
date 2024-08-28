import 'dart:math';

int getRandomIntInRange([int min = 20, int max = 100]) {
  var random = Random();
  int randomNumber = min + random.nextInt(max - min + 1);
  return randomNumber;
}
