// text_on_cube.scad - Example for text() usage in OpenSCAD

echo(version=version());

font = "Liberation Sans"; //["Liberation Sans", "Liberation Sans:style=Bold", "Liberation Sans:style=Italic", "Liberation Mono", "Liberation Serif"]

cube_size = 60;
letter_size = 50;
letter_height = 5;

o = cube_size / 2 - letter_height / 2;

module letter(l) {
  // Use linear_extrude() to make the letters 3D objects as they
  // are only 2D shapes when only using text()
  linear_extrude(height = letter_height) {
    text(l, size = letter_size, font = font, halign = "center", valign = "center", $fn = 16);
  }
}



module paw() {
    linear_extrude(2)
      resize([20, 0], auto=[false, true])
      import("Paw_Print.svg");
}

module bone() {
    linear_extrude(2)
      resize([20, 0], auto=[false, true])
      import("bone.svg");
}

paw();

!bone();
