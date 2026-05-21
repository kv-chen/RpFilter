-- Assumption: user has Regional or OOC enabled

local MESSAGE_PATTERNS = {
    "^(Entered) the (.-) %- (Regional) channel%.$",
    "^(Entered) the (.-) %- (OOC) channel%.$",
    "^(Left) the (.-) %- (Regional) channel%.$",
    "^(Left) the (.-) %- (OOC) channel%.$"
}

---@param message string
---@return string?, string?, string?
local function parseLocation(message)
    local action, region, channel
    for _, pattern in pairs(MESSAGE_PATTERNS) do
        action, region, channel = message:match(pattern)
        if channel then return action, region, channel end
    end
    return nil
end

---Parses standard channel for Entered/Left messages to keep track of location
---@param message string
function _G.handleLocation(message)
    local action, region, channel = parseLocation(Strip(message))

    if action == "Entered" then
        Location.enter(region, channel)
    elseif action == "Left" then
        Location.leave(channel)
    end
end
