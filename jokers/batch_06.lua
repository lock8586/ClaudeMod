-- ClaudeMod Batch 06: Nature & Animals (n501-n600)

-- n501 Chameleon (Uncommon) - Copies the mult bonus of the joker to its left
SMODS.Joker({ key="n501", loc_txt={name="Chameleon",text={"Copies the {C:mult}+Mult{}","of the Joker to its left"}}, config={extra={last_mult=0}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=0}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local idx = nil
      for i,j in ipairs(G.jokers.cards) do if j==card then idx=i break end end
      if idx and idx>1 then
        local left=G.jokers.cards[idx-1]
        local m=left.ability.mult or 0
        if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
      end
    end
  end })

-- n502 Migration (Common) - Gains +1 Mult each blind (animals on the move)
SMODS.Joker({ key="n502", loc_txt={name="Migration",text={"{C:mult}+#1#{} Mult","gains {C:mult}+1{} Mult each blind"}}, config={extra={val=0}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=1,y=0}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local m=card.ability.extra.val
      if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val=card.ability.extra.val+1
      card:juice_up(0.5,0.5)
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.val}} end })

-- n503 Hibernation (Common) - Gains +25 Chips per shop skipped
SMODS.Joker({ key="n503", loc_txt={name="Hibernation",text={"{C:chips}+#1#{} Chips","gains {C:chips}+25{} Chips","per shop skipped"}}, config={extra={val=0}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=0}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local c=card.ability.extra.val
      if c>0 then return {chips=c,message=localize{type='variable',key='a_chips',vars={c}}} end
    end
    if context.skipping_booster then
      card.ability.extra.val=card.ability.extra.val+25
      card:juice_up(0.5,0.5)
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.val}} end })

-- n504 Alpha Wolf (Uncommon) - +4 Mult per Joker to its right
SMODS.Joker({ key="n504", loc_txt={name="Alpha Wolf",text={"{C:mult}+4{} Mult for each","Joker to the right"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=0}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local idx=nil
      for i,j in ipairs(G.jokers.cards) do if j==card then idx=i break end end
      if idx then
        local count=#G.jokers.cards-idx
        if count>0 then
          local m=count*4
          return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}}
        end
      end
    end
  end })

-- n505 Salmon Run (Common) - +15 Chips per card played beyond 3
SMODS.Joker({ key="n505", loc_txt={name="Salmon Run",text={"{C:chips}+15{} Chips per card","played beyond the first 3"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=0}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local played=#context.scoring_hand
      local extra=played-3
      if extra>0 then
        local c=extra*15
        return {chips=c,message=localize{type='variable',key='a_chips',vars={c}}}
      end
    end
  end })

-- n506 Octopus (Uncommon) - Triggers once per suit in scoring hand (up to 4x)
SMODS.Joker({ key="n506", loc_txt={name="Octopus",text={"Retriggers once for","each {C:attention}suit{} in played hand","(up to {C:attention}4{} times)"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=5,y=0}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local suits={Spades=false,Hearts=false,Clubs=false,Diamonds=false}
      for _,c in ipairs(context.scoring_hand) do
        for s,_ in pairs(suits) do if c.base.suit==s then suits[s]=true end end
      end
      local count=0
      for _,v in pairs(suits) do if v then count=count+1 end end
      if count>0 then return {repetitions=count} end
    end
  end })

-- n507 Honeybee (Common) - +20 Chips per Heart card scored
SMODS.Joker({ key="n507", loc_txt={name="Honeybee",text={"{C:chips}+20{} Chips for each","scored {C:hearts}Heart{} card"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=0}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=="Hearts" then
        return {chips=20,message=localize{type='variable',key='a_chips',vars={20}}}
      end
    end
  end })

-- n508 Firefly (Common) - Gives X2 Mult on even-numbered hands this round
SMODS.Joker({ key="n508", loc_txt={name="Firefly",text={"{X:mult,C:white}X2{} Mult on","even-numbered hands this round"}}, config={extra={hand_count=0}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=7,y=0}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      card.ability.extra.hand_count=card.ability.extra.hand_count+1
      if card.ability.extra.hand_count%2==0 then
        return {Xmult=2,message=localize{type='variable',key='a_xmult',vars={2}}}
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.hand_count=0
    end
  end })

-- n509 Glacier (Common) - Gains +8 Chips per ante survived
SMODS.Joker({ key="n509", loc_txt={name="Glacier",text={"{C:chips}+#1#{} Chips","gains {C:chips}+8{} Chips","per ante survived"}}, config={extra={val=0}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=8,y=0}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local c=card.ability.extra.val
      if c>0 then return {chips=c,message=localize{type='variable',key='a_chips',vars={c}}} end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME.blind.boss then
        card.ability.extra.val=card.ability.extra.val+8
        card:juice_up(0.5,0.5)
      end
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.val}} end })

-- n510 Earthquake (Uncommon) - +15 Mult, destroys the lowest chip card in hand
SMODS.Joker({ key="n510", loc_txt={name="Earthquake",text={"{C:mult}+15{} Mult","Destroys the lowest","chip card in hand"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=0}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local lowest=nil
      local lowest_chips=math.huge
      for _,c in ipairs(G.hand.cards) do
        local ch=c.base.nominal or 0
        if ch<lowest_chips then lowest_chips=ch;lowest=c end
      end
      if lowest then
        G.E_MANAGER:add_event(Event({func=function()
          lowest:start_dissolve(nil,true)
          return true
        end}))
      end
      return {mult=15,message=localize{type='variable',key='a_mult',vars={15}}}
    end
  end })

-- n511 Volcano (Uncommon) - Builds up over 3 rounds, then erupts for X3 Mult
SMODS.Joker({ key="n511", loc_txt={name="Volcano",text={"Builds up each round","Erupts for {X:mult,C:white}X3{} Mult","every {C:attention}3{} rounds ({C:attention}#1#{} built)"}}, config={extra={buildup=0}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=1}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if card.ability.extra.buildup>=3 then
        return {Xmult=3,message=localize{type='variable',key='a_xmult',vars={3}}}
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.buildup=card.ability.extra.buildup+1
      if card.ability.extra.buildup>=3 then card.ability.extra.buildup=0 end
      card:juice_up(0.5,0.5)
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.buildup}} end })

