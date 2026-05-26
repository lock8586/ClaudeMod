-- ClaudeMod Batch 04: Music & The Beatles (n301-n400)

-- n301: Let It Be
SMODS.Joker({
  key = "n301",
  loc_txt = { name = "Let It Be", text = { "When you score,", "{C:mult}+{1}{} Mult,", "no conditions needed" } },
  config = { mult = 8 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 0 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
    end
  end
})

-- n302: Yesterday
SMODS.Joker({
  key = "n302",
  loc_txt = { name = "Yesterday", text = { "{C:mult}+{1}{} Mult equal to", "last round's Mult" } },
  config = { extra = { last_mult = 4 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 0 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.last_mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = card.ability.extra.last_mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.last_mult}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.last_mult = math.floor((G.GAME.last_blind and G.GAME.last_blind.mult or card.ability.extra.last_mult))
    end
  end
})

-- n303: Octopus's Garden
SMODS.Joker({
  key = "n303",
  loc_txt = { name = "Octopus's Garden", text = { "{C:mult}+2{} Mult for each", "8 scored this hand" } },
  config = { mult = 2 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 0 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      local count = 0
      for _, c in ipairs(context.scoring_hand) do
        if c.base.value == "8" then count = count + 1 end
      end
      if count > 0 then
        return { mult = card.ability.mult * count, message = localize{type='variable',key='a_mult',vars={card.ability.mult * count}} }
      end
    end
  end
})

-- n304: Come Together
SMODS.Joker({
  key = "n304",
  loc_txt = { name = "Come Together", text = { "{C:mult}+3{} Mult per Joker", "with same rarity" } },
  config = { mult = 3 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 0 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local count = 0
      for _, j in ipairs(G.jokers.cards) do
        if j ~= card and j.config.center.rarity == card.config.center.rarity then
          count = count + 1
        end
      end
      if count > 0 then
        return { mult = card.ability.mult * count, message = localize{type='variable',key='a_mult',vars={card.ability.mult * count}} }
      end
    end
  end
})

-- n305: Abbey Road
SMODS.Joker({
  key = "n305",
  loc_txt = { name = "Abbey Road", text = { "{C:chips}+30{} Chips if played", "hand has consecutive ranks" } },
  config = { chips = 30 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 0 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      local ranks = {}
      local rank_map = {["2"]=2,["3"]=3,["4"]=4,["5"]=5,["6"]=6,["7"]=7,["8"]=8,["9"]=9,["10"]=10,["Jack"]=11,["Queen"]=12,["King"]=13,["Ace"]=14}
      for _, c in ipairs(context.scoring_hand) do
        local rv = rank_map[c.base.value]
        if rv then ranks[#ranks+1] = rv end
      end
      table.sort(ranks)
      local consec = true
      for i = 2, #ranks do
        if ranks[i] ~= ranks[i-1] + 1 then consec = false; break end
      end
      if consec and #ranks >= 3 then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n306: Yellow Submarine
SMODS.Joker({
  key = "n306",
  loc_txt = { name = "Yellow Submarine", text = { "{C:chips}+8{} Chips per card", "with rank {C:attention}6{} or lower" } },
  config = { chips = 8 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 0 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local rank_map = {["2"]=2,["3"]=3,["4"]=4,["5"]=5,["6"]=6}
      if rank_map[context.other_card.base.value] then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n307: Strawberry Fields
SMODS.Joker({
  key = "n307",
  loc_txt = { name = "Strawberry Fields", text = { "{C:green}50%{} chance:", "{C:mult}X2{} Mult or nothing" } },
  config = {},
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 0 }, atlas = "cm_atlas_04",
  calculate = function(self, card, context)
    if context.joker_main then
      if pseudorandom('strawberry_fields') > 0.5 then
        return { Xmult = 2, message = localize{type='variable',key='a_xmult',vars={2}} }
      else
        return { message = "Nothing!" }
      end
    end
  end
})

-- n308: A Day in the Life
SMODS.Joker({
  key = "n308",
  loc_txt = { name = "A Day in the Life", text = { "{C:mult}+{1}{} Mult, gains", "{C:mult}+1{} Mult per round" } },
  config = { extra = { mult = 2 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 0 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult = card.ability.extra.mult + 1
      card:juice_up(0.5, 0.5)
    end
  end
})

-- n309: Help!
SMODS.Joker({
  key = "n309",
  loc_txt = { name = "Help!", text = { "{C:mult}+5{} Mult for each", "hand still needed" } },
  config = { mult = 5 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 0 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local hands_left = G.GAME.current_round and G.GAME.current_round.hands_left or 0
      if hands_left > 0 then
        return { mult = card.ability.mult * hands_left, message = localize{type='variable',key='a_mult',vars={card.ability.mult * hands_left}} }
      end
    end
  end
})

-- n310: Twist and Shout
SMODS.Joker({
  key = "n310",
  loc_txt = { name = "Twist and Shout", text = { "{C:mult}+12{} Mult if played", "hand is {C:attention}Two Pair{} or better" } },
  config = { mult = 12 },
  rarity = 1, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 0 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local hand_name = G.GAME.last_hand_played or ""
      local good_hands = {["Two Pair"]=true,["Three of a Kind"]=true,["Straight"]=true,["Flush"]=true,["Full House"]=true,["Four of a Kind"]=true,["Straight Flush"]=true,["Royal Flush"]=true,["Five of a Kind"]=true,["Flush House"]=true,["Flush Five"]=true}
      if good_hands[hand_name] then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n311: Norwegian Wood
SMODS.Joker({
  key = "n311",
  loc_txt = { name = "Norwegian Wood", text = { "{C:chips}+12{} Chips per", "{C:clubs}Club{} scored" } },
  config = { chips = 12 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 1 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Clubs" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n312: Blackbird
SMODS.Joker({
  key = "n312",
  loc_txt = { name = "Blackbird", text = { "{C:mult}+15{} Mult on", "odd-numbered {C:attention}Antes{}" } },
  config = { mult = 15 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 1 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local ante = G.GAME.round_resets and G.GAME.round_resets.ante or 1
      if ante % 2 == 1 then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n313: Revolution
SMODS.Joker({
  key = "n313",
  loc_txt = { name = "Revolution", text = { "Swap your current", "{C:chips}Chips{} and {C:mult}Mult{} values" } },
  config = {},
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 1 }, atlas = "cm_atlas_04",
  calculate = function(self, card, context)
    if context.joker_main then
      local c = G.GAME.current_round
      if c then
        local old_chips = c.chips_so_far or 0
        local old_mult = c.mult_so_far or 1
        return { func = function()
          G.GAME.current_round.chips_so_far = old_mult
          G.GAME.current_round.mult_so_far = old_chips
        end, message = "Revolution!" }
      end
    end
  end
})

-- n314: Here Comes the Sun
SMODS.Joker({
  key = "n314",
  loc_txt = { name = "Here Comes the Sun", text = { "{C:chips}+10{} Chips per", "{C:diamonds}Diamond{} scored" } },
  config = { chips = 10 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 1 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Diamonds" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n315: Paperback Writer
SMODS.Joker({
  key = "n315",
  loc_txt = { name = "Paperback Writer", text = { "{C:mult}+5{} Mult per", "face card scored" } },
  config = { mult = 5 },
  rarity = 1, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 1 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local fv = context.other_card.base.value
      if fv == "Jack" or fv == "Queen" or fv == "King" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n316: John Lennon
SMODS.Joker({
  key = "n316",
  loc_txt = { name = "John Lennon", text = { "{C:mult}+10{} Mult per", "{C:attention}Ace{} scored" } },
  config = { mult = 10 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 1 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value == "Ace" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n317: Paul McCartney
SMODS.Joker({
  key = "n317",
  loc_txt = { name = "Paul McCartney", text = { "{C:chips}+50{} Chips if hand", "contains all 4 suits" } },
  config = { chips = 50 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 1 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      local suits = {}
      for _, c in ipairs(context.scoring_hand) do suits[c.base.suit] = true end
      if suits["Spades"] and suits["Hearts"] and suits["Clubs"] and suits["Diamonds"] then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n318: George Harrison
SMODS.Joker({
  key = "n318",
  loc_txt = { name = "George Harrison", text = { "Hidden — reveals its", "{C:mult}Mult{} when you score" } },
  config = { extra = { mult = 20, revealed = false } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 1 }, atlas = "cm_atlas_04",
  calculate = function(self, card, context)
    if context.joker_main then
      card.ability.extra.revealed = true
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n319: Ringo Starr
SMODS.Joker({
  key = "n319",
  loc_txt = { name = "Ringo Starr", text = { "{C:chips}+15{} Chips per", "repeated rank scored" } },
  config = { chips = 15 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 1 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      local seen = {}
      local repeats = 0
      for _, c in ipairs(context.scoring_hand) do
        if seen[c.base.value] then repeats = repeats + 1
        else seen[c.base.value] = true end
      end
      if repeats > 0 then
        return { chips = card.ability.chips * repeats, message = localize{type='variable',key='a_chips',vars={card.ability.chips * repeats}} }
      end
    end
  end
})

-- n320: The White Album
SMODS.Joker({
  key = "n320",
  loc_txt = { name = "The White Album", text = { "Each hand gives a", "random {C:attention}effect" } },
  config = {},
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 1 }, atlas = "cm_atlas_04",
  calculate = function(self, card, context)
    if context.joker_main then
      local r = pseudorandom('white_album')
      if r < 0.33 then
        return { mult = math.floor(pseudorandom('wa_mult') * 15) + 5, message = "Random Mult!" }
      elseif r < 0.66 then
        return { chips = math.floor(pseudorandom('wa_chips') * 40) + 10, message = "Random Chips!" }
      else
        return { Xmult = 1 + pseudorandom('wa_xmult'), message = "Random X!" }
      end
    end
  end
})

-- n321: Sgt. Pepper
SMODS.Joker({
  key = "n321",
  loc_txt = { name = "Sgt. Pepper", text = { "{C:mult}X2{} Mult,", "played by the band!" } },
  config = { Xmult = 2 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 2 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { Xmult = card.ability.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult}} }
    end
  end
})

-- n322: Penny Lane
SMODS.Joker({
  key = "n322",
  loc_txt = { name = "Penny Lane", text = { "{C:chips}+10{} Chips per {C:clubs}Club{}","{C:chips}+10{} Chips per {C:hearts}Heart{} scored" } },
  config = { chips = 10 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 2 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local s = context.other_card.base.suit
      if s == "Clubs" or s == "Hearts" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n323: In My Life
SMODS.Joker({
  key = "n323",
  loc_txt = { name = "In My Life", text = { "Gains {C:mult}+3{} Mult", "each time a Joker is sold" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 2 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
    if context.selling_card and context.selling_card ~= card then
      if context.selling_card.config.center.set == "Joker" then
        card.ability.extra.mult = card.ability.extra.mult + 3
        card:juice_up(0.5, 0.5)
      end
    end
  end
})

-- n324: Across the Universe
SMODS.Joker({
  key = "n324",
  loc_txt = { name = "Across the Universe", text = { "{C:mult}X5{} Mult,", "only once per run" } },
  config = { extra = { used = false } },
  rarity = 4, cost = 15,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 2 }, atlas = "cm_atlas_04",
  calculate = function(self, card, context)
    if context.joker_main and not card.ability.extra.used then
      card.ability.extra.used = true
      return { Xmult = 5, message = localize{type='variable',key='a_xmult',vars={5}} }
    end
  end
})

-- n325: Hey Jude
SMODS.Joker({
  key = "n325",
  loc_txt = { name = "Hey Jude", text = { "{C:mult}+6{} Mult per", "face card in hand" } },
  config = { mult = 6 },
  rarity = 1, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 2 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local count = 0
      for _, c in ipairs(G.hand.cards) do
        local v = c.base.value
        if v == "Jack" or v == "Queen" or v == "King" then count = count + 1 end
      end
      if count > 0 then
        return { mult = card.ability.mult * count, message = localize{type='variable',key='a_mult',vars={card.ability.mult * count}} }
      end
    end
  end
})

-- n326: Led Zeppelin
SMODS.Joker({
  key = "n326",
  loc_txt = { name = "Led Zeppelin", text = { "{C:mult}+25{} Mult,", "destroys leftmost card in hand" } },
  config = { mult = 25 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = false, perishable_compat = true,
  pos = { x = 5, y = 2 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.hand and #G.hand.cards > 0 then
        local target = G.hand.cards[1]
        if target then
          G.E_MANAGER:add_event(Event({func = function()
            G.hand:remove_card(target)
            target:remove()
            return true
          end}))
        end
      end
      return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
    end
  end
})

-- n327: David Bowie
SMODS.Joker({
  key = "n327",
  loc_txt = { name = "David Bowie", text = { "{C:mult}X1.5{} Mult;", "rarity shifts each round" } },
  config = { Xmult = 1.5 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 2 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { Xmult = card.ability.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.config.center.rarity = math.random(1, 3)
    end
  end
})

-- n328: Freddie Mercury
SMODS.Joker({
  key = "n328",
  loc_txt = { name = "Freddie Mercury", text = { "{C:mult}X3{} Mult if played", "hand is {C:attention}High Card{}" } },
  config = { Xmult = 3 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 2 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.last_hand_played == "High Card" then
        return { Xmult = card.ability.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult}} }
      end
    end
  end
})

-- n329: Rolling Stones
SMODS.Joker({
  key = "n329",
  loc_txt = { name = "Rolling Stones", text = { "{C:mult}+7{} Mult per", "discard used this round" } },
  config = { extra = { mult = 7 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 2 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local discards_used = (G.GAME.current_round and G.GAME.round_resets and
        G.GAME.round_resets.discards - G.GAME.current_round.discards_left) or 0
      if discards_used > 0 then
        return { mult = card.ability.extra.mult * discards_used, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult * discards_used}} }
      end
    end
  end
})

-- n330: Elvis
SMODS.Joker({
  key = "n330",
  loc_txt = { name = "Elvis", text = { "{C:mult}+8{} Mult per", "face card scored" } },
  config = { mult = 8 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 2 }, atlas = "cm_atlas_04",
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

-- n331: Back in Black
SMODS.Joker({
  key = "n331",
  loc_txt = { name = "Back in Black", text = { "{C:mult}+10{} Mult per", "{C:spades}Spade{} scored" } },
  config = { mult = 10 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 3 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Spades" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n332: Bohemian Rhapsody
SMODS.Joker({
  key = "n332",
  loc_txt = { name = "Bohemian Rhapsody", text = { "{C:mult}X2{} Mult if 5+", "different ranks scored" } },
  config = { Xmult = 2 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 3 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      local ranks = {}
      for _, c in ipairs(context.scoring_hand) do ranks[c.base.value] = true end
      local count = 0
      for _ in pairs(ranks) do count = count + 1 end
      if count >= 5 then
        return { Xmult = card.ability.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult}} }
      end
    end
  end
})

-- n333: Stairway to Heaven
SMODS.Joker({
  key = "n333",
  loc_txt = { name = "Stairway to Heaven", text = { "{C:chips}+5{} Chips per card", "above rank {C:attention}9{}" } },
  config = { chips = 5 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 3 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local high = {["10"]=true,["Jack"]=true,["Queen"]=true,["King"]=true,["Ace"]=true}
      if high[context.other_card.base.value] then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n334: Hotel California
SMODS.Joker({
  key = "n334",
  loc_txt = { name = "Hotel California", text = { "Cards cannot be discarded.", "{C:mult}+20{} Mult" } },
  config = { mult = 20 },
  rarity = 3, cost = 10,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 3 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
    end
  end
})

-- n335: Purple Haze
SMODS.Joker({
  key = "n335",
  loc_txt = { name = "Purple Haze", text = { "{C:mult}X1.5{} Mult per", "{C:hearts}Heart{} scored" } },
  config = { Xmult = 1.5 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 3 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Hearts" then
        return { Xmult = card.ability.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult}} }
      end
    end
  end
})

-- n336: Light My Fire
SMODS.Joker({
  key = "n336",
  loc_txt = { name = "Light My Fire", text = { "{C:mult}+12{} Mult if hand", "contains an {C:attention}Ace{}" } },
  config = { mult = 12 },
  rarity = 1, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 3 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      for _, c in ipairs(context.scoring_hand) do
        if c.base.value == "Ace" then
          return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
        end
      end
    end
  end
})

-- n337: Sympathy for the Devil
SMODS.Joker({
  key = "n337",
  loc_txt = { name = "Sympathy for the Devil", text = { "{C:mult}X2{} Mult if Blind", "has not been beaten" } },
  config = { Xmult = 2 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 3 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local chips = G.GAME.chips or 0
      local blind_chips = G.GAME.blind and G.GAME.blind.chips or 999999
      if chips < blind_chips then
        return { Xmult = card.ability.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult}} }
      end
    end
  end
})

-- n338: Paint It Black
SMODS.Joker({
  key = "n338",
  loc_txt = { name = "Paint It Black", text = { "{C:mult}+5{} Mult per", "{C:spades}Spade{} in hand" } },
  config = { mult = 5 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 3 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local count = 0
      for _, c in ipairs(G.hand.cards) do
        if c.base.suit == "Spades" then count = count + 1 end
      end
      if count > 0 then
        return { mult = card.ability.mult * count, message = localize{type='variable',key='a_mult',vars={card.ability.mult * count}} }
      end
    end
  end
})

-- n339: Piano Man
SMODS.Joker({
  key = "n339",
  loc_txt = { name = "Piano Man", text = { "{C:chips}+20{} Chips per", "{C:attention}7{} scored" } },
  config = { chips = 20 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 3 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value == "7" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n340: Born to Run
SMODS.Joker({
  key = "n340",
  loc_txt = { name = "Born to Run", text = { "{C:mult}+3{} Mult per", "card in played hand" } },
  config = { mult = 3 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 3 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      local n = #context.scoring_hand
      if n > 0 then
        return { mult = card.ability.mult * n, message = localize{type='variable',key='a_mult',vars={card.ability.mult * n}} }
      end
    end
  end
})

-- n341: Sound of Silence
SMODS.Joker({
  key = "n341",
  loc_txt = { name = "Sound of Silence", text = { "{C:mult}+25{} Mult if no", "other Jokers are active" } },
  config = { mult = 25 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 4 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.jokers.cards == 1 then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n342: Mr. Tambourine Man
SMODS.Joker({
  key = "n342",
  loc_txt = { name = "Mr. Tambourine Man", text = { "Retriggered cards give", "{C:chips}+5{} extra Chips" } },
  config = { chips = 5 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 4 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.repetition then
      return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
    end
  end
})

-- n343: Like a Rolling Stone
SMODS.Joker({
  key = "n343",
  loc_txt = { name = "Like a Rolling Stone", text = { "{C:mult}+2{} Mult per", "Joker owned" } },
  config = { mult = 2 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 4 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local n = #G.jokers.cards
      return { mult = card.ability.mult * n, message = localize{type='variable',key='a_mult',vars={card.ability.mult * n}} }
    end
  end
})

-- n344: American Pie
SMODS.Joker({
  key = "n344",
  loc_txt = { name = "American Pie", text = { "{C:chips}+50{} Chips on", "{C:attention}Straight{} or better" } },
  config = { chips = 50 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 4 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local straights = {["Straight"]=true,["Flush"]=true,["Full House"]=true,["Four of a Kind"]=true,["Straight Flush"]=true,["Royal Flush"]=true,["Five of a Kind"]=true,["Flush House"]=true,["Flush Five"]=true}
      if straights[G.GAME.last_hand_played] then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n345: Good Vibrations
SMODS.Joker({
  key = "n345",
  loc_txt = { name = "Good Vibrations", text = { "{C:mult}+4{} Mult per", "card enhanced" } },
  config = { mult = 4 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 4 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      local count = 0
      for _, c in ipairs(context.scoring_hand) do
        if c.ability.name and c.ability.name ~= "Base" then count = count + 1 end
      end
      if count > 0 then
        return { mult = card.ability.mult * count, message = localize{type='variable',key='a_mult',vars={card.ability.mult * count}} }
      end
    end
  end
})

-- n346: Whole Lotta Love
SMODS.Joker({
  key = "n346",
  loc_txt = { name = "Whole Lotta Love", text = { "{C:mult}X1.5{} Mult if scored", "hand has {C:attention}5{} cards" } },
  config = { Xmult = 1.5 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 4 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      if #context.scoring_hand == 5 then
        return { Xmult = card.ability.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult}} }
      end
    end
  end
})

-- n347: Johnny B. Goode
SMODS.Joker({
  key = "n347",
  loc_txt = { name = "Johnny B. Goode", text = { "{C:mult}+15{} Mult if any", "{C:attention}King{} is scored" } },
  config = { mult = 15 },
  rarity = 1, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 4 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      for _, c in ipairs(context.scoring_hand) do
        if c.base.value == "King" then
          return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
        end
      end
    end
  end
})

-- n348: Jolene
SMODS.Joker({
  key = "n348",
  loc_txt = { name = "Jolene", text = { "{C:mult}+9{} Mult per", "{C:hearts}Heart{} in played hand" } },
  config = { mult = 9 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 4 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Hearts" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n349: Superstition
SMODS.Joker({
  key = "n349",
  loc_txt = { name = "Superstition", text = { "{C:mult}+13{} Mult if hand", "score ends in {C:attention}13{}" } },
  config = { mult = 13 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 4 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local chips = G.GAME.chips or 0
      if chips % 13 == 0 and chips > 0 then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n350: Purple Rain
SMODS.Joker({
  key = "n350",
  loc_txt = { name = "Purple Rain", text = { "{C:mult}X2{} Mult if all", "scored cards share a suit" } },
  config = { Xmult = 2 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 4 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand and #context.scoring_hand > 1 then
      local suit = context.scoring_hand[1].base.suit
      local all_same = true
      for _, c in ipairs(context.scoring_hand) do
        if c.base.suit ~= suit then all_same = false; break end
      end
      if all_same then
        return { Xmult = card.ability.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult}} }
      end
    end
  end
})

-- n351: Dancing Queen
SMODS.Joker({
  key = "n351",
  loc_txt = { name = "Dancing Queen", text = { "{C:mult}+10{} Mult if hand", "contains a {C:attention}Queen{}" } },
  config = { mult = 10 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 5 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      for _, c in ipairs(context.scoring_hand) do
        if c.base.value == "Queen" then
          return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
        end
      end
    end
  end
})

-- n352: Waterloo
SMODS.Joker({
  key = "n352",
  loc_txt = { name = "Waterloo", text = { "Gains {C:mult}+2{} Mult each", "time you lose a round" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 5 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n353: Money for Nothing
SMODS.Joker({
  key = "n353",
  loc_txt = { name = "Money for Nothing", text = { "Earn {C:money}$2{} at end of", "round for each face card scored" } },
  config = { extra = { money = 2 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 5 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.money } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      local count = 0
      if G.play and G.play.cards then
        for _, c in ipairs(G.play.cards) do
          local v = c.base.value
          if v == "Jack" or v == "Queen" or v == "King" then count = count + 1 end
        end
      end
      if count > 0 then
        ease_dollars(card.ability.extra.money * count)
        return { message = "Cha-Ching!" }
      end
    end
  end
})

-- n354: Imagine
SMODS.Joker({
  key = "n354",
  loc_txt = { name = "Imagine", text = { "{C:mult}+20{} Mult if all", "cards scored are the same rank" } },
  config = { mult = 20 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 5 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand and #context.scoring_hand > 1 then
      local rank = context.scoring_hand[1].base.value
      local all_same = true
      for _, c in ipairs(context.scoring_hand) do
        if c.base.value ~= rank then all_same = false; break end
      end
      if all_same then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n355: Rocket Man
SMODS.Joker({
  key = "n355",
  loc_txt = { name = "Rocket Man", text = { "{C:chips}+60{} Chips if hand", "is {C:attention}Five of a Kind{}" } },
  config = { chips = 60 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 5 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.last_hand_played == "Five of a Kind" then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n356: Jump
SMODS.Joker({
  key = "n356",
  loc_txt = { name = "Jump", text = { "{C:chips}+5{} Chips per card", "in full hand area" } },
  config = { chips = 5 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 5 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local n = G.hand and #G.hand.cards or 0
      if n > 0 then
        return { chips = card.ability.chips * n, message = localize{type='variable',key='a_chips',vars={card.ability.chips * n}} }
      end
    end
  end
})

-- n357: Walk This Way
SMODS.Joker({
  key = "n357",
  loc_txt = { name = "Walk This Way", text = { "{C:mult}+5{} Mult per", "Joker to the left of this" } },
  config = { mult = 5 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 5 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local idx = nil
      for i, j in ipairs(G.jokers.cards) do
        if j == card then idx = i; break end
      end
      local left = idx and (idx - 1) or 0
      if left > 0 then
        return { mult = card.ability.mult * left, message = localize{type='variable',key='a_mult',vars={card.ability.mult * left}} }
      end
    end
  end
})

-- n358: My Generation
SMODS.Joker({
  key = "n358",
  loc_txt = { name = "My Generation", text = { "Gains {C:mult}+1{} Mult for", "each Ante completed" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 5 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      local ante = G.GAME.round_resets and G.GAME.round_resets.ante or 0
      card.ability.extra.mult = ante
    end
  end
})

-- n359: Smoke on the Water
SMODS.Joker({
  key = "n359",
  loc_txt = { name = "Smoke on the Water", text = { "{C:mult}+18{} Mult if a", "card was destroyed this round" } },
  config = { extra = { mult = 18, destroyed = false } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 5 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.remove_playing_cards and context.removed and #context.removed > 0 then
      card.ability.extra.destroyed = true
    end
    if context.joker_main and card.ability.extra.destroyed then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.destroyed = false
    end
  end
})

-- n360: Roxanne
SMODS.Joker({
  key = "n360",
  loc_txt = { name = "Roxanne", text = { "{C:mult}+8{} Mult per", "{C:hearts}Heart{} in hand" } },
  config = { mult = 8 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 5 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local count = 0
      for _, c in ipairs(G.hand.cards) do
        if c.base.suit == "Hearts" then count = count + 1 end
      end
      if count > 0 then
        return { mult = card.ability.mult * count, message = localize{type='variable',key='a_mult',vars={card.ability.mult * count}} }
      end
    end
  end
})

-- n361: Every Breath You Take
SMODS.Joker({
  key = "n361",
  loc_txt = { name = "Every Breath You Take", text = { "Gains {C:chips}+5{} Chips each", "time a hand is played" } },
  config = { extra = { chips = 0 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 6 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      card.ability.extra.chips = card.ability.extra.chips + 5
      return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
    end
  end
})

-- n362: Don't Stop Believin'
SMODS.Joker({
  key = "n362",
  loc_txt = { name = "Don't Stop Believin'", text = { "{C:mult}+5{} Mult on last", "hand of the round" } },
  config = { mult = 5 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 6 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local hands_left = G.GAME.current_round and G.GAME.current_round.hands_left or 1
      if hands_left == 0 then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n363: Hit Me Baby One More Time
SMODS.Joker({
  key = "n363",
  loc_txt = { name = "Hit Me Baby", text = { "{C:mult}+6{} Mult per", "discard remaining" } },
  config = { mult = 6 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 6 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local d = G.GAME.current_round and G.GAME.current_round.discards_left or 0
      if d > 0 then
        return { mult = card.ability.mult * d, message = localize{type='variable',key='a_mult',vars={card.ability.mult * d}} }
      end
    end
  end
})

-- n364: Livin' on a Prayer
SMODS.Joker({
  key = "n364",
  loc_txt = { name = "Livin' on a Prayer", text = { "{C:mult}X3{} Mult if chips", "are less than half Blind" } },
  config = { Xmult = 3 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 6 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local chips = G.GAME.chips or 0
      local blind_chips = G.GAME.blind and G.GAME.blind.chips or 999999
      if chips < blind_chips / 2 then
        return { Xmult = card.ability.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult}} }
      end
    end
  end
})

-- n365: Sweet Home Alabama
SMODS.Joker({
  key = "n365",
  loc_txt = { name = "Sweet Home Alabama", text = { "{C:chips}+15{} Chips per", "{C:diamonds}Diamond{} in hand" } },
  config = { chips = 15 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 6 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local count = 0
      for _, c in ipairs(G.hand.cards) do
        if c.base.suit == "Diamonds" then count = count + 1 end
      end
      if count > 0 then
        return { chips = card.ability.chips * count, message = localize{type='variable',key='a_chips',vars={card.ability.chips * count}} }
      end
    end
  end
})

-- n366: Californication
SMODS.Joker({
  key = "n366",
  loc_txt = { name = "Californication", text = { "{C:mult}+3{} Mult per", "unique suit in hand" } },
  config = { mult = 3 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 6 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local suits = {}
      for _, c in ipairs(G.hand.cards) do suits[c.base.suit] = true end
      local count = 0
      for _ in pairs(suits) do count = count + 1 end
      if count > 0 then
        return { mult = card.ability.mult * count, message = localize{type='variable',key='a_mult',vars={card.ability.mult * count}} }
      end
    end
  end
})

-- n367: Under the Bridge
SMODS.Joker({
  key = "n367",
  loc_txt = { name = "Under the Bridge", text = { "{C:chips}+20{} Chips for", "each low card ({C:attention}2-5{})" } },
  config = { chips = 20 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 6 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local low = {["2"]=true,["3"]=true,["4"]=true,["5"]=true}
      if low[context.other_card.base.value] then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n368: Losing My Religion
SMODS.Joker({
  key = "n368",
  loc_txt = { name = "Losing My Religion", text = { "{C:mult}+5{} Mult lost when", "discarding a face card" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 6 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
    if context.discard then
      local v = context.other_card and context.other_card.base.value
      if v == "Jack" or v == "Queen" or v == "King" then
        card.ability.extra.mult = card.ability.extra.mult + 5
        card:juice_up(0.5, 0.5)
      end
    end
  end
})

-- n369: Comfortably Numb
SMODS.Joker({
  key = "n369",
  loc_txt = { name = "Comfortably Numb", text = { "{C:mult}X2{} Mult. Loses", "{C:mult}X0.1{} each round played" } },
  config = { extra = { Xmult = 2.0 } },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 6 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { string.format("%.1f", center.ability.extra.Xmult) } } end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.Xmult > 1.0 then
      return { Xmult = card.ability.extra.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.Xmult = math.max(1.0, card.ability.extra.Xmult - 0.1)
    end
  end
})

-- n370: With or Without You
SMODS.Joker({
  key = "n370",
  loc_txt = { name = "With or Without You", text = { "{C:mult}+15{} Mult if scored", "hand has exactly {C:attention}1{} card" } },
  config = { mult = 15 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 6 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      if #context.scoring_hand == 1 then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n371: Owner of a Lonely Heart
SMODS.Joker({
  key = "n371",
  loc_txt = { name = "Owner of a Lonely Heart", text = { "{C:mult}+20{} Mult if this", "is your only Joker" } },
  config = { mult = 20 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 7 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and #G.jokers.cards == 1 then
      return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
    end
  end
})

-- n372: Killing Me Softly
SMODS.Joker({
  key = "n372",
  loc_txt = { name = "Killing Me Softly", text = { "{C:mult}+4{} Mult per card", "discarded this hand" } },
  config = { extra = { mult = 4, discards = 0 } },
  rarity = 1, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 7 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.discard then
      card.ability.extra.discards = card.ability.extra.discards + 1
    end
    if context.joker_main and card.ability.extra.discards > 0 then
      local m = card.ability.extra.mult * card.ability.extra.discards
      card.ability.extra.discards = 0
      return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
    end
  end
})

-- n373: Space Oddity
SMODS.Joker({
  key = "n373",
  loc_txt = { name = "Space Oddity", text = { "{C:mult}X2{} Mult if Blind", "is a {C:attention}Boss Blind{}" } },
  config = { Xmult = 2 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 7 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.blind and G.GAME.blind.boss then
        return { Xmult = card.ability.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult}} }
      end
    end
  end
})

-- n374: Under Pressure
SMODS.Joker({
  key = "n374",
  loc_txt = { name = "Under Pressure", text = { "{C:mult}+2{} Mult for each", "chip above Blind requirement" } },
  config = { mult = 2 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 7 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local chips = G.GAME.chips or 0
      local blind_chips = G.GAME.blind and G.GAME.blind.chips or 0
      local over = math.max(0, math.floor((chips - blind_chips) / 100))
      if over > 0 then
        return { mult = card.ability.mult * over, message = localize{type='variable',key='a_mult',vars={card.ability.mult * over}} }
      end
    end
  end
})

-- n375: Don't You (Forget About Me)
SMODS.Joker({
  key = "n375",
  loc_txt = { name = "Don't You Forget", text = { "Gains {C:mult}+2{} Mult when", "a Joker leaves your hand" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 7 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
    if context.selling_card and context.selling_card ~= card then
      card.ability.extra.mult = card.ability.extra.mult + 2
      card:juice_up(0.5, 0.5)
    end
  end
})

-- n376: Time After Time
SMODS.Joker({
  key = "n376",
  loc_txt = { name = "Time After Time", text = { "{C:chips}+10{} Chips per", "round survived" } },
  config = { extra = { chips = 0, rounds = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 7 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.chips > 0 then
      return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.rounds = card.ability.extra.rounds + 1
      card.ability.extra.chips = card.ability.extra.rounds * 10
    end
  end
})

-- n377: Brass in Pocket
SMODS.Joker({
  key = "n377",
  loc_txt = { name = "Brass in Pocket", text = { "Earn {C:money}$1{} per", "{C:attention}10{} scored" } },
  config = {},
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 7 }, atlas = "cm_atlas_04",
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value == "10" then
        ease_dollars(1)
        return { message = "$1!" }
      end
    end
  end
})

-- n378: Smooth Criminal
SMODS.Joker({
  key = "n378",
  loc_txt = { name = "Smooth Criminal", text = { "{C:mult}+10{} Mult if no", "cards were discarded" } },
  config = { mult = 10 },
  rarity = 1, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 7 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local discards_used = G.GAME.round_resets and G.GAME.current_round and
        (G.GAME.round_resets.discards - G.GAME.current_round.discards_left) or 0
      if discards_used == 0 then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n379: Beat It
SMODS.Joker({
  key = "n379",
  loc_txt = { name = "Beat It", text = { "{C:mult}+5{} Mult per", "{C:attention}pair{} in hand" } },
  config = { mult = 5 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 7 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      local counts = {}
      for _, c in ipairs(context.scoring_hand) do
        counts[c.base.value] = (counts[c.base.value] or 0) + 1
      end
      local pairs_count = 0
      for _, v in pairs(counts) do
        if v >= 2 then pairs_count = pairs_count + 1 end
      end
      if pairs_count > 0 then
        return { mult = card.ability.mult * pairs_count, message = localize{type='variable',key='a_mult',vars={card.ability.mult * pairs_count}} }
      end
    end
  end
})

-- n380: Billie Jean
SMODS.Joker({
  key = "n380",
  loc_txt = { name = "Billie Jean", text = { "{C:mult}+12{} Mult if hand", "is a {C:attention}Pair{} or better" } },
  config = { mult = 12 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 7 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local not_hc = G.GAME.last_hand_played ~= "High Card"
      if not_hc then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n381: Thriller
SMODS.Joker({
  key = "n381",
  loc_txt = { name = "Thriller", text = { "{C:mult}X1.5{} Mult at", "night (even Antes)" } },
  config = { Xmult = 1.5 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 8 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local ante = G.GAME.round_resets and G.GAME.round_resets.ante or 1
      if ante % 2 == 0 then
        return { Xmult = card.ability.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult}} }
      end
    end
  end
})

-- n382: Don't Stop Me Now
SMODS.Joker({
  key = "n382",
  loc_txt = { name = "Don't Stop Me Now", text = { "Gains {C:mult}+1{} Mult each", "hand played this round" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 8 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      card.ability.extra.mult = card.ability.extra.mult + 1
      if card.ability.extra.mult > 0 then
        return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult = 0
    end
  end
})

-- n383: Radio Ga Ga
SMODS.Joker({
  key = "n383",
  loc_txt = { name = "Radio Ga Ga", text = { "{C:chips}+8{} Chips per card", "in played hand" } },
  config = { chips = 8 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 8 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      local n = #context.scoring_hand
      if n > 0 then
        return { chips = card.ability.chips * n, message = localize{type='variable',key='a_chips',vars={card.ability.chips * n}} }
      end
    end
  end
})

-- n384: We Will Rock You
SMODS.Joker({
  key = "n384",
  loc_txt = { name = "We Will Rock You", text = { "{C:mult}+5{} Mult per", "{C:attention}10{} or {C:attention}Jack{} scored" } },
  config = { mult = 5 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 8 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "10" or v == "Jack" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n385: We Are the Champions
SMODS.Joker({
  key = "n385",
  loc_txt = { name = "We Are the Champions", text = { "{C:mult}X2{} Mult if Blind", "has been defeated" } },
  config = { Xmult = 2 },
  rarity = 3, cost = 10,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 8 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local chips = G.GAME.chips or 0
      local blind_chips = G.GAME.blind and G.GAME.blind.chips or 999999
      if chips >= blind_chips then
        return { Xmult = card.ability.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult}} }
      end
    end
  end
})

-- n386: Dream On
SMODS.Joker({
  key = "n386",
  loc_txt = { name = "Dream On", text = { "Gains {C:mult}+3{} Mult each", "time Blind is not beaten" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 8 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n387: More Than a Feeling
SMODS.Joker({
  key = "n387",
  loc_txt = { name = "More Than a Feeling", text = { "{C:mult}+6{} Mult per suit", "represented in played hand" } },
  config = { mult = 6 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 8 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      local suits = {}
      for _, c in ipairs(context.scoring_hand) do suits[c.base.suit] = true end
      local count = 0
      for _ in pairs(suits) do count = count + 1 end
      if count > 0 then
        return { mult = card.ability.mult * count, message = localize{type='variable',key='a_mult',vars={card.ability.mult * count}} }
      end
    end
  end
})

-- n388: Ramble On
SMODS.Joker({
  key = "n388",
  loc_txt = { name = "Ramble On", text = { "{C:mult}+2{} Mult per", "hand played this game" } },
  config = { mult = 2 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 8 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local hands = G.GAME.hands_played or 0
      if hands > 0 then
        return { mult = card.ability.mult * hands, message = localize{type='variable',key='a_mult',vars={card.ability.mult * hands}} }
      end
    end
  end
})

-- n389: The Unforgiven
SMODS.Joker({
  key = "n389",
  loc_txt = { name = "The Unforgiven", text = { "{C:mult}+30{} Mult but", "cannot be sold" } },
  config = { mult = 30 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = false,
  pos = { x = 8, y = 8 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
    end
  end
})

-- n390: Nothing Else Matters
SMODS.Joker({
  key = "n390",
  loc_txt = { name = "Nothing Else Matters", text = { "{C:mult}X3{} Mult if only", "one card is played" } },
  config = { Xmult = 3 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 8 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      if #context.scoring_hand == 1 then
        return { Xmult = card.ability.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult}} }
      end
    end
  end
})

-- n391: Stayin' Alive
SMODS.Joker({
  key = "n391",
  loc_txt = { name = "Stayin' Alive", text = { "{C:mult}+4{} Mult per", "hand remaining" } },
  config = { mult = 4 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 9 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local hands = G.GAME.current_round and G.GAME.current_round.hands_left or 0
      if hands > 0 then
        return { mult = card.ability.mult * hands, message = localize{type='variable',key='a_mult',vars={card.ability.mult * hands}} }
      end
    end
  end
})

-- n392: Night Fever
SMODS.Joker({
  key = "n392",
  loc_txt = { name = "Night Fever", text = { "{C:chips}+25{} Chips on", "even-numbered Antes" } },
  config = { chips = 25 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 9 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.chips } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local ante = G.GAME.round_resets and G.GAME.round_resets.ante or 1
      if ante % 2 == 0 then
        return { chips = card.ability.chips, message = localize{type='variable',key='a_chips',vars={card.ability.chips}} }
      end
    end
  end
})

-- n393: Superstars (Bowie tribute)
SMODS.Joker({
  key = "n393",
  loc_txt = { name = "Starman", text = { "{C:mult}+5{} Mult per", "{C:attention}Ace{} or {C:attention}King{} scored" } },
  config = { mult = 5 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 9 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "Ace" or v == "King" then
        return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
      end
    end
  end
})

-- n394: I Will Survive
SMODS.Joker({
  key = "n394",
  loc_txt = { name = "I Will Survive", text = { "Starts at {C:mult}+0{} Mult.", "Gains {C:mult}+5{} each round" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 9 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult = card.ability.extra.mult + 5
      card:juice_up(0.5, 0.5)
    end
  end
})

-- n395: The Show Must Go On
SMODS.Joker({
  key = "n395",
  loc_txt = { name = "The Show Must Go On", text = { "{C:mult}+8{} Mult per", "Joker in your deck" } },
  config = { mult = 8 },
  rarity = 3, cost = 10,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 9 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local n = #G.jokers.cards
      if n > 0 then
        return { mult = card.ability.mult * n, message = localize{type='variable',key='a_mult',vars={card.ability.mult * n}} }
      end
    end
  end
})

-- n396: Golden Years
SMODS.Joker({
  key = "n396",
  loc_txt = { name = "Golden Years", text = { "Earn {C:money}$3{} at end", "of round if Blind beaten" } },
  config = { extra = { money = 3 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 9 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.money } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      local chips = G.GAME.chips or 0
      local blind_chips = G.GAME.blind and G.GAME.blind.chips or 999999
      if chips >= blind_chips then
        ease_dollars(card.ability.extra.money)
        return { message = "Gold!" }
      end
    end
  end
})

-- n397: Fame
SMODS.Joker({
  key = "n397",
  loc_txt = { name = "Fame", text = { "{C:mult}X1.5{} Mult per", "Legendary Joker owned" } },
  config = { Xmult = 1.5 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 9 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local count = 0
      for _, j in ipairs(G.jokers.cards) do
        if j.config.center.rarity == 4 then count = count + 1 end
      end
      if count > 0 then
        local xm = card.ability.Xmult ^ count
        return { Xmult = xm, message = localize{type='variable',key='a_xmult',vars={xm}} }
      end
    end
  end
})

-- n398: Heroes
SMODS.Joker({
  key = "n398",
  loc_txt = { name = "Heroes", text = { "{C:mult}+10{} Mult.", "Just for one day." } },
  config = { mult = 10 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 9 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { mult = card.ability.mult, message = localize{type='variable',key='a_mult',vars={card.ability.mult}} }
    end
  end
})

-- n399: Changes
SMODS.Joker({
  key = "n399",
  loc_txt = { name = "Changes", text = { "Each round, randomly gives", "{C:mult}Mult{}, {C:chips}Chips{}, or {C:mult}XMult{}" } },
  config = { extra = { mode = 1 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 9 }, atlas = "cm_atlas_04",
  calculate = function(self, card, context)
    if context.joker_main then
      local m = card.ability.extra.mode
      if m == 1 then return { mult = 15, message = localize{type='variable',key='a_mult',vars={15}} }
      elseif m == 2 then return { chips = 40, message = localize{type='variable',key='a_chips',vars={40}} }
      else return { Xmult = 1.5, message = localize{type='variable',key='a_xmult',vars={1.5}} } end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mode = math.random(1, 3)
    end
  end
})

-- n400: Let It Be (Reprise) - Legendary
SMODS.Joker({
  key = "n400",
  loc_txt = { name = "The Long and Winding Road", text = { "{C:mult}X4{} Mult.", "The Beatles' farewell." } },
  config = { Xmult = 4 },
  rarity = 4, cost = 20,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 9 }, atlas = "cm_atlas_04",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.Xmult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { Xmult = card.ability.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.Xmult}} }
    end
  end
})
