class Points {
  int y_pos, new_points;

  Points(int random_points) {
    new_points = random_points;
    y_pos = 300;
  }

  void movePoints() {
    y_pos--;
    drawPoints();
  }

  //teken de punten nieuwe punten
  void drawPoints() {
    fill(0, 102, 153);
    text("+ " + new_points, 300, y_pos);
  }

// return true als punten buiten het scherm zijn
  boolean outOfBounds() {
    if (y_pos <= -30) {
      return true;
    } else {
      return false;
    }
  }
}