-- n512 Hurricane (Rare) - Discard hand draw new, X2 Mult (once per round)
SMODS.Joker({ key="n512", loc_txt={name="Hurricane",text={"Once per round: discard hand,","draw a new hand,","{X:mult,C:white}X2{} Mult"}}, config={extra={used=false}}, rarity=3, cost=10, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=1,y=1}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main and not card.ability.extra.used then
      card.ability.extra.used=true
      G.E_MANAGER:add_event(Event({func=function()
        for _,c in ipairs(G.hand.cards) do G.hand:remove_card(c);c:remove() end
        G.FUNCS.draw_from_deck_to_hand()
        return true
      end}))
      return {Xmult=2,message=localize{type='variable',key='a_xmult',vars={2}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.used=false
    end
  end })

-- n513 Tide (Common) - +30 Chips when playing exactly 5 cards
SMODS.Joker({ key="n513", loc_txt={name="Tide",text={"{C:chips}+30{} Chips when playing","exactly {C:attention}5{} cards"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=1}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand==5 then
        return {chips=30,message=localize{type='variable',key='a_chips',vars={30}}}
      end
    end
  end })

-- n514 Photosynthesis (Common) - Gains +5 Chips each round
SMODS.Joker({ key="n514", loc_txt={name="Photosynthesis",text={"{C:chips}+#1#{} Chips","gains {C:chips}+5{} Chips each round"}}, config={extra={val=0}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=3,y=1}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local c=card.ability.extra.val
      if c>0 then return {chips=c,message=localize{type='variable',key='a_chips',vars={c}}} end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val=card.ability.extra.val+5
      card:juice_up(0.5,0.5)
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.val}} end })

-- n515 Caterpillar (Common) - +1 Mult before ante 4, +3 Xmult after
SMODS.Joker({ key="n515", loc_txt={name="Caterpillar",text={"{C:attention}Ante 1-3:{} {C:mult}+1{} Mult","{C:attention}Ante 4+:{} {X:mult,C:white}X3{} Mult","(transforms at ante 4)"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=1}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local ante=G.GAME.round_resets.ante or 1
      if ante<4 then
        return {mult=1,message=localize{type='variable',key='a_mult',vars={1}}}
      else
        return {Xmult=3,message=localize{type='variable',key='a_xmult',vars={3}}}
      end
    end
  end })

-- n516 Leopard (Common) - +35 Chips for High Card hands
SMODS.Joker({ key="n516", loc_txt={name="Leopard",text={"{C:chips}+35{} Chips if played","hand is {C:attention}High Card"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=1}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if G.GAME.hands[context.scoring_name] and context.scoring_name=="High Card" then
        return {chips=35,message=localize{type='variable',key='a_chips',vars={35}}}
      end
    end
  end })

-- n517 Elephant (Uncommon) - +4 Mult per Joker sold this run
SMODS.Joker({ key="n517", loc_txt={name="Elephant",text={"{C:mult}+4{} Mult per Joker","sold this run ({C:attention}#1#{} sold)"}}, config={extra={sold=0}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=6,y=1}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local m=card.ability.extra.sold*4
      if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
    end
    if context.selling_card and context.selling_card~=card then
      if context.selling_card.config.center and context.selling_card.config.center.set=="Joker" then
        card.ability.extra.sold=card.ability.extra.sold+1
      end
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.sold}} end })

