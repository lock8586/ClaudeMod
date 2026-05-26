-- ClaudeMod Batch 05: Architecture & Famous Places (n401-n500)

-- n401: The Colosseum — +Mult per face card scored (gladiators)
SMODS.Joker({ key="n401", loc_txt={name="The Colosseum",text={"{C:mult}+#1#{} Mult","per {C:attention}face card{} scored"}}, config={mult=5}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=0}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=='Jack' or v=='Queen' or v=='King' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n402: Sagrada Familia — gains +1 chips each round (still unfinished)
SMODS.Joker({ key="n402", loc_txt={name="Sagrada Familia",text={"Gains {C:chips}+1{} Chips","each round","{C:chips}+#1#{} Chips"," currently"}}, config={extra={chips=0}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=1,y=0}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips=card.ability.extra.chips+1
      return{message=localize{type='variable',key='a_chips',vars={1}}}
    end
    if context.joker_main then return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}} end
  end })

-- n403: Eiffel Tower — +chips for high-value cards (7,8,9,10,J,Q,K,A)
SMODS.Joker({ key="n403", loc_txt={name="Eiffel Tower",text={"{C:chips}+#1#{} Chips","per high card scored","(7 or above)"}}, config={chips=4}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=0}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      local high={'7','8','9','10','Jack','Queen','King','Ace'}
      for _,hv in ipairs(high) do if v==hv then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end end
    end
  end })

-- n404: The Parthenon — +Mult if all 4 suits present in scored hand
SMODS.Joker({ key="n404", loc_txt={name="The Parthenon",text={"{C:mult}+#1#{} Mult if scored","hand contains","all {C:attention}4 suits{}"}}, config={mult=20}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=0}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local suits={Spades=false,Hearts=false,Clubs=false,Diamonds=false}
      for _,c in ipairs(context.scoring_hand) do suits[c.base.suit]=true end
      if suits.Spades and suits.Hearts and suits.Clubs and suits.Diamonds then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n405: Big Ben — +Mult at rounds 12, 24, 36 (clock chimes)
SMODS.Joker({ key="n405", loc_txt={name="Big Ben",text={"{C:mult}+#1#{} Mult","at rounds {C:attention}12{},{C:attention}24{},{C:attention}36{}"}}, config={mult=24}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=0}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local r=G.GAME and G.GAME.round or 0
      if r==12 or r==24 or r==36 then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n406: Notre Dame — +chips per Heart card scored
SMODS.Joker({ key="n406", loc_txt={name="Notre Dame",text={"{C:chips}+#1#{} Chips","per {C:hearts}Heart{} scored"}}, config={chips=6}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=0}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Hearts' then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
    end
  end })

-- n407: The Alhambra — +Mult per distinct rank in scored hand
SMODS.Joker({ key="n407", loc_txt={name="The Alhambra",text={"{C:mult}+#1#{} Mult","per {C:attention}distinct rank{}","in scored hand"}}, config={mult=3}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=0}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ranks={}
      for _,c in ipairs(context.scoring_hand) do ranks[c.base.value]=true end
      local count=0; for _ in pairs(ranks) do count=count+1 end
      local bonus=card.ability.mult*count
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n408: Stonehenge — random positive effect each hand
SMODS.Joker({ key="n408", loc_txt={name="Stonehenge",text={"Mysterious...","{C:attention}random{} positive","effect each hand"}}, config={}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=7,y=0}, atlas="cm_atlas_05",
  calculate=function(self,card,context)
    if context.joker_main then
      local roll=math.random(3)
      if roll==1 then return{mult=math.random(5,15),message=localize{type='variable',key='a_mult',vars={0}}}
      elseif roll==2 then return{chips=math.random(20,60),message=localize{type='variable',key='a_chips',vars={0}}}
      else return{Xmult=1+math.random()*0.5,message=localize{type='variable',key='a_xmult',vars={0}}} end
    end
  end })

-- n409: The Pantheon — +chips per ante survived (eternal dome)
SMODS.Joker({ key="n409", loc_txt={name="The Pantheon",text={"Gains {C:chips}+2{} Chips","each ante","{C:chips}+#1#{} Chips"," currently"}}, config={extra={chips=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=8,y=0}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME and G.GAME.blind and G.GAME.blind.boss then
        card.ability.extra.chips=card.ability.extra.chips+2
        return{message=localize{type='variable',key='a_chips',vars={2}}}
      end
    end
    if context.joker_main and card.ability.extra.chips>0 then return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}} end
  end })

-- n410: Hagia Sophia — dual nature: +Mult AND +Chips but both halved
SMODS.Joker({ key="n410", loc_txt={name="Hagia Sophia",text={"{C:mult}+#1#{} Mult","and {C:chips}+#2#{} Chips","(dual nature, halved)"}}, config={mult=6,chips=20}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=0}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult,center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{mult=card.ability.mult,chips=card.ability.chips} end
  end })

-- n411: The Louvre — +Mult per joker owned
SMODS.Joker({ key="n411", loc_txt={name="The Louvre",text={"{C:mult}+#1#{} Mult","per {C:attention}Joker{} owned"}}, config={mult=2}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=1}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=#G.jokers.cards
      local bonus=card.ability.mult*count
      return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}}
    end
  end })

