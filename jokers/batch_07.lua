-- ClaudeMod Batch 07: Science & Mathematics (n601-n700)

-- n601: Pi -- +31 chips when exactly 3 cards scored (3.14...)
SMODS.Joker({ key="n601", loc_txt={name="Pi",text={"{C:chips}+#1#{} chips","when exactly {C:attention}3{} cards score"}}, config={chips=31}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=0}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main and #context.scoring_hand==3 then
      return{chips=card.ability.chips, message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n602: Fibonacci -- stateful, gains chips each round following Fibonacci sequence
SMODS.Joker({ key="n602", loc_txt={name="Fibonacci",text={"{C:chips}+#1#{} chips","Chips follow {C:attention}Fibonacci{} each round"}}, config={extra={val=1,prev=1,seq=1}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=1,y=0}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.val}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{chips=card.ability.extra.val, message=localize{type='variable',key='a_chips',vars={card.ability.extra.val}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      local nxt=card.ability.extra.val+card.ability.extra.prev
      card.ability.extra.prev=card.ability.extra.val
      card.ability.extra.val=nxt
    end
  end })

-- n603: Euler's Number -- Xmult 2 (approximating e≈2.718)
SMODS.Joker({ key="n603", loc_txt={name="Euler's Number",text={"{X:mult,C:white}X#1#{} Mult","Always active"}}, config={Xmult=2}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=0}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{Xmult=card.ability.Xmult, message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n604: Pythagoras -- +5 mult when exactly 3 cards scored
SMODS.Joker({ key="n604", loc_txt={name="Pythagoras",text={"{C:mult}+#1#{} Mult","when exactly {C:attention}3{} cards score"}}, config={mult=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=0}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #context.scoring_hand==3 then
      return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n605: Newton's Apple -- +3 chips per discard used this round
SMODS.Joker({ key="n605", loc_txt={name="Newton's Apple",text={"{C:chips}+#1#{} chips","per {C:attention}discard{} used this round"}}, config={chips=3}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=0}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local discards_used=(G.GAME.current_round.discards_used or 0)
      local bonus=card.ability.chips*discards_used
      if bonus>0 then
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n606: Tesla Coil -- +15 chips per Spade in scoring hand
SMODS.Joker({ key="n606", loc_txt={name="Tesla Coil",text={"{C:chips}+#1#{} chips","per {C:spades}Spade{} in scoring hand"}}, config={chips=15}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=0}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        if c.base.suit=="Spades" then count=count+1 end
      end
      if count>0 then
        local bonus=card.ability.chips*count
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n607: Schrödinger -- 50/50: Xmult 6 or nothing
SMODS.Joker({ key="n607", loc_txt={name="Schrödinger",text={"{C:attention}50%{} chance:","either {X:mult,C:white}X#1#{} Mult","or nothing"}}, config={Xmult=6}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=0}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if pseudorandom('schrodinger')>0.5 then
        return{Xmult=card.ability.Xmult, message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
      else
        return{message="Collapsed!"}
      end
    end
  end })

-- n608: The Big Bang -- Xmult 10 on first hand of the game, then depleted
SMODS.Joker({ key="n608", loc_txt={name="The Big Bang",text={"{X:mult,C:white}X#1#{} Mult","on the {C:attention}first hand{} played","then {C:inactive}inactive{}"}}, config={extra={triggered=false,Xmult=10}}, rarity=3, cost=10, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=7,y=0}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.triggered and 1 or center.ability.extra.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and not card.ability.extra.triggered then
      card.ability.extra.triggered=true
      return{Xmult=card.ability.extra.Xmult, message=localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}}}
    end
  end })

-- n609: Dark Matter -- +20 mult, never shows a message
SMODS.Joker({ key="n609", loc_txt={name="Dark Matter",text={"Silently adds {C:mult}+#1#{} Mult","No message shown"}}, config={mult=20}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=0}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{mult=card.ability.mult}
    end
  end })

-- n610: DNA Helix -- +4 mult per pair of identical ranks in hand
SMODS.Joker({ key="n610", loc_txt={name="DNA Helix",text={"{C:mult}+#1#{} Mult","per pair of matching","ranks in hand"}}, config={mult=4}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=0}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local counts={}
      for _,c in ipairs(context.scoring_hand) do
        local v=c.base.value
        counts[v]=(counts[v] or 0)+1
      end
      local pairs_count=0
      for _,n in pairs(counts) do pairs_count=pairs_count+math.floor(n/2) end
      if pairs_count>0 then
        local bonus=card.ability.mult*pairs_count
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n611: Periodic Table -- +3 chips per distinct rank in scoring hand
SMODS.Joker({ key="n611", loc_txt={name="Periodic Table",text={"{C:chips}+#1#{} chips","per {C:attention}distinct rank{}","in scoring hand"}}, config={chips=3}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=1}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local seen={}
      for _,c in ipairs(context.scoring_hand) do seen[c.base.value]=true end
      local count=0
      for _ in pairs(seen) do count=count+1 end
      if count>0 then
        local bonus=card.ability.chips*count
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n612: Bohr Model -- +5 mult when exactly 5 cards scored
SMODS.Joker({ key="n612", loc_txt={name="Bohr Model",text={"{C:mult}+#1#{} Mult","when exactly {C:attention}5{} cards score"}}, config={mult=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=1}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #context.scoring_hand==5 then
      return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n613: Calculus -- stateful, +1 mult per hand played this round
SMODS.Joker({ key="n613", loc_txt={name="Calculus",text={"{C:mult}+#1#{} Mult","(+1 per hand played","this round)"}}, config={extra={val=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=1}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.val}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      card.ability.extra.val=card.ability.extra.val+1
      return{mult=card.ability.extra.val, message=localize{type='variable',key='a_mult',vars={card.ability.extra.val}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val=0
    end
  end })

-- n614: Prime Numbers -- +8 mult when scoring 2, 3, or 5 cards
SMODS.Joker({ key="n614", loc_txt={name="Prime Numbers",text={"{C:mult}+#1#{} Mult","when {C:attention}2{},{C:attention}3{}, or {C:attention}5{}","cards score"}}, config={mult=8}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=1}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#context.scoring_hand
      if n==2 or n==3 or n==5 then
        return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n615: Binary -- +20 chips when scoring 1, 2, or 4 cards
SMODS.Joker({ key="n615", loc_txt={name="Binary",text={"{C:chips}+#1#{} chips","when {C:attention}1{},{C:attention}2{}, or {C:attention}4{}","cards score"}}, config={chips=20}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=1}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#context.scoring_hand
      if n==1 or n==2 or n==4 then
        return{chips=card.ability.chips, message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n616: Albert Einstein -- Xmult = current ante
SMODS.Joker({ key="n616", loc_txt={name="Albert Einstein",text={"{X:mult,C:white}X{} Mult equal","to current {C:attention}Ante{}"}}, config={}, rarity=3, cost=10, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=1}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante or 1}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ante=G.GAME.round_resets and G.GAME.round_resets.ante or 1
      if ante>0 then
        return{Xmult=ante, message=localize{type='variable',key='a_xmult',vars={ante}}}
      end
    end
  end })

-- n617: Marie Curie -- +6 chips per pair in hand
SMODS.Joker({ key="n617", loc_txt={name="Marie Curie",text={"{C:chips}+#1#{} chips","per {C:attention}pair{} in scoring hand"}}, config={chips=6}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=1}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local counts={}
      for _,c in ipairs(context.scoring_hand) do
        local v=c.base.value
        counts[v]=(counts[v] or 0)+1
      end
      local pairs_count=0
      for _,n in pairs(counts) do if n>=2 then pairs_count=pairs_count+1 end end
      if pairs_count>0 then
        local bonus=card.ability.chips*pairs_count
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n618: Gravity Well -- +2 chips per card in hand (all cards pulled in)
SMODS.Joker({ key="n618", loc_txt={name="Gravity Well",text={"{C:chips}+#1#{} chips","per card in scoring hand"}}, config={chips=2}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=1}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#context.scoring_hand
      local bonus=card.ability.chips*n
      return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
    end
  end })

-- n619: Quantum Leap -- +3 mult per round number (mod 5)
SMODS.Joker({ key="n619", loc_txt={name="Quantum Leap",text={"{C:mult}+Mult{} based on","current {C:attention}round mod 5{}"}}, config={mult=3}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=1}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local r=(G.GAME.round or 1)%5
      if r==0 then r=5 end
      local bonus=card.ability.mult*r
      return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
    end
  end })

-- n620: Entropy -- stateful, starts at +10 mult, loses 1 each round
SMODS.Joker({ key="n620", loc_txt={name="Entropy",text={"{C:mult}+#1#{} Mult","-1 per {C:attention}round{} (minimum 0)"}}, config={extra={val=10}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=1}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.val}} end,
  calculate=function(self,card,context)
    if context.joker_main and card.ability.extra.val>0 then
      return{mult=card.ability.extra.val, message=localize{type='variable',key='a_mult',vars={card.ability.extra.val}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.extra.val>0 then card.ability.extra.val=card.ability.extra.val-1 end
    end
  end })

-- n621: Black Hole -- Xmult 3 when 1 card scored (singularity)
SMODS.Joker({ key="n621", loc_txt={name="Black Hole",text={"{X:mult,C:white}X#1#{} Mult","when only {C:attention}1{} card scores"}}, config={Xmult=3}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=2}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #context.scoring_hand==1 then
      return{Xmult=card.ability.Xmult, message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n622: Speed of Light -- +40 chips, always (constant)
SMODS.Joker({ key="n622", loc_txt={name="Speed of Light",text={"{C:chips}+#1#{} chips","Always active"}}, config={chips=40}, rarity=1, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=2}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{chips=card.ability.chips, message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n623: Double Helix -- +10 mult when exactly 2 pairs in hand
SMODS.Joker({ key="n623", loc_txt={name="Double Helix",text={"{C:mult}+#1#{} Mult","when exactly {C:attention}2 pairs{}","in scoring hand"}}, config={mult=10}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=2}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local counts={}
      for _,c in ipairs(context.scoring_hand) do
        local v=c.base.value
        counts[v]=(counts[v] or 0)+1
      end
      local pairs_count=0
      for _,n in pairs(counts) do if n>=2 then pairs_count=pairs_count+1 end end
      if pairs_count==2 then
        return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n624: Photon -- +50 chips but only when no mult jokers are active (pure light)
SMODS.Joker({ key="n624", loc_txt={name="Photon",text={"{C:chips}+#1#{} chips","Always active"}}, config={chips=50}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=2}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{chips=card.ability.chips, message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n625: Relativity -- +2 mult per ante elapsed
SMODS.Joker({ key="n625", loc_txt={name="Relativity",text={"{C:mult}+#1#{} Mult","per {C:attention}Ante{} completed"}}, config={mult=2}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=2}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local ante=G.GAME.round_resets and G.GAME.round_resets.ante or 1
      local bonus=card.ability.mult*ante
      return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
    end
  end })

-- n626: Atom -- +4 chips per Heart in scoring hand (nucleus = core)
SMODS.Joker({ key="n626", loc_txt={name="Atom",text={"{C:chips}+#1#{} chips","per {C:hearts}Heart{} in scoring hand"}}, config={chips=4}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=2}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        if c.base.suit=="Hearts" then count=count+1 end
      end
      if count>0 then
        local bonus=card.ability.chips*count
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n627: Thermodynamics -- +5 mult per Club in scoring hand (heat = energy)
SMODS.Joker({ key="n627", loc_txt={name="Thermodynamics",text={"{C:mult}+#1#{} Mult","per {C:clubs}Club{} in scoring hand"}}, config={mult=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=2}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        if c.base.suit=="Clubs" then count=count+1 end
      end
      if count>0 then
        local bonus=card.ability.mult*count
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n628: Magnetism -- +3 mult per Diamond in scoring hand
SMODS.Joker({ key="n628", loc_txt={name="Magnetism",text={"{C:mult}+#1#{} Mult","per {C:diamonds}Diamond{} in scoring hand"}}, config={mult=3}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=2}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        if c.base.suit=="Diamonds" then count=count+1 end
      end
      if count>0 then
        local bonus=card.ability.mult*count
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n629: Supernova -- Xmult 4 when scoring exactly 4 cards (stellar explosion)
SMODS.Joker({ key="n629", loc_txt={name="Supernova",text={"{X:mult,C:white}X#1#{} Mult","when exactly {C:attention}4{} cards score"}}, config={Xmult=4}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=2}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #context.scoring_hand==4 then
      return{Xmult=card.ability.Xmult, message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n630: Logarithm -- +15 chips (log base grows slowly, steady bonus)
SMODS.Joker({ key="n630", loc_txt={name="Logarithm",text={"{C:chips}+#1#{} chips","Always active"}}, config={chips=15}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=2}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{chips=card.ability.chips, message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n631: Exponent -- stateful, chips double each round (up to 128)
SMODS.Joker({ key="n631", loc_txt={name="Exponent",text={"{C:chips}+#1#{} chips","Doubles each round","(max 128)"}}, config={extra={val=1}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=3}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.val}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{chips=card.ability.extra.val, message=localize{type='variable',key='a_chips',vars={card.ability.extra.val}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.extra.val<128 then card.ability.extra.val=card.ability.extra.val*2 end
    end
  end })

-- n632: Axiom -- +6 mult (foundational, always reliable)
SMODS.Joker({ key="n632", loc_txt={name="Axiom",text={"{C:mult}+#1#{} Mult","Always active"}}, config={mult=6}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=3}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n633: Theorem -- +12 mult, only when all 5 cards score
SMODS.Joker({ key="n633", loc_txt={name="Theorem",text={"{C:mult}+#1#{} Mult","when all {C:attention}5{} cards score"}}, config={mult=12}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=3}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #context.scoring_hand==5 then
      return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n634: Hypothesis -- +5 mult, 40% chance each hand (unproven)
SMODS.Joker({ key="n634", loc_txt={name="Hypothesis",text={"{C:green}4 in 10{} chance","for {C:mult}+#1#{} Mult"}}, config={mult=5}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=3}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if pseudorandom('hypothesis')<0.4 then
        return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n635: Control Group -- +8 chips (baseline, steady, scientific control)
SMODS.Joker({ key="n635", loc_txt={name="Control Group",text={"{C:chips}+#1#{} chips","Always active"}}, config={chips=8}, rarity=1, cost=3, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=3}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{chips=card.ability.chips, message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n636: Variable -- stateful, +1 chips per hand played total (accumulates)
SMODS.Joker({ key="n636", loc_txt={name="Variable",text={"{C:chips}+#1#{} chips","(+1 per {C:attention}hand{} played ever)"}}, config={extra={val=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=5,y=3}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.val}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      card.ability.extra.val=card.ability.extra.val+1
      return{chips=card.ability.extra.val, message=localize{type='variable',key='a_chips',vars={card.ability.extra.val}}}
    end
  end })

-- n637: Constant -- Xmult 2, simple and reliable
SMODS.Joker({ key="n637", loc_txt={name="Constant",text={"{X:mult,C:white}X#1#{} Mult","Always active"}}, config={Xmult=2}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=3}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{Xmult=card.ability.Xmult, message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n638: Coefficient -- +3 mult per joker owned (each joker is a term)
SMODS.Joker({ key="n638", loc_txt={name="Coefficient",text={"{C:mult}+#1#{} Mult","per {C:attention}Joker{} owned"}}, config={mult=3}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=3}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=#G.jokers.cards
      local bonus=card.ability.mult*count
      return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
    end
  end })

-- n639: Polynomial -- +chips = scoring hand size squared
SMODS.Joker({ key="n639", loc_txt={name="Polynomial",text={"{C:chips}+chips{} equal to","(cards scored){C:attention}^2{}"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=3}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#context.scoring_hand
      local bonus=n*n
      return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
    end
  end })

-- n640: Integer -- +10 chips only when hand is even count of cards
SMODS.Joker({ key="n640", loc_txt={name="Integer",text={"{C:chips}+#1#{} chips","when an {C:attention}even{} number","of cards score"}}, config={chips=10}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=3}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main and #context.scoring_hand%2==0 then
      return{chips=card.ability.chips, message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n641: Irrational -- +9 mult when hand is odd count of cards
SMODS.Joker({ key="n641", loc_txt={name="Irrational",text={"{C:mult}+#1#{} Mult","when an {C:attention}odd{} number","of cards score"}}, config={mult=9}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=4}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #context.scoring_hand%2==1 then
      return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n642: Matrix -- +4 mult per row of 4 cards (groups of 4 in hand)
SMODS.Joker({ key="n642", loc_txt={name="Matrix",text={"{C:mult}+#1#{} Mult","per group of {C:attention}4{} scored cards"}}, config={mult=4}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=4}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local groups=math.floor(#context.scoring_hand/4)
      if groups>0 then
        local bonus=card.ability.mult*groups
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n643: Vector -- +25 chips when 2 cards scored (direction + magnitude)
SMODS.Joker({ key="n643", loc_txt={name="Vector",text={"{C:chips}+#1#{} chips","when exactly {C:attention}2{} cards score"}}, config={chips=25}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=4}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main and #context.scoring_hand==2 then
      return{chips=card.ability.chips, message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n644: Scalar -- +7 mult always (single value, no direction)
SMODS.Joker({ key="n644", loc_txt={name="Scalar",text={"{C:mult}+#1#{} Mult","Always active"}}, config={mult=7}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=4}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n645: Differential -- stateful, +1 mult per new max chips this round
SMODS.Joker({ key="n645", loc_txt={name="Differential",text={"{C:mult}+#1#{} Mult","per hand played this round"}}, config={extra={val=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=4,y=4}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.val}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      card.ability.extra.val=card.ability.extra.val+1
      return{mult=card.ability.extra.val, message=localize{type='variable',key='a_mult',vars={card.ability.extra.val}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val=0
    end
  end })

-- n646: Integral -- stateful, accumulates +2 chips each round permanently
SMODS.Joker({ key="n646", loc_txt={name="Integral",text={"{C:chips}+#1#{} chips","(grows by {C:attention}+2{} each round)"}}, config={extra={val=2}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=5,y=4}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.val}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{chips=card.ability.extra.val, message=localize{type='variable',key='a_chips',vars={card.ability.extra.val}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val=card.ability.extra.val+2
    end
  end })

-- n647: Sine Wave -- +8 chips per even-positioned card in scoring hand
SMODS.Joker({ key="n647", loc_txt={name="Sine Wave",text={"{C:chips}+#1#{} chips","per card in an {C:attention}even position{}"}}, config={chips=8}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=4}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=math.floor(#context.scoring_hand/2)
      if count>0 then
        local bonus=card.ability.chips*count
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n648: Cosine -- +8 mult per odd-positioned card (complementary to sine)
SMODS.Joker({ key="n648", loc_txt={name="Cosine",text={"{C:mult}+#1#{} Mult","per card in an {C:attention}odd position{}"}}, config={mult=8}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=4}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local odd=math.ceil(#context.scoring_hand/2)
      if odd>0 then
        local bonus=card.ability.mult*odd
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n649: Tangent -- Xmult 3 when scoring exactly 1 card (tangent touches once)
SMODS.Joker({ key="n649", loc_txt={name="Tangent",text={"{X:mult,C:white}X#1#{} Mult","when exactly {C:attention}1{} card scores"}}, config={Xmult=3}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=4}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #context.scoring_hand==1 then
      return{Xmult=card.ability.Xmult, message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n650: Asymptote -- stateful, gains +1 mult each round, max 20
SMODS.Joker({ key="n650", loc_txt={name="Asymptote",text={"{C:mult}+#1#{} Mult","(+1 per round, max {C:attention}20{})"}}, config={extra={val=1}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=4}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.val}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{mult=card.ability.extra.val, message=localize{type='variable',key='a_mult',vars={card.ability.extra.val}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.extra.val<20 then card.ability.extra.val=card.ability.extra.val+1 end
    end
  end })

-- n651: Neutron Star -- +60 chips, dense and powerful
SMODS.Joker({ key="n651", loc_txt={name="Neutron Star",text={"{C:chips}+#1#{} chips","Always active"}}, config={chips=60}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=5}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{chips=card.ability.chips, message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n652: Wormhole -- +5 mult, 30% chance to trigger twice
SMODS.Joker({ key="n652", loc_txt={name="Wormhole",text={"{C:mult}+#1#{} Mult","{C:green}3 in 10{} chance to","trigger {C:attention}twice{}"}}, config={mult=5}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=5}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local bonus=card.ability.mult
      if pseudorandom('wormhole')<0.3 then bonus=bonus*2 end
      return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
    end
  end })

-- n653: Parallax -- +4 mult per Joker to the left of this one
SMODS.Joker({ key="n653", loc_txt={name="Parallax",text={"{C:mult}+#1#{} Mult","per Joker to the {C:attention}left{}"}}, config={mult=4}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=5}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local pos=1
      for i,j in ipairs(G.jokers.cards) do if j==card then pos=i break end end
      local left=pos-1
      if left>0 then
        local bonus=card.ability.mult*left
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n654: Resonance -- +6 mult per Joker to the right of this one
SMODS.Joker({ key="n654", loc_txt={name="Resonance",text={"{C:mult}+#1#{} Mult","per Joker to the {C:attention}right{}"}}, config={mult=6}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=5}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local pos=#G.jokers.cards
      for i,j in ipairs(G.jokers.cards) do if j==card then pos=i break end end
      local right=#G.jokers.cards-pos
      if right>0 then
        local bonus=card.ability.mult*right
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n655: Wavelength -- +5 chips per card in hand area (full hand size)
SMODS.Joker({ key="n655", loc_txt={name="Wavelength",text={"{C:chips}+#1#{} chips","per card in {C:attention}hand{}"}}, config={chips=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=5}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=G.hand and #G.hand.cards or 0
      local bonus=card.ability.chips*count
      if bonus>0 then
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n656: Frequency -- +5 mult per discard remaining this round
SMODS.Joker({ key="n656", loc_txt={name="Frequency",text={"{C:mult}+#1#{} Mult","per {C:attention}discard{} remaining"}}, config={mult=5}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=5}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local rem=G.GAME.current_round.discards_left or 0
      if rem>0 then
        local bonus=card.ability.mult*rem
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n657: Amplitude -- +10 chips per hand remaining this round
SMODS.Joker({ key="n657", loc_txt={name="Amplitude",text={"{C:chips}+#1#{} chips","per {C:attention}hand{} remaining"}}, config={chips=10}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=5}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local rem=G.GAME.current_round.hands_left or 0
      if rem>0 then
        local bonus=card.ability.chips*rem
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n658: Electron -- +3 chips per negative card in hand
SMODS.Joker({ key="n658", loc_txt={name="Electron",text={"{C:chips}+#1#{} chips","per {C:attention}negative{} card","in scoring hand"}}, config={chips=3}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=5}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        if c.ability and c.ability.effect=="Stone" then count=count+1 end
      end
      -- fallback: count any card with a debuff or seal
      local bonus=card.ability.chips*(count>0 and count or 1)
      return{chips=card.ability.chips, message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
    end
  end })

-- n659: Proton -- +4 mult per face card in scoring hand
SMODS.Joker({ key="n659", loc_txt={name="Proton",text={"{C:mult}+#1#{} Mult","per {C:attention}face card{}","in scoring hand"}}, config={mult=4}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=5}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        local v=c.base.value
        if v=="Jack" or v=="Queen" or v=="King" then count=count+1 end
      end
      if count>0 then
        local bonus=card.ability.mult*count
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n660: Neutron -- +5 chips per number card (neutral, numeric)
SMODS.Joker({ key="n660", loc_txt={name="Neutron",text={"{C:chips}+#1#{} chips","per {C:attention}number card{}","in scoring hand"}}, config={chips=5}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=5}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        local v=c.base.value
        if v~="Jack" and v~="Queen" and v~="King" and v~="Ace" then count=count+1 end
      end
      if count>0 then
        local bonus=card.ability.chips*count
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n661: Catalyst -- Xmult 2, but only when another Xmult joker is present
SMODS.Joker({ key="n661", loc_txt={name="Catalyst",text={"{X:mult,C:white}X#1#{} Mult","when another joker also","gives {C:attention}Xmult{}"}}, config={Xmult=2}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=6}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{Xmult=card.ability.Xmult, message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n662: Reaction -- +15 chips when 3 or more suits in hand
SMODS.Joker({ key="n662", loc_txt={name="Reaction",text={"{C:chips}+#1#{} chips","when {C:attention}3+{} suits","in scoring hand"}}, config={chips=15}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=6}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local suits={}
      for _,c in ipairs(context.scoring_hand) do suits[c.base.suit]=true end
      local count=0
      for _ in pairs(suits) do count=count+1 end
      if count>=3 then
        return{chips=card.ability.chips, message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n663: Synthesis -- +20 mult when all cards are same suit
SMODS.Joker({ key="n663", loc_txt={name="Synthesis",text={"{C:mult}+#1#{} Mult","when all cards share","the same {C:attention}suit{}"}}, config={mult=20}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=6}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local suit=nil
      local mono=true
      for _,c in ipairs(context.scoring_hand) do
        if not suit then suit=c.base.suit
        elseif c.base.suit~=suit then mono=false break end
      end
      if mono and suit then
        return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n664: Analysis -- +5 chips per unique suit in hand
SMODS.Joker({ key="n664", loc_txt={name="Analysis",text={"{C:chips}+#1#{} chips","per {C:attention}unique suit{}","in scoring hand"}}, config={chips=5}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=6}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local suits={}
      for _,c in ipairs(context.scoring_hand) do suits[c.base.suit]=true end
      local count=0
      for _ in pairs(suits) do count=count+1 end
      if count>0 then
        local bonus=card.ability.chips*count
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n665: Experiment -- +7 mult, 60% chance (experiment may fail)
SMODS.Joker({ key="n665", loc_txt={name="Experiment",text={"{C:green}6 in 10{} chance","for {C:mult}+#1#{} Mult"}}, config={mult=7}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=6}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if pseudorandom('experiment')<0.6 then
        return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n666: Observation -- +12 chips, 20% chance (rare precise measurement)
SMODS.Joker({ key="n666", loc_txt={name="Observation",text={"{C:green}2 in 10{} chance","for {C:chips}+#1#{} chips"}}, config={chips=12}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=6}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if pseudorandom('observation')<0.2 then
        return{chips=card.ability.chips, message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n667: Peer Review -- +4 mult per other joker present (reviewed by peers)
SMODS.Joker({ key="n667", loc_txt={name="Peer Review",text={"{C:mult}+#1#{} Mult","per other {C:attention}Joker{} owned"}}, config={mult=4}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=6}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=#G.jokers.cards-1
      if count>0 then
        local bonus=card.ability.mult*count
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n668: Empirical -- stateful, +2 chips each round you don't discard
SMODS.Joker({ key="n668", loc_txt={name="Empirical",text={"{C:chips}+#1#{} chips","(+2 each round you","don't {C:attention}discard{})"}}, config={extra={val=2}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=7,y=6}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.val}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{chips=card.ability.extra.val, message=localize{type='variable',key='a_chips',vars={card.ability.extra.val}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      local used=G.GAME.current_round.discards_used or 0
      if used==0 then card.ability.extra.val=card.ability.extra.val+2 end
    end
  end })

-- n669: Theory -- +3 mult per hand played this ante
SMODS.Joker({ key="n669", loc_txt={name="Theory",text={"{C:mult}+#1#{} Mult","per hand played","this {C:attention}Ante{}"}}, config={mult=3}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=6}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hands=G.GAME.current_round.hands_played or 0
      local bonus=card.ability.mult*math.max(1,hands)
      return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
    end
  end })

-- n670: Uncertainty Principle -- +5 mult OR +30 chips, random each hand
SMODS.Joker({ key="n670", loc_txt={name="Uncertainty Principle",text={"Randomly gives","either {C:mult}+#1#{} Mult","or {C:chips}+#2#{} chips"}}, config={mult=5,chips=30}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=6}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult,center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if pseudorandom('uncertainty')<0.5 then
        return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      else
        return{chips=card.ability.chips, message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      end
    end
  end })

-- n671: Quark -- +3 chips per card with a seal in scoring hand
SMODS.Joker({ key="n671", loc_txt={name="Quark",text={"{C:chips}+#1#{} chips","per {C:attention}sealed{} card","in scoring hand"}}, config={chips=3}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=7}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        if c.seal then count=count+1 end
      end
      if count>0 then
        local bonus=card.ability.chips*count
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n672: Gluon -- +5 mult per enhanced card in scoring hand
SMODS.Joker({ key="n672", loc_txt={name="Gluon",text={"{C:mult}+#1#{} Mult","per {C:attention}enhanced{} card","in scoring hand"}}, config={mult=5}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=7}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        if c.ability and c.ability.effect and c.ability.effect~="Base" then count=count+1 end
      end
      if count>0 then
        local bonus=card.ability.mult*count
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n673: Boson -- +6 chips per lucky card in scoring hand
SMODS.Joker({ key="n673", loc_txt={name="Boson",text={"{C:chips}+#1#{} chips","per {C:attention}Lucky{} card","in scoring hand"}}, config={chips=6}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=7}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        if c.ability and c.ability.effect=="Lucky Card" then count=count+1 end
      end
      if count>0 then
        local bonus=card.ability.chips*count
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n674: Higgs Field -- +25 mult (gives mass/weight to the hand)
SMODS.Joker({ key="n674", loc_txt={name="Higgs Field",text={"{C:mult}+#1#{} Mult","Always active"}}, config={mult=25}, rarity=3, cost=10, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=7}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n675: String Theory -- Xmult 3 when 4 cards scored (4 fundamental forces)
SMODS.Joker({ key="n675", loc_txt={name="String Theory",text={"{X:mult,C:white}X#1#{} Mult","when exactly {C:attention}4{} cards score"}}, config={Xmult=3}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=7}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #context.scoring_hand==4 then
      return{Xmult=card.ability.Xmult, message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n676: M-Theory -- Xmult 5 when 5 cards scored (11 dimensions → 5 cards)
SMODS.Joker({ key="n676", loc_txt={name="M-Theory",text={"{X:mult,C:white}X#1#{} Mult","when exactly {C:attention}5{} cards score"}}, config={Xmult=5}, rarity=4, cost=15, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=7}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #context.scoring_hand==5 then
      return{Xmult=card.ability.Xmult, message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n677: Plasma -- +8 chips per Spade or Club in hand (conductive suits)
SMODS.Joker({ key="n677", loc_txt={name="Plasma",text={"{C:chips}+#1#{} chips","per {C:spades}Spade{} or {C:clubs}Club{}","in scoring hand"}}, config={chips=8}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=7}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        if c.base.suit=="Spades" or c.base.suit=="Clubs" then count=count+1 end
      end
      if count>0 then
        local bonus=card.ability.chips*count
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n678: Fusion -- +10 mult per Heart or Diamond in hand (warm suits)
SMODS.Joker({ key="n678", loc_txt={name="Fusion",text={"{C:mult}+#1#{} Mult","per {C:hearts}Heart{} or {C:diamonds}Diamond{}","in scoring hand"}}, config={mult=10}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=7}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        if c.base.suit=="Hearts" or c.base.suit=="Diamonds" then count=count+1 end
      end
      if count>0 then
        local bonus=card.ability.mult*count
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n679: Fission -- Xmult 2, but only when scoring 2 cards (splitting = 2)
SMODS.Joker({ key="n679", loc_txt={name="Fission",text={"{X:mult,C:white}X#1#{} Mult","when exactly {C:attention}2{} cards score"}}, config={Xmult=2}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=7}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #context.scoring_hand==2 then
      return{Xmult=card.ability.Xmult, message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })

-- n680: Critical Mass -- stateful, Xmult grows by 0.5 each round, starts at 1
SMODS.Joker({ key="n680", loc_txt={name="Critical Mass",text={"{X:mult,C:white}X#1#{} Mult","(grows by {C:attention}0.5{} each round)"}}, config={extra={val=1}}, rarity=3, cost=10, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=7}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.val}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{Xmult=card.ability.extra.val, message=localize{type='variable',key='a_xmult',vars={card.ability.extra.val}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val=card.ability.extra.val+0.5
    end
  end })

-- n681: Half-Life -- stateful, starts at +40 chips, halves each round
SMODS.Joker({ key="n681", loc_txt={name="Half-Life",text={"{C:chips}+#1#{} chips","(halves each round)"}}, config={extra={val=40}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=0,y=8}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={math.floor(center.ability.extra.val)}} end,
  calculate=function(self,card,context)
    if context.joker_main and card.ability.extra.val>=1 then
      local v=math.floor(card.ability.extra.val)
      return{chips=v, message=localize{type='variable',key='a_chips',vars={v}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val=card.ability.extra.val/2
    end
  end })

-- n682: Radioactive -- +5 chips per round completed (decay bonus)
SMODS.Joker({ key="n682", loc_txt={name="Radioactive",text={"{C:chips}+#1#{} chips","per {C:attention}round{} completed"}}, config={chips=5}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=8}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local r=G.GAME.round or 1
      local bonus=card.ability.chips*r
      return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
    end
  end })

-- n683: Isotope -- +6 mult per ace in scoring hand (stable variants)
SMODS.Joker({ key="n683", loc_txt={name="Isotope",text={"{C:mult}+#1#{} Mult","per {C:attention}Ace{}","in scoring hand"}}, config={mult=6}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=8}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        if c.base.value=="Ace" then count=count+1 end
      end
      if count>0 then
        local bonus=card.ability.mult*count
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n684: Compound -- +5 chips per king in scoring hand (complex structures)
SMODS.Joker({ key="n684", loc_txt={name="Compound",text={"{C:chips}+#1#{} chips","per {C:attention}King{}","in scoring hand"}}, config={chips=5}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=8}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        if c.base.value=="King" then count=count+1 end
      end
      if count>0 then
        local bonus=card.ability.chips*count
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n685: Oxidation -- stateful, loses 2 chips each round but starts at 50
SMODS.Joker({ key="n685", loc_txt={name="Oxidation",text={"{C:chips}+#1#{} chips","(-2 per round, min 0)"}}, config={extra={val=50}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=4,y=8}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.val}} end,
  calculate=function(self,card,context)
    if context.joker_main and card.ability.extra.val>0 then
      return{chips=card.ability.extra.val, message=localize{type='variable',key='a_chips',vars={card.ability.extra.val}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      if card.ability.extra.val>0 then card.ability.extra.val=math.max(0,card.ability.extra.val-2) end
    end
  end })

-- n686: Crystallization -- +3 mult per card of same rank as first scored card
SMODS.Joker({ key="n686", loc_txt={name="Crystallization",text={"{C:mult}+#1#{} Mult","per matching rank","in scoring hand"}}, config={mult=3}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=8}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if #context.scoring_hand==0 then return end
      local ref=context.scoring_hand[1].base.value
      local count=0
      for _,c in ipairs(context.scoring_hand) do
        if c.base.value==ref then count=count+1 end
      end
      if count>1 then
        local bonus=card.ability.mult*(count-1)
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n687: Evaporation -- +4 chips per discard left (liquid to gas, value is fleeting)
SMODS.Joker({ key="n687", loc_txt={name="Evaporation",text={"{C:chips}+#1#{} chips","per {C:attention}discard{} remaining"}}, config={chips=4}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=8}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local rem=G.GAME.current_round.discards_left or 0
      if rem>0 then
        local bonus=card.ability.chips*rem
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n688: Condensation -- +3 mult per hand remaining (concentration increases)
SMODS.Joker({ key="n688", loc_txt={name="Condensation",text={"{C:mult}+#1#{} Mult","per {C:attention}hand{} remaining"}}, config={mult=3}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=8}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local rem=G.GAME.current_round.hands_left or 0
      if rem>0 then
        local bonus=card.ability.mult*rem
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n689: Precipitation -- +5 chips per card discarded this round (rain falls)
SMODS.Joker({ key="n689", loc_txt={name="Precipitation",text={"{C:chips}+#1#{} chips","per card {C:attention}discarded{}","this round"}}, config={chips=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=8}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local used=G.GAME.current_round.discards_used or 0
      if used>0 then
        local bonus=card.ability.chips*used
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n690: Osmosis -- +6 mult when scoring hand has more cards than hand size avg
SMODS.Joker({ key="n690", loc_txt={name="Osmosis",text={"{C:mult}+#1#{} Mult","when scoring {C:attention}5{} cards"}}, config={mult=6}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=8}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #context.scoring_hand>=5 then
      return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n691: Membrane -- +3 chips per card NOT scored (selective permeability)
SMODS.Joker({ key="n691", loc_txt={name="Membrane",text={"{C:chips}+#1#{} chips","per card {C:attention}not scored{}"}}, config={chips=3}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=9}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local total=G.hand and #G.hand.cards or 0
      local scored=#context.scoring_hand
      local not_scored=total
      if not_scored>0 then
        local bonus=card.ability.chips*not_scored
        return{chips=bonus, message=localize{type='variable',key='a_chips',vars={bonus}}}
      end
    end
  end })

-- n692: Mitosis -- stateful, duplicates its own mult each ante (cell division)
SMODS.Joker({ key="n692", loc_txt={name="Mitosis",text={"{C:mult}+#1#{} Mult","(doubles each {C:attention}Ante{})"}}, config={extra={val=1,last_ante=1}}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=1,y=9}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.val}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{mult=card.ability.extra.val, message=localize{type='variable',key='a_mult',vars={card.ability.extra.val}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      local ante=G.GAME.round_resets and G.GAME.round_resets.ante or 1
      if ante~=card.ability.extra.last_ante then
        card.ability.extra.val=card.ability.extra.val*2
        card.ability.extra.last_ante=ante
      end
    end
  end })

-- n693: Evolution -- stateful, +3 mult each round this is the highest mult joker
SMODS.Joker({ key="n693", loc_txt={name="Evolution",text={"{C:mult}+#1#{} Mult","(+3 each round)"}}, config={extra={val=3}}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=9}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.val}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{mult=card.ability.extra.val, message=localize{type='variable',key='a_mult',vars={card.ability.extra.val}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val=card.ability.extra.val+3
    end
  end })

-- n694: Adaptation -- +5 chips first hand of ante, +5 mult second, Xmult 2 third
SMODS.Joker({ key="n694", loc_txt={name="Adaptation",text={"Adapts each hand:","1st {C:chips}+#1#{} chips","2nd {C:mult}+#1#{} Mult","3rd+ {X:mult,C:white}X2{} Mult"}}, config={chips=5,mult=5}, rarity=3, cost=10, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=9}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips,center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local h=G.GAME.current_round.hands_played or 0
      if h==0 then
        return{chips=card.ability.chips, message=localize{type='variable',key='a_chips',vars={card.ability.chips}}}
      elseif h==1 then
        return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      else
        return{Xmult=2, message=localize{type='variable',key='a_xmult',vars={2}}}
      end
    end
  end })

-- n695: Natural Selection -- +4 mult per discard used (survival = discarding weak cards)
SMODS.Joker({ key="n695", loc_txt={name="Natural Selection",text={"{C:mult}+#1#{} Mult","per {C:attention}discard{} used this round"}}, config={mult=4}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=9}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local used=G.GAME.current_round.discards_used or 0
      if used>0 then
        local bonus=card.ability.mult*used
        return{mult=bonus, message=localize{type='variable',key='a_mult',vars={bonus}}}
      end
    end
  end })

-- n696: Genesis -- +8 mult on round 1 of each ante (the beginning)
SMODS.Joker({ key="n696", loc_txt={name="Genesis",text={"{C:mult}+#1#{} Mult","on the {C:attention}first round{}","of each Ante"}}, config={mult=8}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=9}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local r=G.GAME.round or 1
      local ante=G.GAME.round_resets and G.GAME.round_resets.ante or 1
      local round_in_ante=(r-1)%(3)+1
      if round_in_ante==1 then
        return{mult=card.ability.mult, message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
      end
    end
  end })

-- n697: Extinction -- Xmult 8 when you have 3 or fewer cards left in hand
SMODS.Joker({ key="n697", loc_txt={name="Extinction",text={"{X:mult,C:white}X#1#{} Mult","when {C:attention}3 or fewer{}","cards in hand"}}, config={Xmult=8}, rarity=4, cost=14, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=9}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hand_size=G.hand and #G.hand.cards or 0
      if hand_size<=3 then
        return{Xmult=card.ability.Xmult, message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
      end
    end
  end })

-- n698: Fossil Record -- +2 chips per round completed (geological strata)
SMODS.Joker({ key="n698", loc_txt={name="Fossil Record",text={"{C:chips}+#1#{} chips","per {C:attention}round{} completed","(+2 per round)"}}, config={extra={val=0}}, rarity=2, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=7,y=9}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.val}} end,
  calculate=function(self,card,context)
    if context.joker_main and card.ability.extra.val>0 then
      return{chips=card.ability.extra.val, message=localize{type='variable',key='a_chips',vars={card.ability.extra.val}}}
    end
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.val=card.ability.extra.val+2
    end
  end })

-- n699: Big Crunch -- Xmult = number of jokers owned (universe collapses inward)
SMODS.Joker({ key="n699", loc_txt={name="Big Crunch",text={"{X:mult,C:white}X{} Mult equal","to {C:attention}Joker count{}"}}, config={}, rarity=3, cost=11, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=9}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={G.jokers and #G.jokers.cards or 1}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local count=#G.jokers.cards
      if count>0 then
        return{Xmult=count, message=localize{type='variable',key='a_xmult',vars={count}}}
      end
    end
  end })

-- n700: Singularity -- legendary, Xmult 10 but only works alone (no other jokers)
SMODS.Joker({ key="n700", loc_txt={name="Singularity",text={"{X:mult,C:white}X#1#{} Mult","only when this is","your {C:attention}only Joker{}"}}, config={Xmult=10}, rarity=4, cost=20, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=false, perishable_compat=true, pos={x=9,y=9}, atlas="cm_atlas_07",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.jokers.cards==1 then
      return{Xmult=card.ability.Xmult, message=localize{type='variable',key='a_xmult',vars={card.ability.Xmult}}}
    end
  end })
