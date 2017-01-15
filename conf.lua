-- Configuration
function love.conf(t)
	t.title = "Indictive" 		-- The title of the window the game is in (string)
	--t.version = "0.10.2"         -- The LÖVE version this game was made for (string)
	t.window.width = 300        -- we want our game to be long and thin.
	t.window.height = 600

	-- For Windows debugging
	t.console = true
end