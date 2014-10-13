// Initialize Phaser, and create a 400x490px game
var game = new Phaser.Game(400, 490, Phaser.AUTO, 'gameDiv');

// Create our 'main' state that will contain the game
var mainState = {

    preload: function() {
        // This function will be executed at the beginning
        // That's where we load the game's assets
	//change the background color
	game.stage.backgroundColor = '#71c5cf';
	//load the bird image
	game.load.image ('bird', 'assets/bird.png');
    },

    create: function() {
        // This function is called after the preload function
        // Here we set up the game, display sprites, etc.
	//Set the physics system
	game.physics.startSystem(Phaser.Physics.ARCADE);

	//display the bird on the screen
	this.bird = this.game.add.sprite(100, 245, 'bird');

	//add gravity to the bird to make it fall
	game.physics.arcade.enable(this.bird);
	this.bird.body.gravity.y = 1000;

	// Call the 'jump' function when the spacekey is hit
	var spaceKey = this.game.input.keyboard.addKey(Phaser.Keyboard.SPACEBAR);
	spaceKey.onDown.add(this.jump, this);
    },

    update: function() {
        // This function is called 60 times per second
        // It contains the game's logic
	//If the bird is too high or low, restart the game
	if (this.bird.inWorld == false) {
	    this.restartGame();
	}
    },

    jump: function() {
	//add a vertical velocity to the bird
	this.bird.body.velocity.y = -350;
    },

    restartGame: function () {
	//start the main state, which restarts the game
	game.state.start('main');
    },
};
