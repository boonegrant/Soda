-- Soda
displayMode(OVERLAY)
displayMode(FULLSCREEN)
-- Use this function to perform your initial setup
function setup()
    Soda.Assets()
    strokeWidth(2)
    textAlign(CENTER)
    print("centre=", CENTER) --2
    print("corner=", CORNER) --0
    print("left", LEFT) --0
    print("right", RIGHT) --1
    local t = ElapsedTime
    local box = --create a temporary handle "box" so that we can define other buttons as children
    Soda.Control{title = "Settings", w = 0.8, h = 0.8, frosted = true}
     --320
      --  instruction = Label(instruction, x+20, y+160, 640, 120),
     --   field = TextField(textfield, x+20, y+80, 640.0, 40, default, 1, test_Clicked),

      local   ok = Soda.Button{parent = box, title = "OK", x = 20, y = 20, w = 0.3, h = 40}
      local  cancel = Soda.Button{parent = box, title = "Do not press", style = Soda.style.warning, x = -20, y = 20, w = 0.3, h = 40, callback = function() Soda.Alert1{title = "CONGRATULATIONS!\n\nYou held out\n"..(ElapsedTime - t).." seconds"} end}
     local  choose = Soda.Segment{parent = box, text = {"Several different","options", "to choose", "between"}, x=0.5, y=-60, w=0.9, h = 40} --"options", 
    local   switch = Soda.Switch{parent = box, title = "Wings fall off", x = 20, y = -120}
    local list = Soda.List{parent = box, x = -20, y = -120, w = 0.4, text = {"Washington", "Adams", "Jefferson", "Madison", "Monroe", "Adams", "Jackson", "Van Buren", "Harrison", "Tyler", "Polk", "Taylor", "Fillmore", "Pierce", "Buchanan", "Lincoln", "Johnson", "Grant"} }
    profiler.init()
end

function draw()
    drawing()
    profiler.draw()
end

function drawing(exception)
    background(40, 40, 50)
    sprite("Dropbox:mountainScape2", WIDTH*0.5, HEIGHT*0.5, WIDTH, HEIGHT)
    for i,v in ipairs(Soda.items) do --draw most recent item last
        if v.kill then
            table.remove(Soda.items, i)
        else
            if v:draw(exception) then return end
        end
    end
end

function touched(t)
    for i = #Soda.items, 1, -1 do --test most recent item first
        if Soda.items[i]:touched(t) then return end
    end
end

profiler={}

function profiler.init(quiet)    
    profiler.del=0
    profiler.c=0
    profiler.fps=0
    profiler.mem=0
    if not quiet then
        parameter.watch("profiler.fps")
        parameter.watch("profiler.mem")
    end
end

function profiler.draw()
    profiler.del = profiler.del +  DeltaTime
    profiler.c = profiler.c + 1
    if profiler.c==10 then
        profiler.fps=profiler.c/profiler.del
        profiler.del=0
        profiler.c=0
        profiler.mem=collectgarbage("count", 2)
    end
end
