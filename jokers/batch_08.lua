-- ClaudeMod Batch 08: Mythology & Fantasy (n701-n800)

-- n701: Zeus -- gains Xmult per Spade scored (lightning = spades)
SMODS.Joker({ key="n701", loc_txt={name="Zeus",text={"{X:mult,C:white}X#1#{} Mult","gains {X:mult,C:white}X0.2{} per {C:attention}Spade{} scored"}}, config={extra={xmult=1}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=0}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.xmult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Spades' then
        card.ability.extra.xmult=card.ability.extra.xmult+0.2
        return{message=localize('k_upgrade_ex')}
      end
    end
    if context.joker_main then return{Xmult=card.ability.extra.xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}}} end
  end })

-- n702: Medusa -- +50 chips per round, +25 chips per Spade scored (petrifying gaze)
SMODS.Joker({ key="n702", loc_txt={name="Medusa",text={"{C:chips}+#1#{} Chips","plus {C:chips}+25{} per {C:attention}Spade{} scored"}}, config={chips=50}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=0}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Spades' then
        return{chips=25,message=localize{type='variable',key='a_chips',vars={25}}}
      end
    end
    if context.joker_main then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
  end })

-- n703: Poseidon -- +3 Mult per Heart scored (water = hearts)
SMODS.Joker({ key="n703", loc_txt={name="Poseidon",text={"{C:mult}+#1#{} Mult","per {C:attention}Heart{} scored"}}, config={mult=3}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=0}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Hearts' then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n704: Hades -- gains X0.5 Xmult each time any joker is sold
SMODS.Joker({ key="n704", loc_txt={name="Hades",text={"{X:mult,C:white}X#1#{} Mult","gains {X:mult,C:white}X0.5{} when a {C:attention}Joker{} is sold"}}, config={extra={xmult=1}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=3,y=0}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.xmult}} end,
  calculate=function(self,card,context)
    if context.selling_card and context.selling_card.config and context.selling_card.config.center and context.selling_card.config.center.set=='Joker' then
      card.ability.extra.xmult=card.ability.extra.xmult+0.5
      return{message=localize('k_upgrade_ex')}
    end
    if context.joker_main then return{Xmult=card.ability.extra.xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}}} end
  end })

