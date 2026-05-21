_G.Location = {}

local currLocation = "unknown"
local isInstanced = false
local currChannels = {}

function Location.current()
    return currLocation
end

function Location.isInstanced()
    return isInstanced
end

function Location.enter(region, channel)
    currLocation = region
    isInstanced = false
    if channel then currChannels[channel] = true end
end

function Location.leave(channel)
    currChannels[channel] = nil
    if next(currChannels) == nil then
        isInstanced = true
    end
end
