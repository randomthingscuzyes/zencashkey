                                                                                 local Rayfield=       
                                                                        loadstring(game:HttpGet(                        
                                                                    "https://sirius.menu/rayfield"))();local HttpService=game:    
                                                                GetService("HttpService");local Players=game:GetService("Players");     
                                                            local WORK_INK_CONFIG={BASE_LINK=                                             
                                                          "https://work.ink/2IP4/zencashbloxstrikescript",API_ENDPOINT=                     
                                                        "https://work.ink/_api/v2/token/isValid/"};local savedKey=nil;local keyExpiryTime=nil 
                                                      ;local keySystemActive=true;local scriptExecuted=false;local bloxstrikeButton=nil;local   
                                                    keyRedeemed=false;local usedKeys={};local function saveKeyData(key,expiry,usedKeysList) if (  
                                                  not key or  not expiry) then return false;end local data={key=key,expiry=expiry,usedKeys=         
                                                  usedKeysList or {} };local success,err=pcall(function() writefile("zencash_key_data.json",          
                                                HttpService:JSONEncode(data));end);return success;end local function loadKeyData() local success,data=  
                                                pcall(function() if isfile("zencash_key_data.json") then return HttpService:JSONDecode(readfile(          
                                              "zencash_key_data.json"));end return nil;end);if (success and data) then return data.key,data.expiry,data.    
                                              usedKeys or {} ;end return nil,nil,{};end local function verifyKey(token) local url=WORK_INK_CONFIG.          
                                            API_ENDPOINT   .. token   .. "?deleteToken=1" ;print("Verifying with URL:",url);local ok,result=pcall(function()  
                                            return game:HttpGet(url);end);if  not ok then return false,nil,false;end print("API Response:",result);local        
                                          decoded=game:GetService("HttpService"):JSONDecode(result);if  not decoded then return false,nil,false;end if (decoded.  
                                          valid==true) then local expiryTimestamp=nil;local deleted=decoded.deleted or false ;if (decoded.info and decoded.info.    
                                          expiresAfter) then expiryTimestamp=decoded.info.expiresAfter;end if ( not expiryTimestamp and decoded.info) then            
                                          expiryTimestamp=decoded.info.expiresAt or decoded.info.expiry or decoded.info.expiration ;end if  not expiryTimestamp then  
                                        expiryTimestamp=decoded.expiresAfter or decoded.expiresAt or decoded.expiry ;end if expiryTimestamp then if (expiryTimestamp>   
                                        1000000000000) then expiryTimestamp=expiryTimestamp/1000 ;end print(  --[[==============================]]                        
                                        "Expiry timestamp (seconds):",expiryTimestamp);print(       --[[============================================]]"Expiry date:",os.  
                                        date("%Y-%m-%d %H:%M:%S",expiryTimestamp));print(       --[[======================================================]]                
                                      "Key deleted from Work.ink:",deleted);return true,    --[[==========================================================]]expiryTimestamp,  
                                      deleted;end if (decoded.info and decoded.info.      --[[==============================================================]]createdAt) then 
                                       local createdAt=decoded.info.createdAt;if (        --[[================================================================]]createdAt>      
                                      1000000000000) then createdAt=createdAt/1000 ;end   --[[==================================================================]]local         
                                      expiryTimestamp=createdAt + 10800 ;print(           --[[==================================================================]]                  
                                    "Using fallback expiry:",os.date("%Y-%m-%d %H:%M:%S", --[[====================================================================]]              
                    expiryTimestamp));return true,expiryTimestamp,deleted;end return true --[[====================================================================]],os.time() +    
              10800 ,deleted;else return false,nil,false;end end local function           --[[======================================================================]]isKeyExpired( 
            expiryTime) if  not expiryTime then return true;end local currentTime=os.time --[[======================================================================]]();return     
          currentTime>=expiryTime ;end local function executeMainScript() if              --[[======================================================================]]              
        scriptExecuted then return;end scriptExecuted=true;pcall(function() if (KeyWindow --[[======================================================================]] and          
        KeyWindow.Destroy) then KeyWindow:Destroy();end end);task.wait(0.5);loadstring(   --[[======================================================================]]game:HttpGet( 
                                                                                          --[[======================================================================]]              
                                                                                            --[[==================================================================]]                
                                                                                            --[[================================================================]]                  
                                                                                            --[[==============================================================]]                  
                                                                                              --[[==========================================================]]                    
                                                                                                --[[====================================================]]                        
                                                                                                  --[[==============================================]]                          
                                                                                                      --[[====================================]]                              
    "https://raw.githubusercontent.com/randomthingscuzyes/notreallysigma/refs/heads/main/bloxstrike.lua") --[[========================]])();end local KeyWindow=Rayfield:     
    CreateWindow({Name="zencash - Key System",Icon="key",LoadingTitle="zencash",LoadingSubtitle="Verifying your key...",Theme="DarkBlue",DisableRayfieldPrompts=false,      
  DisableBuildWarnings=false});local KeyTab=KeyWindow:CreateTab("Verify","key");KeyTab:CreateButton({Name="Copy Key Link",Callback=function() if setclipboard then        
  setclipboard(WORK_INK_CONFIG.BASE_LINK);Rayfield:Notify({Title="Copied",Content="Link copied to clipboard",Duration=3});end end});local keyInput={Value=""};KeyTab:   
  CreateInput({Name="Enter Key",CurrentValue="",PlaceholderText="Paste your key here",Callback=function(val) keyInput.Value=val;end});local statusLabel=KeyTab:           
  CreateLabel("Status: Waiting for key...","key",Color3.fromRGB(255,200,0),false);local timerLabel=KeyTab:CreateLabel("","timer",Color3.fromRGB(255,200,0),false);local   
  function updateTimerDisplay(expiryTime) if  not expiryTime then timerLabel:Set("",Color3.fromRGB(255,200,0),false);return;end local currentTime=os.time();local         
  remaining=expiryTime-currentTime ;if (remaining<=0) then timerLabel:Set("Key expired",Color3.fromRGB(255,50,50),false);return;end local expiryDate=os.date(             
  "%Y-%m-%d %H:%M:%S",expiryTime);timerLabel:Set("Expires: "   .. expiryDate ,Color3.fromRGB(100,255,100),false);end local function createBloxstrikeButton() if           
  bloxstrikeButton then return;end bloxstrikeButton=KeyTab:CreateButton({Name="Bloxstrike",Callback=function() if (keyRedeemed and keyExpiryTime and  not isKeyExpired(   
  keyExpiryTime)) then statusLabel:Set("Loading Bloxstrike...",Color3.fromRGB(100,255,255),false);task.wait(1);executeMainScript();else statusLabel:Set(                  
  "Key expired or invalid",Color3.fromRGB(255,100,100),false);end end});end local loadedKey,loadedExpiry,loadedUsedKeys=loadKeyData();if (loadedKey and loadedExpiry)     
  then if  not isKeyExpired(loadedExpiry) then savedKey=loadedKey;keyExpiryTime=loadedExpiry;keyRedeemed=true;usedKeys=loadedUsedKeys or {} ;statusLabel:Set(             
  "Valid saved key found",Color3.fromRGB(100,255,100),false);updateTimerDisplay(keyExpiryTime);createBloxstrikeButton();spawn(function() while keySystemActive do if (      
  keyExpiryTime and  not isKeyExpired(keyExpiryTime)) then updateTimerDisplay(keyExpiryTime);elseif (keyExpiryTime and isKeyExpired(keyExpiryTime)) then timerLabel:Set(    
  "Key expired",Color3.fromRGB(255,50,50),false);statusLabel:Set("Key expired, please enter a new one",Color3.fromRGB(255,100,100),false);pcall(function() if isfile(       
  "zencash_key_data.json") then delfile("zencash_key_data.json");end end);savedKey=nil;keyExpiryTime=nil;keyRedeemed=false;bloxstrikeButton=nil;end task.wait(1);end end);  
  else pcall(function() if isfile("zencash_key_data.json") then delfile("zencash_key_data.json");end end);statusLabel:Set("Saved key expired",Color3.fromRGB(255,100,100),  
  false);usedKeys=loadedUsedKeys or {} ;end end KeyTab:CreateButton({Name="Redeem Key",Callback=function() local rawKey=keyInput.Value or "" ;if ((typeof(rawKey)~="string" 
  ) or (rawKey=="")) then statusLabel:Set("Please paste a key first",Color3.fromRGB(255,100,100),false);return;end rawKey=rawKey:gsub("%s+","");if (rawKey=="") then        
  statusLabel:Set("Invalid key",Color3.fromRGB(255,100,100),false);return;end if usedKeys[rawKey] then statusLabel:Set("This key has already been used",Color3.fromRGB(255, 
  200,0),false);return;end statusLabel:Set("Checking key...",Color3.fromRGB(100,200,255),false);task.wait(1);local valid,expiryTimestamp,deleted=verifyKey(rawKey);if (     
  valid and expiryTimestamp) then if  not deleted then print("WARNING: Key may not have been deleted from Work.ink");statusLabel:Set("Key verified but deletion failed!",   
  Color3.fromRGB(255,200,0),false);task.wait(1);else statusLabel:Set("Key verified and deleted from Work.ink",Color3.fromRGB(100,255,100),false);end usedKeys[rawKey]=true; 
  if (keyRedeemed and keyExpiryTime and  not isKeyExpired(keyExpiryTime)) then if (expiryTimestamp>keyExpiryTime) then keyExpiryTime=expiryTimestamp;statusLabel:Set(       
  "Key extended to: "   .. os.date("%Y-%m-%d %H:%M:%S",expiryTimestamp) ,Color3.fromRGB(100,255,100),false);else statusLabel:Set("Key already expires later",Color3.fromRGB 
  (255,200,0),false);end else keyExpiryTime=expiryTimestamp;keyRedeemed=true;statusLabel:Set("Key valid until: "   .. os.date("%Y-%m-%d %H:%M:%S",expiryTimestamp) ,      
  Color3.fromRGB(100,255,100),false);createBloxstrikeButton();end savedKey=rawKey;saveKeyData(savedKey,keyExpiryTime,usedKeys);updateTimerDisplay(keyExpiryTime);spawn(   
  function() while keySystemActive do if (keyExpiryTime and  not isKeyExpired(keyExpiryTime)) then updateTimerDisplay(keyExpiryTime);end task.wait(1);end end);else       
    statusLabel:Set("Invalid key, try again",Color3.fromRGB(255,100,100),false);end end});print("Key system ready");
