class GameOfLife
	#Some constant values to replace magic numbers
	ALIVE = 1
	DEAD = 0
	KILL = 2
	SPAWN = 3

	@@offsetsX = [-1,0,1,-1,1,-1,0,1]
	@@offsetsY = [-1,-1,-1,0,0,1,1,1]

	#Rules for the game of life
	#Number of neighbors 
	#        <2           Dies
	#        >3           Dies
	#      2 or 3 		  Lives
	#    3 and dead       Spawns
	def initialize
		@width = 5
		@height = 5
		@cells = [[0,0,1,0,0],[0,1,1,1,0],[0,1,0,0,0],[0,0,0,0,0],[0,0,0,0,0]]
	end

	def intialize(width,height)
		@cells = Array.new(height) { |i|  }
		for i in 0...height do
			@cells[i] = Array.new(width) { |i| }
		end
	end

	def intialize(width,height,seed)
	end

	#If a cell is alive or it is marked to be killed it is currently alive. 
	def isCellAlive(x,y)
		return (@cells[y][x] == ALIVE) || (@cells[y][x] == KILL)
	end

	#TODO: Wrap around behavior for cells
	def countNeigbors(x,y)
		neighbors = 0
		for i in 0...8 do
			y_ = y + @@offsetsY[i]
			if (y_ < 0) || (y_ >= @height)
				next
			end
			x_ = x + @@offsetsX[i]
			if (x_ > 0) || (x_ < @width) 
				if isCellAlive(x_,y_) == true
						neighbors += 1
				end
			end
		end
		return neighbors
	end

	def checkCells
		for y in 0...5 do
			for x in 0...5 do
				neighbors = countNeigbors(x,y)
				if @cells[y][x] == DEAD && neighbors == 3
					@cells[y][x] = SPAWN
				elsif neighbors < 2 || neighbors > 3
					@cells[y][x] = KILL
				end
			end
			puts ""
		end
    end

    #Check cell will mark various cells to be killed or to be spawned
    #according to the rules of the simulation. This function actually
    #changes those values to the requested values.
    def updateCells
    	for y in 0...5 do
    		for x in 0...5 do
    			if @cells[y][x] == KILL
    				@cells[y][x] = DEAD
    			end
    			if @cells[y][x] == SPAWN
    				@cells[y][x] = ALIVE
    			end
    		end
    	end
    end

    #Take a single step in the simulation
	def evolve
		checkCells
		updateCells
		return @cells
	end
end