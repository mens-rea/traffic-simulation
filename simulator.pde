PImage img;
int posX = 10;
int poxY = 10;

int vehicleNo = 50;

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

boolean openQ2L = false;
boolean openQ2M = false;

boolean openM2L = false;
boolean openM2Q = true;
boolean openM2R = false;

boolean openL2Q = true;
boolean openL2M = false;
boolean openL2R = false;

boolean openR2L = false;
boolean openR2M = false;
boolean openR2Q = true;

/* from quiapo */
Vehicle[] vehiclesQ2M = new Vehicle[vehicleNo];
Vehicle[] vehiclesQ2L = new Vehicle[vehicleNo];
/* from mendiola */
Vehicle[] vehiclesM2Q = new Vehicle[vehicleNo];
Vehicle[] vehiclesM2R = new Vehicle[vehicleNo];
Vehicle[] vehiclesM2L = new Vehicle[vehicleNo];
/* from legarda */
Vehicle[] vehiclesL2Q = new Vehicle[vehicleNo];
Vehicle[] vehiclesL2R = new Vehicle[vehicleNo];
Vehicle[] vehiclesL2M = new Vehicle[vehicleNo];
/* from recto */
Vehicle[] vehiclesR2Q = new Vehicle[vehicleNo];
Vehicle[] vehiclesR2M = new Vehicle[vehicleNo];
Vehicle[] vehiclesR2L = new Vehicle[vehicleNo];

void setup() {
	size(1270, 1000);
	stroke(255);
	println("traffic simulation | current vehicle count: " + vehicleNo);

	/* drawing roads */
	prepDestinations();

	startAnimation(1);
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

	prepDestinations();

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

void mousePressed(){
	if(mouseX > 400){
		startAnimation(1);
		println("vertical");
	}
	else{
		startAnimation(2);
		println("vertical");
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

		if(!reachedX || !reachedY){
			visualize();
		}
		
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

		if(this.type == 1){
			rect(this.posX+this.offsetX, this.posY+this.offsetY, bodyWidth, bodyHeight);
		}
		else if(this.type == 2){
			rect(this.posX+this.offsetX, this.posY+this.offsetY, bodyWidth*2, bodyHeight*2);
		}
		else{
			rect(this.posX+this.offsetX, this.posY+this.offsetY, bodyWidth*2, bodyHeight+2);
		}
	}
}