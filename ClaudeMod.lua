-- ClaudeMod: 1000 Jokers
-- Atlases: 10 batches of 100 jokers each, 10x10 grid per atlas (710x950)

for i = 1, 10 do
  SMODS.Atlas({
    key = string.format("cm_atlas_%02d", i),
    atlas_table = "ASSET_ATLAS",
    path = string.format("cm_atlas_%02d.png", i),
    px = 71,
    py = 95
  })
end

-- Load batches — pcall so missing/incomplete batches don't crash the mod
for i = 1, 10 do
  local path = string.format("jokers/batch_%02d.lua", i)
  local ok, err = pcall(function()
    SMODS.load_file(path)()
  end)
  if not ok then
    sendDebugMessage(string.format("[ClaudeMod] batch %02d not loaded: %s", i, tostring(err)))
  end
end