-- n412: The Kremlin — +Mult per Spade scored
SMODS.Joker({ key="n412", loc_txt={name="The Kremlin",text={"{C:mult}+#1#{} Mult","per {C:spades}Spade{} scored"}}, config={mult=4}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=1}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Spades' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n413: Tower of London — locks in a bonus chip amount when first triggered
SMODS.Joker({ key="n413", loc_txt={name="Tower of London",text={"On first score,","{C:attention}imprisons{} a","bonus of {C:chips}+#1#{} Chips"}}, config={extra={chips=0,locked=false}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=1}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if not card.ability.extra.locked then
        card.ability.extra.chips=math.random(15,50)
        card.ability.extra.locked=true
      end
      return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}
    end
  end })

-- n414: The Acropolis — +chips per Club scored
SMODS.Joker({ key="n414", loc_txt={name="The Acropolis",text={"{C:chips}+#1#{} Chips","per {C:clubs}Club{} scored"}}, config={chips=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=1}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Clubs' then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
    end
  end })

-- n415: Trevi Fountain — +chips per Diamond scored (coin toss wishes)
SMODS.Joker({ key="n415", loc_txt={name="Trevi Fountain",text={"{C:chips}+#1#{} Chips","per {C:diamonds}Diamond{}","scored (make a wish)"}}, config={chips=7}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=1}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Diamonds' then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
    end
  end })

-- n416: Versailles — Xmult but costs chips each hand
SMODS.Joker({ key="n416", loc_txt={name="Versailles",text={"{X:mult,C:white}X#1#{} Mult","but spend {C:chips}#2#{} Chips","each hand played"}}, config={Xmult=2.0,chip_cost=30}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=1}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult,center.ability.chip_cost}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      G.GAME.chips=(G.GAME.chips or 0)-card.ability.chip_cost
      return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n417: Prague Castle — +Mult per King in scored hand
SMODS.Joker({ key="n417", loc_txt={name="Prague Castle",text={"{C:mult}+#1#{} Mult","per {C:attention}King{} in","scored hand"}}, config={mult=8}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=1}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=='King' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n418: Dubrovnik Walls — +chips for each scored card (fortress defense)
SMODS.Joker({ key="n418", loc_txt={name="Dubrovnik Walls",text={"Fortress: {C:chips}+#1{}","Chips per card","in scored hand"}}, config={chips=3}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=1}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n419: St. Basil's Cathedral — +Mult per joker of different rarity owned
SMODS.Joker({ key="n419", loc_txt={name="St. Basil's",text={"{C:mult}+#1#{} Mult","per {C:attention}rarity{}","of jokers owned"}}, config={mult=10}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=1}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local rarities={}
      for _,j in ipairs(G.jokers.cards) do rarities[j.config.center.rarity]=true end
      local count=0; for _ in pairs(rarities) do count=count+1 end
      local bonus=card.ability.mult*count
      return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}}
    end
  end })

-- n420: The Uffizi — +chips per face card in entire hand (not just scoring)
SMODS.Joker({ key="n420", loc_txt={name="The Uffizi",text={"Gallery: {C:chips}+#1{}","Chips per {C:attention}face card{}","in full hand"}}, config={chips=5}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=1}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(G.hand.cards) do
        local v=c.base.value
        if v=='Jack' or v=='Queen' or v=='King' then count=count+1 end
      end
      local bonus=card.ability.chips*count
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n421: Machu Picchu — +Mult if hand has 5+ cards (mountain peak)
SMODS.Joker({ key="n421", loc_txt={name="Machu Picchu",text={"{C:mult}+#1#{} Mult","if {C:attention}5 or more{}","cards scored"}}, config={mult=15}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=2}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand>=5 then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n422: Angkor Wat — +chips per Ace scored
SMODS.Joker({ key="n422", loc_txt={name="Angkor Wat",text={"{C:chips}+#1#{} Chips","per {C:attention}Ace{} scored"}}, config={chips=20}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=2}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=='Ace' then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
    end
  end })

-- n423: Burj Khalifa — Xmult scales with hand size (tallest building)
SMODS.Joker({ key="n423", loc_txt={name="Burj Khalifa",text={"{X:mult,C:white}X#1#{} Mult","scales with","hand size"}}, config={Xmult=1.1}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=2}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hs=#G.hand.cards+#context.scoring_hand
      local xm=1+(hs*0.1)
      return{Xmult=xm,message=localize{type='variable',key='a_xmult',vars={xm}}}
    end
  end })

-- n424: Sydney Opera House — +Mult if hand is a Full House or better
SMODS.Joker({ key="n424", loc_txt={name="Sydney Opera",text={"{C:mult}+#1#{} Mult","for {C:attention}Full House{}","or better"}}, config={mult=18}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=2}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ht=G.GAME.current_round.current_hand.handname
      local good={'Full House','Four of a Kind','Straight Flush','Royal Flush','Five of a Kind','Flush House','Flush Five'}
      for _,h in ipairs(good) do if ht==h then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end end
    end
  end })

-- n425: Neuschwanstein Castle — +Mult per Queen in scored hand
SMODS.Joker({ key="n425", loc_txt={name="Neuschwanstein",text={"{C:mult}+#1#{} Mult","per {C:attention}Queen{}","scored"}}, config={mult=9}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=2}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=='Queen' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n426: Petra — hidden city: +chips if only 1 card scored
SMODS.Joker({ key="n426", loc_txt={name="Petra",text={"Hidden City:","{C:chips}+#1#{} Chips","if only {C:attention}1 card{} scored"}}, config={chips=80}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=2}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand==1 then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
    end
  end })

