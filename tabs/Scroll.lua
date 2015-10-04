Soda.Scroll = class(Soda.Frame) --touch methods for scrolling classes, including distinguishing scroll gesture from touching a button within the scroll area, and elastic bounce back

function Soda.Scroll:init(t)
    self.scrollHeight = t.scrollHeight
    self.scrollVel = 0
    self.scrollY = 0
    self.touchMove = 1
    Soda.Frame.init(self,t)
    -- #################################### <JMV38 changes>
    self.freeScroll = false
--    self.doNotInterceptTouches = true
    self.sensor = Soda.Gesture{parent=self, xywhMode = CENTER}
    self.sensor:onDrag(function(event) self:verticalScroll(event.touch, event.tpos) end)
    self.sensor:onTouched(function(event) self:childrenTouched(event.touch, event.tpos) end)
end

function Soda.Scroll:childrenTouched(t,tpos)
    local off = tpos - vec2(self:left(), self:bottom() + self.scrollY)
    for _, v in ipairs(self.child) do --children take priority over frame for touch
       if v:touched(t, off) then return true end
    end
end

function Soda.Scroll:verticalScroll(t,tpos)
    if (t.state == BEGAN or t.state == MOVING) and self.sensor:inbox(tpos) then
        self.scrollVel = t.deltaY
        self.scrollY = self.scrollY + t.deltaY
        self.freeScroll = false
    else
        self.freeScroll = true
    end
end

function Soda.Scroll:touched(t, tpos)
    if self.inactive then return end
    if self.sensor:touched(t, tpos) then return true end
    return self.alert
end
    
function Soda.Scroll:updateScroll()
    if self.freeScroll == false then return end
    -- #################################### </JMV38 changes>
    
    local scrollH = math.max(0, self.scrollHeight -self.h)
    if self.scrollY<0 then 
      --  self.scrollVel = self.scrollVel +   math.abs(self.scrollY) * 0.005
        self.scrollY = self.scrollY * 0.7
    elseif self.scrollY>scrollH then
        self.scrollY = self.scrollY - (self.scrollY-scrollH) * 0.3
    end
    if not self.touchId then
        self.scrollY = self.scrollY + self.scrollVel
        self.scrollVel = self.scrollVel * 0.94
    end
end

    -- #################################### <JMV38 changes>
--[[
function Soda.Scroll:touched(t, tpos)
    if self.inactive then return end
    if self:pointIn(tpos.x, tpos.y) then
        
        if t.state == BEGAN then
            self.scrollVel = t.deltaY
            self.touchId = t.id
            self.touchMove = 0
            self:keyboardHideCheck()
        elseif self.touchId and self.touchId == t.id then
            self.touchMove = self.touchMove + math.abs(t.deltaY) --track ammount of vertical motion
            if t.state == MOVING then
                self.scrollVel = t.deltaY
                self.scrollY = self.scrollY + t.deltaY
                
            else --ended
                self.touchId = nil
            end
    
        end
        if self.touchMove<10 then --only test selectors if this touch was not a scroll gesture
            local off = tpos - vec2(self:left(), self:bottom() + self.scrollY)
            for _, v in ipairs(self.child) do --children take priority over frame for touch
                if v:touched(t, off) then return true end
            end
        end
        return true
    end
    return self.alert
end

<<<<<<< tabs/Scroll.lua
--]]





=======
>>>>>>> tabs/Scroll.lua
