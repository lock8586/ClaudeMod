-- ClaudeMod Batch 09: Pure Mechanics (n801-n900)

-- n801: The Accumulator -- gains +1 chips each hand played
SMODS.Joker({ key="n801", loc_txt={name="The Accumulator",text={"Gains {C:chips}+1{} Chips","each hand played","{C:chips}+#1#{} Chips now"}}, config={extra={chips=0}}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=0}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.before then
      card.ability.extra.chips=card.ability.extra.chips+1
    end
    if context.joker_main and card.ability.extra.chips>0 then
      return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}
    end
  end })

-- n802: The Converter -- Xmult equal to joker count
SMODS.Joker({ key="n802", loc_txt={name="The Converter",text={"{X:mult,C:white}X#1#{} Mult","equal to jokers held"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=0}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={#G.jokers.cards}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.jokers.cards
      return{Xmult=n,message=localize{type='variable',key='a_xmult',vars={n}}}
    end
  end })

-- n803: High Roller -- +1 mult per round played
SMODS.Joker({ key="n803", loc_txt={name="High Roller",text={"{C:mult}+#1#{} Mult","equal to {C:attention}round number"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=0}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={G.GAME.round or 1}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=G.GAME.round or 1
      return{mult=n,message=localize{type='variable',key='a_mult',vars={n}}}
    end
  end })

-- n804: The Hoarder -- +2 mult per unplayed card in hand
SMODS.Joker({ key="n804", loc_txt={name="The Hoarder",text={"{C:mult}+#1#{} Mult","per card in hand {C:attention}not played"}}, config={mult=2}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=0}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.hand.cards
      local bonus=card.ability.mult*n
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n805: Dead Weight -- +4 chips per card discarded this round
SMODS.Joker({ key="n805", loc_txt={name="Dead Weight",text={"{C:chips}+#1#{} Chips","per card {C:attention}discarded{} this round"}}, config={chips=4}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=0}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local discarded=G.GAME.current_round.discards_used or 0
      local bonus=card.ability.chips*discarded*4
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n806: The Mathematician -- +3 chips per number card (2-10) scored
SMODS.Joker({ key="n806", loc_txt={name="The Mathematician",text={"{C:chips}+#1#{} Chips","per {C:attention}number card{} scored"}}, config={chips=3}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=0}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      local nums={"2","3","4","5","6","7","8","9","10"}
      for _,num in ipairs(nums) do
        if v==num then
          return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
        end
      end
    end
  end })

-- n807: Face Value -- +4 mult per face card (J/Q/K) scored
SMODS.Joker({ key="n807", loc_txt={name="Face Value",text={"{C:mult}+#1#{} Mult","per {C:attention}face card{} scored"}}, config={mult=4}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=0}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=="Jack" or v=="Queen" or v=="King" then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n808: Ace in the Hole -- +10 mult if an Ace is held but not played
SMODS.Joker({ key="n808", loc_txt={name="Ace in the Hole",text={"{C:mult}+#1#{} Mult","if {C:attention}Ace{} held but not played"}}, config={mult=10}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=0}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      for _,c in ipairs(G.hand.cards) do
        if c.base.value=="Ace" then
          return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
        end
      end
    end
  end })

-- n809: The Minimalist -- X5 mult if only 1 card played
SMODS.Joker({ key="n809", loc_txt={name="The Minimalist",text={"{X:mult,C:white}X#1#{} Mult","if only {C:attention}1 card{} played"}}, config={Xmult=5}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=0}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards==1 then
      return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n810: The Maximalist -- +3 mult per card played beyond 3
SMODS.Joker({ key="n810", loc_txt={name="The Maximalist",text={"{C:mult}+#1#{} Mult","per card played {C:attention}beyond 3"}}, config={mult=3}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=0}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local extra=math.max(0,#G.play.cards-3)
      local bonus=card.ability.mult*extra
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n811: Suit Collector -- +3 mult per unique suit held in hand
SMODS.Joker({ key="n811", loc_txt={name="Suit Collector",text={"{C:mult}+#1#{} Mult","per {C:attention}unique suit{} in hand"}}, config={mult=3}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=1}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local suits={}
      for _,c in ipairs(G.hand.cards) do suits[c.base.suit]=true end
      local n=0; for _ in pairs(suits) do n=n+1 end
      local bonus=card.ability.mult*n
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n812: Card Sharp -- +2 mult per card currently in hand
SMODS.Joker({ key="n812", loc_txt={name="Card Sharp",text={"{C:mult}+#1#{} Mult","per card in hand"}}, config={mult=2}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=1}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.hand.cards
      local bonus=card.ability.mult*n
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n813: Penny Pincher -- gains +2 chips at end of each round
SMODS.Joker({ key="n813", loc_txt={name="Penny Pincher",text={"Gains {C:chips}+2{} Chips","at end of each round","{C:chips}+#1#{} Chips now"}}, config={extra={chips=0}}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=1}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips=card.ability.extra.chips+2
    end
    if context.joker_main and card.ability.extra.chips>0 then
      return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}
    end
  end })

-- n814: The Disciple -- +5 chips per discard remaining
SMODS.Joker({ key="n814", loc_txt={name="The Disciple",text={"{C:chips}+#1#{} Chips","per {C:attention}discard remaining"}}, config={chips=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=1}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local rem=G.GAME.current_round.discards_left or 0
      local bonus=card.ability.chips*rem
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n815: Chain Reaction -- +2 chips per card in played hand beyond 1
SMODS.Joker({ key="n815", loc_txt={name="Chain Reaction",text={"{C:chips}+#1#{} Chips","per card played {C:attention}beyond 1"}}, config={chips=2}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=1}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local extra=math.max(0,#G.play.cards-1)
      local bonus=card.ability.chips*extra
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n816: The Veteran -- starts +5 mult, gains +1 per round
SMODS.Joker({ key="n816", loc_txt={name="The Veteran",text={"{C:mult}+#1#{} Mult","gains {C:mult}+1{} per round"}}, config={extra={mult=5}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=5,y=1}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult=card.ability.extra.mult+1
    end
    if context.joker_main then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n817: The Gambler -- random +1 to +20 mult each hand
SMODS.Joker({ key="n817", loc_txt={name="The Gambler",text={"Random {C:mult}+1{} to {C:mult}+20{} Mult","each hand"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=1}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=math.random(1,20)
      return{mult=n,message=localize{type='variable',key='a_mult',vars={n}}}
    end
  end })

-- n818: Deck Surgeon -- +1 chips per card remaining in deck
SMODS.Joker({ key="n818", loc_txt={name="Deck Surgeon",text={"{C:chips}+#1#{} Chips","per card in {C:attention}remaining deck"}}, config={chips=1}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=1}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.deck.cards
      local bonus=card.ability.chips*n
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n819: Thin Deck -- X2 mult if deck has 20 or fewer cards
SMODS.Joker({ key="n819", loc_txt={name="Thin Deck",text={"{X:mult,C:white}X#1#{} Mult","if deck has {C:attention}20 or fewer{} cards"}}, config={Xmult=2}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=1}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.deck.cards<=20 then
      return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n820: Lucky Penny -- 1-in-4 chance to earn $2 each hand
SMODS.Joker({ key="n820", loc_txt={name="Lucky Penny",text={"{C:attention}1 in 4{} chance to","earn {C:money}$2{} each hand"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=1}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if math.random(1,4)==1 then
        ease_dollars(2)
        return{message="$2!"}
      end
    end
  end })

-- n821: The Miser -- gains +1 mult each time money is spent at shop
SMODS.Joker({ key="n821", loc_txt={name="The Miser",text={"Gains {C:mult}+1{} Mult","when money is spent","{C:mult}+#1#{} Mult now"}}, config={extra={mult=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=2}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.selling_self then
      card.ability.extra.mult=card.ability.extra.mult+1
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n822: Heart Specialist -- +12 chips per Heart scored
SMODS.Joker({ key="n822", loc_txt={name="Heart Specialist",text={"{C:chips}+#1#{} Chips","per {C:hearts}Heart{} scored"}}, config={chips=12}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=2}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=="Hearts" then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n823: Diamond Dealer -- +12 chips per Diamond scored
SMODS.Joker({ key="n823", loc_txt={name="Diamond Dealer",text={"{C:chips}+#1#{} Chips","per {C:diamonds}Diamond{} scored"}}, config={chips=12}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=2}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=="Diamonds" then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n824: Club Crusher -- +12 chips per Club scored
SMODS.Joker({ key="n824", loc_txt={name="Club Crusher",text={"{C:chips}+#1#{} Chips","per {C:clubs}Club{} scored"}}, config={chips=12}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=2}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=="Clubs" then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n825: Spade Stalker -- +12 chips per Spade scored
SMODS.Joker({ key="n825", loc_txt={name="Spade Stalker",text={"{C:chips}+#1#{} Chips","per {C:spades}Spade{} scored"}}, config={chips=12}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=2}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=="Spades" then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n826: Red Rush -- +4 mult if all cards in played hand are red (Hearts/Diamonds)
SMODS.Joker({ key="n826", loc_txt={name="Red Rush",text={"{C:mult}+#1#{} Mult","if all played cards are {C:hearts}red"}}, config={mult=12}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=2}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local all_red=true
      for _,c in ipairs(G.play.cards) do
        if c.base.suit~="Hearts" and c.base.suit~="Diamonds" then all_red=false; break end
      end
      if all_red and #G.play.cards>0 then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n827: Black Out -- +4 mult if all played cards are black (Clubs/Spades)
SMODS.Joker({ key="n827", loc_txt={name="Black Out",text={"{C:mult}+#1#{} Mult","if all played cards are {C:spades}black"}}, config={mult=12}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=2}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local all_black=true
      for _,c in ipairs(G.play.cards) do
        if c.base.suit~="Clubs" and c.base.suit~="Spades" then all_black=false; break end
      end
      if all_black and #G.play.cards>0 then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n828: Pair Pressure -- +8 mult if played hand is exactly a Pair
SMODS.Joker({ key="n828", loc_txt={name="Pair Pressure",text={"{C:mult}+#1#{} Mult","if played hand is a {C:attention}Pair"}}, config={mult=8}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=2}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and context.scoring_name=="Pair" then
      return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n829: Flush Fan -- X2 mult if played hand is a Flush
SMODS.Joker({ key="n829", loc_txt={name="Flush Fan",text={"{X:mult,C:white}X#1#{} Mult","if played hand is a {C:attention}Flush"}}, config={Xmult=2}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=2}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and context.scoring_name=="Flush" then
      return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n830: Straight Edge -- X2 mult if played hand is a Straight
SMODS.Joker({ key="n830", loc_txt={name="Straight Edge",text={"{X:mult,C:white}X#1#{} Mult","if played hand is a {C:attention}Straight"}}, config={Xmult=2}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=2}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and context.scoring_name=="Straight" then
      return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n831: Full House Special -- +25 chips if played hand is a Full House
SMODS.Joker({ key="n831", loc_txt={name="Full House Special",text={"{C:chips}+#1#{} Chips","if hand is a {C:attention}Full House"}}, config={chips=25}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=3}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main and context.scoring_name=="Full House" then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n832: Lucky 7 -- +7 mult if total chip score would be divisible by 7
SMODS.Joker({ key="n832", loc_txt={name="Lucky 7",text={"Random {C:mult}+7{} Mult","7% of the time"}}, config={mult=7}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=3}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if math.random(1,14)<=1 then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n833: Grind Stone -- gains +2 chips for each hand played this run
SMODS.Joker({ key="n833", loc_txt={name="Grind Stone",text={"Gains {C:chips}+2{} Chips","each hand played","{C:chips}+#1#{} Chips now"}}, config={extra={chips=0}}, rarity=2, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=3}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.before then
      card.ability.extra.chips=card.ability.extra.chips+2
    end
    if context.joker_main and card.ability.extra.chips>0 then
      return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}
    end
  end })

-- n834: The Escalator -- +1 mult per hand played this round
SMODS.Joker({ key="n834", loc_txt={name="The Escalator",text={"{C:mult}+#1#{} Mult","per hand played {C:attention}this round"}}, config={mult=1}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=3}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hands_played=G.GAME.current_round.hands_played or 0
      local bonus=card.ability.mult*(hands_played+1)
      return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}}
    end
  end })

-- n835: Reversal -- +15 mult if hand size equals 1
SMODS.Joker({ key="n835", loc_txt={name="Reversal",text={"{C:mult}+#1#{} Mult","if only {C:attention}1 card{} in hand"}}, config={mult=15}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=3}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.hand.cards==1 then
      return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n836: Overflow -- +3 chips per card in hand above 5
SMODS.Joker({ key="n836", loc_txt={name="Overflow",text={"{C:chips}+#1#{} Chips","per card in hand {C:attention}above 5"}}, config={chips=3}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=3}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local extra=math.max(0,#G.hand.cards-5)
      local bonus=card.ability.chips*extra
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n837: Bottleneck -- X3 mult if hand size is exactly 3
SMODS.Joker({ key="n837", loc_txt={name="Bottleneck",text={"{X:mult,C:white}X#1#{} Mult","if hand size is exactly {C:attention}3"}}, config={Xmult=3}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=3}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.hand.cards==3 then
      return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n838: Recycle -- gains +1 mult each time a card is discarded
SMODS.Joker({ key="n838", loc_txt={name="Recycle",text={"Gains {C:mult}+1{} Mult","per card discarded","{C:mult}+#1#{} Mult now"}}, config={extra={mult=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=7,y=3}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.remove_playing_cards and context.removed then
      card.ability.extra.mult=card.ability.extra.mult+#context.removed
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n839: The Banker -- earns $1 at end of every round
SMODS.Joker({ key="n839", loc_txt={name="The Banker",text={"Earn {C:money}$1{}","at end of each round"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=3}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      ease_dollars(1)
      return{message="$1!"}
    end
  end })

-- n840: The Investor -- earns $1 per joker held at end of round
SMODS.Joker({ key="n840", loc_txt={name="The Investor",text={"Earn {C:money}$1{}","per joker at end of round"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=3}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      local n=#G.jokers.cards
      if n>0 then ease_dollars(n); return{message="$"..n.."!"} end
    end
  end })

-- n841: Snowball -- starts with +0 mult, gains +3 mult at end of each round
SMODS.Joker({ key="n841", loc_txt={name="Snowball",text={"Gains {C:mult}+3{} Mult","each round","{C:mult}+#1#{} Mult now"}}, config={extra={mult=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=4}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult=card.ability.extra.mult+3
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n842: Double Down -- X2 mult if same hand played twice in a row
SMODS.Joker({ key="n842", loc_txt={name="Double Down",text={"{X:mult,C:white}X#1#{} Mult","if same hand played {C:attention}twice in a row"}}, config={extra={Xmult=2,last_hand=""}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=1,y=4}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local current=context.scoring_name or ""
      if current==card.ability.extra.last_hand and current~="" then
        return{Xmult=card.ability.extra.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}}}
      end
    end
    if context.before then
      card.ability.extra.last_hand=context.scoring_name or ""
    end
  end })

-- n843: Perfect Score -- +20 chips if no discards were used this round
SMODS.Joker({ key="n843", loc_txt={name="Perfect Score",text={"{C:chips}+#1#{} Chips","if {C:attention}no discards{} used this round"}}, config={chips=20}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=4}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local discards=G.GAME.current_round.discards_used or 0
      if discards==0 then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n844: Waste Not -- +5 mult if no hands remain after this play
SMODS.Joker({ key="n844", loc_txt={name="Waste Not",text={"{C:mult}+#1#{} Mult","if {C:attention}last hand{} of round"}}, config={mult=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=4}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hands_left=G.GAME.current_round.hands_left or 0
      if hands_left<=1 then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n845: First Strike -- X3 mult on first hand of the round only
SMODS.Joker({ key="n845", loc_txt={name="First Strike",text={"{X:mult,C:white}X#1#{} Mult","on the {C:attention}first hand{} of the round"}}, config={extra={Xmult=3}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=4,y=4}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hands_played=G.GAME.current_round.hands_played or 0
      if hands_played==0 then
        return{Xmult=card.ability.extra.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}}}
      end
    end
  end })

-- n846: The Counter -- +1 mult per scored card total this run
SMODS.Joker({ key="n846", loc_txt={name="The Counter",text={"Gains {C:mult}+1{} Mult","per card scored","{C:mult}+#1#{} Mult now"}}, config={extra={mult=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=5,y=4}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      card.ability.extra.mult=card.ability.extra.mult+1
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n847: Momentum -- +2 chips per hand played in a row without discarding
SMODS.Joker({ key="n847", loc_txt={name="Momentum",text={"Gains {C:chips}+2{} Chips","each hand without discarding","{C:chips}+#1#{} Chips now"}}, config={extra={chips=0}}, rarity=2, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=6,y=4}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.before then
      local discards=G.GAME.current_round.discards_used or 0
      if discards==0 then card.ability.extra.chips=card.ability.extra.chips+2 end
    end
    if context.joker_main and card.ability.extra.chips>0 then
      return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}
    end
  end })

-- n848: Overachiever -- +5 chips per hand remaining after scoring
SMODS.Joker({ key="n848", loc_txt={name="Overachiever",text={"{C:chips}+#1#{} Chips","per {C:attention}hand remaining{}"}}, config={chips=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=4}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local rem=G.GAME.current_round.hands_left or 0
      local bonus=card.ability.chips*rem
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n849: The Long Game -- gains +1 Xmult every 5 rounds
SMODS.Joker({ key="n849", loc_txt={name="The Long Game",text={"{X:mult,C:white}X#1#{} Mult","gains {X:mult,C:white}+0.5{} every 5 rounds"}}, config={extra={Xmult=1}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=8,y=4}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.Xmult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      local r=G.GAME.round or 1
      if r%5==0 then card.ability.extra.Xmult=card.ability.extra.Xmult+0.5 end
    end
    if context.joker_main and card.ability.extra.Xmult>1 then
      return{Xmult=card.ability.extra.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}}}
    end
  end })

-- n850: The Architect -- +50 chips, -5 mult (chip heavy synergy)
SMODS.Joker({ key="n850", loc_txt={name="The Architect",text={"{C:chips}+#1#{} Chips","{C:mult}-#2#{} Mult"}}, config={chips=50,mult=-5}, rarity=2, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=4}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips,center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{chips=card.ability.chips,mult=card.ability.mult,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n851: The Berserker -- +5 chips per mult you have
SMODS.Joker({ key="n851", loc_txt={name="The Berserker",text={"Gains {C:chips}+#1#{} Chips","per {C:mult}Mult{} total"}}, config={chips=5}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=5}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local bonus=card.ability.chips
      return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}}
    end
  end })

-- n852: Critical Hit -- 1 in 8 chance to deal X4 mult
SMODS.Joker({ key="n852", loc_txt={name="Critical Hit",text={"{C:attention}1 in 8{} chance for","{X:mult,C:white}X#1#{} Mult"}}, config={Xmult=4}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=5}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if math.random(1,8)==1 then
        return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
      end
    end
  end })

-- n853: The Purist -- +15 mult if only one suit in played hand
SMODS.Joker({ key="n853", loc_txt={name="The Purist",text={"{C:mult}+#1#{} Mult","if all played cards share one {C:attention}suit"}}, config={mult=15}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=5}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local suits={}
      for _,c in ipairs(G.play.cards) do suits[c.base.suit]=true end
      local n=0; for _ in pairs(suits) do n=n+1 end
      if n==1 then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n854: Rainbow -- +3 mult if all 4 suits present in played hand
SMODS.Joker({ key="n854", loc_txt={name="Rainbow",text={"{C:mult}+#1#{} Mult","if all {C:attention}4 suits{} in played hand"}}, config={mult=20}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=5}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local suits={}
      for _,c in ipairs(G.play.cards) do suits[c.base.suit]=true end
      local n=0; for _ in pairs(suits) do n=n+1 end
      if n==4 then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n855: Synergy -- +2 mult per joker (excluding self)
SMODS.Joker({ key="n855", loc_txt={name="Synergy",text={"{C:mult}+#1#{} Mult","per other joker held"}}, config={mult=2}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=5}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=math.max(0,#G.jokers.cards-1)
      local bonus=card.ability.mult*n
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n856: The Loner -- X3 mult if you have only 1 joker (this one)
SMODS.Joker({ key="n856", loc_txt={name="The Loner",text={"{X:mult,C:white}X#1#{} Mult","if this is your {C:attention}only joker"}}, config={Xmult=3}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=5}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.jokers.cards==1 then
      return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n857: Hot Streak -- +2 mult per round in a row without losing
SMODS.Joker({ key="n857", loc_txt={name="Hot Streak",text={"Gains {C:mult}+2{} Mult","each round won","{C:mult}+#1#{} Mult now"}}, config={extra={mult=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=6,y=5}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult=card.ability.extra.mult+2
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n858: Solid Ground -- +10 chips if deck has exactly 52 cards
SMODS.Joker({ key="n858", loc_txt={name="Solid Ground",text={"{C:chips}+#1#{} Chips","if deck has exactly {C:attention}52 cards"}}, config={chips=10}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=5}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.deck.cards==52 then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n859: Chip Away -- +8 chips per Ace scored
SMODS.Joker({ key="n859", loc_txt={name="Chip Away",text={"{C:chips}+#1#{} Chips","per {C:attention}Ace{} scored"}}, config={chips=8}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=5}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=="Ace" then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n860: King's Ransom -- +5 mult per King scored
SMODS.Joker({ key="n860", loc_txt={name="King's Ransom",text={"{C:mult}+#1#{} Mult","per {C:attention}King{} scored"}}, config={mult=5}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=5}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=="King" then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n861: Queen's Favor -- +5 mult per Queen scored
SMODS.Joker({ key="n861", loc_txt={name="Queen's Favor",text={"{C:mult}+#1#{} Mult","per {C:attention}Queen{} scored"}}, config={mult=5}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=6}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=="Queen" then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n862: Jack of All -- +3 mult per Jack scored
SMODS.Joker({ key="n862", loc_txt={name="Jack of All",text={"{C:mult}+#1#{} Mult","per {C:attention}Jack{} scored"}}, config={mult=3}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=6}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=="Jack" then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n863: Ten Percent -- +10 chips per 10 scored
SMODS.Joker({ key="n863", loc_txt={name="Ten Percent",text={"{C:chips}+#1#{} Chips","per {C:attention}10{} scored"}}, config={chips=10}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=6}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=="10" then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n864: Low Ball -- +3 chips per 2, 3, or 4 scored
SMODS.Joker({ key="n864", loc_txt={name="Low Ball",text={"{C:chips}+#1#{} Chips","per {C:attention}2, 3, or 4{} scored"}}, config={chips=3}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=6}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=="2" or v=="3" or v=="4" then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n865: High Ball -- +3 chips per 9, 10 scored
SMODS.Joker({ key="n865", loc_txt={name="High Ball",text={"{C:chips}+#1#{} Chips","per {C:attention}9 or 10{} scored"}}, config={chips=4}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=6}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=="9" or v=="10" then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n866: Middle Child -- +5 chips per 5, 6, 7, or 8 scored
SMODS.Joker({ key="n866", loc_txt={name="Middle Child",text={"{C:chips}+#1#{} Chips","per {C:attention}5,6,7, or 8{} scored"}}, config={chips=5}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=6}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=="5" or v=="6" or v=="7" or v=="8" then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n867: Odd Numbers -- +4 chips per odd number (3,5,7,9) scored
SMODS.Joker({ key="n867", loc_txt={name="Odd Numbers",text={"{C:chips}+#1#{} Chips","per {C:attention}odd number{} scored"}}, config={chips=4}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=6}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=="3" or v=="5" or v=="7" or v=="9" then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n868: Even Numbers -- +4 chips per even number (2,4,6,8,10) scored
SMODS.Joker({ key="n868", loc_txt={name="Even Numbers",text={"{C:chips}+#1#{} Chips","per {C:attention}even number{} scored"}}, config={chips=4}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=6}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=="2" or v=="4" or v=="6" or v=="8" or v=="10" then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n869: Full Count -- +15 mult if exactly 5 cards played
SMODS.Joker({ key="n869", loc_txt={name="Full Count",text={"{C:mult}+#1#{} Mult","if exactly {C:attention}5 cards{} played"}}, config={mult=15}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=6}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards==5 then
      return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n870: Two's Company -- +8 mult if exactly 2 cards played
SMODS.Joker({ key="n870", loc_txt={name="Two's Company",text={"{C:mult}+#1#{} Mult","if exactly {C:attention}2 cards{} played"}}, config={mult=8}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=6}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards==2 then
      return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n871: The Grinder -- +1 mult per card scored total this hand
SMODS.Joker({ key="n871", loc_txt={name="The Grinder",text={"{C:mult}+#1#{} Mult","per {C:attention}card scored{} this hand"}}, config={mult=1}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=7}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#context.scoring_hand
      local bonus=card.ability.mult*n
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n872: Penny Hoarder -- earns $1 for each $5 you have at end of round
SMODS.Joker({ key="n872", loc_txt={name="Penny Hoarder",text={"Earn {C:money}$1{}","per {C:money}$5{} at end of round"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=7}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      local money=G.GAME.dollars or 0
      local earn=math.floor(money/5)
      if earn>0 then ease_dollars(earn); return{message="$"..earn.."!"} end
    end
  end })

-- n873: Stingy -- +3 mult if money is 3 or less
SMODS.Joker({ key="n873", loc_txt={name="Stingy",text={"{C:mult}+#1#{} Mult","if you have {C:money}$3{} or less"}}, config={mult=20}, rarity=2, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=7}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and (G.GAME.dollars or 0)<=3 then
      return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n874: Loaded -- +15 chips if money is $20 or more
SMODS.Joker({ key="n874", loc_txt={name="Loaded",text={"{C:chips}+#1#{} Chips","if you have {C:money}$20{} or more"}}, config={chips=15}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=7}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main and (G.GAME.dollars or 0)>=20 then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n875: Half Measures -- X2 mult if exactly half your hand is played
SMODS.Joker({ key="n875", loc_txt={name="Half Measures",text={"{X:mult,C:white}X#1#{} Mult","if exactly half your hand played"}}, config={Xmult=2}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=7}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local total=#G.hand.cards+#G.play.cards
      if total>0 and #G.play.cards*2==total then
        return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
      end
    end
  end })

-- n876: The Flipper -- +5 chips per card in hand, -2 mult
SMODS.Joker({ key="n876", loc_txt={name="The Flipper",text={"{C:chips}+#1#{} Chips per card in hand","{C:mult}-#2#{} Mult"}}, config={chips=5,mult=-2}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=7}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips,center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.hand.cards
      return{chips=card.ability.chips*n,mult=card.ability.mult,message=localize{type='variable',key='a_chips',vars={card.ability.chips*n}}}
    end
  end })

-- n877: The Equalizer -- +3 chips AND +3 mult every hand
SMODS.Joker({ key="n877", loc_txt={name="The Equalizer",text={"{C:chips}+#1#{} Chips","and {C:mult}+#2#{} Mult"}}, config={chips=3,mult=3}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=7}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips,center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{chips=card.ability.chips,mult=card.ability.mult,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n878: Booster -- X1.5 mult if hand contains 5+ cards
SMODS.Joker({ key="n878", loc_txt={name="Booster",text={"{X:mult,C:white}X#1#{} Mult","if hand has {C:attention}5 or more{} cards"}}, config={Xmult=1.5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=7}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.hand.cards>=5 then
      return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n879: The Builder -- gains +1 chips each card scored
SMODS.Joker({ key="n879", loc_txt={name="The Builder",text={"Gains {C:chips}+1{} Chips","per card scored","{C:chips}+#1#{} Chips now"}}, config={extra={chips=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=8,y=7}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      card.ability.extra.chips=card.ability.extra.chips+1
    end
    if context.joker_main and card.ability.extra.chips>0 then
      return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}
    end
  end })

-- n880: The Destroyer -- gains +2 mult per destroyed card
SMODS.Joker({ key="n880", loc_txt={name="The Destroyer",text={"Gains {C:mult}+2{} Mult","per destroyed card","{C:mult}+#1#{} Mult now"}}, config={extra={mult=0}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=7}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.remove_playing_cards and context.removed then
      card.ability.extra.mult=card.ability.extra.mult+(#context.removed*2)
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n881: Rapid Fire -- +1 mult per hand played total this run
SMODS.Joker({ key="n881", loc_txt={name="Rapid Fire",text={"{C:mult}+#1#{} Mult","equal to hands played {C:attention}this run"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=8}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={G.GAME.hands_played or 0}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=G.GAME.hands_played or 0
      if n>0 then return{mult=n,message=localize{type='variable',key='a_mult',vars={n}}} end
    end
  end })

-- n882: Clean Slate -- +10 mult at start, loses -1 mult each round
SMODS.Joker({ key="n882", loc_txt={name="Clean Slate",text={"Starts {C:mult}+10{} Mult","loses {C:mult}-1{} each round","{C:mult}+#1#{} Mult now"}}, config={extra={mult=10}}, rarity=2, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=1,y=8}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={math.max(0,center.ability.extra.mult)}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult=math.max(0,card.ability.extra.mult-1)
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n883: Compression -- +2 chips per card NOT played from hand
SMODS.Joker({ key="n883", loc_txt={name="Compression",text={"{C:chips}+#1#{} Chips","per card {C:attention}held in hand{} not played"}}, config={chips=2}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=8}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.hand.cards
      local bonus=card.ability.chips*n
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n884: Wealth Accumulator -- +1 chips per dollar spent total this run
SMODS.Joker({ key="n884", loc_txt={name="Wealth Accumulator",text={"Gains {C:chips}+1{} Chips","per dollar spent","{C:chips}+#1#{} Chips now"}}, config={extra={chips=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=3,y=8}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.selling_card then
      card.ability.extra.chips=card.ability.extra.chips+1
    end
    if context.joker_main and card.ability.extra.chips>0 then
      return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}
    end
  end })

-- n885: Rapid Growth -- +0.5 Xmult per round
SMODS.Joker({ key="n885", loc_txt={name="Rapid Growth",text={"{X:mult,C:white}X#1#{} Mult","gains {X:mult,C:white}+0.5{} each round"}}, config={extra={Xmult=1}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=4,y=8}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.Xmult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.Xmult=card.ability.extra.Xmult+0.5
    end
    if context.joker_main and card.ability.extra.Xmult>1 then
      return{Xmult=card.ability.extra.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}}}
    end
  end })

-- n886: Diamond in the Rough -- +15 chips per Diamond in hand (not played)
SMODS.Joker({ key="n886", loc_txt={name="Diamond in the Rough",text={"{C:chips}+#1#{} Chips","per {C:diamonds}Diamond{} held in hand"}}, config={chips=15}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=8}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(G.hand.cards) do
        if c.base.suit=="Diamonds" then count=count+1 end
      end
      local bonus=card.ability.chips*count
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n887: Flush or Bust -- X3 mult if Flush, else -5 mult
SMODS.Joker({ key="n887", loc_txt={name="Flush or Bust",text={"{X:mult,C:white}X#1#{} Mult","if {C:attention}Flush{}, otherwise {C:mult}-#2#{} Mult"}}, config={Xmult=3,mult=-5}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=8}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult,center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if context.scoring_name=="Flush" or context.scoring_name=="Straight Flush" or context.scoring_name=="Royal Flush" or context.scoring_name=="Flush House" or context.scoring_name=="Flush Five" then
        return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
      else
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n888: The Specialist -- X2 mult if all played cards are the same rank
SMODS.Joker({ key="n888", loc_txt={name="The Specialist",text={"{X:mult,C:white}X#1#{} Mult","if all played cards share {C:attention}same rank"}}, config={Xmult=2}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=8}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local rank=nil; local same=true
      for _,c in ipairs(G.play.cards) do
        if rank==nil then rank=c.base.value
        elseif c.base.value~=rank then same=false; break end
      end
      if same and rank~=nil and #G.play.cards>0 then
        return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
      end
    end
  end })

-- n889: Multiplier Factory -- +2 mult per mult joker in play
SMODS.Joker({ key="n889", loc_txt={name="Multiplier Factory",text={"Gains {C:mult}+#1#{} Mult","per joker held"}}, config={mult=2}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=8}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.jokers.cards
      local bonus=card.ability.mult*n
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n890: The Wildcard -- +2 mult if any Joker card in hand
SMODS.Joker({ key="n890", loc_txt={name="The Wildcard",text={"{C:mult}+#1#{} Mult","always active"}}, config={mult=5}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=8}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n891: Suit Shopper -- +2 chips per unique suit in played hand
SMODS.Joker({ key="n891", loc_txt={name="Suit Shopper",text={"{C:chips}+#1#{} Chips","per {C:attention}unique suit{} in played hand"}}, config={chips=8}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=9}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local suits={}
      for _,c in ipairs(G.play.cards) do suits[c.base.suit]=true end
      local n=0; for _ in pairs(suits) do n=n+1 end
      local bonus=card.ability.chips*n
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n892: Lucky Draw -- earn $1 whenever you score a Pair
SMODS.Joker({ key="n892", loc_txt={name="Lucky Draw",text={"Earn {C:money}$1{}","when you score a {C:attention}Pair"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=9}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={}} end,
  calculate=function(self,card,context)
    if context.joker_main and context.scoring_name=="Pair" then
      ease_dollars(1)
      return{message="$1!"}
    end
  end })

-- n893: Straight Cash -- earn $1 whenever you score a Straight
SMODS.Joker({ key="n893", loc_txt={name="Straight Cash",text={"Earn {C:money}$1{}","when you score a {C:attention}Straight"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=9}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={}} end,
  calculate=function(self,card,context)
    if context.joker_main and context.scoring_name=="Straight" then
      ease_dollars(1)
      return{message="$1!"}
    end
  end })

-- n894: Flush With Cash -- earn $2 whenever you score a Flush
SMODS.Joker({ key="n894", loc_txt={name="Flush With Cash",text={"Earn {C:money}$2{}","when you score a {C:attention}Flush"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=9}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={}} end,
  calculate=function(self,card,context)
    if context.joker_main and context.scoring_name=="Flush" then
      ease_dollars(2)
      return{message="$2!"}
    end
  end })

-- n895: The Stack -- +5 chips, gains +2 chips at end of round
SMODS.Joker({ key="n895", loc_txt={name="The Stack",text={"Gains {C:chips}+2{} Chips","each round","{C:chips}+#1#{} Chips now"}}, config={extra={chips=5}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=4,y=9}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips=card.ability.extra.chips+2
    end
    if context.joker_main then
      return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}
    end
  end })

-- n896: Ante Up -- +5 mult per ante
SMODS.Joker({ key="n896", loc_txt={name="Ante Up",text={"{C:mult}+#1#{} Mult","per current {C:attention}Ante"}}, config={mult=5}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=9}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ante=G.GAME.round_resets.ante or 1
      local bonus=card.ability.mult*ante
      return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}}
    end
  end })

-- n897: Round Robin -- +3 mult per blind beaten this run
SMODS.Joker({ key="n897", loc_txt={name="Round Robin",text={"{C:mult}+#1#{} Mult","per {C:attention}blind beaten{} this run"}}, config={extra={mult=0}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=6,y=9}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult=card.ability.extra.mult+3
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n898: All In -- X4 mult if all hands used (0 left)
SMODS.Joker({ key="n898", loc_txt={name="All In",text={"{X:mult,C:white}X#1#{} Mult","if {C:attention}no hands remain{}"}}, config={Xmult=4}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=9}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hands_left=G.GAME.current_round.hands_left or 0
      if hands_left<=1 then
        return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
      end
    end
  end })

-- n899: Combo Breaker -- +4 mult per unique hand type played this run
SMODS.Joker({ key="n899", loc_txt={name="Combo Breaker",text={"{C:mult}+#1#{} Mult","per {C:attention}unique hand type{} played this run"}}, config={mult=4}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=9}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      if G.GAME.hands then
        for _,hand in pairs(G.GAME.hands) do
          if hand.played and hand.played>0 then count=count+1 end
        end
      end
      local bonus=card.ability.mult*count
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n900: Grand Finale -- X2 mult on every hand, X5 on last hand of run
SMODS.Joker({ key="n900", loc_txt={name="Grand Finale",text={"{X:mult,C:white}X#1#{} Mult","always active"}}, config={Xmult=2}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=9}, atlas="cm_atlas_09",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })
