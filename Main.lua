import "RpFilter"

LOCAL_PLAYER_NAME = Turbine.Gameplay.LocalPlayer:GetInstance():GetName()

do
    local lastPoster
    function print(message, player)
        if not player then
            Turbine.Shell.WriteLine(message)
            return
        end

        if Settings.getOptions().areNewlinesPrinted and player ~= lastPoster then
            Turbine.Shell.WriteLine("")
        end
        lastPoster = player
        Turbine.Shell.WriteLine(message)
    end
end

local function chatParser(_, args)
    local ChatType = Turbine.ChatType
    local message, channel = args.Message, args.ChatType

    if channel == ChatType.Standard then
        handleLocation(message)
    elseif channel == ChatType.Say and Say.isAllowed(message) then
        Say.print(message, Settings.getSayColor())
    elseif channel == ChatType.Emote then
        local s = Settings
        Emote.print(message, s.getEmoteColor(), s.getSayColor(), s.getOptions())
    end
end

function plugin.Load(_)
    Settings.loadSync()
    AddCallback(Turbine.Chat, "Received", chatParser)
    Turbine.Shell.AddCommand("replay", Log.replay)

    DrawOptionsPanel(Settings.getOptions())

    print("<rgb=#DAA520><u>RP Filter v"..plugin:GetVersion().." by Dandiron</u></rgb>")
    if Settings.isFirstLoad() then
        print("You can choose say and emote colour in /plugins manager")
    end
    print("For easy logging, use /replay to print all previous says and emotes")
end

function plugin.Unload(_)
    Settings.saveSync()
    RemoveCallback(Turbine.Chat, "Received", chatParser)
    Turbine.Shell.RemoveCommand(Log.replay)
end
