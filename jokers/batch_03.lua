-- ClaudeMod Batch 03: 90s & 2000s Pop Culture (n201-n300)

-- n201: Tamagotchi
SMODS.Joker({
  key = "n201",
  loc_txt = { name = "Tamagotchi", text = { "Gains {C:chips}+2{} Chips", "each round ({C:chips}#1#{} now)" } },
  config = { extra = { chips = 0 } },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 0 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips = card.ability.extra.chips + 2
      return { message = localize{type='variable',key='a_chips',vars={2}} }
    end
    if context.joker_main then
      return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
    end
  end
})

-- n202: Furby
SMODS.Joker({
  key = "n202",
  loc_txt = { name = "Furby", text = { "{C:mult}+1{} to {C:mult}+10{} Mult,", "randomly each hand" } },
  config = {},
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 0 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local m = math.random(1, 10)
      return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
    end
  end
})

-- n203: Pokemon Card
SMODS.Joker({
  key = "n203",
  loc_txt = { name = "Pokemon Card", text = { "{C:chips}+80{} Chips if", "hand contains a Pair" } },
  config = { chips = 80 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 0 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local counts = {}
      for _, c in ipairs(G.play.cards) do
        local v = c.base.value
        counts[v] = (counts[v] or 0) + 1
      end
      for _, cnt in pairs(counts) do
        if cnt >= 2 then
          return { chips = 80, message = localize{type='variable',key='a_chips',vars={80}} }
        end
      end
    end
  end
})

-- n204: Dial-Up Modem
SMODS.Joker({
  key = "n204",
  loc_txt = { name = "Dial-Up Modem", text = { "{C:attention}-1{} hand size,", "{C:chips}+60{} Chips" } },
  config = { chips = 60 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 0 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.m_hand_size
    return { vars = {} }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { chips = 60, message = localize{type='variable',key='a_chips',vars={60}} }
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(-1)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(1)
  end
})

-- n205: The Matrix
SMODS.Joker({
  key = "n205",
  loc_txt = { name = "The Matrix", text = { "{X:mult,C:white}X3{} Mult if all", "scored cards are black" } },
  config = {},
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 0 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local all_black = true
      for _, c in ipairs(G.play.cards) do
        local s = c.base.suit
        if s ~= "Clubs" and s ~= "Spades" then all_black = false; break end
      end
      if all_black and #G.play.cards > 0 then
        return { Xmult = 3, message = localize{type='variable',key='a_xmult',vars={3}} }
      end
    end
  end
})

-- n206: SpongeBob
SMODS.Joker({
  key = "n206",
  loc_txt = { name = "SpongeBob", text = { "{C:mult}+3{} Mult for each", "Heart scored" } },
  config = { mult = 3 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 0 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Hearts" then
        return { mult = 3, message = localize{type='variable',key='a_mult',vars={3}} }
      end
    end
  end
})

-- n207: Napster
SMODS.Joker({
  key = "n207",
  loc_txt = { name = "Napster", text = { "Copies the {C:mult}Mult{}", "of the joker to the left" } },
  config = {},
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 0 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local idx = nil
      for i, j in ipairs(G.jokers.cards) do
        if j == card then idx = i; break end
      end
      if idx and idx > 1 then
        local left = G.jokers.cards[idx - 1]
        local m = left.ability.mult or 0
        if m > 0 then
          return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
        end
      end
    end
  end
})

-- n208: MySpace
SMODS.Joker({
  key = "n208",
  loc_txt = { name = "MySpace", text = { "{C:mult}+20{} Mult if you have", "exactly 8 jokers (Top 8)" } },
  config = { mult = 20 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 0 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.jokers.cards == 8 then
        return { mult = 20, message = localize{type='variable',key='a_mult',vars={20}} }
      end
    end
  end
})

-- n209: Beanie Baby
SMODS.Joker({
  key = "n209",
  loc_txt = { name = "Beanie Baby", text = { "Gains {C:chips}+3{} Chips", "each round ({C:chips}#1#{} now)" } },
  config = { extra = { chips = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 0 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips = card.ability.extra.chips + 3
      return { message = localize{type='variable',key='a_chips',vars={3}} }
    end
    if context.joker_main then
      return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
    end
  end
})

-- n210: Frosted Tips
SMODS.Joker({
  key = "n210",
  loc_txt = { name = "Frosted Tips", text = { "{C:mult}+5{} Mult for each", "face card scored" } },
  config = { mult = 5 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 0 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "Jack" or v == "Queen" or v == "King" then
        return { mult = 5, message = localize{type='variable',key='a_mult',vars={5}} }
      end
    end
  end
})

-- n211: Harry Potter
SMODS.Joker({
  key = "n211",
  loc_txt = { name = "Harry Potter", text = { "{C:chips}+120{} Chips if", "played hand is a Straight" } },
  config = { chips = 120 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 1 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.current_round.hands_played > 0 or true then
        local hand_name = G.GAME.last_hand_played or ""
        if hand_name == "Straight" or hand_name == "Straight Flush" then
          return { chips = 120, message = localize{type='variable',key='a_chips',vars={120}} }
        end
      end
    end
  end
})

-- n212: Gameboy Color
SMODS.Joker({
  key = "n212",
  loc_txt = { name = "Gameboy Color", text = { "{C:chips}+15{} Chips for each", "distinct suit scored" } },
  config = { chips = 15 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 1 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local suits = {}
      for _, c in ipairs(G.play.cards) do
        suits[c.base.suit] = true
      end
      local cnt = 0
      for _ in pairs(suits) do cnt = cnt + 1 end
      if cnt > 0 then
        local total = cnt * 15
        return { chips = total, message = localize{type='variable',key='a_chips',vars={total}} }
      end
    end
  end
})

-- n213: N64 Controller
SMODS.Joker({
  key = "n213",
  loc_txt = { name = "N64 Controller", text = { "{C:mult}+4{} Mult for each", "joker you own" } },
  config = { mult = 4 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 1 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local cnt = #G.jokers.cards
      local total = cnt * 4
      return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
    end
  end
})

-- n214: Titanic
SMODS.Joker({
  key = "n214",
  loc_txt = { name = "Titanic", text = { "{X:mult,C:white}X2{} Mult, but loses", "{C:attention}1{} Mult each round" } },
  config = { extra = { xmult = 2, decay = 0 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 1 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.xmult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.extra.xmult > 1 then
        card.ability.extra.xmult = math.max(1, card.ability.extra.xmult - 0.2)
        return { message = "-0.2X" }
      end
    end
    if context.joker_main then
      local x = card.ability.extra.xmult
      return { Xmult = x, message = localize{type='variable',key='a_xmult',vars={x}} }
    end
  end
})

-- n215: Shrek
SMODS.Joker({
  key = "n215",
  loc_txt = { name = "Shrek", text = { "{C:chips}+5{} Chips for every", "layer of the hand (cards played)" } },
  config = { chips = 5 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 1 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local cnt = #G.play.cards
      local total = cnt * 5
      return { chips = total, message = localize{type='variable',key='a_chips',vars={total}} }
    end
  end
})

-- n216: Backstreet Boys
SMODS.Joker({
  key = "n216",
  loc_txt = { name = "Backstreet Boys", text = { "{C:mult}+3{} Mult for each", "card in your hand" } },
  config = { mult = 3 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 1 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local cnt = #G.hand.cards
      local total = cnt * 3
      return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
    end
  end
})

-- n217: Britney Spears
SMODS.Joker({
  key = "n217",
  loc_txt = { name = "Britney Spears", text = { "Gains {C:mult}+2{} Mult if you", "play all 5 cards ({C:mult}#1#{} now)" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 1 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      if #G.play.cards == 5 then
        card.ability.extra.mult = card.ability.extra.mult + 2
        return { message = localize{type='variable',key='a_mult',vars={2}} }
      end
    end
    if context.joker_main then
      if card.ability.extra.mult > 0 then
        return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
      end
    end
  end
})

-- n218: NSYNC
SMODS.Joker({
  key = "n218",
  loc_txt = { name = "NSYNC", text = { "{X:mult,C:white}X2{} Mult if all", "scored cards share a suit" } },
  config = {},
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 1 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.play.cards == 0 then return end
      local suit = G.play.cards[1].base.suit
      local all_same = true
      for _, c in ipairs(G.play.cards) do
        if c.base.suit ~= suit then all_same = false; break end
      end
      if all_same then
        return { Xmult = 2, message = localize{type='variable',key='a_xmult',vars={2}} }
      end
    end
  end
})

-- n219: Eminem
SMODS.Joker({
  key = "n219",
  loc_txt = { name = "Eminem", text = { "{C:mult}+2{} Mult for each", "Spade scored" } },
  config = { mult = 2 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 1 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Spades" then
        return { mult = 2, message = localize{type='variable',key='a_mult',vars={2}} }
      end
    end
  end
})

-- n220: Y2K Bug
SMODS.Joker({
  key = "n220",
  loc_txt = { name = "Y2K Bug", text = { "End of round: {C:attention}50%{}", "chance to gain {C:mult}+5{} Mult" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 1 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      if math.random() < 0.5 then
        card.ability.extra.mult = card.ability.extra.mult + 5
        return { message = localize{type='variable',key='a_mult',vars={5}} }
      end
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n221: AIM Messenger
SMODS.Joker({
  key = "n221",
  loc_txt = { name = "AIM Messenger", text = { "{C:chips}+10{} Chips for each", "distinct card value scored" } },
  config = { chips = 10 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 2 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local vals = {}
      for _, c in ipairs(G.play.cards) do
        vals[c.base.value] = true
      end
      local cnt = 0
      for _ in pairs(vals) do cnt = cnt + 1 end
      local total = cnt * 10
      return { chips = total, message = localize{type='variable',key='a_chips',vars={total}} }
    end
  end
})

-- n222: Flash Game
SMODS.Joker({
  key = "n222",
  loc_txt = { name = "Flash Game", text = { "{C:mult}+1{} to {C:mult}+6{} Mult", "per scored Club" } },
  config = {},
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 2 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Clubs" then
        local m = math.random(1, 6)
        return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
      end
    end
  end
})

-- n223: Runescape
SMODS.Joker({
  key = "n223",
  loc_txt = { name = "Runescape", text = { "Gains {C:mult}+1{} Mult each", "hand played ({C:mult}#1#{} now)" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 2 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      card.ability.extra.mult = card.ability.extra.mult + 1
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n224: PS1 Controller
SMODS.Joker({
  key = "n224",
  loc_txt = { name = "PS1 Controller", text = { "{C:chips}+25{} Chips for each", "Diamond scored" } },
  config = { chips = 25 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 2 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.suit == "Diamonds" then
        return { chips = 25, message = localize{type='variable',key='a_chips',vars={25}} }
      end
    end
  end
})

-- n225: Friends
SMODS.Joker({
  key = "n225",
  loc_txt = { name = "Friends", text = { "{C:mult}+6{} Mult if at least", "3 jokers are in play" } },
  config = { mult = 6 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 2 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.jokers.cards >= 3 then
        return { mult = 6, message = localize{type='variable',key='a_mult',vars={6}} }
      end
    end
  end
})

-- n226: The Simpsons
SMODS.Joker({
  key = "n226",
  loc_txt = { name = "The Simpsons", text = { "{C:chips}+10{} Chips for each", "face card in hand" } },
  config = { chips = 10 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 2 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local cnt = 0
      for _, c in ipairs(G.hand.cards) do
        local v = c.base.value
        if v == "Jack" or v == "Queen" or v == "King" then cnt = cnt + 1 end
      end
      local total = cnt * 10
      if total > 0 then
        return { chips = total, message = localize{type='variable',key='a_chips',vars={total}} }
      end
    end
  end
})

-- n227: Halo
SMODS.Joker({
  key = "n227",
  loc_txt = { name = "Halo", text = { "{X:mult,C:white}X2{} Mult if hand", "contains a King" } },
  config = {},
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 2 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      for _, c in ipairs(G.play.cards) do
        if c.base.value == "King" then
          return { Xmult = 2, message = localize{type='variable',key='a_xmult',vars={2}} }
        end
      end
    end
  end
})

-- n228: Butterfly Clips
SMODS.Joker({
  key = "n228",
  loc_txt = { name = "Butterfly Clips", text = { "{C:mult}+4{} Mult for each", "red card scored" } },
  config = { mult = 4 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 2 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local s = context.other_card.base.suit
      if s == "Hearts" or s == "Diamonds" then
        return { mult = 4, message = localize{type='variable',key='a_mult',vars={4}} }
      end
    end
  end
})

-- n229: Tickle Me Elmo
SMODS.Joker({
  key = "n229",
  loc_txt = { name = "Tickle Me Elmo", text = { "{C:mult}+12{} Mult randomly", "1 in 3 chance per hand" } },
  config = { mult = 12 },
  rarity = 2, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 2 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if math.random(1, 3) == 1 then
        return { mult = 12, message = localize{type='variable',key='a_mult',vars={12}} }
      end
    end
  end
})

-- n230: Fanny Pack
SMODS.Joker({
  key = "n230",
  loc_txt = { name = "Fanny Pack", text = { "{C:chips}+8{} Chips for each", "card in your hand" } },
  config = { chips = 8 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 2 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local cnt = #G.hand.cards
      local total = cnt * 8
      return { chips = total, message = localize{type='variable',key='a_chips',vars={total}} }
    end
  end
})

-- n231: Space Jam
SMODS.Joker({
  key = "n231",
  loc_txt = { name = "Space Jam", text = { "{X:mult,C:white}X1.5{} Mult if hand", "contains an Ace" } },
  config = {},
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 3 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      for _, c in ipairs(G.play.cards) do
        if c.base.value == "Ace" then
          return { Xmult = 1.5, message = localize{type='variable',key='a_xmult',vars={1.5}} }
        end
      end
    end
  end
})

-- n232: Saved by the Bell
SMODS.Joker({
  key = "n232",
  loc_txt = { name = "Saved by the Bell", text = { "{C:mult}+15{} Mult on the", "final hand of the round" } },
  config = { mult = 15 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 3 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.current_round.hands_left == 0 then
        return { mult = 15, message = localize{type='variable',key='a_mult',vars={15}} }
      end
    end
  end
})

-- n233: Pager
SMODS.Joker({
  key = "n233",
  loc_txt = { name = "Pager", text = { "Gains {C:chips}+5{} Chips", "when a discard is used ({C:chips}#1#{} now)" } },
  config = { extra = { chips = 0 } },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 3 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.discard then
      card.ability.extra.chips = card.ability.extra.chips + 5
      return { message = localize{type='variable',key='a_chips',vars={5}} }
    end
    if context.joker_main and card.ability.extra.chips > 0 then
      return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
    end
  end
})

-- n234: Power Rangers
SMODS.Joker({
  key = "n234",
  loc_txt = { name = "Power Rangers", text = { "{C:mult}+5{} Mult for each", "color of suit scored (max 4)" } },
  config = { mult = 5 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 3 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local suits = {}
      for _, c in ipairs(G.play.cards) do suits[c.base.suit] = true end
      local cnt = 0
      for _ in pairs(suits) do cnt = cnt + 1 end
      local total = math.min(cnt, 4) * 5
      if total > 0 then
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n235: Buffy the Vampire Slayer
SMODS.Joker({
  key = "n235",
  loc_txt = { name = "Buffy", text = { "{C:chips}+30{} Chips if scored", "hand has no face cards" } },
  config = { chips = 30 },
  rarity = 2, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 3 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local has_face = false
      for _, c in ipairs(G.play.cards) do
        local v = c.base.value
        if v == "Jack" or v == "Queen" or v == "King" then has_face = true; break end
      end
      if not has_face then
        return { chips = 30, message = localize{type='variable',key='a_chips',vars={30}} }
      end
    end
  end
})

-- n236: Mighty Morphin
SMODS.Joker({
  key = "n236",
  loc_txt = { name = "Mighty Morphin", text = { "{X:mult,C:white}X2{} Mult if hand", "is exactly 5 cards" } },
  config = {},
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 3 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.play.cards == 5 then
        return { Xmult = 2, message = localize{type='variable',key='a_xmult',vars={2}} }
      end
    end
  end
})

-- n237: Slap Bracelet
SMODS.Joker({
  key = "n237",
  loc_txt = { name = "Slap Bracelet", text = { "{C:mult}+2{} Mult for each", "card played this hand" } },
  config = { mult = 2 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 3 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local total = #G.play.cards * 2
      return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
    end
  end
})

-- n238: Blockbuster Video
SMODS.Joker({
  key = "n238",
  loc_txt = { name = "Blockbuster Video", text = { "Gains {C:mult}+2{} Mult each round,", "loses {C:attention}1{} at end ({C:mult}#1#{} now)" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 3 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult = math.max(0, card.ability.extra.mult + 2)
      return { message = localize{type='variable',key='a_mult',vars={2}} }
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      local m = card.ability.extra.mult
      card.ability.extra.mult = math.max(0, m - 1)
      return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
    end
  end
})

-- n239: Yo-Yo
SMODS.Joker({
  key = "n239",
  loc_txt = { name = "Yo-Yo", text = { "Alternates between", "{C:chips}+40{} Chips and {C:mult}+8{} Mult" } },
  config = { extra = { toggle = 0 } },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 3 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if card.ability.extra.toggle % 2 == 0 then
        card.ability.extra.toggle = card.ability.extra.toggle + 1
        return { chips = 40, message = localize{type='variable',key='a_chips',vars={40}} }
      else
        card.ability.extra.toggle = card.ability.extra.toggle + 1
        return { mult = 8, message = localize{type='variable',key='a_mult',vars={8}} }
      end
    end
  end
})

-- n240: Lisa Frank
SMODS.Joker({
  key = "n240",
  loc_txt = { name = "Lisa Frank", text = { "{C:mult}+3{} Mult for each", "unique suit in hand" } },
  config = { mult = 3 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 3 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local suits = {}
      for _, c in ipairs(G.hand.cards) do suits[c.base.suit] = true end
      local cnt = 0
      for _ in pairs(suits) do cnt = cnt + 1 end
      local total = cnt * 3
      if total > 0 then
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n241: Pogs
SMODS.Joker({
  key = "n241",
  loc_txt = { name = "Pogs", text = { "{C:chips}+5{} Chips for each", "card destroyed this run" } },
  config = { extra = { chips = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 4 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.remove_playing_cards and context.removed then
      card.ability.extra.chips = card.ability.extra.chips + (#context.removed * 5)
      return { message = localize{type='variable',key='a_chips',vars={#context.removed * 5}} }
    end
    if context.joker_main and card.ability.extra.chips > 0 then
      return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
    end
  end
})

-- n242: Duck Hunt
SMODS.Joker({
  key = "n242",
  loc_txt = { name = "Duck Hunt", text = { "{C:mult}+10{} Mult if scored", "hand contains a 2" } },
  config = { mult = 10 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 4 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      for _, c in ipairs(G.play.cards) do
        if c.base.value == "2" then
          return { mult = 10, message = localize{type='variable',key='a_mult',vars={10}} }
        end
      end
    end
  end
})

-- n243: Kazoo
SMODS.Joker({
  key = "n243",
  loc_txt = { name = "Kazoo", text = { "{C:mult}+1{} to {C:mult}+5{} Mult", "for each card in hand" } },
  config = {},
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 4 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local total = 0
      for _, _ in ipairs(G.hand.cards) do
        total = total + math.random(1, 5)
      end
      return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
    end
  end
})

-- n244: The Fresh Prince
SMODS.Joker({
  key = "n244",
  loc_txt = { name = "Fresh Prince", text = { "{C:chips}+50{} Chips if scored", "hand contains a Club" } },
  config = { chips = 50 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 4 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      for _, c in ipairs(G.play.cards) do
        if c.base.suit == "Clubs" then
          return { chips = 50, message = localize{type='variable',key='a_chips',vars={50}} }
        end
      end
    end
  end
})

-- n245: Macarena
SMODS.Joker({
  key = "n245",
  loc_txt = { name = "Macarena", text = { "Rotates between {C:chips}+30{} Chips,", "{C:mult}+6{} Mult, {X:mult,C:white}X1.5{} each hand" } },
  config = { extra = { step = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 4 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local s = card.ability.extra.step % 3
      card.ability.extra.step = card.ability.extra.step + 1
      if s == 0 then
        return { chips = 30, message = localize{type='variable',key='a_chips',vars={30}} }
      elseif s == 1 then
        return { mult = 6, message = localize{type='variable',key='a_mult',vars={6}} }
      else
        return { Xmult = 1.5, message = localize{type='variable',key='a_xmult',vars={1.5}} }
      end
    end
  end
})

-- n246: Spice Girls
SMODS.Joker({
  key = "n246",
  loc_txt = { name = "Spice Girls", text = { "{X:mult,C:white}X1.5{} Mult if", "5 or more jokers owned" } },
  config = {},
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 4 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.jokers.cards >= 5 then
        return { Xmult = 1.5, message = localize{type='variable',key='a_xmult',vars={1.5}} }
      end
    end
  end
})

-- n247: Discman
SMODS.Joker({
  key = "n247",
  loc_txt = { name = "Discman", text = { "Gains {C:chips}+4{} Chips each hand,", "resets at end of round" } },
  config = { extra = { chips = 0 } },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 4 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips = 0
      return { message = "Skipped!" }
    end
    if context.joker_main then
      card.ability.extra.chips = card.ability.extra.chips + 4
      return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
    end
  end
})

-- n248: Tazo
SMODS.Joker({
  key = "n248",
  loc_txt = { name = "Tazo", text = { "{C:chips}+10{} Chips for each", "Ace in your hand" } },
  config = { chips = 10 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 4 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local cnt = 0
      for _, c in ipairs(G.hand.cards) do
        if c.base.value == "Ace" then cnt = cnt + 1 end
      end
      if cnt > 0 then
        local total = cnt * 10
        return { chips = total, message = localize{type='variable',key='a_chips',vars={total}} }
      end
    end
  end
})

-- n249: VHS Tape
SMODS.Joker({
  key = "n249",
  loc_txt = { name = "VHS Tape", text = { "Gains {C:mult}+1{} Mult each hand,", "max {C:mult}20{} Mult (#1# now)" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 4 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      if card.ability.extra.mult < 20 then
        card.ability.extra.mult = math.min(20, card.ability.extra.mult + 1)
      end
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n250: Oregon Trail
SMODS.Joker({
  key = "n250",
  loc_txt = { name = "Oregon Trail", text = { "{C:mult}+5{} Mult for each", "card destroyed this hand" } },
  config = { mult = 5 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 4 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.remove_playing_cards and context.removed then
      local m = #context.removed * 5
      return { mult = m, message = localize{type='variable',key='a_mult',vars={m}} }
    end
  end
})

-- n251: Crazy Frog
SMODS.Joker({
  key = "n251",
  loc_txt = { name = "Crazy Frog", text = { "{C:mult}+8{} Mult if scored", "hand has no pairs" } },
  config = { mult = 8 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 5 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local vals = {}
      local has_pair = false
      for _, c in ipairs(G.play.cards) do
        local v = c.base.value
        if vals[v] then has_pair = true; break end
        vals[v] = true
      end
      if not has_pair then
        return { mult = 8, message = localize{type='variable',key='a_mult',vars={8}} }
      end
    end
  end
})

-- n252: Who Wants to be a Millionaire
SMODS.Joker({
  key = "n252",
  loc_txt = { name = "Millionaire", text = { "{X:mult,C:white}X2{} Mult if chips scored", "exceed 1000 this hand" } },
  config = {},
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 5 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.chips and G.GAME.chips >= 1000 then
        return { Xmult = 2, message = localize{type='variable',key='a_xmult',vars={2}} }
      end
    end
  end
})

-- n253: eBay
SMODS.Joker({
  key = "n253",
  loc_txt = { name = "eBay", text = { "Gains {C:mult}+1{} Mult each time", "a consumable is used (#1# now)" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 5 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.using_consumeable then
      card.ability.extra.mult = card.ability.extra.mult + 1
      return { message = localize{type='variable',key='a_mult',vars={1}} }
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n254: Google
SMODS.Joker({
  key = "n254",
  loc_txt = { name = "Google", text = { "{C:chips}+20{} Chips for every", "2 different values scored" } },
  config = { chips = 20 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 5 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local vals = {}
      for _, c in ipairs(G.play.cards) do vals[c.base.value] = true end
      local cnt = 0
      for _ in pairs(vals) do cnt = cnt + 1 end
      local total = math.floor(cnt / 2) * 20
      if total > 0 then
        return { chips = total, message = localize{type='variable',key='a_chips',vars={total}} }
      end
    end
  end
})

-- n255: Razr Phone
SMODS.Joker({
  key = "n255",
  loc_txt = { name = "Razr Phone", text = { "{C:mult}+15{} Mult if you have", "used all discards" } },
  config = { mult = 15 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 5 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.current_round.discards_left == 0 then
        return { mult = 15, message = localize{type='variable',key='a_mult',vars={15}} }
      end
    end
  end
})

-- n256: iPod
SMODS.Joker({
  key = "n256",
  loc_txt = { name = "iPod", text = { "{C:chips}+4{} Chips per note", "card value (2-10=face value)" } },
  config = { chips = 4 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 5 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      local num = tonumber(v)
      if num then
        local total = num * 4
        return { chips = total, message = localize{type='variable',key='a_chips',vars={total}} }
      end
    end
  end
})

-- n257: Daft Punk
SMODS.Joker({
  key = "n257",
  loc_txt = { name = "Daft Punk", text = { "Alternates: {C:chips}+50{} Chips", "then {X:mult,C:white}X2{} each hand" } },
  config = { extra = { flip = 0 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 5 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local f = card.ability.extra.flip
      card.ability.extra.flip = 1 - f
      if f == 0 then
        return { chips = 50, message = localize{type='variable',key='a_chips',vars={50}} }
      else
        return { Xmult = 2, message = localize{type='variable',key='a_xmult',vars={2}} }
      end
    end
  end
})

-- n258: The Crocodile Hunter
SMODS.Joker({
  key = "n258",
  loc_txt = { name = "Croc Hunter", text = { "{C:mult}+5{} Mult for each", "Club or Spade in hand" } },
  config = { mult = 5 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 5 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local cnt = 0
      for _, c in ipairs(G.hand.cards) do
        local s = c.base.suit
        if s == "Clubs" or s == "Spades" then cnt = cnt + 1 end
      end
      local total = cnt * 5
      if total > 0 then
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n259: Sims
SMODS.Joker({
  key = "n259",
  loc_txt = { name = "The Sims", text = { "Gains {C:chips}+5{} Chips each", "round, max 50 (#1# now)" } },
  config = { extra = { chips = 0, max = 50 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 5 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.extra.chips < card.ability.extra.max then
        card.ability.extra.chips = math.min(card.ability.extra.max, card.ability.extra.chips + 5)
        return { message = localize{type='variable',key='a_chips',vars={5}} }
      end
    end
    if context.joker_main and card.ability.extra.chips > 0 then
      return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
    end
  end
})

-- n260: Grand Theft Auto
SMODS.Joker({
  key = "n260",
  loc_txt = { name = "Grand Theft Auto", text = { "{X:mult,C:white}X2{} Mult if hand", "contains a 7" } },
  config = {},
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 5 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      for _, c in ipairs(G.play.cards) do
        if c.base.value == "7" then
          return { Xmult = 2, message = localize{type='variable',key='a_xmult',vars={2}} }
        end
      end
    end
  end
})

-- n261: Fidget Spinner
SMODS.Joker({
  key = "n261",
  loc_txt = { name = "Fidget Spinner", text = { "Cycles through suits:", "each scored card earns {C:chips}+15{} Chips" } },
  config = { chips = 15 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 6 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      return { chips = 15, message = localize{type='variable',key='a_chips',vars={15}} }
    end
  end
})

-- n262: Guitar Hero
SMODS.Joker({
  key = "n262",
  loc_txt = { name = "Guitar Hero", text = { "{C:mult}+3{} Mult for each", "consecutive rank in hand" } },
  config = { mult = 3 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 6 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local rank_map = {["2"]=2,["3"]=3,["4"]=4,["5"]=5,["6"]=6,["7"]=7,["8"]=8,["9"]=9,["10"]=10,["Jack"]=11,["Queen"]=12,["King"]=13,["Ace"]=14}
      local ranks = {}
      for _, c in ipairs(G.play.cards) do
        local r = rank_map[c.base.value]
        if r then ranks[#ranks+1] = r end
      end
      table.sort(ranks)
      local consec = 1
      local max_consec = 1
      for i = 2, #ranks do
        if ranks[i] == ranks[i-1] + 1 then
          consec = consec + 1
          if consec > max_consec then max_consec = consec end
        else
          consec = 1
        end
      end
      local total = max_consec * 3
      if total > 0 then
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n263: Britney 2.0
SMODS.Joker({
  key = "n263",
  loc_txt = { name = "Oops I Did It Again", text = { "Gains {C:mult}+3{} Mult whenever", "a hand is replayed (#1# now)" } },
  config = { extra = { mult = 0 } },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 6 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.repetition then
      card.ability.extra.mult = card.ability.extra.mult + 3
      return { message = localize{type='variable',key='a_mult',vars={3}} }
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n264: Winamp
SMODS.Joker({
  key = "n264",
  loc_txt = { name = "Winamp", text = { "{C:chips}+5{} Chips for each", "card in scored hand" } },
  config = { chips = 5 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 6 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      return { chips = 5, message = localize{type='variable',key='a_chips',vars={5}} }
    end
  end
})

-- n265: Quake
SMODS.Joker({
  key = "n265",
  loc_txt = { name = "Quake", text = { "{X:mult,C:white}X2{} Mult if hand", "contains only number cards" } },
  config = {},
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 6 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local all_num = true
      for _, c in ipairs(G.play.cards) do
        local v = c.base.value
        if v == "Jack" or v == "Queen" or v == "King" or v == "Ace" then
          all_num = false; break
        end
      end
      if all_num and #G.play.cards > 0 then
        return { Xmult = 2, message = localize{type='variable',key='a_xmult',vars={2}} }
      end
    end
  end
})

-- n266: Neopets
SMODS.Joker({
  key = "n266",
  loc_txt = { name = "Neopets", text = { "Gains {C:chips}+2{} Chips each hand,", "loses {C:attention}1{} each round (#1# now)" } },
  config = { extra = { chips = 0 } },
  rarity = 2, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 6 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips = math.max(0, card.ability.extra.chips - 1)
    end
    if context.joker_main then
      card.ability.extra.chips = card.ability.extra.chips + 2
      return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
    end
  end
})

-- n267: Who Let the Dogs Out
SMODS.Joker({
  key = "n267",
  loc_txt = { name = "Who Let Dogs Out", text = { "{C:mult}+20{} Mult if", "no cards remain in hand" } },
  config = { mult = 20 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 6 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.hand.cards == 0 then
        return { mult = 20, message = localize{type='variable',key='a_mult',vars={20}} }
      end
    end
  end
})

-- n268: Livestrong
SMODS.Joker({
  key = "n268",
  loc_txt = { name = "Livestrong", text = { "{C:chips}+7{} Chips for each", "Ace or 5 scored" } },
  config = { chips = 7 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 6 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local v = context.other_card.base.value
      if v == "Ace" or v == "5" then
        return { chips = 7, message = localize{type='variable',key='a_chips',vars={7}} }
      end
    end
  end
})

-- n269: Mini Disc
SMODS.Joker({
  key = "n269",
  loc_txt = { name = "MiniDisc", text = { "{C:mult}+10{} Mult if hand size", "is exactly 3 cards" } },
  config = { mult = 10 },
  rarity = 2, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 6 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.play.cards == 3 then
        return { mult = 10, message = localize{type='variable',key='a_mult',vars={10}} }
      end
    end
  end
})

-- n270: MSN Messenger
SMODS.Joker({
  key = "n270",
  loc_txt = { name = "MSN Messenger", text = { "Gains {C:mult}+2{} Mult each", "round up to 10 rounds (#1# now)" } },
  config = { extra = { mult = 0, rounds = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 6 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.extra.rounds < 10 then
        card.ability.extra.rounds = card.ability.extra.rounds + 1
        card.ability.extra.mult = card.ability.extra.mult + 2
        return { message = localize{type='variable',key='a_mult',vars={2}} }
      end
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n271: Scrunchie
SMODS.Joker({
  key = "n271",
  loc_txt = { name = "Scrunchie", text = { "{C:chips}+20{} Chips if all", "played cards are red" } },
  config = { chips = 20 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 7 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local all_red = true
      for _, c in ipairs(G.play.cards) do
        local s = c.base.suit
        if s ~= "Hearts" and s ~= "Diamonds" then all_red = false; break end
      end
      if all_red and #G.play.cards > 0 then
        return { chips = 20, message = localize{type='variable',key='a_chips',vars={20}} }
      end
    end
  end
})

-- n272: Poke Ball
SMODS.Joker({
  key = "n272",
  loc_txt = { name = "Poke Ball", text = { "{C:mult}+5{} Mult for each", "pair in scored hand" } },
  config = { mult = 5 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 7 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local counts = {}
      for _, c in ipairs(G.play.cards) do
        local v = c.base.value
        counts[v] = (counts[v] or 0) + 1
      end
      local pairs_found = 0
      for _, cnt in pairs(counts) do
        if cnt >= 2 then pairs_found = pairs_found + math.floor(cnt / 2) end
      end
      local total = pairs_found * 5
      if total > 0 then
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n273: Sega Dreamcast
SMODS.Joker({
  key = "n273",
  loc_txt = { name = "Sega Dreamcast", text = { "{X:mult,C:white}X1.5{} Mult if hand", "contains a 9 or 10" } },
  config = {},
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 7 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      for _, c in ipairs(G.play.cards) do
        if c.base.value == "9" or c.base.value == "10" then
          return { Xmult = 1.5, message = localize{type='variable',key='a_xmult',vars={1.5}} }
        end
      end
    end
  end
})

-- n274: Ring Toss
SMODS.Joker({
  key = "n274",
  loc_txt = { name = "Ring Toss", text = { "{C:chips}+12{} Chips for each", "8 in scored hand" } },
  config = { chips = 12 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 7 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value == "8" then
        return { chips = 12, message = localize{type='variable',key='a_chips',vars={12}} }
      end
    end
  end
})

-- n275: Reality TV
SMODS.Joker({
  key = "n275",
  loc_txt = { name = "Reality TV", text = { "{C:mult}+6{} Mult for each", "Queen scored" } },
  config = { mult = 6 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 7 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value == "Queen" then
        return { mult = 6, message = localize{type='variable',key='a_mult',vars={6}} }
      end
    end
  end
})

-- n276: Rollerblades
SMODS.Joker({
  key = "n276",
  loc_txt = { name = "Rollerblades", text = { "{C:chips}+5{} Chips per card,", "double if Straight or Flush" } },
  config = { chips = 5 },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 7 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local base = #G.play.cards * 5
      local hand_name = G.GAME.last_hand_played or ""
      if hand_name == "Straight" or hand_name == "Flush" or hand_name == "Straight Flush" or hand_name == "Royal Flush" then
        base = base * 2
      end
      return { chips = base, message = localize{type='variable',key='a_chips',vars={base}} }
    end
  end
})

-- n277: Tamagotchi 2.0
SMODS.Joker({
  key = "n277",
  loc_txt = { name = "Digimon", text = { "Gains {C:mult}+1{} Mult each hand,", "resets if hand is lost (#1# now)" } },
  config = { extra = { mult = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 7 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME.current_round and G.GAME.current_round.hands_left == 0 then
        card.ability.extra.mult = 0
        return { message = "Reset!" }
      end
    end
    if context.joker_main then
      card.ability.extra.mult = card.ability.extra.mult + 1
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n278: CD-ROM
SMODS.Joker({
  key = "n278",
  loc_txt = { name = "CD-ROM", text = { "{C:chips}+30{} Chips when first", "hand is played each round" } },
  config = { extra = { used = false, chips = 30 } },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 7 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.used = false
    end
    if context.joker_main then
      if not card.ability.extra.used then
        card.ability.extra.used = true
        return { chips = 30, message = localize{type='variable',key='a_chips',vars={30}} }
      end
    end
  end
})

-- n279: Bag Phone
SMODS.Joker({
  key = "n279",
  loc_txt = { name = "Bag Phone", text = { "{C:chips}+100{} Chips but only", "{C:attention}1{} hand per round" } },
  config = { chips = 100 },
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 7 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.m_hand_size
    return { vars = {} }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return { chips = 100, message = localize{type='variable',key='a_chips',vars={100}} }
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = math.max(1, (G.GAME.round_resets.hands or 4) - 3)
    if G.GAME.current_round then
      G.GAME.current_round.hands_left = math.max(0, G.GAME.current_round.hands_left - 3)
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = (G.GAME.round_resets.hands or 1) + 3
    if G.GAME.current_round then
      G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + 3
    end
  end
})

-- n280: Super Soaker
SMODS.Joker({
  key = "n280",
  loc_txt = { name = "Super Soaker", text = { "{C:chips}+5{} Chips for each", "card discarded this round" } },
  config = { extra = { chips_per = 5 } },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 7 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local discarded = (G.GAME.current_round.discards_used or 0) * G.GAME.round_resets.discards
      local cnt = G.GAME.round_resets.discards - G.GAME.current_round.discards_left
      local total = cnt * 5
      if total > 0 then
        return { chips = total, message = localize{type='variable',key='a_chips',vars={total}} }
      end
    end
  end
})

-- n281: Zack Morris Phone
SMODS.Joker({
  key = "n281",
  loc_txt = { name = "Zack Morris Phone", text = { "{C:mult}+12{} Mult but only", "if 1 hand remains" } },
  config = { mult = 12 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 8 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.current_round.hands_left <= 1 then
        return { mult = 12, message = localize{type='variable',key='a_mult',vars={12}} }
      end
    end
  end
})

-- n282: WWF Wrestling
SMODS.Joker({
  key = "n282",
  loc_txt = { name = "WWF Wrestling", text = { "{C:mult}+8{} Mult for each", "Jack scored" } },
  config = { mult = 8 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 8 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value == "Jack" then
        return { mult = 8, message = localize{type='variable',key='a_mult',vars={8}} }
      end
    end
  end
})

-- n283: Giga Pet
SMODS.Joker({
  key = "n283",
  loc_txt = { name = "Giga Pet", text = { "Gains {C:chips}+1{} Chips each hand,", "loses 2 each round (#1# now)" } },
  config = { extra = { chips = 0 } },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 8 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips = math.max(0, card.ability.extra.chips - 2)
    end
    if context.joker_main then
      card.ability.extra.chips = card.ability.extra.chips + 1
      return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
    end
  end
})

-- n284: Gameboy Advance
SMODS.Joker({
  key = "n284",
  loc_txt = { name = "Gameboy Advance", text = { "{C:mult}+5{} Mult, gains", "{C:mult}+1{} each win (#1# now)" } },
  config = { extra = { mult = 5 } },
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 8 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult = card.ability.extra.mult + 1
      return { message = localize{type='variable',key='a_mult',vars={1}} }
    end
    if context.joker_main then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n285: MTV
SMODS.Joker({
  key = "n285",
  loc_txt = { name = "MTV", text = { "{X:mult,C:white}X2{} Mult if", "3+ jokers are owned" } },
  config = {},
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 8 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.jokers.cards >= 3 then
        return { Xmult = 2, message = localize{type='variable',key='a_xmult',vars={2}} }
      end
    end
  end
})

-- n286: Nokia 3310
SMODS.Joker({
  key = "n286",
  loc_txt = { name = "Nokia 3310", text = { "{C:chips}+50{} Chips;", "unbreakable - never destroyed" } },
  config = { chips = 50 },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 8 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      return { chips = 50, message = localize{type='variable',key='a_chips',vars={50}} }
    end
  end
})

-- n287: Walkman
SMODS.Joker({
  key = "n287",
  loc_txt = { name = "Walkman", text = { "{C:mult}+2{} Mult for each", "card remaining in hand" } },
  config = { mult = 2 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 8 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local total = #G.hand.cards * 2
      if total > 0 then
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n288: Toy Story
SMODS.Joker({
  key = "n288",
  loc_txt = { name = "Toy Story", text = { "{C:mult}+4{} Mult for each", "card in your hand" } },
  config = { mult = 4 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 8 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local total = #G.hand.cards * 4
      return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
    end
  end
})

-- n289: Goosebumps
SMODS.Joker({
  key = "n289",
  loc_txt = { name = "Goosebumps", text = { "{C:mult}+3{} Mult for each", "Spade or Club in hand" } },
  config = { mult = 3 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 8 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local cnt = 0
      for _, c in ipairs(G.hand.cards) do
        local s = c.base.suit
        if s == "Spades" or s == "Clubs" then cnt = cnt + 1 end
      end
      local total = cnt * 3
      if total > 0 then
        return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
      end
    end
  end
})

-- n290: Floppy Disk
SMODS.Joker({
  key = "n290",
  loc_txt = { name = "Floppy Disk", text = { "{C:chips}+1{} Chips per card value", "saved (saved = highest in hand)" } },
  config = { extra = { chips = 0 } },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 8 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      local rank_map = {["2"]=2,["3"]=3,["4"]=4,["5"]=5,["6"]=6,["7"]=7,["8"]=8,["9"]=9,["10"]=10,["Jack"]=11,["Queen"]=12,["King"]=13,["Ace"]=14}
      local max_rank = 0
      for _, c in ipairs(G.hand.cards) do
        local r = rank_map[c.base.value] or 0
        if r > max_rank then max_rank = r end
      end
      card.ability.extra.chips = card.ability.extra.chips + max_rank
      return { message = localize{type='variable',key='a_chips',vars={max_rank}} }
    end
    if context.joker_main and card.ability.extra.chips > 0 then
      return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
    end
  end
})

-- n291: Phat Pants
SMODS.Joker({
  key = "n291",
  loc_txt = { name = "Phat Pants", text = { "{C:chips}+15{} Chips if hand", "has 4 or more cards" } },
  config = { chips = 15 },
  rarity = 1, cost = 4,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 0, y = 9 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.play.cards >= 4 then
        return { chips = 15, message = localize{type='variable',key='a_chips',vars={15}} }
      end
    end
  end
})

-- n292: Criss Cross Applesauce
SMODS.Joker({
  key = "n292",
  loc_txt = { name = "Criss Cross", text = { "{X:mult,C:white}X2{} Mult if scored", "cards alternate red/black" } },
  config = {},
  rarity = 3, cost = 8,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 1, y = 9 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local cards = G.play.cards
      if #cards < 2 then return end
      local alternates = true
      for i = 2, #cards do
        local prev = cards[i-1].base.suit
        local curr = cards[i].base.suit
        local prev_red = (prev == "Hearts" or prev == "Diamonds")
        local curr_red = (curr == "Hearts" or curr == "Diamonds")
        if prev_red == curr_red then alternates = false; break end
      end
      if alternates then
        return { Xmult = 2, message = localize{type='variable',key='a_xmult',vars={2}} }
      end
    end
  end
})

-- n293: Razor Scooter
SMODS.Joker({
  key = "n293",
  loc_txt = { name = "Razor Scooter", text = { "{C:mult}+10{} Mult if hand", "is 1 or 2 cards" } },
  config = { mult = 10 },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 2, y = 9 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.play.cards <= 2 then
        return { mult = 10, message = localize{type='variable',key='a_mult',vars={10}} }
      end
    end
  end
})

-- n294: Tamagotchi Angel
SMODS.Joker({
  key = "n294",
  loc_txt = { name = "Angel Tamagotchi", text = { "Each scored Ace gives", "{C:mult}+5{} Mult permanently (#1# now)" } },
  config = { extra = { mult = 0 } },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 3, y = 9 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.mult } } end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.base.value == "Ace" then
        card.ability.extra.mult = card.ability.extra.mult + 5
        return { mult = 5, message = localize{type='variable',key='a_mult',vars={5}} }
      end
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult, message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}} }
    end
  end
})

-- n295: Pokémon Stadium
SMODS.Joker({
  key = "n295",
  loc_txt = { name = "Pokemon Stadium", text = { "{X:mult,C:white}X3{} Mult if scored", "hand is Full House" } },
  config = {},
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 4, y = 9 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if G.GAME.last_hand_played == "Full House" then
        return { Xmult = 3, message = localize{type='variable',key='a_xmult',vars={3}} }
      end
    end
  end
})

-- n296: Hamster Dance
SMODS.Joker({
  key = "n296",
  loc_txt = { name = "Hamster Dance", text = { "Each hand: {C:mult}+1{} Mult for", "each hand played this round" } },
  config = { mult = 1 },
  rarity = 1, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 5, y = 9 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local hands_played = G.GAME.current_round.hands_played or 0
      local total = (hands_played + 1) * 1
      return { mult = total, message = localize{type='variable',key='a_mult',vars={total}} }
    end
  end
})

-- n297: Under Construction
SMODS.Joker({
  key = "n297",
  loc_txt = { name = "Under Construction", text = { "Gains {C:chips}+10{} Chips each", "round, no cap (#1# now)" } },
  config = { extra = { chips = 0 } },
  rarity = 2, cost = 6,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 6, y = 9 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.chips } } end,
  calculate = function(self, card, context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips = card.ability.extra.chips + 10
      return { message = localize{type='variable',key='a_chips',vars={10}} }
    end
    if context.joker_main and card.ability.extra.chips > 0 then
      return { chips = card.ability.extra.chips, message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}} }
    end
  end
})

-- n298: Dance Dance Revolution
SMODS.Joker({
  key = "n298",
  loc_txt = { name = "Dance Dance Revolution", text = { "{X:mult,C:white}X2{} Mult if at least", "4 cards are scored" } },
  config = {},
  rarity = 2, cost = 7,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 7, y = 9 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      if #G.play.cards >= 4 then
        return { Xmult = 2, message = localize{type='variable',key='a_xmult',vars={2}} }
      end
    end
  end
})

-- n299: Chicken Noodle Soup
SMODS.Joker({
  key = "n299",
  loc_txt = { name = "Chicken Soup", text = { "{C:chips}+25{} Chips if all", "scored cards are different" } },
  config = { chips = 25 },
  rarity = 2, cost = 5,
  unlocked = true, discovered = true,
  blueprint_compat = true, eternal_compat = true, perishable_compat = true,
  pos = { x = 8, y = 9 }, atlas = "cm_atlas_03",
  calculate = function(self, card, context)
    if context.joker_main then
      local vals = {}
      local all_diff = true
      for _, c in ipairs(G.play.cards) do
        local v = c.base.value
        if vals[v] then all_diff = false; break end
        vals[v] = true
      end
      if all_diff and #G.play.cards > 0 then
        return { chips = 25, message = localize{type='variable',key='a_chips',vars={25}} }
      end
    end
  end
})

-- n300: Total Recall
SMODS.Joker({
  key = "n300",
  loc_txt = { name = "Total Recall", text = { "Remembers highest chip score.", "{X:mult,C:white}X2{} if beaten (#1#)" } },
  config = { extra = { best = 0 } },
  rarity = 3, cost = 9,
  unlocked = true, discovered = true,
  blueprint_compat = false, eternal_compat = true, perishable_compat = true,
  pos = { x = 9, y = 9 }, atlas = "cm_atlas_03",
  loc_vars = function(self, info_queue, center) return { vars = { center.ability.extra.best } } end,
  calculate = function(self, card, context)
    if context.joker_main then
      local current = G.GAME.chips or 0
      if current > card.ability.extra.best then
        card.ability.extra.best = current
        return { Xmult = 2, message = localize{type='variable',key='a_xmult',vars={2}} }
      end
    end
  end
})
