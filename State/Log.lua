_G.Log = {}

local messages = {}

function Log.add(msg)
    table.insert(messages, msg)
end

local function replay()
    if #messages == 0 then
        print("Nothing to replay yet!")
    else
        for _, msg in ipairs(messages) do print(msg) end
    end
end

local replayCmd = Turbine.ShellCommand()
function replayCmd:Execute() replay() end
function replayCmd:GetShortHelp() return "Prints all says and emotes from this session." end
function replayCmd:GetHelp()
    return "usage: /replay\nThis command prints out all says and emotes by players.\n\n"
        .. "The history is cleared whenever the player logs out (or unloads the plugin), "
        .. "so make sure to grab logs first. Once you're done with RP,\n"
        .. "1. Start logging your RP tab\n2. Use /replay\n3. Stop logging"
end
Log.replay = replayCmd
