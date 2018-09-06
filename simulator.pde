PImage img;
int posX = 200;
int poxY = 200;

Vehicle vehicle1;
Vehicle vehicle2;

Vehicle[] vehicles = new Vehicle[1];

void setup() {
	size(1000, 500);
	stroke(255);
	println("hello web!");

	for(int x=0; x<vehicles.length; x++){
		vehicles[x] = new Vehicle(200,200);
	}
}

void draw(){
	background(255);
	fill(0, 20, 150);

	for(int x=0; x<vehicles.length; x++){
		vehicles[x].move(800,200);
	}
}

class Vehicle{
	int posX = 200;
	int posY = 200;
	int offsetX = 0;
	int offsetY = 0;
	int speed = 1;
	boolean arrived = false;

	Vehicle(int spawnX, int spawnY){
		posX = spawnX;
		posY = spawnY;

		offsetX = round(random(20));
		offsetY = round(random(20));

		while(speed%2!=0){
			speed = random(2,20);
			speed = round(speed);
		}

		ellipse(posX+offsetX, posY+offsetY, 10, 10);
	}

	void move(int toX, int toY){
		boolean reachedX = false;
		boolean reachedY = false;
		
		if(this.posX < (toX+speed)){
			this.posX  += speed;
		}
		else if(this.posX  > (toX+speed)){
			this.posX  -= speed;
		}
		else{
			reachedX = true;
		}

		if(this.posY < (toY+speed)){
			this.posY += speed;
		}
		else if(this.posY > (toY+speed)){
			this.posY -= speed;
		}
		else{
			reachedY = true;
			println(speed);
		}

		if(reachedX && reachedY){
			this.arrived = true;
		}		

		if(!this.arrived){
			ellipse(posX+offsetX, posY+offsetY, 10, 10);
		}
		else{
			
		}
	}
}