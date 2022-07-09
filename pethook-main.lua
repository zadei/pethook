print("Script Loaded")
getgenv().launchStatistics = false
getgenv().autoMergePet = false
getgenv().snailFifteen = 0
getgenv().serpentFifteen = 0
getgenv().totalPetsInFifteen = 0
getgenv().webhookURL = ""
getgenv().startTime = os.clock()
getgenv().eggsAtStart = game:GetService("Players").LocalPlayer.leaderstats.Eggs.Value
getgenv().snailSinceLaunch = 0
getgenv().serpentSinceLaunch = 0
getgenv().doAutoClicker = false

function printGlobalBest()
    local Players = game:GetService("Players")

    for i, player in pairs(Players:GetPlayers()) do
        getServerPets(player)
    end
end

-- print everyone's 5 best pets
function getServerPets(player)
    local children = player.petOwned:GetChildren()
    
    print(player)
    for index, children in ipairs(children) do
        local thisPet = children.name.Value
        local thisPetRarity = children.petType.Value
            if thisPetRarity == 1 then
                thisPetRarity = "Regular"
            elseif thisPetRarity == 2 then
                thisPetRarity = "Shiny"
            elseif thisPetRarity == 3 then
                thisPetRarity = "Golden"
            elseif thisPetRarity == 4 then
                thisPetRarity = "Rainbow"
            else
                print("This user has no pets!")
            end
        print(thisPetRarity .. " " .. thisPet)
        if index == 5 then
            break
        end
    end
    print("\n")
end

-- fire on egg hatch event
game:GetService("Players").LocalPlayer.petOwned.ChildAdded:Connect(function(child) -- start event listener
        local thisPet = child:WaitForChild("name")
        thisPet = thisPet.Value
        local thisPetRarity = child:WaitForChild("petType")
        thisPetRarity = thisPetRarity.Value

        -- hatch notification
        local notif = "Hatched a " .. thisPet ..""
        local msg = 
        {
                ["embeds"] = {{
                    ["title"] = notif,
                    ["color"] = 11337983
                }
            }
        }
        local HttpRequest = http_request;
        if syn then
          HttpRequest = syn.request
          else
          HttpRequest = http_request
        end
        HttpRequest({Url=webhookURL, Body=game:GetService("HttpService"):JSONEncode(msg), Method="POST", Headers={["content-type"] = "application/json"}})

            print("got "..thisPet.." with rarity "..thisPetRarity.."")

            if (thisPet == "Slimy Coral Snail") and (thisPetRarity == 1)  then
                getgenv().snailFifteen = getgenv().snailFifteen + 1
                getgenv().snailSinceLaunch = getgenv().snailSinceLaunch + 1
                print("captured snail")
                
            elseif (thisPet == "Coral Serpent") and (thisPetRarity == 1) then
                getgenv().serpentFifteen = getgenv().serpentFifteen + 1
                getgenv().serpentSinceLaunch = getgenv().serpentSinceLaunch + 1
                print("captured serpent")
            --handle shiny and golden
            elseif (thisPet == "Slimy Coral Snail") and (thisPetRarity == 2) then
                print("captured shiny snail")
                    local msg = 
                    {
                            ["embeds"] = {{
                                ["title"] = "Created a Shiny Snail!",
                                ["color"] = 16103936
                            }
                        }
                    }
                    local HttpRequest = http_request;
                    if syn then
                      HttpRequest = syn.request
                      else
                      HttpRequest = http_request
                    end
                    HttpRequest({Url=webhookURL, Body=game:GetService("HttpService"):JSONEncode(msg), Method="POST", Headers={["content-type"] = "application/json"}})
                    print("Webhook Sent")

            elseif (thisPet == "Coral Serpent") and (thisPetRarity == 2) then
                print("captured shiny serpent")
                    local msg = 
                    {
                            ["embeds"] = {{
                                ["title"] = "Created a Shiny Serpent!",
                                ["color"] = 16103936
                            }
                        }
                    }
                    local HttpRequest = http_request;
                    if syn then
                      HttpRequest = syn.request
                      else
                      HttpRequest = http_request
                    end
                    HttpRequest({Url=webhookURL, Body=game:GetService("HttpService"):JSONEncode(msg), Method="POST", Headers={["content-type"] = "application/json"}})
                    print("Webhook Sent")

            elseif (thisPet == "Slimy Coral Snail") and (thisPetRarity == 3) then
                print("captured golden snail")
                    local msg = 
                    {
                            ["embeds"] = {{
                                ["title"] = "Created a Golden Snail!",
                                ["color"] = 14808320
                            }
                        }
                    }
                    local HttpRequest = http_request;
                    if syn then
                      HttpRequest = syn.request
                      else
                      HttpRequest = http_request
                    end
                    HttpRequest({Url=webhookURL, Body=game:GetService("HttpService"):JSONEncode(msg), Method="POST", Headers={["content-type"] = "application/json"}})
                    print("Webhook Sent")

            elseif (thisPet == "Coral Serpent") and (thisPetRarity == 3) then
                print("captured golden serpent")
                    local msg = 
                    {
                            ["embeds"] = {{
                                ["title"] = "Created a Golden Serpent!",
                                ["color"] = 14808320
                            }
                        }
                    }
                    local HttpRequest = http_request;
                    if syn then
                      HttpRequest = syn.request
                      else
                      HttpRequest = http_request
                    end
                    HttpRequest({Url=webhookURL, Body=game:GetService("HttpService"):JSONEncode(msg), Method="POST", Headers={["content-type"] = "application/json"}})
                    print("Webhook Sent")

            else
                print("ew, legendary")
            end
            -- auto merge pet
            if getgenv().autoMergePet == true then
                local A_1 = thisPet
                local A_2 = thisPetRarity
                local A_3 = game:GetService("Players").LocalPlayer.petOwned.ChildAdded
                local Event = game:GetService("ReplicatedStorage").Events.Client.upgradePet
                Event:FireServer(A_1, A_2, A_3)
                print("merged"..thisPet)
            end


end) -- end event listener

