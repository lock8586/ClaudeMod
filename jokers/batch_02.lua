-- ClaudeMod Batch 02: Food, Cheese & Carbs (n101-n200)

-- n101: Gouda
SMODS.Joker({
  key = "n101",
  loc_txt = { name = "Gouda", text = { "{C:mult}+#1#{} Mult", "per {C:attention}Diamond{} scored" } },
  config = { mult = 4 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 0 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Diamonds" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n102: Brie
SMODS.Joker({
  key = "n102",
  loc_txt = { name = "Brie", text = { "Gains {C:mult}+2{} Mult", "each round" } },
  config = { extra = { val = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 0 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = card.ability.extra.val, message = localize{type='variable',key='a_mult',vars={card.ability.extra.val}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val = card.ability.extra.val + 2
    end
  end
})

-- n103: Spaghetti
SMODS.Joker({
  key = "n103",
  loc_txt = { name = "Spaghetti", text = { "{C:red}X#1#{} Mult", "scales with hand size" } },
  config = { extra = { xmult = 0.2 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 0 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center)
    local xm = 1 + (G.hand and #G.hand.cards or 0) * center.ability.extra.xmult
    return { vars = { string.format("%.1f", xm) } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local sz = G.hand and #G.hand.cards or 0
      local xm = 1 + sz * card.ability.extra.xmult
      return { Xmult = xm, message = localize{type='variable',key='a_xmult',vars={string.format("%.1f", xm)}} }
    end
  end
})

-- n104: Pizza
SMODS.Joker({
  key = "n104",
  loc_txt = { name = "Pizza", text = { "{C:chips}+#1#{} Chips", "if last hand was a {C:attention}Flush{}" } },
  config = { chips = 50 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 0 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local last = G.GAME.last_hand_played
      if last == "Flush" or last == "Flush House" or last == "Flush Five" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n105: Croissant
SMODS.Joker({
  key = "n105",
  loc_txt = { name = "Croissant", text = { "{C:chips}+#1#{} Chips", "per {C:attention}Diamond{} scored" } },
  config = { chips = 12 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 0 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Diamonds" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n106: Bagel
SMODS.Joker({
  key = "n106",
  loc_txt = { name = "Bagel", text = { "{C:red}X3{} Mult if hand", "contains {C:attention}Two Pair{}" } },
  config = { xmult = 3 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 0 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local t = G.GAME.current_round.hands_played
      if G.GAME.last_hand_played == "Two Pair" then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n107: Garlic Bread
SMODS.Joker({
  key = "n107",
  loc_txt = { name = "Garlic Bread", text = { "{C:red}X2{} Mult if you", "hold {C:attention}6+{} cards" } },
  config = { xmult = 2 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 0 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.hand and #G.hand.cards >= 6 then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n108: Mac & Cheese
SMODS.Joker({
  key = "n108",
  loc_txt = { name = "Mac & Cheese", text = { "{C:chips}+#1#{} Chips", "every time you play a {C:attention}Pair{}" } },
  config = { extra = { val = 0, chips = 20 } },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 0 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { chips = card.ability.extra.val, message = localize{type='variable',key='a_chips',vars={card.ability.extra.val}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME.last_hand_played == "Pair" then
        card.ability.extra.val = card.ability.extra.val + card.ability.extra.chips
      end
    end
  end
})

-- n109: Cheddar Block
SMODS.Joker({
  key = "n109",
  loc_txt = { name = "Cheddar Block", text = { "{C:mult}+#1#{} Mult,", "gains {C:mult}+1{} when you score {C:attention}5+{} cards" } },
  config = { extra = { val = 2 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 0 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = card.ability.extra.val, message = localize{type='variable',key='a_mult',vars={card.ability.extra.val}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if G.play and #G.play.cards >= 5 then
        card.ability.extra.val = card.ability.extra.val + 1
      end
    end
  end
})

-- n110: Fondue Pot
SMODS.Joker({
  key = "n110",
  loc_txt = { name = "Fondue Pot", text = { "{C:red}X#1#{} Mult", "per {C:attention}Joker{} you own" } },
  config = { extra = { xmult = 0.3 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 0 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center)
    local cnt = G.jokers and #G.jokers.cards or 0
    return { vars = { string.format("%.1f", 1 + cnt * center.ability.extra.xmult) } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local cnt = G.jokers and #G.jokers.cards or 0
      local xm = 1 + cnt * card.ability.extra.xmult
      return { Xmult = xm, message = localize{type='variable',key='a_xmult',vars={string.format("%.1f", xm)}} }
    end
  end
})

-- n111: Sourdough
SMODS.Joker({
  key = "n111",
  loc_txt = { name = "Sourdough", text = { "{C:chips}+#1#{} Chips,", "gains {C:chips}+5{} each round" } },
  config = { extra = { val = 10 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 1 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { chips = card.ability.extra.val, message = localize{type='variable',key='a_chips',vars={card.ability.extra.val}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val = card.ability.extra.val + 5
    end
  end
})

-- n112: Ramen
SMODS.Joker({
  key = "n112",
  loc_txt = { name = "Ramen", text = { "{C:mult}+#1#{} Mult", "per {C:attention}Heart{} scored" } },
  config = { mult = 3 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 1 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Hearts" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n113: Tiramisu
SMODS.Joker({
  key = "n113",
  loc_txt = { name = "Tiramisu", text = { "{C:red}X#1#{} Mult if you've", "played {C:attention}3+{} rounds" } },
  config = { xmult = 2.5 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 1 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.round >= 3 then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n114: Pretzel
SMODS.Joker({
  key = "n114",
  loc_txt = { name = "Pretzel", text = { "{C:chips}+#1#{} Chips", "if hand is {C:attention}Two Pair{} or better" } },
  config = { chips = 40 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 1 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local h = G.GAME.last_hand_played
      local good = { ["Two Pair"]=true, ["Three of a Kind"]=true, ["Straight"]=true, ["Flush"]=true,
                     ["Full House"]=true, ["Four of a Kind"]=true, ["Straight Flush"]=true,
                     ["Royal Flush"]=true, ["Flush House"]=true, ["Flush Five"]=true, ["Five of a Kind"]=true }
      if good[h] then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n115: Camembert
SMODS.Joker({
  key = "n115",
  loc_txt = { name = "Camembert", text = { "{C:mult}+#1#{} Mult", "per {C:attention}Club{} scored" } },
  config = { mult = 4 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 1 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Clubs" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n116: Focaccia
SMODS.Joker({
  key = "n116",
  loc_txt = { name = "Focaccia", text = { "{C:chips}+#1#{} Chips", "per {C:attention}Spade{} scored" } },
  config = { chips = 15 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 1 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Spades" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n117: Mozzarella Stick
SMODS.Joker({
  key = "n117",
  loc_txt = { name = "Mozzarella Stick", text = { "{C:mult}+#1#{} Mult per", "{C:attention}face card{} scored" } },
  config = { mult = 5 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 1 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "Jack" or v == "Queen" or v == "King" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n118: Wonton
SMODS.Joker({
  key = "n118",
  loc_txt = { name = "Wonton", text = { "{C:chips}+#1#{} Chips per", "{C:attention}Ace{} scored" } },
  config = { chips = 30 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 1 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value == "Ace" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n119: Parmesan
SMODS.Joker({
  key = "n119",
  loc_txt = { name = "Parmesan", text = { "Gains {C:chips}+3{} Chips", "each hand played" } },
  config = { extra = { val = 0 } },
  rarity = 2, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 1 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      card.ability.extra.val = card.ability.extra.val + 3
      return { chips = card.ability.extra.val, message = localize{type='variable',key='a_chips',vars={card.ability.extra.val}} }
    end
  end
})

-- n120: Burrito
SMODS.Joker({
  key = "n120",
  loc_txt = { name = "Burrito", text = { "{C:mult}+#1#{} Mult if hand", "has {C:attention}5{} cards scored" } },
  config = { mult = 15 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 1 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.play and #G.play.cards == 5 then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n121: Tacos
SMODS.Joker({
  key = "n121",
  loc_txt = { name = "Tacos", text = { "{C:red}X#1#{} Mult if", "exactly {C:attention}3{} cards scored" } },
  config = { xmult = 2 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 2 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.play and #G.play.cards == 3 then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n122: Nacho
SMODS.Joker({
  key = "n122",
  loc_txt = { name = "Nacho", text = { "{C:chips}+#1#{} Chips per", "{C:attention}number card{} scored" } },
  config = { chips = 8 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 2 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v ~= "Jack" and v ~= "Queen" and v ~= "King" and v ~= "Ace" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n123: Empanada
SMODS.Joker({
  key = "n123",
  loc_txt = { name = "Empanada", text = { "{C:mult}+#1#{} Mult for", "each {C:attention}Full House{} played" } },
  config = { extra = { val = 0, gain = 5 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 2 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.last_hand_played == "Full House" then
        card.ability.extra.val = card.ability.extra.val + card.ability.extra.gain
      end
      if card.ability.extra.val > 0 then
        return { mult = card.ability.extra.val, message = localize{type='variable',key='a_mult',vars={card.ability.extra.val}} }
      end
    end
  end
})

-- n124: Churro
SMODS.Joker({
  key = "n124",
  loc_txt = { name = "Churro", text = { "{C:chips}+#1#{} Chips", "Gains {C:chips}+3{} per {C:attention}Straight{} played" } },
  config = { extra = { val = 10 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 2 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local h = G.GAME.last_hand_played
      if h == "Straight" or h == "Straight Flush" then
        card.ability.extra.val = card.ability.extra.val + 3
      end
      return { chips = card.ability.extra.val, message = localize{type='variable',key='a_chips',vars={card.ability.extra.val}} }
    end
  end
})

-- n125: Fettuccine
SMODS.Joker({
  key = "n125",
  loc_txt = { name = "Fettuccine", text = { "{C:mult}+#1#{} Mult per", "{C:attention}King{} scored" } },
  config = { mult = 8 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 2 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value == "King" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n126: Risotto
SMODS.Joker({
  key = "n126",
  loc_txt = { name = "Risotto", text = { "Gains {C:mult}+1{} Mult each round,", "{C:red}X2{} if hand is {C:attention}High Card{}" } },
  config = { extra = { val = 0 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 2 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local m = card.ability.extra.val
      if G.GAME.last_hand_played == "High Card" then m = m * 2 end
      return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val = card.ability.extra.val + 1
    end
  end
})

-- n127: Lasagna
SMODS.Joker({
  key = "n127",
  loc_txt = { name = "Lasagna", text = { "{C:chips}+#1#{} Chips.", "Gains {C:chips}+5{} each round" } },
  config = { extra = { val = 20 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 2 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { chips = card.ability.extra.val, message = localize{type='variable',key='a_chips',vars={card.ability.extra.val}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val = card.ability.extra.val + 5
    end
  end
})

-- n128: Pesto
SMODS.Joker({
  key = "n128",
  loc_txt = { name = "Pesto", text = { "{C:mult}+#1#{} Mult", "per {C:attention}Club{} or {C:attention}Spade{} scored" } },
  config = { mult = 3 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 2 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local s = context.other_card.base.suit
      if s == "Clubs" or s == "Spades" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n129: Gnocchi
SMODS.Joker({
  key = "n129",
  loc_txt = { name = "Gnocchi", text = { "{C:red}X#1#{} Mult if", "hand is {C:attention}Three of a Kind{}" } },
  config = { xmult = 2.5 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 2 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.last_hand_played == "Three of a Kind" then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n130: Bruschetta
SMODS.Joker({
  key = "n130",
  loc_txt = { name = "Bruschetta", text = { "{C:chips}+#1#{} Chips", "per {C:attention}Heart{} or {C:attention}Diamond{} scored" } },
  config = { chips = 10 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 2 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local s = context.other_card.base.suit
      if s == "Hearts" or s == "Diamonds" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n131: Edam
SMODS.Joker({
  key = "n131",
  loc_txt = { name = "Edam", text = { "{C:red}X#1#{} Mult if hand", "has no {C:attention}face cards{}" } },
  config = { xmult = 2 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 3 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local has_face = false
      if G.play then
        for _, c in ipairs(G.play.cards) do
          local v = c.base.value
          if v == "Jack" or v == "Queen" or v == "King" then has_face = true; break end
        end
      end
      if not has_face then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n132: Blue Cheese
SMODS.Joker({
  key = "n132",
  loc_txt = { name = "Blue Cheese", text = { "{C:mult}+#1#{} Mult per", "card held in hand" } },
  config = { mult = 2 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 3 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local sz = G.hand and #G.hand.cards or 0
      local m = sz * card.ability.mult
      return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
    end
  end
})

-- n133: Manchego
SMODS.Joker({
  key = "n133",
  loc_txt = { name = "Manchego", text = { "{C:chips}+#1#{} Chips if", "hand has {C:attention}no pairs{}" } },
  config = { chips = 60 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 3 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.last_hand_played == "High Card" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n134: Gruyere
SMODS.Joker({
  key = "n134",
  loc_txt = { name = "Gruyere", text = { "Gains {C:red}+0.2{} Xmult", "each round played" } },
  config = { extra = { val = 1.0 } },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 3 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { string.format("%.1f", center.ability.extra.val) } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { Xmult = card.ability.extra.val, message = localize{type='variable',key='a_xmult',vars={string.format("%.1f", card.ability.extra.val)}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val = card.ability.extra.val + 0.2
    end
  end
})

-- n135: Havarti
SMODS.Joker({
  key = "n135",
  loc_txt = { name = "Havarti", text = { "{C:mult}+#1#{} Mult", "for each {C:attention}2{} or {C:attention}3{} scored" } },
  config = { mult = 5 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 3 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "2" or v == "3" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n136: Provolone
SMODS.Joker({
  key = "n136",
  loc_txt = { name = "Provolone", text = { "{C:red}X#1#{} Mult if hand", "is a {C:attention}Pair{}" } },
  config = { xmult = 3 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 3 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.last_hand_played == "Pair" then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n137: Ricotta
SMODS.Joker({
  key = "n137",
  loc_txt = { name = "Ricotta", text = { "{C:chips}+#1#{} Chips per", "card discarded this round" } },
  config = { extra = { chips = 15, discards = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 3 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chips * center.ability.extra.discards } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local total = card.ability.extra.chips * card.ability.extra.discards
      if total > 0 then
        return { chips = total, message = localize{type='variable',key='a_chips',vars={total}} }
      end
    end
    if context.remove_playing_cards and context.removed then
      card.ability.extra.discards = card.ability.extra.discards + #context.removed
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.discards = 0
    end
  end
})

-- n138: Paneer
SMODS.Joker({
  key = "n138",
  loc_txt = { name = "Paneer", text = { "{C:mult}+#1#{} Mult per", "{C:attention}Queen{} scored" } },
  config = { mult = 10 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 3 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value == "Queen" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n139: Colby Jack
SMODS.Joker({
  key = "n139",
  loc_txt = { name = "Colby Jack", text = { "{C:mult}+#1#{} Mult per", "{C:attention}Jack{} scored" } },
  config = { mult = 10 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 3 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value == "Jack" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n140: Raclette
SMODS.Joker({
  key = "n140",
  loc_txt = { name = "Raclette", text = { "{C:red}X#1#{} Mult at end", "of round if no discards used" } },
  config = { xmult = 2 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 3 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.current_round and G.GAME.current_round.discards_used == 0 then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n141: Dumplings
SMODS.Joker({
  key = "n141",
  loc_txt = { name = "Dumplings", text = { "{C:chips}+#1#{} Chips per", "{C:attention}6{}, {C:attention}7{}, or {C:attention}8{} scored" } },
  config = { chips = 12 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 4 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "6" or v == "7" or v == "8" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n142: Baklava
SMODS.Joker({
  key = "n142",
  loc_txt = { name = "Baklava", text = { "Gains {C:mult}+1{} Mult per", "round, max {C:attention}20{}" } },
  config = { extra = { val = 0, max = 20 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 4 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = card.ability.extra.val, message = localize{type='variable',key='a_mult',vars={card.ability.extra.val}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.extra.val < card.ability.extra.max then
        card.ability.extra.val = math.min(card.ability.extra.val + 1, card.ability.extra.max)
      end
    end
  end
})

-- n143: Falafel
SMODS.Joker({
  key = "n143",
  loc_txt = { name = "Falafel", text = { "{C:mult}+#1#{} Mult if all", "scored cards are {C:attention}odd{} rank" } },
  config = { mult = 20 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 4 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local all_odd = true
      local odd_vals = { ["Ace"]=true, ["3"]=true, ["5"]=true, ["7"]=true, ["9"]=true, ["Jack"]=true, ["King"]=true }
      if G.play then
        for _, c in ipairs(G.play.cards) do
          if not odd_vals[c.base.value] then all_odd = false; break end
        end
      end
      if all_odd and G.play and #G.play.cards > 0 then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n144: Hummus
SMODS.Joker({
  key = "n144",
  loc_txt = { name = "Hummus", text = { "{C:chips}+#1#{} Chips", "Gains {C:chips}+2{} per discard used" } },
  config = { extra = { val = 10 } },
  rarity = 2, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 4 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { chips = card.ability.extra.val, message = localize{type='variable',key='a_chips',vars={card.ability.extra.val}} }
    end
    if context.remove_playing_cards and context.removed then
      card.ability.extra.val = card.ability.extra.val + 2
    end
  end
})

-- n145: Polenta
SMODS.Joker({
  key = "n145",
  loc_txt = { name = "Polenta", text = { "{C:chips}+#1#{} Chips per", "{C:attention}4{}, {C:attention}5{}, or {C:attention}6{} scored" } },
  config = { chips = 15 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 4 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "4" or v == "5" or v == "6" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n146: Pumpernickel
SMODS.Joker({
  key = "n146",
  loc_txt = { name = "Pumpernickel", text = { "{C:mult}+#1#{} Mult per", "{C:attention}Spade{} scored" } },
  config = { mult = 4 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 4 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Spades" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n147: Ciabatta
SMODS.Joker({
  key = "n147",
  loc_txt = { name = "Ciabatta", text = { "{C:red}X#1#{} Mult if hand", "is a {C:attention}Straight{}" } },
  config = { xmult = 2 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 4 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.last_hand_played == "Straight" or G.GAME.last_hand_played == "Straight Flush" then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n148: Pita
SMODS.Joker({
  key = "n148",
  loc_txt = { name = "Pita", text = { "{C:mult}+#1#{} Mult if", "you play {C:attention}1{} card" } },
  config = { mult = 30 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 4 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.play and #G.play.cards == 1 then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n149: Naan
SMODS.Joker({
  key = "n149",
  loc_txt = { name = "Naan", text = { "{C:chips}+#1#{} Chips if", "you play {C:attention}2{} cards" } },
  config = { chips = 80 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 4 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.play and #G.play.cards == 2 then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n150: Baguette
SMODS.Joker({
  key = "n150",
  loc_txt = { name = "Baguette", text = { "{C:mult}+#1#{} Mult per", "{C:attention}Diamond{} or {C:attention}Heart{} scored" } },
  config = { mult = 2 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 4 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local s = context.other_card.base.suit
      if s == "Diamonds" or s == "Hearts" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n151: Stroopwafel
SMODS.Joker({
  key = "n151",
  loc_txt = { name = "Stroopwafel", text = { "{C:chips}+#1#{} Chips per", "round, up to {C:attention}100{}" } },
  config = { extra = { val = 0, gain = 8, max = 100 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 5 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { chips = card.ability.extra.val, message = localize{type='variable',key='a_chips',vars={card.ability.extra.val}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val = math.min(card.ability.extra.val + card.ability.extra.gain, card.ability.extra.max)
    end
  end
})

-- n152: Crepe
SMODS.Joker({
  key = "n152",
  loc_txt = { name = "Crepe", text = { "{C:red}X#1#{} Mult if scored", "hand has all 4 suits" } },
  config = { xmult = 3 },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 5 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local suits = {}
      if G.play then
        for _, c in ipairs(G.play.cards) do suits[c.base.suit] = true end
      end
      if suits["Hearts"] and suits["Diamonds"] and suits["Clubs"] and suits["Spades"] then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n153: Macaroon
SMODS.Joker({
  key = "n153",
  loc_txt = { name = "Macaroon", text = { "{C:mult}+#1#{} Mult per", "pair of same-suit cards scored" } },
  config = { mult = 6 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 5 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local suit_counts = {}
      if G.play then
        for _, c in ipairs(G.play.cards) do
          local s = c.base.suit
          suit_counts[s] = (suit_counts[s] or 0) + 1
        end
      end
      local pairs_count = 0
      for _, cnt in pairs(suit_counts) do
        pairs_count = pairs_count + math.floor(cnt / 2)
      end
      if pairs_count > 0 then
        local m = pairs_count * card.ability.mult
        return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
      end
    end
  end
})

-- n154: Eclair
SMODS.Joker({
  key = "n154",
  loc_txt = { name = "Eclair", text = { "{C:chips}+#1#{} Chips", "Gains {C:chips}+8{} if scored all {C:attention}Hearts{}" } },
  config = { extra = { val = 20 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 5 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { chips = card.ability.extra.val, message = localize{type='variable',key='a_chips',vars={card.ability.extra.val}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      local all_hearts = true
      if G.play and #G.play.cards > 0 then
        for _, c in ipairs(G.play.cards) do
          if c.base.suit ~= "Hearts" then all_hearts = false; break end
        end
        if all_hearts then card.ability.extra.val = card.ability.extra.val + 8 end
      end
    end
  end
})

-- n155: Madeleine
SMODS.Joker({
  key = "n155",
  loc_txt = { name = "Madeleine", text = { "{C:mult}+#1#{} Mult", "if hand has exactly {C:attention}4{} cards" } },
  config = { mult = 18 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 5 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.play and #G.play.cards == 4 then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n156: Donut
SMODS.Joker({
  key = "n156",
  loc_txt = { name = "Donut", text = { "{C:red}X#1#{} Mult if hand", "has a {C:attention}pair of Aces{}" } },
  config = { xmult = 4 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 5 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local ace_count = 0
      if G.play then
        for _, c in ipairs(G.play.cards) do
          if c.base.value == "Ace" then ace_count = ace_count + 1 end
        end
      end
      if ace_count >= 2 then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n157: Gelato
SMODS.Joker({
  key = "n157",
  loc_txt = { name = "Gelato", text = { "{C:chips}+#1#{} Chips,", "double if hand is {C:attention}Flush{}" } },
  config = { chips = 25 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 5 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local h = G.GAME.last_hand_played
      local chips = card.ability.chips
      if h == "Flush" or h == "Flush House" or h == "Flush Five" then chips = chips * 2 end
      return { chips = chips, message = localize{type='variable',key='a_chips',vars={chips}} }
    end
  end
})

-- n158: Cannoli
SMODS.Joker({
  key = "n158",
  loc_txt = { name = "Cannoli", text = { "{C:mult}+#1#{} Mult per", "{C:attention}10{} scored" } },
  config = { mult = 12 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 5 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value == "10" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n159: Panna Cotta
SMODS.Joker({
  key = "n159",
  loc_txt = { name = "Panna Cotta", text = { "Gains {C:red}+0.3{} Xmult", "per discard used this run" } },
  config = { extra = { val = 1.0 } },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 5 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { string.format("%.1f", center.ability.extra.val) } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { Xmult = card.ability.extra.val, message = localize{type='variable',key='a_xmult',vars={string.format("%.1f", card.ability.extra.val)}} }
    end
    if context.remove_playing_cards and context.removed then
      card.ability.extra.val = card.ability.extra.val + 0.3
    end
  end
})

-- n160: Focaccine
SMODS.Joker({
  key = "n160",
  loc_txt = { name = "Focaccine", text = { "{C:mult}+#1#{} Mult if", "all scored cards are {C:attention}even{} rank" } },
  config = { mult = 18 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 5 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local even_vals = { ["2"]=true, ["4"]=true, ["6"]=true, ["8"]=true, ["10"]=true, ["Queen"]=true }
      local all_even = true
      if G.play and #G.play.cards > 0 then
        for _, c in ipairs(G.play.cards) do
          if not even_vals[c.base.value] then all_even = false; break end
        end
        if all_even then
          return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
        end
      end
    end
  end
})

-- n161: Kimchi
SMODS.Joker({
  key = "n161",
  loc_txt = { name = "Kimchi", text = { "{C:mult}+#1#{} Mult.", "Gains {C:mult}+2{} per round, resets at 20" } },
  config = { extra = { val = 2 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 6 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = card.ability.extra.val, message = localize{type='variable',key='a_mult',vars={card.ability.extra.val}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val = card.ability.extra.val + 2
      if card.ability.extra.val > 20 then card.ability.extra.val = 2 end
    end
  end
})

-- n162: Bibimbap
SMODS.Joker({
  key = "n162",
  loc_txt = { name = "Bibimbap", text = { "{C:chips}+#1#{} Chips per unique", "suit scored this hand" } },
  config = { chips = 20 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 6 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local suits = {}
      if G.play then
        for _, c in ipairs(G.play.cards) do suits[c.base.suit] = true end
      end
      local cnt = 0
      for _ in pairs(suits) do cnt = cnt + 1 end
      if cnt > 0 then
        local c = cnt * card.ability.chips
        return { chips = c, message = localize{type='variable',key='a_chips',vars={c}} }
      end
    end
  end
})

-- n163: Bulgogi
SMODS.Joker({
  key = "n163",
  loc_txt = { name = "Bulgogi", text = { "{C:red}X#1#{} Mult if you play", "{C:attention}Full House{} or better" } },
  config = { xmult = 2 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 6 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local h = G.GAME.last_hand_played
      local big = { ["Full House"]=true, ["Four of a Kind"]=true, ["Straight Flush"]=true,
                    ["Royal Flush"]=true, ["Flush House"]=true, ["Flush Five"]=true, ["Five of a Kind"]=true }
      if big[h] then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n164: Sushi
SMODS.Joker({
  key = "n164",
  loc_txt = { name = "Sushi", text = { "{C:mult}+#1#{} Mult per", "unique rank scored this hand" } },
  config = { mult = 4 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 6 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local ranks = {}
      if G.play then
        for _, c in ipairs(G.play.cards) do ranks[c.base.value] = true end
      end
      local cnt = 0
      for _ in pairs(ranks) do cnt = cnt + 1 end
      if cnt > 0 then
        local m = cnt * card.ability.mult
        return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
      end
    end
  end
})

-- n165: Tempura
SMODS.Joker({
  key = "n165",
  loc_txt = { name = "Tempura", text = { "{C:chips}+#1#{} Chips per", "{C:attention}9{} or {C:attention}10{} scored" } },
  config = { chips = 20 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 6 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "9" or v == "10" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n166: Mochi
SMODS.Joker({
  key = "n166",
  loc_txt = { name = "Mochi", text = { "Gains {C:chips}+10{} Chips", "per {C:attention}Heart{} scored, ever" } },
  config = { extra = { val = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 6 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { chips = card.ability.extra.val, message = localize{type='variable',key='a_chips',vars={card.ability.extra.val}} }
    end
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Hearts" then
        card.ability.extra.val = card.ability.extra.val + 10
      end
    end
  end
})

-- n167: Pad Thai
SMODS.Joker({
  key = "n167",
  loc_txt = { name = "Pad Thai", text = { "{C:red}X#1#{} Mult per", "hand played this round" } },
  config = { extra = { xmult = 0.2 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 6 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center)
    local hp = G.GAME.current_round and G.GAME.current_round.hands_played or 0
    return { vars = { string.format("%.1f", 1 + hp * center.ability.extra.xmult) } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local hp = G.GAME.current_round and G.GAME.current_round.hands_played or 0
      local xm = 1 + hp * card.ability.extra.xmult
      return { Xmult = xm, message = localize{type='variable',key='a_xmult',vars={string.format("%.1f", xm)}} }
    end
  end
})

-- n168: Tom Yum
SMODS.Joker({
  key = "n168",
  loc_txt = { name = "Tom Yum", text = { "{C:mult}+#1#{} Mult per", "{C:attention}Heart{} or {C:attention}Spade{} scored" } },
  config = { mult = 3 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 6 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local s = context.other_card.base.suit
      if s == "Hearts" or s == "Spades" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n169: Miso Soup
SMODS.Joker({
  key = "n169",
  loc_txt = { name = "Miso Soup", text = { "{C:chips}+#1#{} Chips at start.", "Halves each hand played" } },
  config = { extra = { val = 200 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 6 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local v = card.ability.extra.val
      if v > 0 then
        local ret = { chips = v, message = localize{type='variable',key='a_chips',vars={v}} }
        card.ability.extra.val = math.max(0, math.floor(v / 2))
        return ret
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val = 200
    end
  end
})

-- n170: Gyoza
SMODS.Joker({
  key = "n170",
  loc_txt = { name = "Gyoza", text = { "{C:mult}+#1#{} Mult if", "scored hand has {C:attention}4+ same suit{}" } },
  config = { mult = 20 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 6 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local suit_counts = {}
      if G.play then
        for _, c in ipairs(G.play.cards) do
          local s = c.base.suit
          suit_counts[s] = (suit_counts[s] or 0) + 1
        end
      end
      for _, cnt in pairs(suit_counts) do
        if cnt >= 4 then
          return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
        end
      end
    end
  end
})

-- n171: Borscht
SMODS.Joker({
  key = "n171",
  loc_txt = { name = "Borscht", text = { "{C:chips}+#1#{} Chips", "per {C:attention}red card{} scored" } },
  config = { chips = 12 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 7 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local s = context.other_card.base.suit
      if s == "Hearts" or s == "Diamonds" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n172: Pierogi
SMODS.Joker({
  key = "n172",
  loc_txt = { name = "Pierogi", text = { "{C:mult}+#1#{} Mult if", "scored hand has {C:attention}3+ same rank{}" } },
  config = { mult = 15 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 7 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local rank_counts = {}
      if G.play then
        for _, c in ipairs(G.play.cards) do
          local v = c.base.value
          rank_counts[v] = (rank_counts[v] or 0) + 1
        end
      end
      for _, cnt in pairs(rank_counts) do
        if cnt >= 3 then
          return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
        end
      end
    end
  end
})

-- n173: Kielbasa
SMODS.Joker({
  key = "n173",
  loc_txt = { name = "Kielbasa", text = { "{C:mult}+#1#{} Mult per", "{C:attention}black card{} scored" } },
  config = { mult = 4 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 7 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local s = context.other_card.base.suit
      if s == "Clubs" or s == "Spades" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n174: Stroganoff
SMODS.Joker({
  key = "n174",
  loc_txt = { name = "Stroganoff", text = { "{C:red}X#1#{} Mult if played", "{C:attention}Four of a Kind{} or better" } },
  config = { xmult = 3 },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 7 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local h = G.GAME.last_hand_played
      local big = { ["Four of a Kind"]=true, ["Straight Flush"]=true, ["Royal Flush"]=true,
                    ["Flush House"]=true, ["Flush Five"]=true, ["Five of a Kind"]=true }
      if big[h] then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n175: Guacamole
SMODS.Joker({
  key = "n175",
  loc_txt = { name = "Guacamole", text = { "{C:chips}+#1#{} Chips.", "Gains {C:chips}+5{} per Club scored, ever" } },
  config = { extra = { val = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 7 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { chips = card.ability.extra.val, message = localize{type='variable',key='a_chips',vars={card.ability.extra.val}} }
    end
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Clubs" then
        card.ability.extra.val = card.ability.extra.val + 5
      end
    end
  end
})

-- n176: Salsa
SMODS.Joker({
  key = "n176",
  loc_txt = { name = "Salsa", text = { "{C:mult}+#1#{} Mult.", "Resets each round" } },
  config = { extra = { val = 0, gain = 3 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 7 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      card.ability.extra.val = card.ability.extra.val + card.ability.extra.gain
      return { mult = card.ability.extra.val, message = localize{type='variable',key='a_mult',vars={card.ability.extra.val}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val = 0
    end
  end
})

-- n177: Queso
SMODS.Joker({
  key = "n177",
  loc_txt = { name = "Queso", text = { "{C:red}X#1#{} Mult if you have", "{C:attention}3+{} cheese jokers" } },
  config = { xmult = 4 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 7 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local cheese_keys = { n101=true, n102=true, n109=true, n115=true, n119=true, n132=true,
                            n133=true, n134=true, n135=true, n136=true, n138=true, n139=true }
      local cnt = 0
      if G.jokers then
        for _, j in ipairs(G.jokers.cards) do
          if cheese_keys[j.config.center.key] then cnt = cnt + 1 end
        end
      end
      if cnt >= 3 then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n178: Meatball
SMODS.Joker({
  key = "n178",
  loc_txt = { name = "Meatball", text = { "{C:mult}+#1#{} Mult per", "{C:attention}5{} or {C:attention}6{} scored" } },
  config = { mult = 7 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 7 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "5" or v == "6" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n179: Ravioli
SMODS.Joker({
  key = "n179",
  loc_txt = { name = "Ravioli", text = { "{C:chips}+#1#{} Chips if", "hand is {C:attention}Four of a Kind{}" } },
  config = { chips = 120 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 7 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.last_hand_played == "Four of a Kind" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n180: Minestrone
SMODS.Joker({
  key = "n180",
  loc_txt = { name = "Minestrone", text = { "{C:mult}+#1#{} Mult per", "unique rank in hand (not scored)" } },
  config = { mult = 3 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 7 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local ranks = {}
      if G.hand then
        for _, c in ipairs(G.hand.cards) do ranks[c.base.value] = true end
      end
      local cnt = 0
      for _ in pairs(ranks) do cnt = cnt + 1 end
      if cnt > 0 then
        local m = cnt * card.ability.mult
        return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
      end
    end
  end
})

-- n181: Stromboli
SMODS.Joker({
  key = "n181",
  loc_txt = { name = "Stromboli", text = { "{C:red}X#1#{} Mult if hand", "is {C:attention}Straight Flush{}" } },
  config = { xmult = 5 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 8 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local h = G.GAME.last_hand_played
      if h == "Straight Flush" or h == "Royal Flush" then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n182: Calzone
SMODS.Joker({
  key = "n182",
  loc_txt = { name = "Calzone", text = { "{C:chips}+#1#{} Chips per", "card held in hand (not scored)" } },
  config = { chips = 8 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 8 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local sz = G.hand and #G.hand.cards or 0
      local c = sz * card.ability.chips
      return { chips = c, message = localize{type='variable',key='a_chips',vars={c}} }
    end
  end
})

-- n183: Pepperoni
SMODS.Joker({
  key = "n183",
  loc_txt = { name = "Pepperoni", text = { "{C:mult}+#1#{} Mult if last", "hand was {C:attention}Flush{} or {C:attention}Full House{}" } },
  config = { mult = 12 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 8 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local h = G.GAME.last_hand_played
      if h == "Flush" or h == "Full House" or h == "Flush House" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n184: Parmigiana
SMODS.Joker({
  key = "n184",
  loc_txt = { name = "Parmigiana", text = { "Gains {C:mult}+3{} Mult", "whenever you play a {C:attention}face card{}" } },
  config = { extra = { val = 0 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 8 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = card.ability.extra.val, message = localize{type='variable',key='a_mult',vars={card.ability.extra.val}} }
    end
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "Jack" or v == "Queen" or v == "King" then
        card.ability.extra.val = card.ability.extra.val + 3
      end
    end
  end
})

-- n185: Tortilla
SMODS.Joker({
  key = "n185",
  loc_txt = { name = "Tortilla", text = { "{C:chips}+#1#{} Chips if hand", "has exactly {C:attention}2{} suits" } },
  config = { chips = 50 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 8 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local suits = {}
      if G.play then
        for _, c in ipairs(G.play.cards) do suits[c.base.suit] = true end
      end
      local cnt = 0
      for _ in pairs(suits) do cnt = cnt + 1 end
      if cnt == 2 then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n186: Quesadilla
SMODS.Joker({
  key = "n186",
  loc_txt = { name = "Quesadilla", text = { "{C:red}X#1#{} Mult if scored", "hand has exactly {C:attention}2{} suits" } },
  config = { xmult = 2 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 8 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local suits = {}
      if G.play then
        for _, c in ipairs(G.play.cards) do suits[c.base.suit] = true end
      end
      local cnt = 0
      for _ in pairs(suits) do cnt = cnt + 1 end
      if cnt == 2 then
        return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
      end
    end
  end
})

-- n187: Enchilada
SMODS.Joker({
  key = "n187",
  loc_txt = { name = "Enchilada", text = { "{C:mult}+#1#{} Mult per", "hand played this run" } },
  config = { extra = { mult = 1 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 8 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center)
    local hp = G.GAME and G.GAME.hands_played or 0
    return { vars = { hp * center.ability.extra.mult } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local hp = G.GAME and G.GAME.hands_played or 0
      local m = hp * card.ability.extra.mult
      return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
    end
  end
})

-- n188: Tamale
SMODS.Joker({
  key = "n188",
  loc_txt = { name = "Tamale", text = { "{C:chips}+#1#{} Chips per", "round survived" } },
  config = { extra = { chips = 10, rounds = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 8 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chips * center.ability.extra.rounds } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local total = card.ability.extra.chips * card.ability.extra.rounds
      return { chips = total, message = localize{type='variable',key='a_chips',vars={total}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.rounds = card.ability.extra.rounds + 1
    end
  end
})

-- n189: Pozole
SMODS.Joker({
  key = "n189",
  loc_txt = { name = "Pozole", text = { "{C:mult}+#1#{} Mult for each", "{C:attention}discard{} remaining" } },
  config = { mult = 4 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 8 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local d = G.GAME.current_round and G.GAME.current_round.discards_left or 0
      if d > 0 then
        local m = d * card.ability.mult
        return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
      end
    end
  end
})

-- n190: Menudo
SMODS.Joker({
  key = "n190",
  loc_txt = { name = "Menudo", text = { "{C:chips}+#1#{} Chips for each", "{C:attention}hand{} remaining" } },
  config = { chips = 15 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 8 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local h = G.GAME.current_round and G.GAME.current_round.hands_left or 0
      if h > 0 then
        local c = h * card.ability.chips
        return { chips = c, message = localize{type='variable',key='a_chips',vars={c}} }
      end
    end
  end
})

-- n191: Ceviche
SMODS.Joker({
  key = "n191",
  loc_txt = { name = "Ceviche", text = { "{C:red}X#1#{} Mult if", "scored all {C:attention}Diamonds{}" } },
  config = { xmult = 3 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 9 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local all_dia = true
      if G.play and #G.play.cards > 0 then
        for _, c in ipairs(G.play.cards) do
          if c.base.suit ~= "Diamonds" then all_dia = false; break end
        end
        if all_dia then
          return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
        end
      end
    end
  end
})

-- n192: Paella
SMODS.Joker({
  key = "n192",
  loc_txt = { name = "Paella", text = { "{C:chips}+#1#{} Chips per unique", "rank in hand at scoring" } },
  config = { chips = 15 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 9 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local ranks = {}
      if G.hand then
        for _, c in ipairs(G.hand.cards) do ranks[c.base.value] = true end
      end
      local cnt = 0
      for _ in pairs(ranks) do cnt = cnt + 1 end
      if cnt > 0 then
        local c = cnt * card.ability.chips
        return { chips = c, message = localize{type='variable',key='a_chips',vars={c}} }
      end
    end
  end
})

-- n193: Gazpacho
SMODS.Joker({
  key = "n193",
  loc_txt = { name = "Gazpacho", text = { "{C:mult}+#1#{} Mult.", "Loses {C:mult}-2{} each hand, min 2" } },
  config = { extra = { val = 30 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 9 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local m = card.ability.extra.val
      card.ability.extra.val = math.max(2, card.ability.extra.val - 2)
      return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val = 30
    end
  end
})

-- n194: Tandoori
SMODS.Joker({
  key = "n194",
  loc_txt = { name = "Tandoori", text = { "{C:red}X#1#{} Mult if scored", "all {C:attention}Spades{}" } },
  config = { xmult = 3 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 9 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local all_sp = true
      if G.play and #G.play.cards > 0 then
        for _, c in ipairs(G.play.cards) do
          if c.base.suit ~= "Spades" then all_sp = false; break end
        end
        if all_sp then
          return { Xmult = card.ability.xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.xmult}} }
        end
      end
    end
  end
})

-- n195: Noodle Bowl
SMODS.Joker({
  key = "n195",
  loc_txt = { name = "Noodle Bowl", text = { "{C:mult}+#1#{} Mult per", "card in deck below {C:attention}6{} rank" } },
  config = { mult = 1 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 9 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local low_vals = { ["2"]=true, ["3"]=true, ["4"]=true, ["5"]=true }
      local cnt = 0
      if G.deck then
        for _, c in ipairs(G.deck.cards) do
          if low_vals[c.base.value] then cnt = cnt + 1 end
        end
      end
      if cnt > 0 then
        local m = cnt * card.ability.mult
        return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
      end
    end
  end
})

-- n196: Chowder
SMODS.Joker({
  key = "n196",
  loc_txt = { name = "Chowder", text = { "{C:chips}+#1#{} Chips if", "scored hand is {C:attention}High Card{}" } },
  config = { chips = 150 },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 9 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.last_hand_played == "High Card" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n197: Goulash
SMODS.Joker({
  key = "n197",
  loc_txt = { name = "Goulash", text = { "Gains {C:mult}+1{} Mult per", "joker sold or bought" } },
  config = { extra = { val = 0 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 9 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.val } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = card.ability.extra.val, message = localize{type='variable',key='a_mult',vars={card.ability.extra.val}} }
    end
    if context.selling_card or context.buying_card then
      card.ability.extra.val = card.ability.extra.val + 1
    end
  end
})

-- n198: Dim Sum
SMODS.Joker({
  key = "n198",
  loc_txt = { name = "Dim Sum", text = { "{C:red}X#1#{} Mult per", "{C:attention}Joker{} with positive Xmult" } },
  config = { extra = { xmult = 0.5 } },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 9 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center)
    local cnt = G.jokers and #G.jokers.cards or 0
    return { vars = { string.format("%.1f", 1 + cnt * center.ability.extra.xmult) } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local cnt = G.jokers and #G.jokers.cards or 0
      local xm = 1 + cnt * card.ability.extra.xmult
      return { Xmult = xm, message = localize{type='variable',key='a_xmult',vars={string.format("%.1f", xm)}} }
    end
  end
})

-- n199: Peking Duck
SMODS.Joker({
  key = "n199",
  loc_txt = { name = "Peking Duck", text = { "{C:chips}+#1#{} Chips per", "{C:attention}face card{} in hand (not scored)" } },
  config = { chips = 20 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 9 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local cnt = 0
      if G.hand then
        for _, c in ipairs(G.hand.cards) do
          local v = c.base.value
          if v == "Jack" or v == "Queen" or v == "King" then cnt = cnt + 1 end
        end
      end
      if cnt > 0 then
        local c = cnt * card.ability.chips
        return { chips = c, message = localize{type='variable',key='a_chips',vars={c}} }
      end
    end
  end
})

-- n200: The Grand Buffet
SMODS.Joker({
  key = "n200",
  loc_txt = { name = "The Grand Buffet", text = { "{C:red}X#1#{} Mult equal to", "number of {C:attention}Jokers{} owned" } },
  config = { extra = { xmult = 1.0 } },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 9 }, atlas = "cm_atlas_02",
  loc_vars = function(self, info_queue, center)
    local cnt = G.jokers and #G.jokers.cards or 0
    return { vars = { cnt } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local cnt = G.jokers and #G.jokers.cards or 0
      if cnt > 0 then
        return { Xmult = cnt, message = localize{type='variable',key='a_xmult',vars={cnt}} }
      end
    end
  end
})
