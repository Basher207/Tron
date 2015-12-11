class Obstical implements ColoredObject {
  ;
  color obsticleColor;
  Obstical (GridVector [] verts, color obsticleColor) {
    this.obsticleColor = obsticleColor;
    Trail [] trails = new Trail [verts.length];
    trails[0] 			  = new Trail(verts[verts.length - 1], this, false);
    trails[0].endPosition = verts[0];
    for (int i = 1; i < verts.length; i++) {
      trails[i] = new Trail (verts[i - 1], this, false);
      trails[i].endPosition = verts[i];
    }
    for (Trail trail : trails) {
      game.trails.add(trail);
    }
  }
  color ObjectColor () {
    return obsticleColor;
  }
}