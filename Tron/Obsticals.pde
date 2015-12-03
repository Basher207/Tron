class Obstical extends GameObject implements ColoredObject {
	Trail 	   [] trails;
	color obsticleColor;
	Obstical (GridVector [] verts, color obsticleColor) {
		this.obsticleColor = obsticleColor;
		trails = new Trail [verts.length];
		trails[0] 			  = new Trail(verts[verts.length - 1], this);
		trails[0].endPosition = verts[0];
		for (int i = 1; i < verts.length; i++) {
			trails[i] = new Trail (verts[i - 1], this);
			trails[i].endPosition = verts[i];
		}
	}
	void Render () {
		for (Trail trail : trails) 
			trail.Render();
	}
	color ObjectColor () {
		return obsticleColor;
	}
}