-- n705: Apollo -- +5 Mult per Diamond scored (sun = gold = diamonds)
SMODS.Joker({ key="n705", loc_txt={name="Apollo",text={"{C:mult}+#1#{} Mult","per {C:attention}Diamond{} scored"}}, config={mult=5}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=0}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Diamonds' then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n706: Artemis -- +4 Mult per Club scored (forest = clubs)
SMODS.Joker({ key="n706", loc_txt={name="Artemis",text={"{C:mult}+#1#{} Mult","per {C:attention}Club{} scored"}}, config={mult=4}, rarity=2, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=0}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Clubs' then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n707: Ares -- +10 Mult when hand contains any face card (warrior's fury)
SMODS.Joker({ key="n707", loc_txt={name="Ares",text={"{C:mult}+#1#{} Mult","if hand contains a {C:attention}face card{}"}}, config={mult=10}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=0}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local has_face=false
      for _,c in ipairs(context.scoring_hand or {}) do
        if c.base.value=='Jack' or c.base.value=='Queen' or c.base.value=='King' then has_face=true;break end
      end
      if has_face then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n708: Hermes -- +1 Mult per joker you own (messenger of gods)
SMODS.Joker({ key="n708", loc_txt={name="Hermes",text={"{C:mult}+#1#{} Mult","per {C:attention}Joker{} owned"}}, config={mult=1}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=0}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.jokers.cards
      local bonus=card.ability.mult*n
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n709: Athena -- +20 chips per hand played this round (wisdom accumulates)
SMODS.Joker({ key="n709", loc_txt={name="Athena",text={"{C:chips}+#1#{} Chips","per {C:attention}hand{} played this round"}}, config={chips=20}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=0}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hands_played=(G.GAME.current_round.hands_played or 0)
      local bonus=card.ability.chips*hands_played
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n710: Dionysus -- +2 Mult for each discard used this round (drink up!)
SMODS.Joker({ key="n710", loc_txt={name="Dionysus",text={"{C:mult}+#1#{} Mult","per {C:attention}discard{} used this round"}}, config={mult=2}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=0}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local discards=(G.GAME.current_round.discards_used or 0)
      local bonus=card.ability.mult*discards
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n711: Hera -- X2 Mult if you have 4 or more jokers (queen of the gods)
SMODS.Joker({ key="n711", loc_txt={name="Hera",text={"{X:mult,C:white}X#1#{} Mult","if you have {C:attention}4+{} Jokers"}}, config={Xmult=2}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=1}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.jokers.cards>=4 then
      return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n712: Persephone -- +15 Mult for half the rounds (spring/autumn cycle, every other round)
SMODS.Joker({ key="n712", loc_txt={name="Persephone",text={"{C:mult}+#1#{} Mult","on {C:attention}odd{} rounds (spring)"}}, config={mult=15}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=1}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and (G.GAME.round or 1)%2==1 then
      return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n713: Aphrodite -- +8 Mult per Heart scored (goddess of love = hearts)
SMODS.Joker({ key="n713", loc_txt={name="Aphrodite",text={"{C:mult}+#1#{} Mult","per {C:attention}Heart{} scored"}}, config={mult=8}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=1}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Hearts' then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n714: Hercules -- +50 chips when 5 cards are played (labors of strength)
SMODS.Joker({ key="n714", loc_txt={name="Hercules",text={"{C:chips}+#1#{} Chips","when exactly {C:attention}5{} cards played"}}, config={chips=50}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=1}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards==5 then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n715: Achilles -- X3 Mult but only triggers if no Spades are scored (heel weakness)
SMODS.Joker({ key="n715", loc_txt={name="Achilles",text={"{X:mult,C:white}X#1#{} Mult","if no {C:attention}Spades{} in scored hand"}}, config={Xmult=3}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=1}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local has_spade=false
      for _,c in ipairs(context.scoring_hand or {}) do
        if c.base.suit=='Spades' then has_spade=true;break end
      end
      if not has_spade then return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}} end
    end
  end })

-- n716: Odysseus -- gains +5 chips per round survived (long journey home)
SMODS.Joker({ key="n716", loc_txt={name="Odysseus",text={"{C:chips}+#1#{} Chips","gains {C:chips}+5{} chips each round survived"}}, config={extra={chips=5}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=5,y=1}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}} end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips=card.ability.extra.chips+5
    end
  end })

-- n717: Perseus -- +30 chips per Spade scored (Medusa's killer, sword = spades)
SMODS.Joker({ key="n717", loc_txt={name="Perseus",text={"{C:chips}+#1#{} Chips","per {C:attention}Spade{} scored"}}, config={chips=30}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=1}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Spades' then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n718: Theseus -- +3 Mult per card in your hand (labyrinth navigator)
SMODS.Joker({ key="n718", loc_txt={name="Theseus",text={"{C:mult}+#1#{} Mult","per card in {C:attention}hand{}"}}, config={mult=3}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=1}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=G.hand and #G.hand.cards or 0
      local bonus=card.ability.mult*n
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n719: Odin -- X1.5 Mult; +X0.3 each round (all-father grows in wisdom)
SMODS.Joker({ key="n719", loc_txt={name="Odin",text={"{X:mult,C:white}X#1#{} Mult","gains {X:mult,C:white}X0.3{} each round"}}, config={extra={xmult=1.5}}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=8,y=1}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{Xmult=card.ability.extra.xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}}} end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.xmult=card.ability.extra.xmult+0.3
    end
  end })

-- n720: Thor -- +40 chips per Spade scored (thunder hammer smash)
SMODS.Joker({ key="n720", loc_txt={name="Thor",text={"{C:chips}+#1#{} Chips","per {C:attention}Spade{} scored"}}, config={chips=40}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=1}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Spades' then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n721: Loki -- gains +2 Mult and +20 Chips alternating each hand (trickster swaps)
SMODS.Joker({ key="n721", loc_txt={name="Loki",text={"{C:attention}Alternates{} between","{C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips"}}, config={extra={mode=0,mult=2,chips=20}}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=false, perishable_compat=true, pos={x=0,y=2}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult,center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if card.ability.extra.mode==0 then
        card.ability.extra.mode=1
        return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
      else
        card.ability.extra.mode=0
        return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}
      end
    end
  end })

-- n722: Freya -- +6 Mult per face card scored (love goddess, favors royalty)
SMODS.Joker({ key="n722", loc_txt={name="Freya",text={"{C:mult}+#1#{} Mult","per {C:attention}face card{} scored"}}, config={mult=6}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=2}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=='Jack' or v=='Queen' or v=='King' then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n723: Valkyrie -- +8 Mult per face card destroyed this round (chosen warriors)
SMODS.Joker({ key="n723", loc_txt={name="Valkyrie",text={"{C:mult}+#1#{} Mult","gains {C:mult}+8{} per {C:attention}face card{} destroyed"}}, config={extra={mult=0}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=2}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.remove_playing_cards and context.removed then
      for _,c in ipairs(context.removed) do
        local v=c.base.value
        if v=='Jack' or v=='Queen' or v=='King' then
          card.ability.extra.mult=card.ability.extra.mult+8
        end
      end
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n724: Ragnarok -- X5 Mult but only triggers if you have exactly 1 joker (end of all things)
SMODS.Joker({ key="n724", loc_txt={name="Ragnarok",text={"{X:mult,C:white}X#1#{} Mult","if this is your {C:attention}only{} Joker"}}, config={Xmult=5}, rarity=4, cost=20, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=3,y=2}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.jokers.cards==1 then
      return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n725: Yggdrasil -- all scoring cards give +5 extra chips (world tree nourishes all)
SMODS.Joker({ key="n725", loc_txt={name="Yggdrasil",text={"{C:chips}+#1#{} Chips","per {C:attention}scored card{}"}}, config={chips=5}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=2}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n726: Ra -- X2 Mult on Diamond hands (sun god, gold = diamonds)
SMODS.Joker({ key="n726", loc_txt={name="Ra",text={"{X:mult,C:white}X#1#{} Mult","if all scored cards are {C:attention}Diamonds{}"}}, config={Xmult=2}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=2}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local all_diamonds=true
      for _,c in ipairs(context.scoring_hand or {}) do
        if c.base.suit~='Diamonds' then all_diamonds=false;break end
      end
      if all_diamonds and #(context.scoring_hand or {})>0 then
        return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
      end
    end
  end })

-- n727: Anubis -- +5 Mult for each card discarded total this run (guide of the dead)
SMODS.Joker({ key="n727", loc_txt={name="Anubis",text={"{C:mult}+#1#{} Mult","gains {C:mult}+1{} per {C:attention}discard{} used ever"}}, config={extra={mult=0}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=6,y=2}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult=card.ability.extra.mult+(G.GAME.current_round.discards_used or 0)
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n728: Osiris -- +25 Mult at end of round (resurrection power)
SMODS.Joker({ key="n728", loc_txt={name="Osiris",text={"{C:mult}+#1#{} Mult","Always active"}}, config={mult=25}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=2}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
  end })

-- n729: Isis -- +10 chips per Heart scored (magic and protection = hearts)
SMODS.Joker({ key="n729", loc_txt={name="Isis",text={"{C:chips}+#1#{} Chips","per {C:attention}Heart{} scored"}}, config={chips=10}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=2}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Hearts' then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n730: Horus -- +15 Mult when Ace is scored (eye of the king)
SMODS.Joker({ key="n730", loc_txt={name="Horus",text={"{C:mult}+#1#{} Mult","per {C:attention}Ace{} scored"}}, config={mult=15}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=2}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=='Ace' then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n731: Set -- X2 Mult on Spade hands (god of chaos and darkness)
SMODS.Joker({ key="n731", loc_txt={name="Set",text={"{X:mult,C:white}X#1#{} Mult","if all scored cards are {C:attention}Spades{}"}}, config={Xmult=2}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=3}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local all_spades=true
      for _,c in ipairs(context.scoring_hand or {}) do
        if c.base.suit~='Spades' then all_spades=false;break end
      end
      if all_spades and #(context.scoring_hand or {})>0 then
        return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
      end
    end
  end })

-- n732: Dragon -- starts X1, gains X0.5 each round (growing power)
SMODS.Joker({ key="n732", loc_txt={name="Dragon",text={"{X:mult,C:white}X#1#{} Mult","gains {X:mult,C:white}X0.5{} each round"}}, config={extra={xmult=1}}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=1,y=3}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{Xmult=card.ability.extra.xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}}} end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.xmult=card.ability.extra.xmult+0.5
    end
  end })

-- n733: Phoenix -- gains X2 Xmult after losing a round (reborn from ashes)
SMODS.Joker({ key="n733", loc_txt={name="Phoenix",text={"{X:mult,C:white}X#1#{} Mult","gains {X:mult,C:white}X2{} upon {C:attention}reborn{}"}}, config={extra={xmult=1,reborn=false}}, rarity=4, cost=20, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=3}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.xmult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      if G.GAME.chips < G.GAME.blind.chips then
        card.ability.extra.xmult=card.ability.extra.xmult+2
        card.ability.extra.reborn=true
      end
    end
    if context.joker_main then return{Xmult=card.ability.extra.xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}}} end
  end })

-- n734: Unicorn -- +30 chips when hand is all Hearts (pure magic)
SMODS.Joker({ key="n734", loc_txt={name="Unicorn",text={"{C:chips}+#1#{} Chips","if all scored cards are {C:attention}Hearts{}"}}, config={chips=30}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=3}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local all_hearts=true
      for _,c in ipairs(context.scoring_hand or {}) do
        if c.base.suit~='Hearts' then all_hearts=false;break end
      end
      if all_hearts and #(context.scoring_hand or {})>0 then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n735: Mermaid -- +6 Mult per Heart scored (sea creature = hearts)
SMODS.Joker({ key="n735", loc_txt={name="Mermaid",text={"{C:mult}+#1#{} Mult","per {C:attention}Heart{} scored"}}, config={mult=6}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=3}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Hearts' then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n736: Centaur -- +5 Mult and +20 chips per hand (half man half horse duality)
SMODS.Joker({ key="n736", loc_txt={name="Centaur",text={"{C:mult}+#1#{} Mult","and {C:chips}+#2#{} Chips always"}}, config={mult=5,chips=20}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=3}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult,center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{mult=card.ability.mult,chips=card.ability.chips,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n737: Minotaur -- +100 chips when 5 cards played (labyrinth power, brute strength)
SMODS.Joker({ key="n737", loc_txt={name="Minotaur",text={"{C:chips}+#1#{} Chips","when exactly {C:attention}5{} cards are played"}}, config={chips=100}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=3}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards==5 then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n738: Siren -- +12 Mult when 1 card played (enchanting solo voice)
SMODS.Joker({ key="n738", loc_txt={name="Siren",text={"{C:mult}+#1#{} Mult","when exactly {C:attention}1{} card played"}}, config={mult=12}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=3}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards==1 then
      return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n739: Gorgon -- X1.5 Mult but converts to chips next hand (stone touch)
SMODS.Joker({ key="n739", loc_txt={name="Gorgon",text={"{C:attention}Alternates{} every hand","{X:mult,C:white}X#1#{} Mult or {C:chips}+#2#{} Chips"}}, config={extra={mode=0,xmult=1.5,chips=60}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=false, perishable_compat=true, pos={x=8,y=3}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.xmult,center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if card.ability.extra.mode==0 then
        card.ability.extra.mode=1
        return{Xmult=card.ability.extra.xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}}}
      else
        card.ability.extra.mode=0
        return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}
      end
    end
  end })

-- n740: Werewolf -- X3 Mult on even rounds only (full moon cycles)
SMODS.Joker({ key="n740", loc_txt={name="Werewolf",text={"{X:mult,C:white}X#1#{} Mult","on {C:attention}even{} rounds (full moon)"}}, config={Xmult=3}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=3}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and (G.GAME.round or 1)%2==0 then
      return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n741: Vampire -- drains +2 mult from each card destroyed this run
SMODS.Joker({ key="n741", loc_txt={name="Vampire",text={"{C:mult}+#1#{} Mult","gains {C:mult}+2{} per {C:attention}card{} destroyed"}}, config={extra={mult=0}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=4}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.remove_playing_cards and context.removed then
      card.ability.extra.mult=card.ability.extra.mult+(#context.removed*2)
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n742: Elf -- +3 Chips per card in hand (nimble fingers, large hand)
SMODS.Joker({ key="n742", loc_txt={name="Elf",text={"{C:chips}+#1#{} Chips","per card in {C:attention}hand{}"}}, config={chips=3}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=4}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=G.hand and #G.hand.cards or 0
      local bonus=card.ability.chips*n
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n743: Dwarf -- +40 chips per Diamond scored (miners love gems)
SMODS.Joker({ key="n743", loc_txt={name="Dwarf",text={"{C:chips}+#1#{} Chips","per {C:attention}Diamond{} scored"}}, config={chips=40}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=4}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Diamonds' then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n744: Wizard -- X1.5 Mult; gains +X0.5 per joker owned above 3 (arcane power)
SMODS.Joker({ key="n744", loc_txt={name="Wizard",text={"{X:mult,C:white}X#1#{} Mult","base, {C:attention}+X0.5{} per Joker above 3"}}, config={Xmult=1.5}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=4}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local extra=math.max(0,#G.jokers.cards-3)
      local xmult=card.ability.Xmult+(extra*0.5)
      return{Xmult=xmult,message=localize{type='variable',key='a_xmult',vars={xmult}}}
    end
  end })

-- n745: Paladin -- +15 Mult when hand contains an Ace (holy champion)
SMODS.Joker({ key="n745", loc_txt={name="Paladin",text={"{C:mult}+#1#{} Mult","if hand contains an {C:attention}Ace{}"}}, config={mult=15}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=4}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local has_ace=false
      for _,c in ipairs(context.scoring_hand or {}) do
        if c.base.value=='Ace' then has_ace=true;break end
      end
      if has_ace then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n746: Necromancer -- +3 Mult for each joker sold this run (raises the dead)
SMODS.Joker({ key="n746", loc_txt={name="Necromancer",text={"{C:mult}+#1#{} Mult","gains {C:mult}+3{} when any {C:attention}Joker{} is sold"}}, config={extra={mult=0}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=5,y=4}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.selling_card and context.selling_card.config and context.selling_card.config.center and context.selling_card.config.center.set=='Joker' then
      card.ability.extra.mult=card.ability.extra.mult+3
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n747: Fairy -- +4 Mult per Club scored (forest magic = clubs)
SMODS.Joker({ key="n747", loc_txt={name="Fairy",text={"{C:mult}+#1#{} Mult","per {C:attention}Club{} scored"}}, config={mult=4}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=4}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Clubs' then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n748: Giant -- +100 chips, no mult (brute force)
SMODS.Joker({ key="n748", loc_txt={name="Giant",text={"{C:chips}+#1#{} Chips","Always active"}}, config={chips=100}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=4}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}} end
  end })

-- n749: Excalibur -- X5 Mult if hand is Straight or better (legendary sword)
SMODS.Joker({ key="n749", loc_txt={name="Excalibur",text={"{X:mult,C:white}X#1#{} Mult","if hand is {C:attention}Straight{} or better"}}, config={Xmult=5}, rarity=4, cost=20, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=4}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hand_name=context.scoring_name or ''
      local powerful_hands={'Straight','Flush','Full House','Four of a Kind','Straight Flush','Royal Flush','Five of a Kind','Flush House','Flush Five'}
      local is_powerful=false
      for _,h in ipairs(powerful_hands) do if hand_name==h then is_powerful=true;break end end
      if is_powerful then return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}} end
    end
  end })

-- n750: Cerberus -- +10 Mult per joker beyond 3 (three-headed guard)
SMODS.Joker({ key="n750", loc_txt={name="Cerberus",text={"{C:mult}+#1#{} Mult","per {C:attention}Joker{} beyond 3"}}, config={mult=10}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=4}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local extra=math.max(0,#G.jokers.cards-3)
      local bonus=card.ability.mult*extra
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n751: Prometheus -- +5 Chips per card played (fire-giver, one card at a time)
SMODS.Joker({ key="n751", loc_txt={name="Prometheus",text={"{C:chips}+#1#{} Chips","per {C:attention}played card{}"}}, config={chips=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=5}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n752: Narcissus -- X2 Mult when only 1 card is played (self-obsessed solo)
SMODS.Joker({ key="n752", loc_txt={name="Narcissus",text={"{X:mult,C:white}X#1#{} Mult","when {C:attention}1{} card played"}}, config={Xmult=2}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=5}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards==1 then
      return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n753: Icarus -- X3 Mult but loses X0.5 each round (flies too close to the sun)
SMODS.Joker({ key="n753", loc_txt={name="Icarus",text={"{X:mult,C:white}X#1#{} Mult","loses {X:mult,C:white}X0.5{} each round (min X1)"}}, config={extra={xmult=3}}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=5}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{Xmult=card.ability.extra.xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}}} end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.xmult=math.max(1,card.ability.extra.xmult-0.5)
    end
  end })

-- n754: Cyclops -- +80 chips when exactly 1 card scored (one eye, one card)
SMODS.Joker({ key="n754", loc_txt={name="Cyclops",text={"{C:chips}+#1#{} Chips","when exactly {C:attention}1{} card played"}}, config={chips=80}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=5}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards==1 then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n755: Sphinx -- +25 chips per Ace scored (riddle keeper = aces are special)
SMODS.Joker({ key="n755", loc_txt={name="Sphinx",text={"{C:chips}+#1#{} Chips","per {C:attention}Ace{} scored"}}, config={chips=25}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=5}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=='Ace' then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n756: Hydra -- +5 Mult per scored card (grows more heads = more cards)
SMODS.Joker({ key="n756", loc_txt={name="Hydra",text={"{C:mult}+#1#{} Mult","per {C:attention}scored card{}"}}, config={mult=5}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=5}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n757: Chimera -- different bonus every hand: mult, chips, xmult cycling
SMODS.Joker({ key="n757", loc_txt={name="Chimera",text={"{C:attention}Cycles{} each hand","{C:mult}+15 Mult{} / {C:chips}+60 Chips{} / {X:mult,C:white}X2 Mult{}"}}, config={extra={phase=0}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=false, perishable_compat=true, pos={x=6,y=5}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local p=card.ability.extra.phase
      card.ability.extra.phase=(p+1)%3
      if p==0 then return{mult=15,message=localize{type='variable',key='a_mult',vars={15}}}
      elseif p==1 then return{chips=60,message=localize{type='variable',key='a_chips',vars={60}}}
      else return{Xmult=2,message=localize{type='variable',key='a_xmult',vars={2}}} end
    end
  end })

-- n758: Pegasus -- +20 chips when 2 or fewer cards played (swift wings = quick plays)
SMODS.Joker({ key="n758", loc_txt={name="Pegasus",text={"{C:chips}+#1#{} Chips","when {C:attention}2 or fewer{} cards played"}}, config={chips=20}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=5}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards<=2 then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n759: Charybdis -- +50 chips but only if 4 or more cards played (whirlpool swallows all)
SMODS.Joker({ key="n759", loc_txt={name="Charybdis",text={"{C:chips}+#1#{} Chips","when {C:attention}4+{} cards are played"}}, config={chips=50}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=5}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards>=4 then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n760: Scylla -- +8 Mult when 4 or more cards played (multi-headed monster)
SMODS.Joker({ key="n760", loc_txt={name="Scylla",text={"{C:mult}+#1#{} Mult","when {C:attention}4+{} cards are played"}}, config={mult=8}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=5}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards>=4 then
      return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n761: Triton -- +15 Mult per Club scored (sea god, seaweed = clubs)
SMODS.Joker({ key="n761", loc_txt={name="Triton",text={"{C:mult}+#1#{} Mult","per {C:attention}Club{} scored"}}, config={mult=15}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=6}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Clubs' then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n762: Midas -- +5 chips per Diamond scored, gains +1 per round (golden touch)
SMODS.Joker({ key="n762", loc_txt={name="Midas",text={"{C:chips}+#1#{} Chips","per {C:attention}Diamond{} scored, grows each round"}}, config={extra={chips=5}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=1,y=6}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Diamonds' then
        return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}
      end
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips=card.ability.extra.chips+1
    end
  end })

-- n763: Bacchus -- gains +2 mult per discard used, resets each round
SMODS.Joker({ key="n763", loc_txt={name="Bacchus",text={"{C:mult}+#1#{} Mult","gains {C:mult}+2{} per {C:attention}discard{} (resets each round)"}}, config={extra={mult=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=6}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.discard then
      card.ability.extra.mult=card.ability.extra.mult+2
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult=0
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n764: Atlas -- +2 Mult per card in scored hand (carries the whole hand)
SMODS.Joker({ key="n764", loc_txt={name="Atlas",text={"{C:mult}+#1#{} Mult","per card in {C:attention}scored hand{}"}}, config={mult=2}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=6}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#(context.scoring_hand or {})
      local bonus=card.ability.mult*n
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n765: Kronos -- X1 Xmult per round number (father of time, grows with age)
SMODS.Joker({ key="n765", loc_txt={name="Kronos",text={"{X:mult,C:white}X#1#{} Mult","equal to current {C:attention}round number{}"}}, config={Xmult=1}, rarity=4, cost=20, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=6}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={G.GAME and G.GAME.round or 1}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local r=G.GAME.round or 1
      return{Xmult=r,message=localize{type='variable',key='a_xmult',vars={r}}}
    end
  end })

-- n766: Kraken -- +200 chips when 5 cards played (rise from the deep)
SMODS.Joker({ key="n766", loc_txt={name="Kraken",text={"{C:chips}+#1#{} Chips","when exactly {C:attention}5{} cards played"}}, config={chips=200}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=6}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards==5 then
      return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n767: Titan -- +30 Mult always (primordial strength)
SMODS.Joker({ key="n767", loc_txt={name="Titan",text={"{C:mult}+#1#{} Mult","Always active"}}, config={mult=30}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=6}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
  end })

-- n768: Nymph -- +5 Mult per Club scored (nature spirit = clubs)
SMODS.Joker({ key="n768", loc_txt={name="Nymph",text={"{C:mult}+#1#{} Mult","per {C:attention}Club{} scored"}}, config={mult=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=6}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Clubs' then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n769: Oracle -- +4 Mult per Diamond scored (sees the future = fortune/gold)
SMODS.Joker({ key="n769", loc_txt={name="Oracle",text={"{C:mult}+#1#{} Mult","per {C:attention}Diamond{} scored"}}, config={mult=4}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=6}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Diamonds' then
        return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n770: Minotaur's Maze -- +10 chips per hand played total (growing labyrinth)
SMODS.Joker({ key="n770", loc_txt={name="The Labyrinth",text={"{C:chips}+#1#{} Chips","gains {C:chips}+10{} each {C:attention}hand{} played ever"}}, config={extra={chips=0}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=6}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      card.ability.extra.chips=card.ability.extra.chips+10
      return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}
    end
  end })

-- n771: Daedalus -- +25 chips per hand size above 4 (master craftsman, more tools)
SMODS.Joker({ key="n771", loc_txt={name="Daedalus",text={"{C:chips}+#1#{} Chips","per {C:attention}hand size{} above 4"}}, config={chips=25}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=7}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local extra=math.max(0,(G.hand and #G.hand.cards or 0)-4)
      local bonus=card.ability.chips*extra
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n772: Charon -- +20 Mult per joker destroyed this run (ferryman of the dead)
SMODS.Joker({ key="n772", loc_txt={name="Charon",text={"{C:mult}+#1#{} Mult","gains {C:mult}+20{} per {C:attention}Joker{} destroyed"}}, config={extra={mult=0}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=1,y=7}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.remove_playing_cards and context.removed then
      -- track destroyed jokers via global check
    end
    if context.selling_card and context.selling_card.config and context.selling_card.config.center and context.selling_card.config.center.set=='Joker' then
      card.ability.extra.mult=card.ability.extra.mult+20
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n773: Calypso -- +3 Mult per card remaining in hand (enchantress traps you)
SMODS.Joker({ key="n773", loc_txt={name="Calypso",text={"{C:mult}+#1#{} Mult","per card in {C:attention}hand{}"}}, config={mult=3}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=7}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=G.hand and #G.hand.cards or 0
      local bonus=card.ability.mult*n
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n774: Circe -- converts +30 mult per joker to chips (witch transforms)
SMODS.Joker({ key="n774", loc_txt={name="Circe",text={"{C:chips}+#1#{} Chips","per {C:attention}Joker{} owned"}}, config={chips=30}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=7}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local bonus=card.ability.chips*#G.jokers.cards
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n775: Tantalus -- +50 chips but halved each round (always just out of reach)
SMODS.Joker({ key="n775", loc_txt={name="Tantalus",text={"{C:chips}+#1#{} Chips","halved each round (min 1)"}}, config={extra={chips=50}}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=4,y=7}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}} end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips=math.max(1,math.floor(card.ability.extra.chips/2))
    end
  end })

-- n776: Sisyphus -- resets to +10 mult each round, gains +5 each hand played
SMODS.Joker({ key="n776", loc_txt={name="Sisyphus",text={"{C:mult}+#1#{} Mult","Resets each round, +5 per hand played"}}, config={extra={mult=10,base=10}}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=5,y=7}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      card.ability.extra.mult=card.ability.extra.mult+5
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult=card.ability.extra.base
    end
  end })

-- n777: Orpheus -- +10 Mult per hand size (music of the strings)
SMODS.Joker({ key="n777", loc_txt={name="Orpheus",text={"{C:mult}+#1#{} Mult","per card in {C:attention}hand{}"}}, config={mult=10}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=7}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=G.hand and #G.hand.cards or 0
      local bonus=card.ability.mult*n
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n778: Nyx -- +20 chips per round (goddess of night, grows each round)
SMODS.Joker({ key="n778", loc_txt={name="Nyx",text={"{C:chips}+#1#{} Chips","grows by {C:chips}+20{} each round"}}, config={extra={chips=20}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=7,y=7}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}} end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips=card.ability.extra.chips+20
    end
  end })

-- n779: Eos -- +3 Chips per Diamond scored (goddess of dawn, gold = diamonds)
SMODS.Joker({ key="n779", loc_txt={name="Eos",text={"{C:chips}+#1#{} Chips","per {C:attention}Diamond{} scored"}}, config={chips=3}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=7}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Diamonds' then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n780: Helios -- X1.5 Mult; gains +X0.2 per Diamond scored (sun charioteer)
SMODS.Joker({ key="n780", loc_txt={name="Helios",text={"{X:mult,C:white}X#1#{} Mult","gains {X:mult,C:white}X0.2{} per {C:attention}Diamond{} scored"}}, config={extra={xmult=1.5}}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=7}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.xmult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Diamonds' then
        card.ability.extra.xmult=card.ability.extra.xmult+0.2
        return{message=localize('k_upgrade_ex')}
      end
    end
    if context.joker_main then return{Xmult=card.ability.extra.xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}}} end
  end })

-- n781: Selene -- X2 Mult on odd rounds (moon goddess, waxing/waning)
SMODS.Joker({ key="n781", loc_txt={name="Selene",text={"{X:mult,C:white}X#1#{} Mult","on {C:attention}odd{} rounds (moonrise)"}}, config={Xmult=2}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=8}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and (G.GAME.round or 1)%2==1 then
      return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n782: Boreas -- +20 Mult when 3 or fewer cards played (god of north wind, cutting blasts)
SMODS.Joker({ key="n782", loc_txt={name="Boreas",text={"{C:mult}+#1#{} Mult","when {C:attention}3 or fewer{} cards played"}}, config={mult=20}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=8}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards<=3 then
      return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n783: Zephyr -- +8 Mult when 2 or fewer cards played (gentle west wind)
SMODS.Joker({ key="n783", loc_txt={name="Zephyr",text={"{C:mult}+#1#{} Mult","when {C:attention}2 or fewer{} cards played"}}, config={mult=8}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=8}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards<=2 then
      return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n784: Notus -- +10 chips per discard (hot south wind, burns through cards)
SMODS.Joker({ key="n784", loc_txt={name="Notus",text={"{C:chips}+#1#{} Chips","per {C:attention}discard{} used this round"}}, config={chips=10}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=8}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local discards=(G.GAME.current_round.discards_used or 0)
      local bonus=card.ability.chips*discards
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n785: Eurus -- +3 Mult per joker owned (east wind, brings fortune)
SMODS.Joker({ key="n785", loc_txt={name="Eurus",text={"{C:mult}+#1#{} Mult","per {C:attention}Joker{} owned"}}, config={mult=3}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=8}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local bonus=card.ability.mult*#G.jokers.cards
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n786: Hephaestus -- +5 chips per Club scored (forge god, metalwork = clubs)
SMODS.Joker({ key="n786", loc_txt={name="Hephaestus",text={"{C:chips}+#1#{} Chips","per {C:attention}Club{} scored"}}, config={chips=5}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=8}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Clubs' then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n787: Nemesis -- +5 Mult per Mult above 20 at scoring time (retribution)
SMODS.Joker({ key="n787", loc_txt={name="Nemesis",text={"{C:mult}+#1#{} Mult","always active"}}, config={mult=20}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=8}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
  end })

-- n788: Tyche -- X1 to X4 randomly (goddess of fortune, luck)
SMODS.Joker({ key="n788", loc_txt={name="Tyche",text={"{X:mult,C:white}X1{} to {X:mult,C:white}X4{}","random {X:mult,C:white}Xmult{} each hand"}}, config={Xmult=1}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=false, perishable_compat=true, pos={x=7,y=8}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local xm=math.random(1,4)
      return{Xmult=xm,message=localize{type='variable',key='a_xmult',vars={xm}}}
    end
  end })

-- n789: Hecate -- +5 Mult per joker owned, doubles on odd rounds (crossroads witch)
SMODS.Joker({ key="n789", loc_txt={name="Hecate",text={"{C:mult}+#1#{} Mult","per Joker; {C:attention}doubled{} on odd rounds"}}, config={mult=5}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=8}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.jokers.cards
      local mult=card.ability.mult*n
      if (G.GAME.round or 1)%2==1 then mult=mult*2 end
      if mult>0 then return{mult=mult,message=localize{type='variable',key='a_mult',vars={mult}}} end
    end
  end })

-- n790: Nereids -- +8 Chips per Heart scored (sea nymphs = hearts)
SMODS.Joker({ key="n790", loc_txt={name="Nereids",text={"{C:chips}+#1#{} Chips","per {C:attention}Heart{} scored"}}, config={chips=8}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=8}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=='Hearts' then
        return{chips=card.ability.chips,message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n791: Titan Kin -- +4 Mult per scored card (all titans together)
SMODS.Joker({ key="n791", loc_txt={name="Titan Kin",text={"{C:mult}+#1#{} Mult","per {C:attention}scored card{}"}}, config={mult=4}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=9}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n792: Pantheon -- X0.3 Xmult per unique suit in scored hand (all gods united)
SMODS.Joker({ key="n792", loc_txt={name="Pantheon",text={"{X:mult,C:white}X0.3{} Mult","per unique {C:attention}suit{} in hand"}}, config={Xmult=0.3}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=9}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local suits={}
      for _,c in ipairs(context.scoring_hand or {}) do
        suits[c.base.suit]=true
      end
      local count=0
      for _ in pairs(suits) do count=count+1 end
      if count>0 then
        local xm=card.ability.Xmult*count
        return{Xmult=xm,message=localize{type='variable',key='a_xmult',vars={xm}}}
      end
    end
  end })

-- n793: Olympus -- +50 chips per joker; massive baseline (seat of the gods)
SMODS.Joker({ key="n793", loc_txt={name="Olympus",text={"{C:chips}+#1#{} Chips","per {C:attention}Joker{} owned"}}, config={chips=50}, rarity=4, cost=20, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=9}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local bonus=card.ability.chips*#G.jokers.cards
      if bonus>0 then return{chips=bonus,message=localize{type='variable',key='a_chips',vars={bonus}}} end
    end
  end })

-- n794: Elysium -- +10 Mult per round survived (paradise earned over time)
SMODS.Joker({ key="n794", loc_txt={name="Elysium",text={"{C:mult}+#1#{} Mult","gains {C:mult}+10{} each round survived"}}, config={extra={mult=0}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=3,y=9}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult=card.ability.extra.mult+10
    end
  end })

-- n795: Tartarus -- X2 Mult when hand value is lowest possible (punished, low scores)
SMODS.Joker({ key="n795", loc_txt={name="Tartarus",text={"{X:mult,C:white}X#1#{} Mult","if hand contains a {C:attention}2{}"}}, config={Xmult=2}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=9}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local has_two=false
      for _,c in ipairs(context.scoring_hand or {}) do
        if c.base.value=='2' then has_two=true;break end
      end
      if has_two then return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}} end
    end
  end })

-- n796: The Fates -- X0.5 per hand played this round, stacks (three sisters weave destiny)
SMODS.Joker({ key="n796", loc_txt={name="The Fates",text={"{X:mult,C:white}X0.5{} Mult","per {C:attention}hand{} played this round"}}, config={Xmult=0.5}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=9}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hands=(G.GAME.current_round.hands_played or 0)
      local xm=card.ability.Xmult*hands
      if xm>0 then return{Xmult=xm,message=localize{type='variable',key='a_xmult',vars={xm}}} end
    end
  end })

-- n797: Chaos -- random +mult between 1 and 30 each hand (primordial chaos)
SMODS.Joker({ key="n797", loc_txt={name="Chaos",text={"{C:mult}+1{} to {C:mult}+30{} Mult","randomly each hand"}}, config={mult=1}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=false, perishable_compat=true, pos={x=6,y=9}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local m=math.random(1,30)
      return{mult=m,message=localize{type='variable',key='a_mult',vars={m}}}
    end
  end })

-- n798: Ananke -- X2 Mult but only on the last hand of the round (necessity)
SMODS.Joker({ key="n798", loc_txt={name="Ananke",text={"{X:mult,C:white}X#1#{} Mult","on the {C:attention}last hand{} of a round"}}, config={Xmult=2}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=9}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hands_left=(G.GAME.current_round.hands_left or 1)
      if hands_left<=1 then
        return{Xmult=card.ability.Xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
      end
    end
  end })

-- n799: Moirai -- +1 Mult per hand remaining this round (threads of life)
SMODS.Joker({ key="n799", loc_txt={name="Moirai",text={"{C:mult}+#1#{} Mult","per {C:attention}hand{} remaining this round"}}, config={mult=1}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=9}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hands_left=(G.GAME.current_round.hands_left or 0)
      local bonus=card.ability.mult*hands_left
      if bonus>0 then return{mult=bonus,message=localize{type='variable',key='a_mult',vars={bonus}}} end
    end
  end })

-- n800: The Void -- X3 Xmult always but gains +X1 when any joker perishes (darkness consumes)
SMODS.Joker({ key="n800", loc_txt={name="The Void",text={"{X:mult,C:white}X#1#{} Mult","gains {X:mult,C:white}X1{} when a {C:attention}Joker{} perishes"}}, config={extra={xmult=3}}, rarity=4, cost=20, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=9}, atlas="cm_atlas_08",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.xmult}} end,
  calculate=function(self,card,context)
    if context.selling_card and context.selling_card.config and context.selling_card.config.center and context.selling_card.config.center.set=='Joker' then
      card.ability.extra.xmult=card.ability.extra.xmult+1
      return{message=localize('k_upgrade_ex')}
    end
    if context.joker_main then return{Xmult=card.ability.extra.xmult,message=localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}}} end
  end })