-- n427: Taj Mahal — +Mult for symmetrical hands (pairs/two pair/full house)
SMODS.Joker({ key="n427", loc_txt={name="Taj Mahal",text={"Symmetry: {C:mult}+#1{}","Mult for {C:attention}Pair{}","{C:attention}Two Pair{} or {C:attention}Full House{}"}}, config={mult=12}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=2}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ht=G.GAME.current_round.current_hand.handname
      if ht=='Pair' or ht=='Two Pair' or ht=='Full House' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n428: Chichen Itza — +chips per number card scored (2-9)
SMODS.Joker({ key="n428", loc_txt={name="Chichen Itza",text={"Ancient Steps:","{C:chips}+#1#{} Chips","per number card"}}, config={chips=3}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=2}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      local nums={'2','3','4','5','6','7','8','9','10'}
      for _,n in ipairs(nums) do if v==n then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end end
    end
  end })

-- n429: Santorini — +Mult for blue-suit cards (Spades/Clubs = blue)
SMODS.Joker({ key="n429", loc_txt={name="Santorini",text={"Blue Domes:","{C:mult}+#1#{} Mult","per {C:spades}Spade{} or {C:clubs}Club{}"}}, config={mult=4}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=2}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local s=context.other_card.base.suit
      if s=='Spades' or s=='Clubs' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n430: Golden Gate Bridge — +chips if scored hand spans a straight (any straight)
SMODS.Joker({ key="n430", loc_txt={name="Golden Gate",text={"Bridge: {C:chips}+#1{}","Chips for any","Straight hand"}}, config={chips=35}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=2}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ht=G.GAME.current_round.current_hand.handname
      if ht=='Straight' or ht=='Straight Flush' or ht=='Royal Flush' then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
    end
  end })

-- n431: Mount Everest — gains +1 Xmult every ante (reaching the summit)
SMODS.Joker({ key="n431", loc_txt={name="Mount Everest",text={"Gains {X:mult,C:white}X0.1{}","each ante","{X:mult,C:white}X#1#{} Mult now"}}, config={extra={xm=1.0}}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=3}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={string.format("%.1f",center.ability.extra.xm)}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME and G.GAME.blind and G.GAME.blind.boss then
        card.ability.extra.xm=card.ability.extra.xm+0.1
        return{message=localize{type='variable',key='a_xmult',vars={0.1}}}
      end
    end
    if context.joker_main and card.ability.extra.xm>1 then return{Xmult=card.ability.extra.xm,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xm}}} end
  end })

-- n432: Niagara Falls — +chips that overflow/cascade (+2 chips per chip bonus earned)
SMODS.Joker({ key="n432", loc_txt={name="Niagara Falls",text={"Cascade: earn","{C:chips}+#1#{} Chips","each hand"}}, config={chips=25}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=3}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
  end })

-- n433: Amazon Rainforest — +Mult per green card enhancement (foil/holographic)
SMODS.Joker({ key="n433", loc_txt={name="Amazon",text={"Biodiversity:","{C:mult}+#1#{} Mult","per enhanced card scored"}}, config={mult=4}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=3}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local c=context.other_card
      if c.ability.name~='Base Card' and c.ability.name~='' and c.ability.name then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n434: Sahara Desert — +Xmult if scored hand has no Hearts or Diamonds (dry/barren)
SMODS.Joker({ key="n434", loc_txt={name="Sahara Desert",text={"Arid: {X:mult,C:white}X#1{}","Mult if no red","cards scored"}}, config={Xmult=2.5}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=3}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local red=false
      for _,c in ipairs(context.scoring_hand) do
        if c.base.suit=='Hearts' or c.base.suit=='Diamonds' then red=true; break end
      end
      if not red then return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}} end
    end
  end })

-- n435: Venice Canals — +chips per card with a watermark/seal
SMODS.Joker({ key="n435", loc_txt={name="Venice Canals",text={"Waterways:","{C:chips}+#1#{} Chips","per {C:attention}sealed{} card scored"}}, config={chips=15}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=3}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.seal and context.other_card.seal~='' then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n436: Stonehenge II — Xmult that changes every round
SMODS.Joker({ key="n436", loc_txt={name="Stonehenge II",text={"Cyclic Stones:","{X:mult,C:white}X#1#{} Mult","changes each round"}}, config={extra={xm=1.5}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=5,y=3}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={string.format("%.1f",center.ability.extra.xm)}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      local vals={1.2,1.5,1.8,2.0,2.5,3.0}
      card.ability.extra.xm=vals[math.random(#vals)]
    end
    if context.joker_main then return{Xmult=card.ability.extra.xm,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xm}}} end
  end })

-- n437: Forbidden City — +Mult but only works on even rounds
SMODS.Joker({ key="n437", loc_txt={name="Forbidden City",text={"Imperial: {C:mult}+#1{}","Mult on {C:attention}even{}","rounds only"}}, config={mult=22}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=3}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local r=G.GAME and G.GAME.round or 0
      if r%2==0 then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n438: Pyramids of Giza — +chips that scale with number of cards in scored hand (pyramid shape)
SMODS.Joker({ key="n438", loc_txt={name="Pyramids of Giza",text={"Pyramid: {C:chips}+#1{}","Chips times cards","in scored hand"}}, config={chips=5}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=3}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local bonus=card.ability.chips*#context.scoring_hand
      return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}}
    end
  end })

