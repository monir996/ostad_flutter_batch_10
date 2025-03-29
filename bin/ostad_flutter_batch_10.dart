/*
* ========== Ostad Flutter Batch-10 Assignment ==========
* Assignment-01
* Name: Mohammad Monir Hossain
* Email: ahmedmonir303@gmail.com
* Phone: 01521439480
* */

abstract class Vehicle {
  int _speed = 0;

  void move();

  void setSpeed(int speed) {
    _speed = speed;
  }
}

class Car extends Vehicle {
  @override
  void move() {
    print("The car is moving at $_speed km/h");
  }
}
// -------- Main Function ---------
void main() {
  Car newCar = Car();
  newCar.setSpeed(120);
  newCar.move();
}