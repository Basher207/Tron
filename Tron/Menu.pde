class Menu {
	ArrayList <MenuItem> menuItems;
	ArrayList <Button>   buttons;
	Menu () {
		menuItems = new ArrayList <MenuItem> ();
		buttons   = new ArrayList <Button> ();
		buttons.add   (new Button (new Bounds2D (new GridVector (width/2 - 50,height/2 - 50), new GridVector (width/2 + 50,height/2 + 50)), "Restart", 
					   new FunctionContainer () {public void Function () {setup ();}}));
		menuItems.add (new Plane  (new Bounds2D (new GridVector (0,0), new GridVector (width,height)), color (0, 100)));
	}
	void Update () {
		for (MenuItem menuItem : menuItems) {
			menuItem.Render ();
		}
		for (Button button : buttons) {
			button.Render ();
		}
	}
	void MousePressed () {
		for (Button button : buttons)
			button.MousePressed ();
	}
}

abstract class MenuItem {
	Bounds2D bound;
	abstract void Render ();
}
class Plane extends MenuItem {
	color col;
	Plane (Bounds2D bound, color col) {
		this.bound = bound;
		this.col   = col;
	}
	void Render () {
		rectMode (CORNERS);
		noStroke();
		fill(col);
		rect (bound.min.x, bound.min.y, bound.max.x, bound.max.y);
	}
}
class Button extends MenuItem {
	FunctionContainer functionCall;
	String description;
	Button (Bounds2D bound, String description, FunctionContainer functionCall) {
		this.bound = bound;
		this.description = description;
		this.functionCall = functionCall;
	}
	void Render () {
		rectMode (CORNERS);
		stroke (255);
		strokeWeight (2);
		noFill();
		rect (bound.min.x, bound.min.y, bound.max.x, bound.max.y);
		fill (255);

		GridVector center = bound.min.Get().Sub (bound.max).Div (2).Add (bound.max);
		textAlign(CENTER);
		text (description, center.x, center.y);
	}
	void MousePressed () {
		if (bound.Intersects (new GridVector (mouseX, mouseY)))
			functionCall.Function ();
	}
}