-- n439: Great Wall of China — +chips per scored hand this run (accumulates)
SMODS.Joker({ key="n439", loc_txt={name="Great Wall",text={"Wall grows:","{C:chips}+#1#{} Chips","per hand played this run"}}, config={chips=1}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=8,y=3}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hands=G.GAME and G.GAME.hands_played or 0
      local bonus=card.ability.chips*hands
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n440: Stonehenge Sunrise — +Xmult on first hand of each round
SMODS.Joker({ key="n440", loc_txt={name="Stonehenge Sunrise",text={"Dawn Ritual:","{X:mult,C:white}X#1#{} Mult","on first hand each round"}}, config={extra={Xmult=3.0,used=false}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=3}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.Xmult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.used=false
    end
    if context.joker_main and not card.ability.extra.used then
      card.ability.extra.used=true
      return{Xmult=card.ability.extra.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}}}
    end
  end })

-- n441: Arc de Triomphe — +Mult for winning (scoring enough chips) hands
SMODS.Joker({ key="n441", loc_txt={name="Arc de Triomphe",text={"Triumph: gains","{C:mult}+1{} Mult","each ante survived"}}, config={extra={mult=0}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=4}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME and G.GAME.blind and G.GAME.blind.boss then
        card.ability.extra.mult=card.ability.extra.mult+1
        return{message=localize{type='variable',key='a_mult',vars={1}}}
      end
    end
    if context.joker_main and card.ability.extra.mult>0 then return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}} end
  end })

-- n442: Colosseum II — Xmult that grows when face cards are scored
SMODS.Joker({ key="n442", loc_txt={name="Colosseum II",text={"Arena grows:","{X:mult,C:white}X#1#{} Mult","(gains X0.2 per face)"}}, config={extra={xm=1.0}}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=1,y=4}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={string.format("%.1f",center.ability.extra.xm)}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=='Jack' or v=='Queen' or v=='King' then
        card.ability.extra.xm=card.ability.extra.xm+0.2
        return{message=localize{type='variable',key='a_xmult',vars={0.2}}}
      end
    end
    if context.joker_main and card.ability.extra.xm>1 then return{Xmult=card.ability.extra.xm,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xm}}} end
  end })

-- n443: Kyoto Temples — +Mult per club or spade scored (zen)
SMODS.Joker({ key="n443", loc_txt={name="Kyoto Temples",text={"Zen: {C:mult}+#1{}","Mult per","dark suit scored"}}, config={mult=3}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=4}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local s=context.other_card.base.suit
      if s=='Clubs' or s=='Spades' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n444: Fuji-san — +Xmult if scored hand is exactly 5 cards (perfect peak)
SMODS.Joker({ key="n444", loc_txt={name="Fuji-san",text={"Perfect Peak:","{X:mult,C:white}X#1#{} Mult","for exactly 5 cards"}}, config={Xmult=2.0}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=4}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand==5 then return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}} end
    end
  end })

-- n445: Ayers Rock — +chips based on odd-valued cards scored
SMODS.Joker({ key="n445", loc_txt={name="Uluru",text={"Sacred Stone:","{C:chips}+#1#{} Chips","per odd-value card"}}, config={chips=8}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=4}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      local odds={'3','5','7','9','Jack','King','Ace'}
      for _,o in ipairs(odds) do if v==o then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end end
    end
  end })

-- n446: Easter Island — +Mult per stone/unmovable card (face-down concept: per 2 or 3)
SMODS.Joker({ key="n446", loc_txt={name="Easter Island",text={"Moai: {C:mult}+#1{}","Mult per {C:attention}2{}","or {C:attention}3{} scored"}}, config={mult=6}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=4}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=='2' or v=='3' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n447: Bali Temples — +Mult per Heart or Diamond scored (warmth/fire)
SMODS.Joker({ key="n447", loc_txt={name="Bali Temples",text={"Flame Dance:","{C:mult}+#1#{} Mult","per red suit scored"}}, config={mult=3}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=4}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local s=context.other_card.base.suit
      if s=='Hearts' or s=='Diamonds' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n448: Borobudur — +chips per rank below 7 scored (ancient foundations)
SMODS.Joker({ key="n448", loc_txt={name="Borobudur",text={"Foundation:","{C:chips}+#1#{} Chips","per low card (2-6)"}}, config={chips=6}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=4}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      local low={'2','3','4','5','6'}
      for _,l in ipairs(low) do if v==l then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end end
    end
  end })

-- n449: Potala Palace — +Mult if hand has no repeated suits
SMODS.Joker({ key="n449", loc_txt={name="Potala Palace",text={"High Purity:","{C:mult}+#1#{} Mult","if no suit repeated"}}, config={mult=16}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=4}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local seen={}; local pure=true
      for _,c in ipairs(context.scoring_hand) do
        if seen[c.base.suit] then pure=false; break end
        seen[c.base.suit]=true
      end
      if pure then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n450: Tiananmen Square — +chips per 4 scored (four as death/power)
SMODS.Joker({ key="n450", loc_txt={name="Tiananmen Square",text={"Power: {C:chips}+#1{}","Chips per {C:attention}4{}","scored"}}, config={chips=14}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=4}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=='4' then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
    end
  end })

-- n451: St. Peter's Basilica — +chips for Straight or Flush (divine order)
SMODS.Joker({ key="n451", loc_txt={name="St. Peter's",text={"Divine Order:","{C:chips}+#1#{} Chips","for Flush or Straight"}}, config={chips=40}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=5}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ht=G.GAME.current_round.current_hand.handname
      if ht=='Straight' or ht=='Flush' or ht=='Straight Flush' or ht=='Royal Flush' then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
    end
  end })

