 /* @pjs preload="mendiola.png"; */
PImage map;

int posX = 10;
int poxY = 10;

int vehicleNo = 100;

Vehicle vehicle1;
Vehicle vehicle2;

int quiapoX = 10;
int quiapoY = 200;
int quiapoR2Y = quiapoY + 100;

int legardaX = 970;
int legardaY = 200;
int legardaR2Y = legardaY + 100;

int rectoX = 340;
int rectoY = 10;
int rectoR2X = rectoX + 300;

int mendiolaX = 340;
int mendiolaY = 600;
int mendiolaR2X = mendiolaX + 300;

Vehicle[] vehicles = new Vehicle[vehicleNo];

/* toggle flags */

boolean running = true;

boolean openQ2L = false;
boolean openQ2M = false;

boolean openM2L = false;
boolean openM2Q = false;
boolean openM2R = false;

boolean openL2Q = false;
boolean openL2M = false;
boolean openL2R = false;

boolean openR2L = false;
boolean openR2M = false;
boolean openR2Q = false;

/* from quiapo */
Vehicle[] vehiclesQ2M = new Vehicle[vehicleNo]; /* 1 */
Vehicle[] vehiclesQ2L = new Vehicle[vehicleNo]; /* 2 */
/* add quiapo to recto */
/* from mendiola */
Vehicle[] vehiclesM2Q = new Vehicle[vehicleNo]; /* 3 */
Vehicle[] vehiclesM2R = new Vehicle[vehicleNo]; /* 4 */
Vehicle[] vehiclesM2L = new Vehicle[vehicleNo]; /* 5 */
/* from legarda */
Vehicle[] vehiclesL2Q = new Vehicle[vehicleNo]; /* 6 */
Vehicle[] vehiclesL2R = new Vehicle[vehicleNo]; /* 7 */
Vehicle[] vehiclesL2M = new Vehicle[vehicleNo]; /* 8 */ /* remove this */
/* from recto */
Vehicle[] vehiclesR2Q = new Vehicle[vehicleNo]; /* 9 */
Vehicle[] vehiclesR2M = new Vehicle[vehicleNo]; /* 10 */
Vehicle[] vehiclesR2L = new Vehicle[vehicleNo]; /* 11 */

/* GRAPH UNORDERED GROUP *
/* {Q2M, Q2L, Q2R, M2Q, M2R, M2L, L2Q, L2R, R2Q, R2M, R2L} */

Button button1;
Button button2;
Button button3;
Button button4;
Button button5;
Button button6;
Button button7;
Button button8;
Button button9;
Button button10;
Button button11;

Button play, pause, stop;

void setup() {
	size(1270, 1000);
	stroke(255);
	println("traffic simulation | current vehicle count: " + vehicleNo);

	/* drawing roads */
	prepDestinations();

	startAnimation(1);

	// Load map background
	map = loadImage("mendiola.png");
	map.resize(1270, 700);
	image(map, 0, 0);

	// Control buttons
	button1 = new Button("1",20,30);
	button2 = new Button("2",20,55);
	button3 = new Button("3",20,80);
	button4 = new Button("4",20,105);
	button5 = new Button("5",20,130);
	button6 = new Button("6",50,30);
	button7 = new Button("7",50,55);
	button8 = new Button("8",50,80);
	button9 = new Button("9",50,105);
	button10 = new Button("10",50,130);
	button11 = new Button("11",80,30);

	play = new Button("Play", 500, 400);
	pause = new Button("Pause", 700, 400);
}

void prepDestinations(){
	/* draw quiapo R1 */
	rect(quiapoX, quiapoY, 300, 100);
	/* draw quiapo R2 */
	rect(quiapoX, quiapoR2Y, 300, 100);

	fill(255,0,0);
	/* draw quiapo R1 */
	rect(legardaX, legardaY, 300, 100);
	/* draw quiapo R2 */
	rect(legardaX, legardaR2Y, 300, 100);

	fill(255,0,0);
	/* draw recto R1 */
	rect(rectoX, rectoY, 300, 100);
	/* draw recto R2 */
	rect(rectoR2X, rectoY, 300, 100);

	fill(0,255,0);
	/* draw mendiola R1 */
	rect(mendiolaX, mendiolaY, 300, 100);
	/* draw mendiola R2 */
	rect(mendiolaR2X, mendiolaY, 300, 100);

	fill(0,0,255);
}

