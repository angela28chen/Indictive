debug = true

--Text Bubble Table
convo_table = {}

--Global Variables
line = 0

function love.load(arg)
	love.graphics.setBackgroundColor(255,174,201)
	loadingImg = love.graphics.newImage('assets/loadingheart.png')
	script = readtextfromfile('assets/introduction.txt')
	win_width, win_height = love.graphics.getDimensions()
	add_bubble("N: hello. press space to continue")
end

function readtextfromfile(filename)
	script = {}

	ind = 0

	for line in love.filesystem.lines(filename) do
		ind = ind+1
		script[ind] = line
	end
	return script
 end

function love.textinput(t)
	if (t == ' ' or t == 'n' or t == 'space') then
		line = line + 1
		if line <= #script then add_bubble(script[line]) end
	end
end

function love.update(dt)

end

function love.draw(dt)
	--love.graphics.print("Hello World!", 200, 300)
		
	--love.graphics.draw(loadingImg, 150, 350)
	

	for i,bubble in ipairs(convo_table) do
		print(line)
		love.graphics.setColor(255,255,255,255)
		love.graphics.polygon('fill', bubble[1])
		love.graphics.polygon('fill', bubble[2])
		love.graphics.setColor(0,0,0,255)
		love.graphics.printf(bubble[3], bubble[1][1], bubble[1][2], 210)
	end
end

function add_bubble(text)
	if text:sub(1,1) == 'Y' then speaking_index = 1
	else speaking_index = 0
	end
	--LATER THE HEIGHT MUST BE DYNAMICALLY DETERMINED :oooooooooo
	rect_vertices, tri_vertices, v_spacing = bubble_vertices(2, speaking_index)
	new_bubble = {}
	increment = v_spacing + 20
	
	-- increment old bubbles
	for i,bubble in ipairs(convo_table) do
		bubble[1][2] = bubble[1][2] - increment
		bubble[1][4] = bubble[1][4] - increment
		bubble[1][6] = bubble[1][6] - increment
		bubble[1][8] = bubble[1][8] - increment
		bubble[2][2] = bubble[2][2] - increment
		bubble[2][4] = bubble[2][4] - increment
		bubble[2][6] = bubble[2][6] - increment
	end
	
	
	new_bubble[1] = rect_vertices
	new_bubble[2] = tri_vertices
	new_bubble[3] = text:sub(4)
	table.insert(convo_table, new_bubble)
end

function bubble_vertices(num_lines, side)
	st = 500
	v_spacing = 15 * num_lines
	gap = 40
	bound_left = 20 + side*gap
	bound_right = win_width - 20 - gap + side*gap
	
	
	-- 0 for left, 1 for right
	if side == 0 then 
		tri_left = bound_left + 10
		tri_tip = tri_left + 10
		tri_right = tri_tip + 10
	else
		tri_right = bound_right - 10
		tri_tip = tri_right - 10
		tri_left = tri_tip - 10
	end
	
	rect_vert = {bound_left,st,  bound_right,st,  bound_right,st+v_spacing,  bound_left,st+v_spacing}
	tri_vert = {tri_right,st+v_spacing,  tri_tip,st+v_spacing+10,  tri_left,st+v_spacing}
	return rect_vert, tri_vert, v_spacing
end