-- n452: Westminster Abbey — +Mult per Jack scored (coronation)
SMODS.Joker({ key="n452", loc_txt={name="Westminster",text={"Coronation:","{C:mult}+#1#{} Mult","per {C:attention}Jack{} scored"}}, config={mult=10}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=5}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=='Jack' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n453: Buckingham Palace — +Mult if hand contains a King and a Queen (royal couple)
SMODS.Joker({ key="n453", loc_txt={name="Buckingham",text={"Royal Couple:","{C:mult}+#1#{} Mult","if King and Queen scored"}}, config={mult=25}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=5}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hasK,hasQ=false,false
      for _,c in ipairs(context.scoring_hand) do
        if c.base.value=='King' then hasK=true end
        if c.base.value=='Queen' then hasQ=true end
      end
      if hasK and hasQ then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n454: Edinburgh Castle — +Mult for Three of a Kind or better pair hands
SMODS.Joker({ key="n454", loc_txt={name="Edinburgh Castle",text={"Highland: {C:mult}+#1{}","Mult for {C:attention}Three{} of","a Kind or better"}}, config={mult=14}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=5}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ht=G.GAME.current_round.current_hand.handname
      local good={'Three of a Kind','Full House','Four of a Kind','Five of a Kind','Flush House','Flush Five'}
      for _,h in ipairs(good) do if ht==h then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end end
    end
  end })

-- n455: Kremlin II — Xmult for all-Spade hands
SMODS.Joker({ key="n455", loc_txt={name="Kremlin Walls",text={"Ironclad:","{X:mult,C:white}X#1#{} Mult","if all cards are Spades"}}, config={Xmult=3.0}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=5}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local allSpades=true
      for _,c in ipairs(context.scoring_hand) do if c.base.suit~='Spades' then allSpades=false; break end end
      if allSpades and #context.scoring_hand>0 then return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}} end
    end
  end })

-- n456: Castel Sant'Angelo — +Mult for defensive pairs
SMODS.Joker({ key="n456", loc_txt={name="Castel Sant'Angelo",text={"Fortress: {C:mult}+#1{}","Mult for {C:attention}Pair{}","or {C:attention}Two Pair{}"}}, config={mult=10}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=5}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ht=G.GAME.current_round.current_hand.handname
      if ht=='Pair' or ht=='Two Pair' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n457: Leaning Tower of Pisa — off-balance: +Mult but 50% chance each hand
SMODS.Joker({ key="n457", loc_txt={name="Tower of Pisa",text={"Unstable: {C:mult}+#1{}","Mult with {C:attention}50%{}","chance each hand"}}, config={mult=20}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=5}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if math.random()<0.5 then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n458: Pompeii Ruins — +Mult but decreases by 1 each hand (decay)
SMODS.Joker({ key="n458", loc_txt={name="Pompeii Ruins",text={"Decay: {C:mult}+#1{}","Mult (loses {C:attention}1{}","each hand played)"}}, config={extra={mult=30}}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=false, perishable_compat=true, pos={x=7,y=5}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local m=card.ability.extra.mult
      if m>0 then
        card.ability.extra.mult=m-1
        return{mult=m,message=localize{type='variable',key='a_mult',vars={m}}}
      end
    end
  end })

-- n459: Colosseum of Verona — +chips per scored card (arena seating)
SMODS.Joker({ key="n459", loc_txt={name="Arena of Verona",text={"Seating:","{C:chips}+#1#{} Chips","per scored card"}}, config={chips=4}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=5}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n460: Forum Romanum — +Mult for any flush-type hand
SMODS.Joker({ key="n460", loc_txt={name="Forum Romanum",text={"Senate: {C:mult}+#1{}","Mult for any","Flush hand"}}, config={mult=16}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=5}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ht=G.GAME.current_round.current_hand.handname
      if ht=='Flush' or ht=='Straight Flush' or ht=='Royal Flush' or ht=='Flush House' or ht=='Flush Five' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n461: Stonehenge III — +Mult for high cards, +Chips for low cards (solstice)
SMODS.Joker({ key="n461", loc_txt={name="Stonehenge III",text={"Solstice Balance:","{C:mult}+#1#{} Mult (high)","or {C:chips}+#2#{} Chips (low)"}}, config={mult=8,chips=12}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=6}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult,center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      local high={'7','8','9','10','Jack','Queen','King','Ace'}
      for _,h in ipairs(high) do if v==h then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end end
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n462: Alcazar of Seville — +Mult per distinct suit in scored hand
SMODS.Joker({ key="n462", loc_txt={name="Alcazar",text={"Court: {C:mult}+#1{}","Mult per {C:attention}distinct suit{}","in scored hand"}}, config={mult=6}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=6}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local suits={}
      for _,c in ipairs(context.scoring_hand) do suits[c.base.suit]=true end
      local count=0; for _ in pairs(suits) do count=count+1 end
      local bonus=card.ability.mult*count
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n463: Palacio Real — +chips per 10 or face card (royal treasury)
SMODS.Joker({ key="n463", loc_txt={name="Palacio Real",text={"Royal Treasury:","{C:chips}+#1#{} Chips","per 10, J, Q, or K"}}, config={chips=6}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=6}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=='10' or v=='Jack' or v=='Queen' or v=='King' then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
    end
  end })

-- n464: Sagrada Familia II — Xmult that scales with rounds survived
SMODS.Joker({ key="n464", loc_txt={name="Sagrada II",text={"Still Building:","{X:mult,C:white}X#1#{} Mult","(gains X0.05 per round)"}}, config={extra={xm=1.0}}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=3,y=6}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={string.format("%.2f",center.ability.extra.xm)}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.xm=card.ability.extra.xm+0.05
    end
    if context.joker_main then return{Xmult=card.ability.extra.xm,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xm}}} end
  end })

-- n465: Colosseum Midnight — +Mult for pairs of face cards
SMODS.Joker({ key="n465", loc_txt={name="Midnight Games",text={"Night Arena:","{C:mult}+#1#{} Mult","for face card pairs"}}, config={mult=14}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=6}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ht=G.GAME.current_round.current_hand.handname
      local faces=0
      for _,c in ipairs(context.scoring_hand) do
        local v=c.base.value
        if v=='Jack' or v=='Queen' or v=='King' then faces=faces+1 end
      end
      if (ht=='Pair' or ht=='Two Pair' or ht=='Full House') and faces>=2 then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n466: Amphitheater — +Mult per unique hand type played this run (scholarship)
SMODS.Joker({ key="n466", loc_txt={name="Amphitheater",text={"Repertoire:","{C:mult}+#1#{} Mult","per hand type used this run"}}, config={mult=3}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=6}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      if G.GAME and G.GAME.hand_usage then
        for _,v in pairs(G.GAME.hand_usage) do if v.count and v.count>0 then count=count+1 end end
      end
      local bonus=card.ability.mult*math.max(count,1)
      return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}}
    end
  end })