-- return pet list
function printPetDump()
spawn(function()
        -- put all pets in a table
        local petArray = {}
        print("---------------------------------------------------------")
            local descendants = game:GetService("Players").LocalPlayer.petOwned:GetChildren()
            for i,v in pairs(descendants) do
                local thisPet = v:WaitForChild("name")
                local thisPetRarity = v:WaitForChild("petType")
                thisPet = thisPet.Value
                thisPetRarity = thisPetRarity.Value
                if thisPetRarity == 1 then
                    thisPetRarity = "Regular"
                elseif thisPetRarity == 2 then
                    thisPetRarity = "Shiny"
                elseif thisPetRarity == 3 then
                    thisPetRarity = "Golden"
                elseif thisPetRarity == 4 then
                    thisPetRarity = "Rainbow"
                else
                    print("This user has no pets!")
                end
                table.insert(petArray, thisPetRarity .. " " .. thisPet)
            end
            --total pets
            local count = 0
            for index, descendants in ipairs(descendants) do
                count = count + 1
            end
            table.insert(petArray, "Pets: " .. count .. "")

            local curTime = os.date('*t')
            local hour = curTime.hour
            local minute = curTime.min
            local finalTime = hour .. ":" .. minute
        
        local msg = 
        {
                ["embeds"] = {{
                    ["title"] = "Current Pets:",
                    ["description"] = table.concat(petArray, "\n"),
                    ["color"] = 16056575,
                    ["footer"] = {
                        ["text"] = finalTime
                    }
                }
            }
        }

    local HttpRequest = http_request;

    if syn then
      HttpRequest = syn.request
      else
      HttpRequest = http_request
    end
    
    HttpRequest({Url=webhookURL, Body=game:GetService("HttpService"):JSONEncode(msg), Method="POST", Headers={["content-type"] = "application/json"}})
    print("Webhook Sent")

    task.wait(900)
end) -- spawn function
end

-- runtime stats
spawn(function()
    while getgenv().launchStatistics == true do        
        -- return how long the script has been running
        getgenv().runtime = (os.clock() - getgenv().startTime) / 60 -- runtime in minutes
        --remove decimals from runtime
        getgenv().runtime = math.floor(getgenv().runtime)

        --eggs since script started
        getgenv().eggsNow = game:GetService("Players").LocalPlayer.leaderstats.Eggs.Value
        local eggs = getgenv().eggsNow - getgenv().eggsAtStart

        -- increment pets since launch
        getgenv().totalPetsInFifteen = getgenv().snailFifteen + getgenv().serpentFifteen

        local hatchColor
        if getgenv().totalPetsInFifteen <= 3 then
                hatchColor = 65280 -- green
        end
        if getgenv().totalPetsInFifteen > 3 and getgenv().totalPetsInFifteen <= 9 then
                hatchColor = 16771840 -- yellow
        end
        if getgenv().totalPetsInFifteen > 10 then
                hatchColor = 16711680 -- red
        end
        
    local msg = 
    {
            ["embeds"] = {{
                ["title"] = "Statistics since launch",
                ["description"] = "**Slimy Coral Snail**: "..getgenv().snailSinceLaunch.."\n\n**Coral Serpent**: "..getgenv().serpentSinceLaunch.."",
                ["color"] = hatchColor,
                ["footer"] = {
                    ["text"] = "["..getgenv().runtime.." minutes]\n["..eggs.." eggs]"
                }
            }
        }
    }
    
    local HttpRequest = http_request;
    
    if syn then
        HttpRequest = syn.request
        else
        HttpRequest = http_request
    end
            
    HttpRequest({Url=webhookURL, Body=game:GetService("HttpService"):JSONEncode(msg), Method="POST", Headers={["content-type"] = "application/json"}})
    print("sent to webhook, resetting values...\n\n")

    getgenv().snailFifteen = 0
    getgenv().serpentFifteen = 0
    getgenv().totalPetsInFifteen = 0

    task.wait(900)
    end -- while loop
end) -- spawn function


