local placeId = game.PlaceId
if placeId == 2753915549 or placeId == 4442272183 or placeId == 7449423635 then
    BF = true
end
if placeId == 2753915549 then
    first_sea = true
end
if placeId == 4442272183 then
    second_sea = true
end
if placeId == 7449423635 then
    third_sea = true
end
if BF then
    local plr = game.Players.LocalPlayer
    local level_need_to_reach = 0
    local is_need_to_wait_level = false
    local activate_auto_world = 'none'
    if first_sea then
        if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0 then
            is_need_to_wait_level = true
            activate_auto_world = 'second'
            level_need_to_reach = 700
        end
    elseif second_sea then
        if plr.Data.Level.Value < 1500 then
            is_need_to_wait_level = true
            level_need_to_reach = 1500
        end
    elseif third_sea then
        if plr.Data.Level.Value < 2550 then
            is_need_to_wait_level = true
            level_need_to_reach = 2550
        end
    end
    
    local OSTime = os.time()
    local Time = os.date('!*t', OSTime)
    local function send_webhook()
        local Embed = {
            ["title"] = "__**" .. plr.Name .. "**__",
            ["description"] = "**Name: **"..plr.Name.."\n**Reached " .. plr.Data.Level.Value .. " level!**\n**Money:**" .. plr.Data.Beli.Value .. "\n\n*TRYING TO GO NEXT SEA IF LEVEL 700*",
            ["type"] = "rich",
            ["color"] = tonumber(0xffff00),
            ["footer"] = {
                ["text"] = "deadcxde watcher",
            },
            ["timestamp"] = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec),
        };
        http.request {
            Url = 'https://discord.com/api/webhooks/1174720347526922292/8RAWz_Wm6jeScxTgYr0GhmJPRwLYBLL8cWfgh3g4UXz3qHF4CH8yU-ArleUEhqk4oaT8';
            Method = 'POST';
            Headers = {
                ['Content-Type'] = 'application/json';
            };
            Body = game:GetService'HttpService':JSONEncode({embeds = {Embed};});
        };
    end
    local function run_next_world()
        getgenv()._G.AutoFarm = false
        getgenv()._G.Auto_New_World = true
    end

    local function watch_level()
        task = task or getrenv().task;
        fastSpawn,fastWait,delay = task.spawn,task.wait,task.delay
        if is_need_to_wait_level == false then return end
        while true do
            if plr.Data.Level.Value >= level_need_to_reach then
                level_need_to_reach = 0
                is_need_to_wait_level = false
                send_webhook()
                if first_sea then
                    run_next_world()
                end
                return
            end
            fastWait(.5)
        end
    end
    coroutine.wrap(watch_level)()
    print("Roblox Watcher Loaded!")
else
    print("Not Supported")
end