-- n467: Parthenon II — +chips per scored card (old civic pride)
SMODS.Joker({ key="n467", loc_txt={name="Parthenon II",text={"Civic Pride:","{C:chips}+#1#{} Chips","per card in scored hand"}}, config={chips=7}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=6}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local bonus=card.ability.chips*#context.scoring_hand
      return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}}
    end
  end })

-- n468: Pantheon II — Xmult for all-same-suit hands (purity of god)
SMODS.Joker({ key="n468", loc_txt={name="Pantheon II",text={"Pure Offering:","{X:mult,C:white}X#1#{} Mult","for single-suit hand"}}, config={Xmult=2.5}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=6}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local suit=nil; local pure=true
      for _,c in ipairs(context.scoring_hand) do
        if suit==nil then suit=c.base.suit
        elseif c.base.suit~=suit then pure=false; break end
      end
      if pure and suit then return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}} end
    end
  end })

-- n469: Temple of Zeus — +Mult for High Cards (divine lightning)
SMODS.Joker({ key="n469", loc_txt={name="Temple of Zeus",text={"Lightning: {C:mult}+#1{}","Mult for {C:attention}High Card{}","hand"}}, config={mult=18}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=6}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ht=G.GAME.current_round.current_hand.handname
      if ht=='High Card' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n470: Library of Alexandria — +chips per Ace in full hand (knowledge)
SMODS.Joker({ key="n470", loc_txt={name="Library of Alexandria",text={"Knowledge:","{C:chips}+#1#{} Chips","per Ace in full hand"}}, config={chips=25}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=6}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(G.hand.cards) do if c.base.value=='Ace' then count=count+1 end end
      for _,c in ipairs(context.scoring_hand) do if c.base.value=='Ace' then count=count+1 end end
      local bonus=card.ability.chips*count
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n471: Inca Trail — +Mult that builds per hand (mountain climb)
SMODS.Joker({ key="n471", loc_txt={name="Inca Trail",text={"Ascent: gains","{C:mult}+1{} Mult","each hand played"}}, config={extra={mult=0}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=7}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      card.ability.extra.mult=card.ability.extra.mult+1
      if card.ability.extra.mult>0 then return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}} end
    end
  end })