-- GUI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("pethook - zade#9158", "Sentinel")

--pets
local Pets = Window:NewTab("Pets")
local mergeOptions = Pets:NewSection("Merge Options")
local autoMerge = mergeOptions:NewToggle("Auto Merge", "Automatically merge pets with the same name", function(state)
    getgenv().autoMergePet = state
end)

--misc
local Misc = Window:NewTab("Misc")

local Console = Misc:NewSection("Console")

local GlobalPetDump = Console:NewButton("View Server Pets", "Dump everybody's best pets into console", function()
    printGlobalBest()
end)

--settings
local Settings = Window:NewTab("Settings")

local Webhooks = Settings:NewSection("Webhooks")

local webhookInput = Webhooks:NewTextBox("Webhook URL", "Edit Channel > Integrations > New Webhook", function(url)
    getgenv().webhookURL = url
end)

local testMsg = Webhooks:NewButton("Send Test Message", "Send a test message to the webhook", function()
    local msg = 
    {
            ["embeds"] = {{
                ["title"] = "pethook - zade#9158",
                ["description"] = "Webhook linked.",
                ["color"] = 65280,
                ["footer"] = {
                    ["text"] = "Sent at "..os.date('%X')
                }
            }
        }
    }
    local HttpRequest = http_request;
    
    if syn then
        HttpRequest = syn.request
        else
        HttpRequest = http_request
    end
    
    HttpRequest({Url=getgenv().webhookURL, Body=game:GetService("HttpService"):JSONEncode(msg), Method="POST", Headers={["content-type"] = "application/json"}})
    print("Webhook Sent")
end)

local toggleLaunchStatistics = Webhooks:NewToggle("Toggle Launch Statistics", "Toggle sending statistics about the script's runtime to a webhook", function(state)
    getgenv().launchStatistics = state
end)

local petDumpBtn = Webhooks:NewButton("Dump Pets", "Dump all pets into webhook", function()
    printPetDump()
end)




-- old merge function
    -- print("pet merge button updated")
    -- local folder = game:GetService("Players").LocalPlayer.petOwned
    -- --create array of all pet names
    -- local unsortedPetArray = {}
    -- local descendants = folder:GetChildren()
    -- for i,v in pairs(descendants) do
    --     table.insert(unsortedPetArray, v)
    -- end
    -- print("unsorted pet array created")
    -- -- make new array of pet names with no duplicates
    -- local sortedPetArray = {}
    -- for i,v in pairs(unsortedPetArray) do
    --     if not table.contains(sortedPetArray, v.name.Value) then -- checks if any table entries have that pet
    --         table.insert(sortedPetArray, v) -- if not, insert its parent
    --     end
    -- end
    -- print("sorted pet array created")
    -- -- outer for loop to dynamically change nameToFind
    -- for i,v in pairs(sortedPetArray) do
    --     local nameToFind = v.name.Value
    --     local count = 0

    --     -- inner loop goes through unsorted array and looks for duplicates
    --     for i, x in pairs(folder:Descendants()) do
    --         if x.Name == nameToFind then
    --             count = count + 1
    --                 if count == 4 then
    --                     -- fire merge function to server on nameToFind's parent (index)
    --                     local petToMerge = x
    --                     -- fire merge function (use remote spy to get parameters)
    --                         local A_1 = x.name.Value
    --                         -- 1 is for shiny
    --                         local A_2 = 1
    --                         local A_3 = game:GetService("Players").LocalPlayer.petOwned.v
    --                         local Event = game:GetService("ReplicatedStorage").Events.Client.upgradePet
    --                         Event:FireServer(A_1, A_2, A_3)
    --                 end
    --         end
    --     end
    -- end