void startAnimation(int animType){
	for(int x=0; x<vehicles.length; x++){
		/* from quiapo */
		vehiclesQ2M[x] = new Vehicle(quiapoX,quiapoR2Y,1);
		vehiclesQ2L[x] = new Vehicle(quiapoX,quiapoR2Y,1);
		/* from mendiola */
		vehiclesM2Q[x] = new Vehicle(mendiolaR2X,mendiolaY,2);
		vehiclesM2R[x] = new Vehicle(mendiolaR2X,mendiolaY,2);
		vehiclesM2L[x] = new Vehicle(mendiolaR2X,mendiolaY,2);
		/* from legarda */
		vehiclesL2Q[x] = new Vehicle(legardaX,legardaY,1);
		vehiclesL2R[x] = new Vehicle(legardaX,legardaY,1);
		vehiclesL2M[x] = new Vehicle(legardaX,legardaY,1);
		/* from recto */
		vehiclesR2Q[x] = new Vehicle(rectoX,rectoY,2);
		vehiclesR2M[x] = new Vehicle(rectoX,rectoY,2);
		vehiclesR2L[x] = new Vehicle(rectoX,rectoY,2);
	}

	for(int x=0; x<vehicles.length; x++){
		/* from quiapo */
		vehiclesQ2M[x].evaluateDirection(mendiolaX,mendiolaY);
		vehiclesQ2L[x].evaluateDirection(legardaX,legardaR2Y);
		/* from mendiola */
		vehiclesM2Q[x].evaluateDirection(quiapoX,quiapoY);
		vehiclesM2R[x].evaluateDirection(rectoR2X,rectoY);
		vehiclesM2L[x].evaluateDirection(legardaX,legardaR2Y);
		/* from legarda */
		vehiclesL2Q[x].evaluateDirection(quiapoX,quiapoY);
		vehiclesL2R[x].evaluateDirection(rectoR2X,rectoY);
		vehiclesL2M[x].evaluateDirection(mendiolaX,mendiolaY);
		/* from recto */
		vehiclesR2Q[x].evaluateDirection(quiapoX,quiapoY);
		vehiclesR2M[x].evaluateDirection(mendiolaX,mendiolaY);
		vehiclesR2L[x].evaluateDirection(legardaX,legardaR2Y);
	}
}

void draw(){
	background(255);
	fill(0, 20, 150);

	image(map, 0, 0);

	prepDestinations();

	button1.redraw();
	button2.redraw();
	button3.redraw();
	button4.redraw();
	button5.redraw();
	button6.redraw();
	button7.redraw();
	button8.redraw();
	button9.redraw();
	button10.redraw();
	button11.redraw();

	play.redraw();
	pause.redraw();

	if(running){

		for(int x=0; x<vehicles.length; x++){
			/* from mendiola */
			if(openQ2M){
				vehiclesQ2M[x].move(mendiolaX,mendiolaY);
			}
			if(openQ2L){
				vehiclesQ2L[x].move(legardaX,legardaR2Y);
			}

			/* from quiapo */
			if(openM2Q){
				vehiclesM2Q[x].move(quiapoX,quiapoY);
			}
			if(openM2R){
				vehiclesM2R[x].move(rectoR2X,rectoY);
			}
			if(openM2L){
				vehiclesM2L[x].move(legardaX,legardaR2Y);
			}
			
			/* from legarda */
			if(openL2Q){
				vehiclesL2Q[x].move(quiapoX,quiapoY);
			}
			if(openL2R){
				vehiclesL2R[x].move(rectoR2X,rectoY);
			}
			if(openL2M){
				vehiclesL2M[x].move(mendiolaX,mendiolaY);
			}
			
			/* from recto */
			if(openR2Q){
				vehiclesR2Q[x].move(quiapoX,quiapoY);
			}
			if(openR2M){
				vehiclesR2M[x].move(mendiolaX,mendiolaY);
			}
			if(openR2L){
				vehiclesR2L[x].move(legardaX,legardaR2Y);
			}
		}
	}
	else{
		for(int x=0; x<vehicles.length; x++){
			if(openQ2M){
				vehiclesQ2M[x].visualize();
			}
			if(openQ2L){
				vehiclesQ2L[x].visualize();
			}

			/* from quiapo */
			if(openM2Q){
				vehiclesM2Q[x].visualize();
			}
			if(openM2R){
				vehiclesM2R[x].visualize();
			}
			if(openM2L){
				vehiclesM2L[x].visualize();
			}

			/* from legarda */
			if(openL2Q){
				vehiclesL2Q[x].visualize();
			}
			if(openL2R){
				vehiclesL2R[x].visualize();
			}
			if(openL2M){
				vehiclesL2M[x].visualize();
			}

			/* from recto */
			if(openR2Q){
				vehiclesR2Q[x].visualize();
			}
			if(openR2M){
				vehiclesR2M[x].visualize();
			}
			if(openR2L){
				vehiclesR2L[x].visualize();
			}
		}
	}
}

