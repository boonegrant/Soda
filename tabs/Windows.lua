--factories for various window types

function Soda.Control(t)
    t.shape = Soda.RoundedRectangle
    t.shapeArgs = t.shapeArgs or {}
    t.shapeArgs.radius = 25
    t.label = {x=0.5, y=-20, text = t.title}
    t.shadow = true
    return Soda.Frame(t)
end

function Soda.Control2(t)
    t.shape = Soda.RoundedRectangle
    t.shapeArgs = t.shapeArgs or {}
    t.shapeArgs.radius = 25
    t.style = Soda.style.thickStroke
    t.label = {x=0.5, y=-10, text = t.title}
    t.shadow = true
    return Soda.Frame(t)
end

function Soda.TextWindow(t)
    t.x = t.x or 0.5
    t.y = t.y or 20
    t.w = t.w or 700
    t.h = t.h or -20
    local this = Soda.Control2(t)
    
    Soda.TextScroll{
        parent = this,
        x = 10, y = 10, w = -10, h = -10,
        text = t.text,
    }  
    
    Soda.CloseButton{
        parent = this,
        x = -5, y = -5,
        style = Soda.style.icon,
        shape = Soda.ellipse,
        callback = function() this.kill = true end  
    }
    
    return this
end

function Soda.Alert2Dark(t)
    local this = Soda.Control{title = t.title, h = 0.2, blurred = true}
    
    local ok = Soda.Button{parent = this, title = "OK", x = 0, y = 0, w = 0.5, h = 50, style = Soda.style.dark, shape = Soda.outline, shapeArgs = {edge = TOPEDGE | RIGHTEDGE}} --style = Soda.style.transparent,blurred = true --{edgeX = LEFT, edgeY = 1, r = 25}
    
    local cancel = Soda.Button{parent = this, title = "Cancel", x = 0.75, y = 0, w = 0.5, h = 50, style = Soda.style.dark, shape = Soda.outline, shapeArgs = {edge = TOPEDGE}, callback = function() this.kill = true end} --style = Soda.style.transparent,{edgeX = RIGHT, edgeY = 1, r = 25}
    return this
end

function Soda.Alert2(t)
    local this = Soda.Frame{h = 0.25} --, edge = ~BOTTOMEDGE
     
    this.mesh = {
        Soda.Mesh{parent = this, shape = Soda.roundedRect, style = Soda.style.default, shapeArgs = {r = 25}, label = {x=0.5, y=0.6, text = t.title}}}
    
    this.mesh[2] = Soda.Shadow{parent = this}
    
    local ok = Soda.Button{parent = this, title = "OK", x = 0.251, y = 0, w = 0.5, h = 50, shapeArgs = {r = 25, edge = LEFTEDGE | BOTTOMEDGE}} --style = Soda.style.transparent,blurred = true --{edgeX = LEFT, edgeY = 1, r = 25}
    local cancel = Soda.Button{parent = this, title = "Cancel", x = 0.748, y = 0, w = 0.5, h = 50, shapeArgs = {r = 25, edge = RIGHTEDGE | BOTTOMEDGE}, callback = function() this.kill = true end} --style = Soda.style.transparent,{edgeX = RIGHT, edgeY = 1, r = 25}
    return this
end

function Soda.Alert1(t)
    t.h = t.h or 0.25
    local this = Soda.Control(t) --alert = true
    local ok = Soda.Button{parent = this, title = "OK", x = 0, y = 0, w = 1, h = 50, shapeArgs = {corners = 1 | 8, radius = 25}, callback = function() this.kill = true end,  style = Soda.style.transparent} --style = Soda.style.transparent,blurred = t.blurred,
    return this
end