-- n472: Colosseum of Cards — +chips per scoring repeat (echoing arena)
SMODS.Joker({ key="n472", loc_txt={name="Echo Arena",text={"Echo: {C:chips}+#1{}","Chips on each","card score"}}, config={chips=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=7}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n473: Catacombs — +Mult for playing with fewer than 4 cards (underground)
SMODS.Joker({ key="n473", loc_txt={name="Catacombs",text={"Underground:","{C:mult}+#1#{} Mult","if 3 or fewer cards scored"}}, config={mult=20}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=7}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand<=3 then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n474: Ruins of Carthage — +Xmult but permanently loses 0.1 each round
SMODS.Joker({ key="n474", loc_txt={name="Ruins of Carthage",text={"Crumbling:","{X:mult,C:white}X#1#{} Mult","(loses X0.1 each round)"}}, config={extra={xm=3.0}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=false, perishable_compat=true, pos={x=3,y=7}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={string.format("%.1f",center.ability.extra.xm)}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.xm=math.max(1.0,card.ability.extra.xm-0.1)
    end
    if context.joker_main and card.ability.extra.xm>1 then return{Xmult=card.ability.extra.xm,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xm}}} end
  end })

-- n475: Stonehenge Altar — +Mult based on hand count remaining (sacrifice)
SMODS.Joker({ key="n475", loc_txt={name="Stonehenge Altar",text={"Sacrifice: {C:mult}+#1{}","Mult per {C:attention}hand{}","remaining"}}, config={mult=5}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=7}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hands=G.GAME and G.GAME.current_round and G.GAME.current_round.hands_left or 0
      local bonus=card.ability.mult*hands
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n476: Hagia Sophia II — +Mult and +Chips for balanced hands (2+2+1 mix of suits)
SMODS.Joker({ key="n476", loc_txt={name="Hagia Sophia II",text={"East-West:","{C:mult}+#1#{} Mult and","{C:chips}+#2#{} Chips each hand"}}, config={mult=5,chips=15}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=7}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult,center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{mult=card.ability.mult,chips=card.ability.chips} end
  end })

-- n477: Alhambra II — +chips per 5,6,7,8 scored (geometric patterns)
SMODS.Joker({ key="n477", loc_txt={name="Alhambra II",text={"Geometric:","{C:chips}+#1#{} Chips","per 5,6,7, or 8 scored"}}, config={chips=8}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=7}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=='5' or v=='6' or v=='7' or v=='8' then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
    end
  end })

-- n478: Great Mosque of Cordoba — +Mult for flush hands (pillared hall)
SMODS.Joker({ key="n478", loc_txt={name="Mosque of Cordoba",text={"Pillars: {C:mult}+#1{}","Mult for","Flush hands"}}, config={mult=14}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=7}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ht=G.GAME.current_round.current_hand.handname
      if ht=='Flush' or ht=='Flush House' or ht=='Flush Five' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n479: Mecca — +Xmult if all cards in scored hand are the same suit
SMODS.Joker({ key="n479", loc_txt={name="Mecca",text={"Holy City:","{X:mult,C:white}X#1#{} Mult","for single-suit flush"}}, config={Xmult=2.0}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=7}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ht=G.GAME.current_round.current_hand.handname
      if ht=='Flush' or ht=='Straight Flush' or ht=='Royal Flush' or ht=='Flush House' or ht=='Flush Five' then return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}} end
    end
  end })

-- n480: Kaaba — +Xmult once per ante (once per pilgrimage)
SMODS.Joker({ key="n480", loc_txt={name="The Kaaba",text={"Pilgrimage:","{X:mult,C:white}X#1#{} Mult","once per ante"}}, config={extra={Xmult=2.5,used=false}}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=7}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.Xmult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME and G.GAME.blind and G.GAME.blind.boss then card.ability.extra.used=false end
    end
    if context.joker_main and not card.ability.extra.used then
      card.ability.extra.used=true
      return{Xmult=card.ability.extra.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}}}
    end
  end })

-- n481: Parthenon Frieze — +Mult for straights (carved sequence)
SMODS.Joker({ key="n481", loc_txt={name="Parthenon Frieze",text={"Carved Sequence:","{C:mult}+#1#{} Mult","for Straight hands"}}, config={mult=20}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=8}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ht=G.GAME.current_round.current_hand.handname
      if ht=='Straight' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n482: Sistine Chapel — +Xmult for face cards (divine portraits)
SMODS.Joker({ key="n482", loc_txt={name="Sistine Chapel",text={"Divine Art:","{C:mult}+#1#{} Mult","per face card scored"}}, config={mult=6}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=8}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=='Jack' or v=='Queen' or v=='King' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n483: Amalfi Coast — +chips per Heart or Diamond scored (colorful coast)
SMODS.Joker({ key="n483", loc_txt={name="Amalfi Coast",text={"Vivid Colors:","{C:chips}+#1#{} Chips","per Heart or Diamond"}}, config={chips=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=8}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local s=context.other_card.base.suit
      if s=='Hearts' or s=='Diamonds' then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
    end
  end })

-- n484: Doge's Palace — +Mult per scored 9 or 10 (Venetian commerce)
SMODS.Joker({ key="n484", loc_txt={name="Doge's Palace",text={"Commerce:","{C:mult}+#1#{} Mult","per 9 or 10 scored"}}, config={mult=7}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=8}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=='9' or v=='10' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n485: Murano Island — +Xmult for glass/enhanced cards (glass blowing)
SMODS.Joker({ key="n485", loc_txt={name="Murano Island",text={"Glass Art:","{X:mult,C:white}X#1#{} Mult","per Glass card scored"}}, config={Xmult=1.5}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=8}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.ability and context.other_card.ability.name=='Glass Card' then
        return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
      end
    end
  end })

-- n486: Rialto Bridge — +chips that bridge suit transitions (when consecutive suits alternate)
SMODS.Joker({ key="n486", loc_txt={name="Rialto Bridge",text={"Commerce Bridge:","{C:chips}+#1#{} Chips","each hand played"}}, config={chips=20}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=8}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
  end })

-- n487: Basilica di San Marco — +Mult for all-face-card hands (golden mosaics)
SMODS.Joker({ key="n487", loc_txt={name="San Marco",text={"Golden Mosaic:","{C:mult}+#1#{} Mult","if all scored are face cards"}}, config={mult=30}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=8}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local allFace=true
      for _,c in ipairs(context.scoring_hand) do
        local v=c.base.value
        if v~='Jack' and v~='Queen' and v~='King' then allFace=false; break end
      end
      if allFace and #context.scoring_hand>0 then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n488: Campanile di Venezia — +chips per round (steady bell tower)
SMODS.Joker({ key="n488", loc_txt={name="Campanile",text={"Bell Tower:","{C:chips}+#1#{} Chips","per round number"}}, config={chips=2}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=8}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local r=G.GAME and G.GAME.round or 1
      local bonus=card.ability.chips*r
      return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}}
    end
  end })