void mousePressed(){
	if(button1.clicked(mouseX, mouseY)){
		openQ2M = button1.toggleOn;
		startAnimation();
	}

	if(button2.clicked(mouseX, mouseY)){
		openQ2L = button2.toggleOn;
		startAnimation();
	}

	if(button3.clicked(mouseX, mouseY)){
		openM2Q = button3.toggleOn;
		startAnimation();
	}

	if(button4.clicked(mouseX, mouseY)){
		openM2R = button4.toggleOn;
		startAnimation();
	}

	if(button5.clicked(mouseX, mouseY)){
		openM2L = button5.toggleOn;
		startAnimation();
	}

	if(button6.clicked(mouseX, mouseY)){
		openL2Q = button6.toggleOn;
		startAnimation();
	}

	if(button7.clicked(mouseX, mouseY)){
		openL2R = button7.toggleOn;
		startAnimation();
	}

	if(button8.clicked(mouseX, mouseY)){
		openL2M = button8.toggleOn;
		startAnimation();
	}

	if(button9.clicked(mouseX, mouseY)){
		openR2Q = button9.toggleOn;
		startAnimation();
	}

	if(button10.clicked(mouseX, mouseY)){
		openR2M = button10.toggleOn;
		startAnimation();
	}

	if(button11.clicked(mouseX, mouseY)){
		openR2L = button11.toggleOn;
		startAnimation();
	}

	if(play.clicked(mouseX, mouseY)){
		running = true;
	}

	if(pause.clicked(mouseX, mouseY)){
		running = false;
	}
}

class Button{
	String name = "0";
	int posX = 200;
	int posY = 200;
	int height = 20;
	int width = 20;
	boolean toggleOn = false;
	int redToggle = 0;
	int greenToggle = 255;

	Button(String name, int posX, int posY){
		this.name = name;
		this.posX = posX;
		this.posY = posY;

		ellipse(posX,posY,width,height);
		text(name,posX,posY+20);
	}

	void redraw(){
		fill(redToggle,greenToggle,0);
		ellipse(posX,posY,width,height);
		fill(255);
		text(name,posX-3,posY+3);
	}

	boolean clicked(int pointX, int pointY){
		boolean hitX = false;
		boolean hitY = false;
		
		for(int x=(posX-width/2); x<(posX+width/2); x++){
			if(x==pointX){
				hitX = true;
			}
		}

		for(int y=(posY-height/2); y<(posY+height/2); y++){
			if(y==pointY){
				hitY = true;
			}
		}

		if(hitX && hitY){
			if(toggleOn){
				toggleOn = false;
				greenToggle = 255;
				redToggle = 0;
			}
			else{
				toggleOn = true;
				greenToggle = 0;
				redToggle = 255;
			}
			return true;
		}
		else{
			return false;
		}
	}
}

class Vehicle{
	int posX = 200;
	int posY = 200;
	int offsetX = 0;
	int offsetY = 0;
	int speed = 1;
	boolean arrived = false;
	int type = 1;
	int gearShift = 1;
	boolean addX;
	boolean addY;
	boolean vertical = false;
	boolean reachedX = false;
	boolean reachedY = false;

	Vehicle(int spawnX, int spawnY, int gear){
		posX = spawnX;
		posY = spawnY;

		offsetX = round(random(20, 200));
		offsetY = round(random(20, 60));

		speed = random(4,12);
		speed = round(speed);

		type = random(1,3);
		type = round(type);

		this.gearShift = gear;
	}

	void evaluateDirection(int toX, int toY){
		if(this.posX < toX){
			this.addX = true;
		}
		else if(this.posX  > toX){
			this.addX = false;
		}

		if(this.posY < toY){
			this.addY = true;
		}
		else if(this.posY > toY){
			this.addY = false;
		}
	}

	void move(int toX, int toY){
		if(this.addX && this.posX<toX && gearShift == 1){
			this.posX  += speed;
			vertical = false;
		}
		else if(!this.addX && this.posX>toX && gearShift == 1){
			this.posX  -= speed;
			vertical = false;
		}
		else{
			reachedX = true;
			gearShift = 2;
		}

		if(this.addY && this.posY<toY && gearShift == 2){
			this.posY  += speed;
			vertical = true;
		}
		else if(!this.addY && this.posY>toY && gearShift == 2){
			this.posY  -= speed;
			vertical = true;
		}
		else{
			/* reachedY = true; */
			gearShift = 1;
		}

		visualize();
	}

	void visualize(){
		int bodyWidth = 0;
		int bodyHeight = 0;

		if(vertical){
			bodyWidth = 5;
			bodyHeight = 10;
		}
		else{
			bodyWidth = 10;
			bodyHeight = 5;
		}

		if(!reachedX || !reachedY){
			fill(0,0,255);
			// private vehicles (cars)
			if(this.type == 1){
				rect(this.posX+this.offsetX, this.posY+this.offsetY, bodyWidth, bodyHeight);
			} // public vehicles (bus)
			else if(this.type == 2){
				rect(this.posX+this.offsetX, this.posY+this.offsetY, bodyWidth*2, bodyHeight*2);
			} // public vehicles (jeep)
			else{
				rect(this.posX+this.offsetX, this.posY+this.offsetY, bodyWidth*2, bodyHeight+2);
			}
		}
	}
}