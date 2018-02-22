-- I'm going to attempt to learn lua
-- with LOVE. lol
--
-- LOVE structures it's programs/games like this
-- 
-- love.draw() like rendering shit
-- love.load() initialization mostly.
-- love.update()
-- and apparently a crapton of other call backs.... F**k

gameState=0;
selectionY = 72*1.4+200+35
selectionId = 0;
AIOn=0;

p1Y = 72+200
p2Y = 72+200
ballAccelerationX=4;
ballAccelerationY=2;
ballX = 400;
ballY = 280;
function love.draw()
	if gameState==0 then
		love.graphics.print("Pong in LUA/LOVE", 160);
		love.graphics.line( 160, 80, 620, 80 );	
		love.graphics.line( 160, selectionY, 300, selectionY );
		love.graphics.print("Start New Game(AI)", 160, 72*1.4+200, 0, 0.5, 0.5);
		love.graphics.print("Start New Game(2 Player)", 160, 72*1.4+236, 0, 0.5, 0.5);
		love.graphics.print("Exit Game", 160, 72*1.4+272, 0, 0.5, 0.5);
	else
		love.graphics.print("Player 1", 0, -10);
		love.graphics.print("Player 2", 584, -10);
		love.graphics.line(0, 0, 1000, 0);
		love.graphics.line(0, 72, 1000, 72);
		-- 72 no higher.
		love.graphics.rectangle( "fill", 10, p1Y, 15, 40 );
		love.graphics.rectangle( "fill", 773, p2Y, 15, 40 );
		--
		love.graphics.rectangle( "fill", ballX, ballY, 15, 15 );
	end
end
function reset()
	ballX=400;
	ballY=280;
end
function love.update()
	if gameState == 1 then
	ballX = ballX + ballAccelerationX;
	ballY = ballY + ballAccelerationY;
	if love.keyboard.isDown("w") then
		if p1Y > 72 then
			p1Y = p1Y - 10;
		end
	end
	if love.keyboard.isDown("s") then
		if p1Y < 550 then
			p1Y = p1Y + 10;
		end
	end
	if AIOn == 0 then
	if love.keyboard.isDown("up") then
		if p2Y > 72 then
			p2Y = p2Y - 10;
		end
	end
	if love.keyboard.isDown("down") then
		if p2Y < 550 then
			p2Y = p2Y + 10;
		end
	end
	else
		-- unbeatable AI.
		p2Y = ballY;	
	end
	if ballY < p1Y + 40 and ballY + 15 > p1Y then
		print("Y collide");
	if ballX < 10 + 15 and ballX + 15 > 10 then
		ballAccelerationX = -ballAccelerationX --+ math.random(-3, 3);
		ballAccelerationY = -ballAccelerationY + math.random(-3, 3);
	end
	end

	if ballY < p2Y + 40 and ballY + 15 > p2Y then
		print("Y collide");
	if ballX < 773 + 15 and ballX + 15 > 773 then
		ballAccelerationX = -ballAccelerationX --+ math.random(-3, 3);
		ballAccelerationY = -ballAccelerationY + math.random(-3, 3);
	end
	end

	if ballX < 0 or ballX > 773 then
		reset();
	end
	if ballY < 72 or ballY > 600-15 then
		ballAccelerationY=-ballAccelerationY;
	end
end
end
function love.quit()
end
function love.mousepressed(x, y, button, istouch)
end
function love.keypressed( key, scancode, isrepeat )
	if gameState == 1 then
		if scancode == "escape" then
			gameState = 0;
		end
	end
	if scancode == 'w' then
		if gameState == 0 then
			if selectionId > 0 then
			selectionY = selectionY - 36;
			selectionId = selectionId-1;
			end
		end
	end
	if scancode == 's' then
		if gameState == 0 then
			if selectionId < 2 then
			selectionY = selectionY + 36;
			selectionId = selectionId+1;
			end
		end
	end
	if gameState == 0 then
		if scancode == "return" and selectionId == 2 then
			love.event.quit();
		end
		if scancode == "return" and selectionId == 1 then
			gameState=1;
			reset()
			AIOn=0;
		end
		if scancode == "return" and selectionId == 0 then
			gameState=1;
			AIOn=1;
		end
	end
end
function love.load()
	font = love.graphics.newFont("font/font.ttf", 72);
	love.graphics.setFont(font);
end
function love.visible( visibility )
end