-- n518 Peacock (Uncommon) - +12 Mult if all 4 suits in played hand
SMODS.Joker({ key="n518", loc_txt={name="Peacock",text={"{C:mult}+12{} Mult if played hand","contains all {C:attention}4 suits"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=1}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local suits={Spades=false,Hearts=false,Clubs=false,Diamonds=false}
      for _,c in ipairs(context.scoring_hand) do
        for s,_ in pairs(suits) do if c.base.suit==s then suits[s]=true end end
      end
      local all=true
      for _,v in pairs(suits) do if not v then all=false break end end
      if all then return {mult=12,message=localize{type='variable',key='a_mult',vars={12}}} end
    end
  end })

-- n519 Penguin (Common) - +3 Mult in antes 5+
SMODS.Joker({ key="n519", loc_txt={name="Penguin",text={"{C:mult}+3{} Mult in antes {C:attention}5+{}","(thrives in the cold)"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=1}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local ante=G.GAME.round_resets.ante or 1
      if ante>=5 then
        return {mult=3,message=localize{type='variable',key='a_mult',vars={3}}}
      end
    end
  end })

-- n520 Crow (Common) - +3 Chips per card remaining in hand after scoring
SMODS.Joker({ key="n520", loc_txt={name="Crow",text={"{C:chips}+3{} Chips per card","remaining in hand after playing"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=1}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local remaining=#G.hand.cards
      if remaining>0 then
        local c=remaining*3
        return {chips=c,message=localize{type='variable',key='a_chips',vars={c}}}
      end
    end
  end })

-- n521 Shark (Uncommon) - X2 Mult on the first hand of each blind
SMODS.Joker({ key="n521", loc_txt={name="Shark",text={"{X:mult,C:white}X2{} Mult on the","first hand of each blind"}}, config={extra={first=true}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=2}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if card.ability.extra.first then
        card.ability.extra.first=false
        return {Xmult=2,message=localize{type='variable',key='a_xmult',vars={2}}}
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.first=true
    end
  end })

-- n522 Coral Reef (Common) - +5 Chips per Club card scored
SMODS.Joker({ key="n522", loc_txt={name="Coral Reef",text={"{C:chips}+5{} Chips for each","scored {C:clubs}Club{} card"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=2}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=="Clubs" then
        return {chips=5,message=localize{type='variable',key='a_chips',vars={5}}}
      end
    end
  end })

-- n523 Tornado (Rare) - Shuffles jokers each round, +2 Mult per joker
SMODS.Joker({ key="n523", loc_txt={name="Tornado",text={"{C:mult}+2{} Mult per Joker owned","Shuffles joker order each round"}}, config={}, rarity=3, cost=10, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=2}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local m=#G.jokers.cards*2
      if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      local cards=G.jokers.cards
      for i=#cards,2,-1 do
        local j=math.random(i)
        cards[i],cards[j]=cards[j],cards[i]
      end
      G.jokers:reorder()
    end
  end })

-- n524 Firefly Swarm (Common) - +12 Mult if you played more than 3 hands this round
SMODS.Joker({ key="n524", loc_txt={name="Firefly Swarm",text={"{C:mult}+12{} Mult if you've played","more than {C:attention}3{} hands this round"}}, config={extra={hands=0}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=3,y=2}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      card.ability.extra.hands=card.ability.extra.hands+1
      if card.ability.extra.hands>3 then
        return {mult=12,message=localize{type='variable',key='a_mult',vars={12}}}
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.hands=0
    end
  end })

-- n525 Turtle (Common) - +10 Chips, +1 Chips each round (slow and steady)
SMODS.Joker({ key="n525", loc_txt={name="Turtle",text={"{C:chips}+#1#{} Chips","gains {C:chips}+1{} Chips each round"}}, config={extra={val=10}}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=4,y=2}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      return {chips=card.ability.extra.val,message=localize{type='variable',key='a_chips',vars={card.ability.extra.val}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val=card.ability.extra.val+1
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.val}} end })

-- n526 Eagle Eye (Common) - +20 Chips for face cards scored
SMODS.Joker({ key="n526", loc_txt={name="Eagle Eye",text={"{C:chips}+20{} Chips for each","scored {C:attention}face card"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=2}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=="Jack" or v=="Queen" or v=="King" then
        return {chips=20,message=localize{type='variable',key='a_chips',vars={20}}}
      end
    end
  end })

-- n527 Bear Claw (Common) - +8 Mult for scored Spade cards
SMODS.Joker({ key="n527", loc_txt={name="Bear Claw",text={"{C:mult}+8{} Mult for each","scored {C:spades}Spade{} card"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=2}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=="Spades" then
        return {mult=8,message=localize{type='variable',key='a_mult',vars={8}}}
      end
    end
  end })

-- n528 Fox (Common) - +5 Mult when playing 4 or fewer cards
SMODS.Joker({ key="n528", loc_txt={name="Fox",text={"{C:mult}+5{} Mult when playing","4 or fewer cards"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=2}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand<=4 then
        return {mult=5,message=localize{type='variable',key='a_mult',vars={5}}}
      end
    end
  end })

-- n529 Hummingbird (Common) - +15 Chips for Diamond cards scored
SMODS.Joker({ key="n529", loc_txt={name="Hummingbird",text={"{C:chips}+15{} Chips for each","scored {C:diamonds}Diamond{} card"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=2}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=="Diamonds" then
        return {chips=15,message=localize{type='variable',key='a_chips',vars={15}}}
      end
    end
  end })

-- n530 Bison (Common) - +4 Mult when playing 5 cards
SMODS.Joker({ key="n530", loc_txt={name="Bison",text={"{C:mult}+4{} Mult when playing","exactly {C:attention}5{} cards"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=2}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand==5 then
        return {mult=4,message=localize{type='variable',key='a_mult',vars={4}}}
      end
    end
  end })

-- n531 Dragonfly (Common) - +25 Chips for Aces scored
SMODS.Joker({ key="n531", loc_txt={name="Dragonfly",text={"{C:chips}+25{} Chips for each","scored {C:attention}Ace"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=3}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=="Ace" then
        return {chips=25,message=localize{type='variable',key='a_chips',vars={25}}}
      end
    end
  end })

-- n532 Mantis (Uncommon) - X1.5 Mult if only 1 card played
SMODS.Joker({ key="n532", loc_txt={name="Mantis",text={"{X:mult,C:white}X1.5{} Mult if","only {C:attention}1{} card was played"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=3}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand==1 then
        return {Xmult=1.5,message=localize{type='variable',key='a_xmult',vars={1.5}}}
      end
    end
  end })

-- n533 Grizzly (Uncommon) - +15 Mult but must play at least 4 cards
SMODS.Joker({ key="n533", loc_txt={name="Grizzly",text={"{C:mult}+15{} Mult when playing","at least {C:attention}4{} cards"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=3}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand>=4 then
        return {mult=15,message=localize{type='variable',key='a_mult',vars={15}}}
      end
    end
  end })

-- n534 Flamingo (Common) - +30 Chips if only Hearts and Diamonds played
SMODS.Joker({ key="n534", loc_txt={name="Flamingo",text={"{C:chips}+30{} Chips if only","{C:hearts}Hearts{} and {C:diamonds}Diamonds{} are played"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=3}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local ok=true
      for _,c in ipairs(context.scoring_hand) do
        if c.base.suit~="Hearts" and c.base.suit~="Diamonds" then ok=false break end
      end
      if ok then return {chips=30,message=localize{type='variable',key='a_chips',vars={30}}} end
    end
  end })

-- n535 Crocodile (Common) - +5 Chips for number cards (2-10) scored
SMODS.Joker({ key="n535", loc_txt={name="Crocodile",text={"{C:chips}+5{} Chips for each","scored number card (2-10)"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=3}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      local nums={"2","3","4","5","6","7","8","9","10"}
      for _,n in ipairs(nums) do
        if v==n then return {chips=5,message=localize{type='variable',key='a_chips',vars={5}}} end
      end
    end
  end })

-- n536 Spider Web (Common) - Gains +3 Mult each round (weaving the web)
SMODS.Joker({ key="n536", loc_txt={name="Spider Web",text={"{C:mult}+#1#{} Mult","gains {C:mult}+3{} Mult each round"}}, config={extra={val=0}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=5,y=3}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local m=card.ability.extra.val
      if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val=card.ability.extra.val+3
      card:juice_up(0.5,0.5)
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.val}} end })

-- n537 Coyote (Common) - +6 Mult if playing a Pair or Two Pair
SMODS.Joker({ key="n537", loc_txt={name="Coyote",text={"{C:mult}+6{} Mult when playing","a {C:attention}Pair{} or {C:attention}Two Pair"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=3}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local n=context.scoring_name
      if n=="Pair" or n=="Two Pair" then
        return {mult=6,message=localize{type='variable',key='a_mult',vars={6}}}
      end
    end
  end })

-- n538 Orca (Uncommon) - +8 Chips per card in played hand
SMODS.Joker({ key="n538", loc_txt={name="Orca",text={"{C:chips}+8{} Chips per card","in played hand"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=3}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local c=#context.scoring_hand*8
      if c>0 then return {chips=c,message=localize{type='variable',key='a_chips',vars={c}}} end
    end
  end })

-- n539 Moth (Common) - +10 Chips at night (hands 4+ this round)
SMODS.Joker({ key="n539", loc_txt={name="Moth",text={"{C:chips}+10{} Chips after the","4th hand played this round"}}, config={extra={hands=0}}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=8,y=3}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      card.ability.extra.hands=card.ability.extra.hands+1
      if card.ability.extra.hands>=4 then
        return {chips=10,message=localize{type='variable',key='a_chips',vars={10}}}
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.hands=0
    end
  end })

-- n540 Stag Beetle (Common) - +4 Mult for each Joker you own
SMODS.Joker({ key="n540", loc_txt={name="Stag Beetle",text={"{C:mult}+4{} Mult for each","Joker owned"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=3}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local m=#G.jokers.cards*4
      if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
    end
  end })

-- n541 Jellyfish (Common) - +10 Chips per discard remaining
SMODS.Joker({ key="n541", loc_txt={name="Jellyfish",text={"{C:chips}+10{} Chips per","discard remaining"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=4}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local discards=G.GAME.current_round.discards_left or 0
      local c=discards*10
      if c>0 then return {chips=c,message=localize{type='variable',key='a_chips',vars={c}}} end
    end
  end })

-- n542 Narwhal (Uncommon) - +20 Chips for each Ace in hand (not played)
SMODS.Joker({ key="n542", loc_txt={name="Narwhal",text={"{C:chips}+20{} Chips per {C:attention}Ace","held in hand (not played)"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=4}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(G.hand.cards) do
        if c.base.value=="Ace" then count=count+1 end
      end
      local ch=count*20
      if ch>0 then return {chips=ch,message=localize{type='variable',key='a_chips',vars={ch}}} end
    end
  end })

-- n543 Badger (Common) - +3 Mult per hand size above 5
SMODS.Joker({ key="n543", loc_txt={name="Badger",text={"{C:mult}+3{} Mult per hand size","above the base 5"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=4}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local hs=G.hand.config.hand_size or 8
      local extra=hs-5
      if extra>0 then
        local m=extra*3
        return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}}
      end
    end
  end })

-- n544 Heron (Common) - +25 Chips for scoring a straight
SMODS.Joker({ key="n544", loc_txt={name="Heron",text={"{C:chips}+25{} Chips when playing","a {C:attention}Straight{} or better"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=4}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local n=context.scoring_name
      if n=="Straight" or n=="Straight Flush" or n=="Royal Flush" then
        return {chips=25,message=localize{type='variable',key='a_chips',vars={25}}}
      end
    end
  end })

-- n545 Antler (Common) - +5 Mult for each King scored
SMODS.Joker({ key="n545", loc_txt={name="Antler",text={"{C:mult}+5{} Mult for each","scored {C:attention}King"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=4}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=="King" then
        return {mult=5,message=localize{type='variable',key='a_mult',vars={5}}}
      end
    end
  end })

-- n546 Clam (Common) - +5 Chips for each Queen scored
SMODS.Joker({ key="n546", loc_txt={name="Clam",text={"{C:chips}+5{} Chips for each","scored {C:attention}Queen"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=4}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=="Queen" then
        return {chips=5,message=localize{type='variable',key='a_chips',vars={5}}}
      end
    end
  end })

-- n547 Osprey (Uncommon) - +10 Mult for Flush hands
SMODS.Joker({ key="n547", loc_txt={name="Osprey",text={"{C:mult}+10{} Mult when playing","a {C:attention}Flush{} or better"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=4}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local n=context.scoring_name
      if n=="Flush" or n=="Full House" or n=="Straight Flush" or n=="Royal Flush" or n=="Flush Five" or n=="Flush House" then
        return {mult=10,message=localize{type='variable',key='a_mult',vars={10}}}
      end
    end
  end })

-- n548 Tapir (Common) - +6 Chips per card discarded this round
SMODS.Joker({ key="n548", loc_txt={name="Tapir",text={"{C:chips}+6{} Chips per card","discarded this round"}}, config={extra={discarded=0}}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=7,y=4}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local c=card.ability.extra.discarded*6
      if c>0 then return {chips=c,message=localize{type='variable',key='a_chips',vars={c}}} end
    end
    if context.discard then
      card.ability.extra.discarded=(card.ability.extra.discarded or 0)+(#context.discarded_cards or 1)
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.discarded=0
    end
  end })

-- n549 Python (Uncommon) - +3 Mult for each card in hand above 5
SMODS.Joker({ key="n549", loc_txt={name="Python",text={"{C:mult}+3{} Mult per card","in hand above 5"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=4}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local extra=#G.hand.cards-5
      if extra>0 then
        local m=extra*3
        return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}}
      end
    end
  end })

-- n550 Meerkat (Common) - +8 Chips, gives +2 to all Jokers to its right
SMODS.Joker({ key="n550", loc_txt={name="Meerkat",text={"{C:chips}+8{} Chips","(sentinel of the savanna)"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=4}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      return {chips=8,message=localize{type='variable',key='a_chips',vars={8}}}
    end
  end })

-- n551 Wildebeest (Common) - +2 Mult per round survived this ante
SMODS.Joker({ key="n551", loc_txt={name="Wildebeest",text={"{C:mult}+#1#{} Mult","gains {C:mult}+2{} per round this ante"}}, config={extra={val=0,ante=0}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=5}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local m=card.ability.extra.val
      if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      local ante=G.GAME.round_resets.ante or 1
      if ante~=card.ability.extra.ante then
        card.ability.extra.ante=ante
        card.ability.extra.val=0
      end
      card.ability.extra.val=card.ability.extra.val+2
      card:juice_up(0.5,0.5)
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.val}} end })

-- n552 Komodo Dragon (Uncommon) - +10 Mult for Full House
SMODS.Joker({ key="n552", loc_txt={name="Komodo Dragon",text={"{C:mult}+10{} Mult when playing","a {C:attention}Full House"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=5}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if context.scoring_name=="Full House" then
        return {mult=10,message=localize{type='variable',key='a_mult',vars={10}}}
      end
    end
  end })

-- n553 Manta Ray (Uncommon) - +20 Chips for each face card in hand
SMODS.Joker({ key="n553", loc_txt={name="Manta Ray",text={"{C:chips}+20{} Chips per face card","held in hand (not played)"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=5}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(G.hand.cards) do
        local v=c.base.value
        if v=="Jack" or v=="Queen" or v=="King" then count=count+1 end
      end
      local ch=count*20
      if ch>0 then return {chips=ch,message=localize{type='variable',key='a_chips',vars={ch}}} end
    end
  end })

-- n554 Pangolin (Common) - Retriggers number cards (2-9) once
SMODS.Joker({ key="n554", loc_txt={name="Pangolin",text={"Retriggers scored","number cards {C:attention}2-9{} once"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=3,y=5}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      local nums={"2","3","4","5","6","7","8","9"}
      for _,n in ipairs(nums) do
        if v==n then return {repetitions=1} end
      end
    end
  end })

-- n555 Lynx (Uncommon) - X1.5 Mult when playing 3 or fewer cards
SMODS.Joker({ key="n555", loc_txt={name="Lynx",text={"{X:mult,C:white}X1.5{} Mult when","playing {C:attention}3{} or fewer cards"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=5}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand<=3 then
        return {Xmult=1.5,message=localize{type='variable',key='a_xmult',vars={1.5}}}
      end
    end
  end })

-- n556 Starfish (Common) - +5 Chips per suit represented in played hand
SMODS.Joker({ key="n556", loc_txt={name="Starfish",text={"{C:chips}+5{} Chips per unique","suit in played hand"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=5}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local suits={}
      for _,c in ipairs(context.scoring_hand) do suits[c.base.suit]=true end
      local count=0
      for _ in pairs(suits) do count=count+1 end
      local ch=count*5
      if ch>0 then return {chips=ch,message=localize{type='variable',key='a_chips',vars={ch}}} end
    end
  end })

-- n557 Warthog (Common) - +3 Chips for each scored 3 through 7
SMODS.Joker({ key="n557", loc_txt={name="Warthog",text={"{C:chips}+3{} Chips for each","scored {C:attention}3,4,5,6,{} or {C:attention}7"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=5}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=="3" or v=="4" or v=="5" or v=="6" or v=="7" then
        return {chips=3,message=localize{type='variable',key='a_chips',vars={3}}}
      end
    end
  end })

-- n558 Platypus (Rare) - Scores both chips and mult equal to cards played x5
SMODS.Joker({ key="n558", loc_txt={name="Platypus",text={"Gains {C:chips}+Chips{} and {C:mult}+Mult{}","equal to cards played x{C:attention}5"}}, config={}, rarity=3, cost=10, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=5}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#context.scoring_hand*5
      return {chips=n,mult=n}
    end
  end })

-- n559 Blue Jay (Common) - +8 Chips for each Jack scored
SMODS.Joker({ key="n559", loc_txt={name="Blue Jay",text={"{C:chips}+8{} Chips for each","scored {C:attention}Jack"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=5}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=="Jack" then
        return {chips=8,message=localize{type='variable',key='a_chips',vars={8}}}
      end
    end
  end })

-- n560 Bull (Common) - +10 Chips per dollar above $10
SMODS.Joker({ key="n560", loc_txt={name="Bull",text={"{C:chips}+10{} Chips per {C:money}$1{}","above {C:money}$10{} held"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=5}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local money=G.GAME.dollars or 0
      local extra=money-10
      if extra>0 then
        local c=extra*10
        return {chips=c,message=localize{type='variable',key='a_chips',vars={c}}}
      end
    end
  end })

-- n561 Gazelle (Common) - +5 Mult for Straights (speed and grace)
SMODS.Joker({ key="n561", loc_txt={name="Gazelle",text={"{C:mult}+5{} Mult when playing","any {C:attention}Straight"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=6}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local n=context.scoring_name
      if n=="Straight" or n=="Straight Flush" or n=="Royal Flush" then
        return {mult=5,message=localize{type='variable',key='a_mult',vars={5}}}
      end
    end
  end })

-- n562 Crab (Common) - +15 Chips when playing exactly 2 cards
SMODS.Joker({ key="n562", loc_txt={name="Crab",text={"{C:chips}+15{} Chips when playing","exactly {C:attention}2{} cards"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=6}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand==2 then
        return {chips=15,message=localize{type='variable',key='a_chips',vars={15}}}
      end
    end
  end })

-- n563 Condor (Uncommon) - +5 Mult per round in current ante
SMODS.Joker({ key="n563", loc_txt={name="Condor",text={"{C:mult}+5{} Mult per round","survived in the current ante"}}, config={extra={rounds=0,ante=0}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=6}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local m=card.ability.extra.rounds*5
      if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      local ante=G.GAME.round_resets.ante or 1
      if ante~=card.ability.extra.ante then
        card.ability.extra.ante=ante
        card.ability.extra.rounds=0
      end
      card.ability.extra.rounds=card.ability.extra.rounds+1
      card:juice_up(0.5,0.5)
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.rounds}} end })

-- n564 Fireant (Common) - +1 Mult per Joker owned (colony strength)
SMODS.Joker({ key="n564", loc_txt={name="Fire Ant",text={"{C:mult}+1{} Mult for each","Joker owned"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=6}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local m=#G.jokers.cards
      if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
    end
  end })

-- n565 Sea Turtle (Common) - +4 Mult when playing 5 cards with 2+ suits
SMODS.Joker({ key="n565", loc_txt={name="Sea Turtle",text={"{C:mult}+4{} Mult when playing 5 cards","with {C:attention}2+{} different suits"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=6}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand==5 then
        local suits={}
        for _,c in ipairs(context.scoring_hand) do suits[c.base.suit]=true end
        local count=0
        for _ in pairs(suits) do count=count+1 end
        if count>=2 then return {mult=4,message=localize{type='variable',key='a_mult',vars={4}}} end
      end
    end
  end })

-- n566 Toad (Common) - +12 Chips for played 2s through 5s
SMODS.Joker({ key="n566", loc_txt={name="Toad",text={"{C:chips}+12{} Chips for each","scored {C:attention}2,3,4,{} or {C:attention}5"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=6}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=="2" or v=="3" or v=="4" or v=="5" then
        return {chips=12,message=localize{type='variable',key='a_chips',vars={12}}}
      end
    end
  end })

-- n567 Porcupine (Common) - Retriggers 8s, 9s, 10s once
SMODS.Joker({ key="n567", loc_txt={name="Porcupine",text={"Retriggers scored","8s, 9s, and 10s once"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=6,y=6}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=="8" or v=="9" or v=="10" then return {repetitions=1} end
    end
  end })

-- n568 Robin (Common) - +5 Mult in antes 1 through 3
SMODS.Joker({ key="n568", loc_txt={name="Robin",text={"{C:mult}+5{} Mult in antes {C:attention}1-3{}","(early bird)"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=6}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local ante=G.GAME.round_resets.ante or 1
      if ante<=3 then
        return {mult=5,message=localize{type='variable',key='a_mult',vars={5}}}
      end
    end
  end })

-- n569 Black Widow (Uncommon) - X2 Mult when only 1 hand remains this round
SMODS.Joker({ key="n569", loc_txt={name="Black Widow",text={"{X:mult,C:white}X2{} Mult when","only {C:attention}1{} hand remains this round"}}, config={}, rarity=2, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=6}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local hands_left=G.GAME.current_round.hands_left or 0
      if hands_left<=1 then
        return {Xmult=2,message=localize{type='variable',key='a_xmult',vars={2}}}
      end
    end
  end })

-- n570 Thunderbird (Rare) - +5 Mult per card of the first played suit
SMODS.Joker({ key="n570", loc_txt={name="Thunderbird",text={"Counts suit of first scored card","gives {C:mult}+5{} Mult per card of that suit"}}, config={extra={suit=""}}, rarity=3, cost=10, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=6}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand>0 then
        local first_suit=context.scoring_hand[1].base.suit
        local count=0
        for _,c in ipairs(context.scoring_hand) do
          if c.base.suit==first_suit then count=count+1 end
        end
        local m=count*5
        if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
      end
    end
  end })

-- n571 Hamster (Common) - Stores up to 5 Mult; cashes out end of round
SMODS.Joker({ key="n571", loc_txt={name="Hamster",text={"Stores {C:mult}+2{} Mult each hand","Cashes out at end of round (max {C:mult}+10{})"}}, config={extra={stored=0}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=7}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      card.ability.extra.stored=math.min(10,card.ability.extra.stored+2)
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.stored=0
      card:juice_up(0.5,0.5)
    end
  end })

-- n572 Mongoose (Common) - +8 Mult for Three of a Kind
SMODS.Joker({ key="n572", loc_txt={name="Mongoose",text={"{C:mult}+8{} Mult when playing","a {C:attention}Three of a Kind"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=7}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if context.scoring_name=="Three of a Kind" then
        return {mult=8,message=localize{type='variable',key='a_mult',vars={8}}}
      end
    end
  end })

-- n573 Bat (Common) - +10 Chips for each discard used this round
SMODS.Joker({ key="n573", loc_txt={name="Bat",text={"{C:chips}+10{} Chips per discard","used this round"}}, config={extra={discards=0}}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=7}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local c=card.ability.extra.discards*10
      if c>0 then return {chips=c,message=localize{type='variable',key='a_chips',vars={c}}} end
    end
    if context.discard then
      card.ability.extra.discards=card.ability.extra.discards+1
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.discards=0
    end
  end })

-- n574 Scorpion (Uncommon) - +4 Mult per card remaining in hand
SMODS.Joker({ key="n574", loc_txt={name="Scorpion",text={"{C:mult}+4{} Mult per card","remaining in hand"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=7}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local m=#G.hand.cards*4
      if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
    end
  end })

-- n575 Catfish (Common) - +15 Chips per Club card in hand (not played)
SMODS.Joker({ key="n575", loc_txt={name="Catfish",text={"{C:chips}+15{} Chips per {C:clubs}Club{}","card held in hand (not played)"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=7}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(G.hand.cards) do
        if c.base.suit=="Clubs" then count=count+1 end
      end
      local ch=count*15
      if ch>0 then return {chips=ch,message=localize{type='variable',key='a_chips',vars={ch}}} end
    end
  end })

-- n576 Pigeon (Common) - +4 Mult per hand played this round
SMODS.Joker({ key="n576", loc_txt={name="Pigeon",text={"{C:mult}+4{} Mult per hand","played this round"}}, config={extra={hands=0}}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=5,y=7}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      card.ability.extra.hands=card.ability.extra.hands+1
      local m=card.ability.extra.hands*4
      if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.hands=0
    end
  end })

-- n577 Caiman (Common) - +6 Chips for pairs of same-suit cards in hand
SMODS.Joker({ key="n577", loc_txt={name="Caiman",text={"{C:chips}+6{} Chips per pair","of same-suit cards in hand"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=7}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local suits={Spades=0,Hearts=0,Clubs=0,Diamonds=0}
      for _,c in ipairs(G.hand.cards) do
        suits[c.base.suit]=(suits[c.base.suit] or 0)+1
      end
      local pairs_count=0
      for _,v in pairs(suits) do pairs_count=pairs_count+math.floor(v/2) end
      local ch=pairs_count*6
      if ch>0 then return {chips=ch,message=localize{type='variable',key='a_chips',vars={ch}}} end
    end
  end })

-- n578 Sloth (Common) - +20 Chips if no discards used this round
SMODS.Joker({ key="n578", loc_txt={name="Sloth",text={"{C:chips}+20{} Chips if no discards","used this round (stay still)"}}, config={extra={used_discard=false}}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=7,y=7}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if not card.ability.extra.used_discard then
        return {chips=20,message=localize{type='variable',key='a_chips',vars={20}}}
      end
    end
    if context.discard then
      card.ability.extra.used_discard=true
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.used_discard=false
    end
  end })

-- n579 Macaw (Uncommon) - Retriggers face cards once
SMODS.Joker({ key="n579", loc_txt={name="Macaw",text={"Retriggers scored","face cards once"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=8,y=7}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=="Jack" or v=="Queen" or v=="King" then return {repetitions=1} end
    end
  end })

-- n580 Leech (Common) - Gains +1 Mult each time a Joker to its left scores
SMODS.Joker({ key="n580", loc_txt={name="Leech",text={"{C:mult}+#1#{} Mult","gains {C:mult}+1{} Mult each round"}}, config={extra={val=0}}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=7}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local m=card.ability.extra.val
      if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val=card.ability.extra.val+1
      card:juice_up(0.3,0.3)
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.val}} end })

-- n581 Chameleon Lizard (Common) - Changes suit bonus each round
SMODS.Joker({ key="n581", loc_txt={name="Lizard",text={"Each round gives {C:chips}+20{} Chips","for a different {C:attention}suit"}}, config={extra={round=0}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=8}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local suits={"Spades","Hearts","Clubs","Diamonds"}
      local idx=(card.ability.extra.round%4)+1
      if context.other_card.base.suit==suits[idx] then
        return {chips=20,message=localize{type='variable',key='a_chips',vars={20}}}
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.round=card.ability.extra.round+1
    end
  end })

-- n582 Raven (Common) - +5 Mult per hand remaining when scored
SMODS.Joker({ key="n582", loc_txt={name="Raven",text={"{C:mult}+5{} Mult per hand","remaining this round"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=8}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local hands_left=G.GAME.current_round.hands_left or 0
      local m=hands_left*5
      if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
    end
  end })

-- n583 Newt (Common) - +10 Chips at end of round (regeneration)
SMODS.Joker({ key="n583", loc_txt={name="Newt",text={"{C:chips}+#1#{} Chips","gains {C:chips}+10{} Chips per ante"}}, config={extra={val=0}}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=8}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local c=card.ability.extra.val
      if c>0 then return {chips=c,message=localize{type='variable',key='a_chips',vars={c}}} end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME.blind.boss then
        card.ability.extra.val=card.ability.extra.val+10
        card:juice_up(0.5,0.5)
      end
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.val}} end })

-- n584 Gorilla (Uncommon) - +20 Mult but must play exactly 5 cards
SMODS.Joker({ key="n584", loc_txt={name="Gorilla",text={"{C:mult}+20{} Mult only when","playing exactly {C:attention}5{} cards"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=8}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand==5 then
        return {mult=20,message=localize{type='variable',key='a_mult',vars={20}}}
      end
    end
  end })

-- n585 Hyena (Common) - Gains chips when other Jokers score
SMODS.Joker({ key="n585", loc_txt={name="Hyena",text={"{C:chips}+#1#{} Chips","gains {C:chips}+4{} Chips each round"}}, config={extra={val=0}}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=4,y=8}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local c=card.ability.extra.val
      if c>0 then return {chips=c,message=localize{type='variable',key='a_chips',vars={c}}} end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val=card.ability.extra.val+4
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.val}} end })

-- n586 Walrus (Common) - +10 Chips per Spade card in hand
SMODS.Joker({ key="n586", loc_txt={name="Walrus",text={"{C:chips}+10{} Chips per {C:spades}Spade{}","card held in hand (not played)"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=8}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(G.hand.cards) do
        if c.base.suit=="Spades" then count=count+1 end
      end
      local ch=count*10
      if ch>0 then return {chips=ch,message=localize{type='variable',key='a_chips',vars={ch}}} end
    end
  end })

-- n587 Toucan (Common) - +8 Chips for each scored 6, 7, 8
SMODS.Joker({ key="n587", loc_txt={name="Toucan",text={"{C:chips}+8{} Chips for each","scored {C:attention}6, 7,{} or {C:attention}8"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=8}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=="6" or v=="7" or v=="8" then
        return {chips=8,message=localize{type='variable',key='a_chips',vars={8}}}
      end
    end
  end })

-- n588 Chameleon Frog (Uncommon) - Copies X-mult of last triggered joker
SMODS.Joker({ key="n588", loc_txt={name="Tree Frog",text={"{X:mult,C:white}X1.5{} Mult when","playing a {C:attention}Flush"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=8}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local n=context.scoring_name
      if n=="Flush" or n=="Straight Flush" or n=="Royal Flush" or n=="Flush Five" or n=="Flush House" then
        return {Xmult=1.5,message=localize{type='variable',key='a_xmult',vars={1.5}}}
      end
    end
  end })

-- n589 River Otter (Common) - +6 Mult when playing 3-5 different values
SMODS.Joker({ key="n589", loc_txt={name="River Otter",text={"{C:mult}+6{} Mult when playing","3-5 different {C:attention}card values"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=8}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local vals={}
      for _,c in ipairs(context.scoring_hand) do vals[c.base.value]=true end
      local count=0
      for _ in pairs(vals) do count=count+1 end
      if count>=3 and count<=5 then
        return {mult=6,message=localize{type='variable',key='a_mult',vars={6}}}
      end
    end
  end })

-- n590 Grasshopper (Common) - +25 Chips when jumping over a blind (Small/Big only)
SMODS.Joker({ key="n590", loc_txt={name="Grasshopper",text={"{C:chips}+8{} Chips","gains {C:chips}+8{} per boss blind beaten"}}, config={extra={val=0}}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=8}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local c=card.ability.extra.val
      if c>0 then return {chips=c,message=localize{type='variable',key='a_chips',vars={c}}} end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME.blind.boss then
        card.ability.extra.val=card.ability.extra.val+8
        card:juice_up(0.5,0.5)
      end
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.val}} end })

-- n591 Mole (Common) - +20 Chips if playing underground (Clubs only hand)
SMODS.Joker({ key="n591", loc_txt={name="Mole",text={"{C:chips}+20{} Chips when all","played cards are {C:clubs}Clubs"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=9}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local ok=true
      for _,c in ipairs(context.scoring_hand) do
        if c.base.suit~="Clubs" then ok=false break end
      end
      if ok then return {chips=20,message=localize{type='variable',key='a_chips',vars={20}}} end
    end
  end })

-- n592 Cobra (Uncommon) - +15 Mult for Four of a Kind
SMODS.Joker({ key="n592", loc_txt={name="Cobra",text={"{C:mult}+15{} Mult when playing","a {C:attention}Four of a Kind"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=9}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      if context.scoring_name=="Four of a Kind" then
        return {mult=15,message=localize{type='variable',key='a_mult',vars={15}}}
      end
    end
  end })

-- n593 Moose (Common) - +4 Mult for each King held in hand
SMODS.Joker({ key="n593", loc_txt={name="Moose",text={"{C:mult}+4{} Mult per {C:attention}King","held in hand (not played)"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=9}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(G.hand.cards) do
        if c.base.value=="King" then count=count+1 end
      end
      local m=count*4
      if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
    end
  end })

-- n594 Owl (Rare) - X2 Mult on final hand of round (wisdom of last resort)
SMODS.Joker({ key="n594", loc_txt={name="Owl",text={"{X:mult,C:white}X2{} Mult on the","final hand of each round"}}, config={}, rarity=3, cost=10, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=9}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local hands_left=G.GAME.current_round.hands_left or 0
      if hands_left<=0 then
        return {Xmult=2,message=localize{type='variable',key='a_xmult',vars={2}}}
      end
    end
  end })

-- n595 Seahorse (Common) - +10 Chips per Diamond card in hand
SMODS.Joker({ key="n595", loc_txt={name="Seahorse",text={"{C:chips}+10{} Chips per {C:diamonds}Diamond{}","card held in hand (not played)"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=9}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(G.hand.cards) do
        if c.base.suit=="Diamonds" then count=count+1 end
      end
      local ch=count*10
      if ch>0 then return {chips=ch,message=localize{type='variable',key='a_chips',vars={ch}}} end
    end
  end })

-- n596 Mammoth (Rare) - +50 Chips, -1 Mult (ancient power, slow scoring)
SMODS.Joker({ key="n596", loc_txt={name="Mammoth",text={"{C:chips}+50{} Chips","but {C:mult}-1{} Mult"}}, config={}, rarity=3, cost=10, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=9}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      return {chips=50,mult=-1}
    end
  end })

-- n597 Phoenix (Legendary) - Gains +3 Xmult each time you lose a hand
SMODS.Joker({ key="n597", loc_txt={name="Phoenix",text={"Gains {X:mult,C:white}X0.5{} Mult","each time you lose a hand","Current: {X:mult,C:white}X#1#{}"}}, config={extra={xmult=1}}, rarity=4, cost=20, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=false, perishable_compat=true, pos={x=6,y=9}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local x=card.ability.extra.xmult
      if x>1 then return {Xmult=x,message=localize{type='variable',key='a_xmult',vars={x}}} end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME.chips<G.GAME.blind.chips then
        card.ability.extra.xmult=card.ability.extra.xmult+0.5
        card:juice_up(0.8,0.8)
      end
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.xmult}} end })

-- n598 Dragon (Legendary) - Starts at X1, gains X0.5 each ante beaten
SMODS.Joker({ key="n598", loc_txt={name="Dragon",text={"Starts at {X:mult,C:white}X1{} Mult","gains {X:mult,C:white}X0.5{} per ante beaten","Current: {X:mult,C:white}X#1#{}"}}, config={extra={xmult=1}}, rarity=4, cost=20, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=false, perishable_compat=true, pos={x=7,y=9}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      return {Xmult=card.ability.extra.xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME.blind.boss then
        card.ability.extra.xmult=card.ability.extra.xmult+0.5
        card:juice_up(0.8,0.8)
      end
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.xmult}} end })

-- n599 Unicorn (Rare) - +15 Mult when all cards in hand share one suit
SMODS.Joker({ key="n599", loc_txt={name="Unicorn",text={"Retriggers all scored cards once","if all played cards are the same suit"}}, config={}, rarity=3, cost=12, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=8,y=9}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local first=context.scoring_hand[1] and context.scoring_hand[1].base.suit
      local all_same=true
      for _,c in ipairs(context.scoring_hand) do
        if c.base.suit~=first then all_same=false break end
      end
      if all_same then return {repetitions=1} end
    end
  end })

-- n600 Ancient Tree (Rare) - Gains +1 Mult per ante, caps at +20
SMODS.Joker({ key="n600", loc_txt={name="Ancient Tree",text={"{C:mult}+#1#{} Mult","gains {C:mult}+1{} Mult per ante beaten","(max {C:mult}+20{})"}}, config={extra={val=0}}, rarity=3, cost=12, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=9}, atlas="cm_atlas_06",
  calculate=function(self,card,context)
    if context.joker_main then
      local m=card.ability.extra.val
      if m>0 then return {mult=m,message=localize{type='variable',key='a_mult',vars={m}}} end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME.blind.boss and card.ability.extra.val<20 then
        card.ability.extra.val=math.min(20,card.ability.extra.val+1)
        card:juice_up(0.5,0.5)
      end
    end
  end,
  loc_vars=function(self,info_queue,card) return {vars={card.ability.extra.val}} end })
