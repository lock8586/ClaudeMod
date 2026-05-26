-- ClaudeMod Batch 01: European History (n001-n100)

-- n001: Julius Caesar
SMODS.Joker({
  key = "n001",
  loc_txt = { name = "Julius Caesar", text = { "{C:mult}+#1#{} Mult", "per {C:attention}Ace{} scored" } },
  config = { mult = 4 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 0 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value == "Ace" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n002: The Black Death
SMODS.Joker({
  key = "n002",
  loc_txt = { name = "The Black Death", text = { "Gains {X:mult,C:white}X1{} Mult", "each time a card is", "destroyed ({X:mult,C:white}X#1#{} now)" } },
  config = { extra = { xmult = 1 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 0 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.xmult } } end,
  calculate = function(self, card, context)
    if context.remove_playing_cards and context.removed then
      card.ability.extra.xmult = card.ability.extra.xmult + #context.removed
      card:juice_up(0.5, 0.2)
      return { message = "Plague!", colour = G.C.RED }
    end
    if context.joker_main then
      return { Xmult = card.ability.extra.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}} }
    end
  end
})

-- n003: Magna Carta
SMODS.Joker({
  key = "n003",
  loc_txt = { name = "Magna Carta", text = { "{C:chips}+#1#{} Chips", "if hand size is {C:attention}7{} or more" } },
  config = { chips = 50 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 0 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.hand.cards >= 7 then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n004: The Vikings
SMODS.Joker({
  key = "n004",
  loc_txt = { name = "The Vikings", text = { "{C:mult}+#1#{} Mult", "per {C:attention}Club{} scored" } },
  config = { mult = 3 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 0 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Clubs" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n005: Napoleon Complex
SMODS.Joker({
  key = "n005",
  loc_txt = { name = "Napoleon Complex", text = { "{X:mult,C:white}X#1#{} Mult", "if you have {C:attention}3{} or fewer jokers" } },
  config = { xmult = 3 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 0 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.jokers.cards <= 3 then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n006: The Renaissance
SMODS.Joker({
  key = "n006",
  loc_txt = { name = "The Renaissance", text = { "Gains {C:mult}+1{} Mult", "at end of each round", "({C:mult}+#1#{} Mult now)" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 0 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult = card.ability.extra.mult + 1
      card:juice_up(0.5, 0.2)
      return { message = "Flourishing!", colour = G.C.MULT }
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n007: The Crusades
SMODS.Joker({
  key = "n007",
  loc_txt = { name = "The Crusades", text = { "{C:chips}+#1#{} Chips per", "{C:attention}face card{} if hand", "is a {C:attention}Flush{}" } },
  config = { chips = 25 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 0 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local hand_name = context.scoring_name or ""
      if (hand_name == "Flush" or hand_name == "Flush House" or hand_name == "Flush Five") then
        local v = context.other_card.base.value
        if v == "Jack" or v == "Queen" or v == "King" then
          return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
        end
      end
    end
  end
})

-- n008: Marie Curie
SMODS.Joker({
  key = "n008",
  loc_txt = { name = "Marie Curie", text = { "{C:mult}+#1#{} Mult per", "pair of identical", "values played" } },
  config = { mult = 8 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 0 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local counts = {}
      for _, c in ipairs(G.play.cards) do
        local v = c.base.value
        counts[v] = (counts[v] or 0) + 1
      end
      local pairs_count = 0
      for _, cnt in pairs(counts) do
        pairs_count = pairs_count + math.floor(cnt / 2)
      end
      if pairs_count > 0 then
        local total = card.ability.mult * pairs_count
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n009: Joan of Arc
SMODS.Joker({
  key = "n009",
  loc_txt = { name = "Joan of Arc", text = { "{X:mult,C:white}X#1#{} Mult", "if all played cards", "are {C:attention}Hearts{}" } },
  config = { xmult = 3 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 0 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local all_hearts = true
      for _, c in ipairs(G.play.cards) do
        if c.base.suit ~= "Hearts" then all_hearts = false; break end
      end
      if all_hearts then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n010: Charlemagne
SMODS.Joker({
  key = "n010",
  loc_txt = { name = "Charlemagne", text = { "{C:mult}+#1#{} Mult per", "unique {C:attention}suit{} played" } },
  config = { mult = 6 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 0 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local suits = {}
      for _, c in ipairs(G.play.cards) do suits[c.base.suit] = true end
      local count = 0
      for _ in pairs(suits) do count = count + 1 end
      if count > 0 then
        local total = card.ability.mult * count
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n011: Vasco da Gama
SMODS.Joker({
  key = "n011",
  loc_txt = { name = "Vasco da Gama", text = { "Gains {C:chips}+2{} Chips", "each round", "({C:chips}+#1#{} Chips now)" } },
  config = { extra = { chips = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 1 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips = card.ability.extra.chips + 2
      card:juice_up(0.5, 0.2)
      return { message = "Explored!", colour = G.C.CHIPS }
    end
    if context.joker_main and card.ability.extra.chips > 0 then
      return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
    end
  end
})

-- n012: Copernicus
SMODS.Joker({
  key = "n012",
  loc_txt = { name = "Copernicus", text = { "{X:mult,C:white}X#1#{} Mult", "based on round", "number mod {C:attention}8{}" } },
  config = { xmult = 1 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 1 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local orbit = (G.GAME.round % 8) + 1
      return { Xmult = orbit, message = localize{type='variable',key='a_xmult',vars={orbit}} }
    end
  end
})

-- n013: The Ottoman Empire
SMODS.Joker({
  key = "n013",
  loc_txt = { name = "The Ottoman Empire", text = { "{C:chips}+#1#{} Chips", "per non-{C:attention}Ace{} scored" } },
  config = { chips = 8 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 1 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value ~= "Ace" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n014: Galileo
SMODS.Joker({
  key = "n014",
  loc_txt = { name = "Galileo", text = { "{C:mult}+#1#{} Mult", "if played hand", "contains an {C:attention}Ace{}" } },
  config = { mult = 20 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 1 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      for _, c in ipairs(G.play.cards) do
        if c.base.value == "Ace" then
          return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
        end
      end
    end
  end
})

-- n015: The Medici Bank
SMODS.Joker({
  key = "n015",
  loc_txt = { name = "The Medici Bank", text = { "Earn {C:money}$1{} for every", "{C:attention}100{} chips scored", "at end of round" } },
  config = { extra = { accum = 0 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 1 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = {} } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      local score = G.GAME.chips or 0
      local gold = math.floor(score / 100)
      if gold > 0 then
        ease_dollars(gold)
        card:juice_up(0.5, 0.2)
        return { message = "Profit!", colour = G.C.MONEY }
      end
    end
  end
})

-- n016: Attila the Hun
SMODS.Joker({
  key = "n016",
  loc_txt = { name = "Attila the Hun", text = { "{C:chips}+#1#{} Chips per", "card scored if hand", "size is {C:attention}maximum{}" } },
  config = { chips = 12 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 1 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if #G.hand.cards + #G.play.cards >= G.hand.config.card_limit then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n017: Leonardo da Vinci
SMODS.Joker({
  key = "n017",
  loc_txt = { name = "Leonardo da Vinci", text = { "{C:mult}+#1#{} Mult and", "{C:chips}+#1#{} Chips equal", "to joker count" } },
  config = { mult = 1 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 1 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { #G.jokers.cards } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local n = #G.jokers.cards
      return { mult = n, chips = n * 5, message = "Genius!" }
    end
  end
})

-- n018: The Hundred Years War
SMODS.Joker({
  key = "n018",
  loc_txt = { name = "Hundred Years War", text = { "Gains {C:mult}+1{} Mult", "per round, max {C:attention}100{}", "({C:mult}+#1#{} Mult now)" } },
  config = { extra = { mult = 0 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 1 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.extra.mult < 100 then
        card.ability.extra.mult = card.ability.extra.mult + 1
        card:juice_up(0.3, 0.1)
        return { message = "War drags on...", colour = G.C.MULT }
      end
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n019: Queen Elizabeth I
SMODS.Joker({
  key = "n019",
  loc_txt = { name = "Queen Elizabeth I", text = { "{X:mult,C:white}X#1#{} Mult", "if hand contains", "a {C:attention}Queen{}" } },
  config = { xmult = 3 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 1 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      for _, c in ipairs(G.play.cards) do
        if c.base.value == "Queen" then
          return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
        end
      end
    end
  end
})

-- n020: Martin Luther
SMODS.Joker({
  key = "n020",
  loc_txt = { name = "Martin Luther", text = { "Gains {C:mult}+1{} Mult", "permanently per discard", "({C:mult}+#1#{} Mult now)" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 1 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.discard then
      card.ability.extra.mult = card.ability.extra.mult + 1
      card:juice_up(0.4, 0.2)
      return { message = "Reformation!", colour = G.C.MULT }
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n021: Hannibal
SMODS.Joker({
  key = "n021",
  loc_txt = { name = "Hannibal", text = { "{C:chips}+#1#{} Chips", "if you have exactly", "{C:attention}3{} jokers" } },
  config = { chips = 80 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 2 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.jokers.cards == 3 then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n022: William Tell
SMODS.Joker({
  key = "n022",
  loc_txt = { name = "William Tell", text = { "{C:mult}+#1#{} Mult if an", "{C:attention}Ace{} is in hand", "but {C:attention}not played{}" } },
  config = { mult = 25 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 2 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local ace_in_hand = false
      local ace_played = false
      for _, c in ipairs(G.hand.cards) do
        if c.base.value == "Ace" then ace_in_hand = true end
      end
      for _, c in ipairs(G.play.cards) do
        if c.base.value == "Ace" then ace_played = true end
      end
      if ace_in_hand and not ace_played then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n023: The Roman Senate
SMODS.Joker({
  key = "n023",
  loc_txt = { name = "The Roman Senate", text = { "{X:mult,C:white}X#1#{} Mult", "if exactly {C:attention}5{}", "cards are played" } },
  config = { xmult = 4 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 2 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.play.cards == 5 then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n024: The Spanish Inquisition
SMODS.Joker({
  key = "n024",
  loc_txt = { name = "Spanish Inquisition", text = { "End of round: {C:attention}33%{}", "chance to destroy lowest", "card, gain {X:mult,C:white}X2{} Mult" } },
  config = { extra = { xmult = 1 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = false, perishable_compat = true,
  pos = { x = 3, y = 2 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.xmult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      if math.random() < 0.33 then
        card.ability.extra.xmult = card.ability.extra.xmult + 2
        card:juice_up(0.8, 0.3)
        return { message = "Nobody expects...", colour = G.C.RED }
      end
    end
    if context.joker_main and card.ability.extra.xmult > 1 then
      return { Xmult = card.ability.extra.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}} }
    end
  end
})

-- n025: Vlad the Impaler
SMODS.Joker({
  key = "n025",
  loc_txt = { name = "Vlad the Impaler", text = { "Gains {C:mult}+3{} Mult", "each time a card", "is {C:attention}destroyed{}", "({C:mult}+#1#{} now)" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 2 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.remove_playing_cards and context.removed then
      card.ability.extra.mult = card.ability.extra.mult + (3 * #context.removed)
      card:juice_up(0.6, 0.2)
      return { message = "Impaled!", colour = G.C.RED }
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n026: William Shakespeare
SMODS.Joker({
  key = "n026",
  loc_txt = { name = "Shakespeare", text = { "{C:mult}+#1#{} Mult per", "{C:attention}face card{} in hand", "(not played)" } },
  config = { mult = 5 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 2 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local count = 0
      for _, c in ipairs(G.hand.cards) do
        local v = c.base.value
        if v == "Jack" or v == "Queen" or v == "King" then count = count + 1 end
      end
      if count > 0 then
        local total = card.ability.mult * count
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n027: Alexander the Great
SMODS.Joker({
  key = "n027",
  loc_txt = { name = "Alexander the Great", text = { "{C:mult}+#1#{} Mult", "per {C:attention}King{} scored" } },
  config = { mult = 7 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 2 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value == "King" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n028: The Printing Press
SMODS.Joker({
  key = "n028",
  loc_txt = { name = "The Printing Press", text = { "{C:chips}+#1#{} Chips per", "{C:attention}face card{} scored" } },
  config = { chips = 20 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 2 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "Jack" or v == "Queen" or v == "King" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n029: Cleopatra
SMODS.Joker({
  key = "n029",
  loc_txt = { name = "Cleopatra", text = { "{C:mult}+#1#{} Mult per", "{C:attention}Diamond{} scored" } },
  config = { mult = 5 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 2 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Diamonds" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n030: The Trojan Horse
SMODS.Joker({
  key = "n030",
  loc_txt = { name = "The Trojan Horse", text = { "{X:mult,C:white}X#1#{} Mult", "if hand contains", "a {C:attention}Jack{}" } },
  config = { xmult = 2.5 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 2 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      for _, c in ipairs(G.play.cards) do
        if c.base.value == "Jack" then
          return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
        end
      end
    end
  end
})

-- n031: Genghis Khan
SMODS.Joker({
  key = "n031",
  loc_txt = { name = "Genghis Khan", text = { "{C:mult}+#1#{} Mult", "per card played", "beyond {C:attention}3{}" } },
  config = { mult = 8 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 3 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local extra = math.max(0, #G.play.cards - 3)
      if extra > 0 then
        local total = card.ability.mult * extra
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n032: The Colosseum
SMODS.Joker({
  key = "n032",
  loc_txt = { name = "The Colosseum", text = { "{C:chips}+#1#{} Chips", "if {C:attention}5{} cards played" } },
  config = { chips = 100 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 3 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.play.cards == 5 then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n033: The Silk Road
SMODS.Joker({
  key = "n033",
  loc_txt = { name = "The Silk Road", text = { "Earn {C:money}$#1#{}", "at end of round", "per joker owned" } },
  config = { extra = { gold = 1 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 3 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.gold } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      local gold = #G.jokers.cards
      ease_dollars(gold)
      card:juice_up(0.4, 0.2)
      return { message = "Trade!", colour = G.C.MONEY }
    end
  end
})

-- n034: Nero
SMODS.Joker({
  key = "n034",
  loc_txt = { name = "Nero", text = { "{X:mult,C:white}X#1#{} Mult", "if hand size is", "{C:attention}3{} or fewer" } },
  config = { xmult = 4 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 3 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.hand.cards <= 3 then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n035: The Plague of Athens
SMODS.Joker({
  key = "n035",
  loc_txt = { name = "Plague of Athens", text = { "Gains {C:mult}+2{} Mult", "when a hand is lost", "({C:mult}+#1#{} now)" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 3 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME.blind and G.GAME.chips < G.GAME.blind.chips then
        card.ability.extra.mult = card.ability.extra.mult + 2
        card:juice_up(0.5, 0.2)
        return { message = "Suffering!", colour = G.C.RED }
      end
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n036: The Battle of Hastings
SMODS.Joker({
  key = "n036",
  loc_txt = { name = "Battle of Hastings", text = { "{C:mult}+#1#{} Mult", "if hand contains", "a {C:attention}10{}" } },
  config = { mult = 15 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 3 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      for _, c in ipairs(G.play.cards) do
        if c.base.value == "10" then
          return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
        end
      end
    end
  end
})

-- n037: Archimedes
SMODS.Joker({
  key = "n037",
  loc_txt = { name = "Archimedes", text = { "{C:chips}+#1#{} Chips", "per {C:attention}number card{} scored", "(not face cards)" } },
  config = { chips = 15 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 3 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v ~= "Jack" and v ~= "Queen" and v ~= "King" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n038: Socrates
SMODS.Joker({
  key = "n038",
  loc_txt = { name = "Socrates", text = { "{C:mult}+#1#{} Mult", "if hand size is", "exactly {C:attention}5{}" } },
  config = { mult = 20 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 3 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.play.cards == 5 and #G.hand.cards == 0 then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n039: The Inquisitor
SMODS.Joker({
  key = "n039",
  loc_txt = { name = "The Inquisitor", text = { "{C:mult}+#1#{} Mult", "per {C:attention}Spade{} scored" } },
  config = { mult = 4 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 3 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Spades" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n040: The Papal Schism
SMODS.Joker({
  key = "n040",
  loc_txt = { name = "The Papal Schism", text = { "{X:mult,C:white}X#1#{} Mult", "if hand contains", "no {C:attention}face cards{}" } },
  config = { xmult = 2 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 3 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local has_face = false
      for _, c in ipairs(G.play.cards) do
        local v = c.base.value
        if v == "Jack" or v == "Queen" or v == "King" then has_face = true; break end
      end
      if not has_face then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n041: Spartacus
SMODS.Joker({
  key = "n041",
  loc_txt = { name = "Spartacus", text = { "{C:mult}+#1#{} Mult", "if {C:attention}1{} card is played", "(solo rebellion)" } },
  config = { mult = 35 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 4 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.play.cards == 1 then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n042: Boudicca
SMODS.Joker({
  key = "n042",
  loc_txt = { name = "Boudicca", text = { "Gains {C:mult}+4{} Mult", "each round", "({C:mult}+#1#{} now)" } },
  config = { extra = { mult = 0 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 4 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult = card.ability.extra.mult + 4
      card:juice_up(0.6, 0.3)
      return { message = "Rise up!", colour = G.C.MULT }
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n043: Marco Polo
SMODS.Joker({
  key = "n043",
  loc_txt = { name = "Marco Polo", text = { "{C:chips}+#1#{} Chips", "per {C:attention}unique suit{}", "in played hand" } },
  config = { chips = 30 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 4 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local suits = {}
      for _, c in ipairs(G.play.cards) do suits[c.base.suit] = true end
      local count = 0
      for _ in pairs(suits) do count = count + 1 end
      if count > 0 then
        local total = card.ability.chips * count
        return { chips = total, message = localize{type='variable',key='a_chips',vars={total}} }
      end
    end
  end
})

-- n044: Hadrian's Wall
SMODS.Joker({
  key = "n044",
  loc_txt = { name = "Hadrian's Wall", text = { "{C:chips}+#1#{} Chips", "if no {C:attention}Clubs{}", "are played" } },
  config = { chips = 60 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 4 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local has_club = false
      for _, c in ipairs(G.play.cards) do
        if c.base.suit == "Clubs" then has_club = true; break end
      end
      if not has_club then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n045: The Mongol Invasion
SMODS.Joker({
  key = "n045",
  loc_txt = { name = "The Mongol Invasion", text = { "{X:mult,C:white}X#1#{} Mult", "if {C:attention}4{} or more", "cards are played" } },
  config = { xmult = 2 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 4 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.play.cards >= 4 then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n046: The Venetian Republic
SMODS.Joker({
  key = "n046",
  loc_txt = { name = "Venetian Republic", text = { "Earn {C:money}$2{}", "per {C:attention}Diamond{}", "scored" } },
  config = { extra = { gold = 2 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 4 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.gold } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Diamonds" then
        ease_dollars(card.ability.extra.gold)
        return { message = localize('k_plus_dollars'), colour = G.C.MONEY }
      end
    end
  end
})

-- n047: The Reformation
SMODS.Joker({
  key = "n047",
  loc_txt = { name = "The Reformation", text = { "{C:mult}+#1#{} Mult", "per {C:attention}discard{}", "remaining this round" } },
  config = { mult = 5 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 4 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local discards = G.GAME.current_round.discards_left or 0
      if discards > 0 then
        local total = card.ability.mult * discards
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n048: Plato
SMODS.Joker({
  key = "n048",
  loc_txt = { name = "Plato", text = { "{C:mult}+#1#{} Mult", "per {C:attention}hand{} remaining", "this round" } },
  config = { mult = 7 },
  rarity = 2, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 4 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local hands = G.GAME.current_round.hands_left or 0
      if hands > 0 then
        local total = card.ability.mult * hands
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n049: The Normans
SMODS.Joker({
  key = "n049",
  loc_txt = { name = "The Normans", text = { "{C:mult}+#1#{} Mult", "per {C:attention}Heart{} scored" } },
  config = { mult = 3 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 4 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Hearts" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n050: The Byzantine Empire
SMODS.Joker({
  key = "n050",
  loc_txt = { name = "Byzantine Empire", text = { "{C:chips}+#1#{} Chips", "per {C:attention}Spade{} scored" } },
  config = { chips = 18 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 4 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Spades" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n051: The Great Wall
SMODS.Joker({
  key = "n051",
  loc_txt = { name = "The Great Wall", text = { "{C:chips}+#1#{} Chips", "if all played cards", "are the same {C:attention}suit{}" } },
  config = { chips = 80 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 5 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local suit = nil
      local all_same = true
      for _, c in ipairs(G.play.cards) do
        if suit == nil then suit = c.base.suit
        elseif c.base.suit ~= suit then all_same = false; break end
      end
      if all_same and suit ~= nil then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n052: Pythagoras
SMODS.Joker({
  key = "n052",
  loc_txt = { name = "Pythagoras", text = { "{C:chips}+#1#{} Chips", "if played hand is", "exactly {C:attention}3{} cards" } },
  config = { chips = 50 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 5 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.play.cards == 3 then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n053: The Black Knight
SMODS.Joker({
  key = "n053",
  loc_txt = { name = "The Black Knight", text = { "Gains {X:mult,C:white}X0.5{} Mult", "when any joker is", "sold or destroyed", "({X:mult,C:white}X#1#{} now)" } },
  config = { extra = { xmult = 1 } },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 5 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.xmult } } end,
  calculate = function(self, card, context)
    if context.selling_card then
      for _, j in ipairs(G.jokers.cards) do
        if j ~= card then
          card.ability.extra.xmult = card.ability.extra.xmult + 0.5
          card:juice_up(0.5, 0.2)
          return { message = "'Tis but a scratch!", colour = G.C.RED }
        end
      end
    end
    if context.joker_main and card.ability.extra.xmult > 1 then
      return { Xmult = card.ability.extra.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}} }
    end
  end
})

-- n054: Frederick the Great
SMODS.Joker({
  key = "n054",
  loc_txt = { name = "Frederick the Great", text = { "{C:mult}+#1#{} Mult", "per joker owned" } },
  config = { mult = 3 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 5 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local total = card.ability.mult * #G.jokers.cards
      return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
    end
  end
})

-- n055: The French Revolution
SMODS.Joker({
  key = "n055",
  loc_txt = { name = "French Revolution", text = { "{X:mult,C:white}X#1#{} Mult", "if score beats", "previous round's score" } },
  config = { extra = { xmult = 2, last_score = 0 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 5 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.xmult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.last_score = G.GAME.chips or 0
    end
    if context.joker_main then
      local curr = G.GAME.chips or 0
      if card.ability.extra.last_score > 0 and curr > card.ability.extra.last_score then
        return { Xmult = card.ability.extra.xmult, message = "Liberté!", colour = G.C.MULT }
      end
    end
  end
})

-- n056: Nicolaus Copernicus II
SMODS.Joker({
  key = "n056",
  loc_txt = { name = "Heliocentric Model", text = { "{C:mult}+#1#{} Mult", "if {C:attention}Ace{} is first", "card played" } },
  config = { mult = 20 },
  rarity = 2, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 5 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.play.cards > 0 and G.play.cards[1].base.value == "Ace" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n057: Machiavelli
SMODS.Joker({
  key = "n057",
  loc_txt = { name = "Machiavelli", text = { "{X:mult,C:white}X#1#{} Mult", "if you have the most", "jokers ({C:attention}#2#{} needed)" } },
  config = { xmult = 2.5, extra = { needed = 4 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 5 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult, center.ability.extra.needed } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.jokers.cards >= card.ability.extra.needed then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n058: The Inquisition Ends
SMODS.Joker({
  key = "n058",
  loc_txt = { name = "The Inquisition Ends", text = { "{C:mult}+#1#{} Mult", "per card remaining", "in {C:attention}hand{}" } },
  config = { mult = 4 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 5 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local n = #G.hand.cards
      if n > 0 then
        local total = card.ability.mult * n
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n059: Isaac Newton
SMODS.Joker({
  key = "n059",
  loc_txt = { name = "Isaac Newton", text = { "{C:chips}+#1#{} Chips", "if hand is a", "{C:attention}Straight{}" } },
  config = { chips = 120 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 5 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local hand_name = context.scoring_name or ""
      if hand_name == "Straight" or hand_name == "Straight Flush" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n060: Catherine the Great
SMODS.Joker({
  key = "n060",
  loc_txt = { name = "Catherine the Great", text = { "{X:mult,C:white}X#1#{} Mult", "if hand is a", "{C:attention}Full House{}" } },
  config = { xmult = 3 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 5 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if context.scoring_name == "Full House" then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n061: The Alamo
SMODS.Joker({
  key = "n061",
  loc_txt = { name = "The Alamo", text = { "Gains {C:mult}+5{} Mult", "when a hand is", "{C:attention}lost{} ({C:mult}+#1#{} now)" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 6 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME.blind and G.GAME.chips < G.GAME.blind.chips then
        card.ability.extra.mult = card.ability.extra.mult + 5
        card:juice_up(0.7, 0.3)
        return { message = "Remember!", colour = G.C.RED }
      end
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n062: Gutenberg Press
SMODS.Joker({
  key = "n062",
  loc_txt = { name = "Gutenberg Press", text = { "Gains {C:chips}+50{} Chips", "each time a", "{C:attention}Straight{} is played", "({C:chips}+#1#{} now)" } },
  config = { extra = { chips = 0 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 6 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local hand_name = context.scoring_name or ""
      if hand_name == "Straight" or hand_name == "Straight Flush" then
        card.ability.extra.chips = card.ability.extra.chips + 50
        card:juice_up(0.5, 0.2)
      end
      if card.ability.extra.chips > 0 then
        return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
      end
    end
  end
})

-- n063: Suleiman the Magnificent
SMODS.Joker({
  key = "n063",
  loc_txt = { name = "Suleiman Magnificent", text = { "{C:mult}+#1#{} Mult", "per {C:attention}2{} through {C:attention}6{}", "scored" } },
  config = { mult = 5 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 6 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "2" or v == "3" or v == "4" or v == "5" or v == "6" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n064: Charles Darwin
SMODS.Joker({
  key = "n064",
  loc_txt = { name = "Charles Darwin", text = { "Gains {C:mult}+1{} Mult", "per round survived", "({C:mult}+#1#{} now)" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 6 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult = card.ability.extra.mult + 1
      card:juice_up(0.3, 0.1)
      return { message = "Evolved!", colour = G.C.MULT }
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n065: The Black Prince
SMODS.Joker({
  key = "n065",
  loc_txt = { name = "The Black Prince", text = { "{C:mult}+#1#{} Mult", "per {C:attention}Spade{} in hand", "(not played)" } },
  config = { mult = 6 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 6 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local count = 0
      for _, c in ipairs(G.hand.cards) do
        if c.base.suit == "Spades" then count = count + 1 end
      end
      if count > 0 then
        local total = card.ability.mult * count
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n066: Erasmus
SMODS.Joker({
  key = "n066",
  loc_txt = { name = "Erasmus", text = { "{C:mult}+#1#{} Mult", "per {C:attention}book{} — joker", "count times {C:attention}2{}" } },
  config = { mult = 2 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 6 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local total = card.ability.mult * #G.jokers.cards * 2
      return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
    end
  end
})

-- n067: El Cid
SMODS.Joker({
  key = "n067",
  loc_txt = { name = "El Cid", text = { "{C:mult}+#1#{} Mult", "if hand is a", "{C:attention}Pair{}" } },
  config = { mult = 30 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 6 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_name == "Pair" then
      return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
    end
  end
})

-- n068: The Habsburg Empire
SMODS.Joker({
  key = "n068",
  loc_txt = { name = "The Habsburg Empire", text = { "{X:mult,C:white}X#1#{} Mult", "if played hand has", "cards of {C:attention}3+{} suits" } },
  config = { xmult = 2 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 6 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local suits = {}
      for _, c in ipairs(G.play.cards) do suits[c.base.suit] = true end
      local count = 0
      for _ in pairs(suits) do count = count + 1 end
      if count >= 3 then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n069: Ivan the Terrible
SMODS.Joker({
  key = "n069",
  loc_txt = { name = "Ivan the Terrible", text = { "{X:mult,C:white}X#1#{} Mult", "if hand score", "is below {C:attention}500{}" } },
  config = { xmult = 5 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 6 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if (G.GAME.chips or 0) < 500 then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n070: The Peasant's Revolt
SMODS.Joker({
  key = "n070",
  loc_txt = { name = "Peasant's Revolt", text = { "Gains {C:mult}+2{} Mult", "per discard used", "({C:mult}+#1#{} now)" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 6 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.discard then
      card.ability.extra.mult = card.ability.extra.mult + 2
      card:juice_up(0.4, 0.2)
      return { message = "Revolt!", colour = G.C.MULT }
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n071: Dante Alighieri
SMODS.Joker({
  key = "n071",
  loc_txt = { name = "Dante Alighieri", text = { "{C:chips}+#1#{} Chips", "if hand is a", "{C:attention}Three of a Kind{}" } },
  config = { chips = 90 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 7 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_name == "Three of a Kind" then
      return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
    end
  end
})

-- n072: Cicero
SMODS.Joker({
  key = "n072",
  loc_txt = { name = "Cicero", text = { "{C:mult}+#1#{} Mult", "per {C:attention}hand{} played", "this round" } },
  config = { extra = { mult = 5 } },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 7 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local played = (G.GAME.current_round.hands_played or 0)
      if played > 0 then
        local total = card.ability.extra.mult * played
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n073: The Ptolemaic System
SMODS.Joker({
  key = "n073",
  loc_txt = { name = "Ptolemaic System", text = { "{C:chips}+#1#{} Chips", "per card in played", "hand" } },
  config = { chips = 12 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 7 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local total = card.ability.chips * #G.play.cards
      return { chips = total, message = localize{type='variable',key='a_chips',vars={total}} }
    end
  end
})

-- n074: The Columbian Exchange
SMODS.Joker({
  key = "n074",
  loc_txt = { name = "Columbian Exchange", text = { "{C:chips}+#1#{} Chips and", "{C:mult}+#1#{} Mult if", "all {C:attention}4{} suits played" } },
  config = { chips = 40, mult = 10 },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 7 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips, center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local suits = {}
      for _, c in ipairs(G.play.cards) do suits[c.base.suit] = true end
      local count = 0
      for _ in pairs(suits) do count = count + 1 end
      if count == 4 then
        return { chips = card.ability.chips, mult = card.ability.mult, message = "New World!" }
      end
    end
  end
})

-- n075: Robespierre
SMODS.Joker({
  key = "n075",
  loc_txt = { name = "Robespierre", text = { "{X:mult,C:white}X#1#{} Mult", "if you have fewer", "than {C:attention}3{} discards" } },
  config = { xmult = 2 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 7 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if (G.GAME.current_round.discards_left or 0) < 3 then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n076: Tycho Brahe
SMODS.Joker({
  key = "n076",
  loc_txt = { name = "Tycho Brahe", text = { "{C:chips}+#1#{} Chips", "per {C:attention}7{}, {C:attention}8{}, or {C:attention}9{}", "scored" } },
  config = { chips = 22 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 7 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "7" or v == "8" or v == "9" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n077: The Inquisitor's Book
SMODS.Joker({
  key = "n077",
  loc_txt = { name = "Inquisitor's Book", text = { "{C:mult}+#1#{} Mult", "per {C:attention}Club{} in hand", "(not played)" } },
  config = { mult = 5 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 7 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local count = 0
      for _, c in ipairs(G.hand.cards) do
        if c.base.suit == "Clubs" then count = count + 1 end
      end
      if count > 0 then
        local total = card.ability.mult * count
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n078: The Holy Roman Emperor
SMODS.Joker({
  key = "n078",
  loc_txt = { name = "Holy Roman Emperor", text = { "{X:mult,C:white}X#1#{} Mult", "if {C:attention}King{} and {C:attention}Ace{}", "both played" } },
  config = { xmult = 4 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 7 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local has_king, has_ace = false, false
      for _, c in ipairs(G.play.cards) do
        if c.base.value == "King" then has_king = true end
        if c.base.value == "Ace" then has_ace = true end
      end
      if has_king and has_ace then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n079: Chivalric Code
SMODS.Joker({
  key = "n079",
  loc_txt = { name = "Chivalric Code", text = { "{C:mult}+#1#{} Mult", "per {C:attention}face card{} played", "in Hearts or Diamonds" } },
  config = { mult = 8 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 7 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      local s = context.other_card.base.suit
      if (v == "Jack" or v == "Queen" or v == "King") and (s == "Hearts" or s == "Diamonds") then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n080: The Magna Graecia
SMODS.Joker({
  key = "n080",
  loc_txt = { name = "Magna Graecia", text = { "{C:chips}+#1#{} Chips", "if hand is a", "{C:attention}High Card{}" } },
  config = { chips = 200 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 7 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_name == "High Card" then
      return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
    end
  end
})

-- n081: The Hanseatic League
SMODS.Joker({
  key = "n081",
  loc_txt = { name = "Hanseatic League", text = { "Earn {C:money}$1{} per", "{C:attention}Club{} scored" } },
  config = { extra = { gold = 1 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 8 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.gold } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Clubs" then
        ease_dollars(card.ability.extra.gold)
        return { message = localize('k_plus_dollars'), colour = G.C.MONEY }
      end
    end
  end
})

-- n082: The Thirty Years War
SMODS.Joker({
  key = "n082",
  loc_txt = { name = "Thirty Years War", text = { "Gains {C:mult}+2{} Mult", "and {C:chips}+10{} Chips", "per round ({C:mult}+#1#{} /{C:chips}+#2#{})" } },
  config = { extra = { mult = 0, chips = 0 } },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 8 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult, center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult = card.ability.extra.mult + 2
      card.ability.extra.chips = card.ability.extra.chips + 10
      card:juice_up(0.5, 0.2)
      return { message = "War rages!", colour = G.C.RED }
    end
    if context.joker_main then
      local m = card.ability.extra.mult
      local c = card.ability.extra.chips
      if m > 0 or c > 0 then
        return { mult = m, chips = c, message = "Carnage!" }
      end
    end
  end
})

-- n083: Peter the Great
SMODS.Joker({
  key = "n083",
  loc_txt = { name = "Peter the Great", text = { "{X:mult,C:white}X#1#{} Mult", "if {C:attention}4{} or more", "jokers owned" } },
  config = { xmult = 2 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 8 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main and #G.jokers.cards >= 4 then
      return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
    end
  end
})

-- n084: Vercingetorix
SMODS.Joker({
  key = "n084",
  loc_txt = { name = "Vercingetorix", text = { "{C:mult}+#1#{} Mult", "if played cards are", "all {C:attention}different{} values" } },
  config = { mult = 20 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 8 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local vals = {}
      local all_diff = true
      for _, c in ipairs(G.play.cards) do
        if vals[c.base.value] then all_diff = false; break end
        vals[c.base.value] = true
      end
      if all_diff then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n085: The Council of Trent
SMODS.Joker({
  key = "n085",
  loc_txt = { name = "Council of Trent", text = { "{C:mult}+#1#{} Mult", "if hand is a", "{C:attention}Two Pair{}" } },
  config = { mult = 25 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 8 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_name == "Two Pair" then
      return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
    end
  end
})

-- n086: Galileo's Telescope
SMODS.Joker({
  key = "n086",
  loc_txt = { name = "Galileo's Telescope", text = { "{C:chips}+#1#{} Chips", "per {C:attention}10{}, {C:attention}Jack{}, or {C:attention}Queen{}", "scored" } },
  config = { chips = 18 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 8 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "10" or v == "Jack" or v == "Queen" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n087: The Black Sea Fleet
SMODS.Joker({
  key = "n087",
  loc_txt = { name = "Black Sea Fleet", text = { "{C:chips}+#1#{} Chips", "if all played cards", "are {C:attention}Spades{}" } },
  config = { chips = 100 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 8 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local all_spades = true
      for _, c in ipairs(G.play.cards) do
        if c.base.suit ~= "Spades" then all_spades = false; break end
      end
      if all_spades then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n088: The Diet of Worms
SMODS.Joker({
  key = "n088",
  loc_txt = { name = "The Diet of Worms", text = { "{C:mult}+#1#{} Mult", "if exactly {C:attention}4{}", "cards are played" } },
  config = { mult = 15 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 8 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and #G.play.cards == 4 then
      return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
    end
  end
})

-- n089: The Sun King
SMODS.Joker({
  key = "n089",
  loc_txt = { name = "The Sun King", text = { "{X:mult,C:white}X#1#{} Mult", "if hand contains", "a {C:attention}King{}" } },
  config = { xmult = 2.5 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 8 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      for _, c in ipairs(G.play.cards) do
        if c.base.value == "King" then
          return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
        end
      end
    end
  end
})

-- n090: The Spanish Armada
SMODS.Joker({
  key = "n090",
  loc_txt = { name = "The Spanish Armada", text = { "{X:mult,C:white}X#1#{} Mult", "if hand is a {C:attention}Flush{}" } },
  config = { xmult = 2 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 8 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local hand_name = context.scoring_name or ""
      if hand_name == "Flush" or hand_name == "Flush House" or hand_name == "Flush Five" then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n091: The Peace of Westphalia
SMODS.Joker({
  key = "n091",
  loc_txt = { name = "Peace of Westphalia", text = { "{C:chips}+#1#{} Chips", "per round survived", "({C:chips}+#1#{} now)" } },
  config = { extra = { chips = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 9 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips = card.ability.extra.chips + 5
      card:juice_up(0.3, 0.1)
      return { message = "Peace!", colour = G.C.CHIPS }
    end
    if context.joker_main and card.ability.extra.chips > 0 then
      return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
    end
  end
})

-- n092: The Doge of Venice
SMODS.Joker({
  key = "n092",
  loc_txt = { name = "Doge of Venice", text = { "Earn {C:money}$#1#{}", "at end of round" } },
  config = { extra = { gold = 3 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 9 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.gold } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      ease_dollars(card.ability.extra.gold)
      card:juice_up(0.4, 0.2)
      return { message = "Ducats!", colour = G.C.MONEY }
    end
  end
})

-- n093: The Alchemist
SMODS.Joker({
  key = "n093",
  loc_txt = { name = "The Alchemist", text = { "{X:mult,C:white}X#1#{} Mult", "if hand is a", "{C:attention}Four of a Kind{}" } },
  config = { xmult = 5 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 9 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_name == "Four of a Kind" then
      return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
    end
  end
})

-- n094: The Treaty of Utrecht
SMODS.Joker({
  key = "n094",
  loc_txt = { name = "Treaty of Utrecht", text = { "{C:mult}+#1#{} Mult", "if score beats", "{C:attention}blind{} by {C:attention}2x{}" } },
  config = { mult = 25 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 9 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local blind_chips = G.GAME.blind and G.GAME.blind.chips or 0
      if blind_chips > 0 and (G.GAME.chips or 0) >= blind_chips * 2 then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n095: Montaigne
SMODS.Joker({
  key = "n095",
  loc_txt = { name = "Montaigne", text = { "{C:mult}+#1#{} Mult", "if hand is a", "{C:attention}Straight Flush{}" } },
  config = { mult = 50 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 9 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_name == "Straight Flush" then
      return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
    end
  end
})

-- n096: The Age of Exploration
SMODS.Joker({
  key = "n096",
  loc_txt = { name = "Age of Exploration", text = { "Gains {C:chips}+5{} Chips", "and {C:mult}+1{} Mult", "each round", "({C:chips}+#1#{} / {C:mult}+#2#{})" } },
  config = { extra = { chips = 0, mult = 0 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 9 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips, center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips = card.ability.extra.chips + 5
      card.ability.extra.mult = card.ability.extra.mult + 1
      card:juice_up(0.5, 0.2)
      return { message = "Discovered!", colour = G.C.CHIPS }
    end
    if context.joker_main then
      local c = card.ability.extra.chips
      local m = card.ability.extra.mult
      if c > 0 or m > 0 then
        return { chips = c, mult = m, message = "New Horizons!" }
      end
    end
  end
})

-- n097: The Grand Tour
SMODS.Joker({
  key = "n097",
  loc_txt = { name = "The Grand Tour", text = { "{C:chips}+#1#{} Chips", "per unique {C:attention}suit{}", "seen this run" } },
  config = { extra = { chips = 40, suits_seen = {} } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 9 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center)
    local seen = 0
    for _ in pairs(center.ability.extra.suits_seen or {}) do seen = seen + 1 end
    return { vars = { center.ability.extra.chips * math.max(1, seen) } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      card.ability.extra.suits_seen = card.ability.extra.suits_seen or {}
      card.ability.extra.suits_seen[context.other_card.base.suit] = true
    end
    if context.joker_main then
      local seen = 0
      for _ in pairs(card.ability.extra.suits_seen or {}) do seen = seen + 1 end
      local total = card.ability.extra.chips * math.max(1, seen)
      return { chips = total, message = localize{type='variable',key='a_chips',vars={total}} }
    end
  end
})

-- n098: The Enlightenment
SMODS.Joker({
  key = "n098",
  loc_txt = { name = "The Enlightenment", text = { "{C:mult}+#1#{} Mult", "per {C:attention}hand{} size", "above {C:attention}5{}" } },
  config = { mult = 8 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 9 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local extra = math.max(0, (G.hand.config.card_limit or 8) - 5)
      if extra > 0 then
        local total = card.ability.mult * extra
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n099: Pompeii
SMODS.Joker({
  key = "n099",
  loc_txt = { name = "Pompeii", text = { "{X:mult,C:white}X#1#{} Mult", "but loses {C:attention}1{} Mult", "each round (min {X:mult,C:white}X1{})" } },
  config = { extra = { xmult = 10 } },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 9 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.xmult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.extra.xmult > 1 then
        card.ability.extra.xmult = card.ability.extra.xmult - 1
        card:juice_up(0.3, 0.1)
        return { message = "Erupting!", colour = G.C.RED }
      end
    end
    if context.joker_main and card.ability.extra.xmult > 1 then
      return { Xmult = card.ability.extra.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}} }
    end
  end
})

-- n100: The Fall of Rome
SMODS.Joker({
  key = "n100",
  loc_txt = { name = "The Fall of Rome", text = { "{X:mult,C:white}X#1#{} Mult", "Loses {C:attention}0.5{} each hand,", "resets each round" } },
  config = { extra = { xmult = 8, base_xmult = 8 } },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 9 }, atlas = "cm_atlas_01",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.xmult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.xmult = card.ability.extra.base_xmult
      return { message = "Reset!", colour = G.C.CHIPS }
    end
    if context.joker_main then
      local x = card.ability.extra.xmult
      if x > 1 then
        card.ability.extra.xmult = math.max(1, x - 0.5)
        return { Xmult = x, message = localize{type='variable',key='a_xmult',vars={x}} }
      end
    end
  end
})
