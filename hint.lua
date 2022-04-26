PLUGIN.name = "Hint"
PLUGIN.description = "Simple way to show hint's to your players."
PLUGIN.author = "Chlexy"

if SERVER then return false end;

ix.hints = ix.hints or {};

local function addHint(hint)
  table.insert(ix.hints, hint);
end

addHint("Some hint1");
addHint("Some hint2");
addHint("Some hint3");

// ================================================================
local function showRandomHint()
  notification.AddLegacy(table.Random(ix.hints), NOTIFY_GENERIC, 5);
end

local function hintsReloadTimer()
  if (timer.Exists("ixShowRandomHint")) then
    timer.Remove("ixShowRandomHint")
  end
  
  if (ix.option.Get("hintsEnabled", true)) then
    timer.Create("ixShowRandomHint", ix.option.Get("hintsTimer", 60), 0, showRandomHint);
  end
end

ix.option.Add("hintsEnabled", ix.type.bool, true, {
  category = "Hints",
  hidden = hintsReloadTimer
});

ix.option.Add("hintsTimer", ix.type.number, 10, {
  category = "Hints", 
  min = 10, 
  max = 3600,
  hidden = hintsReloadTimer
})

if (ix.option.Get("hintsEnabled", true)) then
  timer.Create("ixShowRandomHint", ix.option.Get("hintsTimer", 60), 0, showRandomHint);
end