-- n489: Piazza San Marco — crowded: +Mult for large hands (5 cards)
SMODS.Joker({ key="n489", loc_txt={name="Piazza San Marco",text={"Crowded Square:","{C:mult}+#1#{} Mult","for 5-card hands"}}, config={mult=12}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=8}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand==5 then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n490: Ponte Vecchio — +chips per gold/Steel card scored (gold bridge market)
SMODS.Joker({ key="n490", loc_txt={name="Ponte Vecchio",text={"Gold Market:","{C:chips}+#1#{} Chips","per Steel card scored"}}, config={chips=20}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=8}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.ability and context.other_card.ability.name=='Steel Card' then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n491: Pitti Palace — +Mult per joker in collection (art patron)
SMODS.Joker({ key="n491", loc_txt={name="Pitti Palace",text={"Art Patron:","{C:mult}+#1#{} Mult","per Joker owned"}}, config={mult=3}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=9}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=#G.jokers.cards
      return{mult=card.ability.mult*count,message=localize{type='variable',key='a_mult',vars={card.ability.mult*count}}}
    end
  end })

-- n492: Piazzale Michelangelo — overlook: +Mult if scoring hand beats current best
SMODS.Joker({ key="n492", loc_txt={name="Piazzale Michel.",text={"Best View:","{C:mult}+#1#{} Mult","per Ace in scored hand"}}, config={mult=12}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=9}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=='Ace' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n493: Florence Baptistery — baptism: +Xmult on first hand of each ante
SMODS.Joker({ key="n493", loc_txt={name="Baptistery",text={"Baptism:","{X:mult,C:white}X#1#{} Mult","first hand each ante"}}, config={extra={Xmult=2.0,used=false}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=9}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.Xmult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME and G.GAME.blind and G.GAME.blind.boss then card.ability.extra.used=false end
    end
    if context.joker_main and not card.ability.extra.used then
      card.ability.extra.used=true
      return{Xmult=card.ability.extra.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}}}
    end
  end })

-- n494: Giotto's Tower — +chips per scoring card's chip value (artistic detail)
SMODS.Joker({ key="n494", loc_txt={name="Giotto's Tower",text={"Detail Work:","{C:chips}+#1#{} Chips","per card scored"}}, config={chips=3}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=9}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n495: Palazzo Vecchio — +Mult for paired Jacks/Queens/Kings (civic authority)
SMODS.Joker({ key="n495", loc_txt={name="Palazzo Vecchio",text={"Authority:","{C:mult}+#1#{} Mult","for pairs of face cards"}}, config={mult=16}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=9}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local faces=0
      for _,c in ipairs(context.scoring_hand) do
        local v=c.base.value
        if v=='Jack' or v=='Queen' or v=='King' then faces=faces+1 end
      end
      if faces>=2 then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n496: Forte dei Marmi — marble: +chips per 10 scored (marble richness)
SMODS.Joker({ key="n496", loc_txt={name="Forte dei Marmi",text={"Marble: {C:chips}+#1{}","Chips per","10 scored"}}, config={chips=18}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=9}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=='10' then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
    end
  end })

-- n497: San Gimignano — tower town: +Mult per joker of rarity 1 owned
SMODS.Joker({ key="n497", loc_txt={name="San Gimignano",text={"Tower Town:","{C:mult}+#1#{} Mult","per Common Joker"}}, config={mult=4}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=9}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,j in ipairs(G.jokers.cards) do if j.config.center.rarity==1 then count=count+1 end end
      local bonus=card.ability.mult*count
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n498: Cinque Terre — five lands: +Xmult if exactly 5 different suits counted (impossible — so: if hand is exactly 5 cards)
SMODS.Joker({ key="n498", loc_txt={name="Cinque Terre",text={"Five Lands:","{X:mult,C:white}X#1#{} Mult","for exactly 5 cards"}}, config={Xmult=2.2}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=9}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand==5 then return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}} end
    end
  end })

-- n499: Portofino — yacht harbor: +Mult per Diamond scored (wealth/glamour)
SMODS.Joker({ key="n499", loc_txt={name="Portofino",text={"Harbor Glamour:","{C:mult}+#1#{} Mult","per Diamond scored"}}, config={mult=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=9}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Diamonds' then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n500: Colosseum Eternal — Xmult that never decays (eternal monument)
SMODS.Joker({ key="n500", loc_txt={name="Colosseum Eternal",text={"Eternal:","{X:mult,C:white}X#1#{} Mult","always (no conditions)"}}, config={Xmult=2.0}, rarity=4, cost=10, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=9}, atlas="cm_atlas_05",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}} end
  end })
