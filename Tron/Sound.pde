import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

Minim minim;

AudioPlayer crash;
AudioPlayer pickup;

void SetupSound () {
  minim = new Minim (this);
  //crash = minim.loadFile("Crash");
  pickup = minim.loadFile("Pickup.aif");
}
void PlayCrash () {
  //crash.play ();
}
void PlayPickup () {
  pickup.rewind ();
  pickup.play ();
}