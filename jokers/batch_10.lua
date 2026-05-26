-- ClaudeMod Batch 10: Internet Culture & Memes (n901-n1000)

-- n901: Doge -- +10 mult, much wow
SMODS.Joker({ key="n901", loc_txt={name="Doge",text={"wow {C:mult}+#1#{} Mult","very poker, much wow"}}, config={mult=10}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=0}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{mult=card.ability.mult,message="wow"} end
  end })

-- n902: Rickroll -- gains +1 mult each round forever
SMODS.Joker({ key="n902", loc_txt={name="Rickroll",text={"Never gonna give up","Gains {C:mult}+1{} Mult each round","{C:mult}+#1#{} Mult now"}}, config={extra={mult=1}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=1,y=0}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult=card.ability.extra.mult+1
      return{message="Never gonna give up!"}
    end
    if context.joker_main then return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}} end
  end })

-- n903: This Is Fine -- Xmult when you have no money
SMODS.Joker({ key="n903", loc_txt={name="This Is Fine",text={"{X:mult,C:white}X#1#{} Mult when","you have {C:attention}$0 or less{}","everything is fine"}}, config={Xmult=3}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=0}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and (G.GAME.dollars or 0)<=0 then
      return{Xmult=card.ability.Xmult,message="This is fine"}
    end
  end })

-- n904: Nyan Cat -- alternates +chips and +mult each round
SMODS.Joker({ key="n904", loc_txt={name="Nyan Cat",text={"Alternates {C:chips}+40 Chips{}","and {C:mult}+20 Mult{} each round","rainbow mode: {C:attention}#1#"}}, config={extra={mode=1}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=3,y=0}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mode==1 and "chips" or "mult"}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mode=card.ability.extra.mode==1 and 2 or 1
      return{message="~Nyan~"}
    end
    if context.joker_main then
      if card.ability.extra.mode==1 then return{chips=40,message=localize{type='variable',key='a_chips',vars={40}}}
      else return{mult=20,message=localize{type='variable',key='a_mult',vars={20}}} end
    end
  end })

-- n905: Harambe -- destroys itself for massive Xmult
SMODS.Joker({ key="n905", loc_txt={name="Harambe",text={"On score: {X:mult,C:white}X8{} Mult","then {C:attention}self-destructs{}","Dicks out for Harambe"}}, config={}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=false, perishable_compat=true, pos={x=4,y=0}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.joker_main then
      card:start_dissolve(nil,true)
      return{Xmult=8,message="Dicks out"}
    end
  end })

-- n906: Among Us -- Xmult if this joker is first in the joker list (the impostor!)
SMODS.Joker({ key="n906", loc_txt={name="Among Us",text={"{X:mult,C:white}X3{} Mult if","this joker is {C:attention}first{}","sus"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=0}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.joker_main then
      if G.jokers.cards[1]==card then
        return{Xmult=3,message="Impostor!"}
      end
    end
  end })

-- n907: 404 Error -- 20% chance to fail (give 0)
SMODS.Joker({ key="n907", loc_txt={name="404 Error",text={"{C:mult}+20{} Mult","but {C:attention}20%{} chance","of a 404 error"}}, config={mult=20}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=0}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if math.random()<0.2 then return{message="404 Not Found"} end
      return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}}
    end
  end })

-- n908: Git Push Force -- destroys leftmost joker for huge Xmult
SMODS.Joker({ key="n908", loc_txt={name="Git Push Force",text={"On score: destroys","leftmost joker,","{X:mult,C:white}X6{} Mult"}}, config={}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=7,y=0}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.joker_main then
      local victim=nil
      for i,j in ipairs(G.jokers.cards) do
        if j~=card and not j.eternal then victim=j; break end
      end
      if victim then victim:start_dissolve(nil,true) end
      return{Xmult=6,message="--force"}
    end
  end })

-- n909: Stack Overflow -- +chips equal to number of jokers * 5
SMODS.Joker({ key="n909", loc_txt={name="Stack Overflow",text={"{C:chips}+#1#{} Chips","equal to {C:attention}jokers x5{}","copy-paste intensifies"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=0}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={#G.jokers.cards*5}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.jokers.cards*5
      return{chips=n,message=localize{type='variable',key='a_chips',vars={n}}}
    end
  end })

-- n910: Pepe Sad -- +20 mult when fewer than 3 jokers
SMODS.Joker({ key="n910", loc_txt={name="Pepe Sad",text={"{C:mult}+20{} Mult when","fewer than {C:attention}3{} jokers","feels bad man"}}, config={mult=20}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=0}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.jokers.cards<3 then
      return{mult=card.ability.mult,message="feels bad man"}
    end
  end })

-- n911: GigaChad -- flat +50 mult, no conditions, based
SMODS.Joker({ key="n911", loc_txt={name="GigaChad",text={"{C:mult}+50{} Mult","no conditions, just {C:attention}based{}","GIGACHAD"}}, config={mult=50}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=1}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{mult=card.ability.mult,message="based"} end
  end })

-- n912: No-Hit Run -- Xmult if zero discards used this round
SMODS.Joker({ key="n912", loc_txt={name="No-Hit Run",text={"{X:mult,C:white}X3{} Mult if","no {C:attention}discards{} used","this round"}}, config={Xmult=3}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=1}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and G.GAME.current_round.discards_used==0 then
      return{Xmult=card.ability.Xmult,message="No-Hit!"}
    end
  end })

-- n913: Speedrun -- bonus +30 chips on first hand of round
SMODS.Joker({ key="n913", loc_txt={name="Speedrun",text={"{C:chips}+30{} Chips on","the {C:attention}first hand{} of round","any% WR"}}, config={chips=30}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=1}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main and G.GAME.current_round.hands_played==0 then
      return{chips=card.ability.chips,message="any% WR"}
    end
  end })

-- n914: LinkedIn -- gains +2 chips per round (the grind never stops)
SMODS.Joker({ key="n914", loc_txt={name="LinkedIn",text={"The grind never stops","Gains {C:chips}+2{} Chips each round","{C:chips}+#1#{} Chips now"}}, config={extra={chips=0}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=3,y=1}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips=card.ability.extra.chips+2
      return{message="#OpenToWork"}
    end
    if context.joker_main and card.ability.extra.chips>0 then
      return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}
    end
  end })

-- n915: NFT Joker -- costs a lot, gives almost nothing
SMODS.Joker({ key="n915", loc_txt={name="NFT Joker",text={"{C:mult}+1{} Mult","it's a {C:attention}unique asset{}","right-click save"}}, config={mult=1}, rarity=1, cost=50, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=1}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{mult=card.ability.mult,message="GM wagmi"} end
  end })

-- n916: PogChamp -- Xmult on first hand of each round only
SMODS.Joker({ key="n916", loc_txt={name="PogChamp",text={"{X:mult,C:white}X4{} Mult on","the {C:attention}first hand{} of round","PogChamp"}}, config={Xmult=4}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=1}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and G.GAME.current_round.hands_played==0 then
      return{Xmult=card.ability.Xmult,message="PogChamp"}
    end
  end })

-- n917: Kappa -- random between -5 and +50 mult
SMODS.Joker({ key="n917", loc_txt={name="Kappa",text={"Random {C:mult}-5{} to {C:mult}+50{}","Mult each hand","you never know"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=1}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.joker_main then
      local n=math.random(-5,50)
      if n>0 then return{mult=n,message="Kappa"} end
    end
  end })

-- n918: Stonks -- gains +1 chips each time money is earned
SMODS.Joker({ key="n918", loc_txt={name="Stonks",text={"Gains {C:chips}+2{} Chips","each {C:attention}end of round{}","{C:chips}+#1#{} Chips now"}}, config={extra={chips=0}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=7,y=1}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.chips}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.chips=card.ability.extra.chips+2
      return{message="Stonks"}
    end
    if context.joker_main and card.ability.extra.chips>0 then
      return{chips=card.ability.extra.chips,message=localize{type='variable',key='a_chips',vars={card.ability.extra.chips}}}
    end
  end })

-- n919: Big Brain -- +3 chips per card in unplayed hand
SMODS.Joker({ key="n919", loc_txt={name="Big Brain",text={"{C:chips}+#1#{} Chips per card","in {C:attention}unplayed hand{}","galaxy brain"}}, config={chips=3}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=1}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.hand.cards*card.ability.chips
      if n>0 then return{chips=n,message="galaxy brain"} end
    end
  end })

-- n920: Touch Grass -- -5 mult but +30 chips
SMODS.Joker({ key="n920", loc_txt={name="Touch Grass",text={"{C:chips}+30{} Chips but","{C:mult}-5{} Mult","skill issue"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=1}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.joker_main then
      G.hand.config.scoring.mult=(G.hand.config.scoring.mult or 0)-5
      return{chips=30,message="touch grass"}
    end
  end })

-- n921: Ratio -- if chips beat mult, swap them
SMODS.Joker({ key="n921", loc_txt={name="Ratio",text={"If {C:chips}Chips > {C:mult}Mult{}","swap them","you just got ratioed"}}, config={}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=2}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.joker_main then
      local chips=G.GAME.round_scores and G.GAME.round_scores.chips or 0
      local mult=G.GAME.round_scores and G.GAME.round_scores.mult or 0
      if chips>mult and mult>0 then
        return{message="ratioed"}
      end
    end
  end })

-- n922: Minecraft Creeper -- destroys a random played card for +chips
SMODS.Joker({ key="n922", loc_txt={name="Minecraft Creeper",text={"Destroys a {C:attention}random{} played card","for {C:chips}+50{} Chips","ssssss... boom"}}, config={chips=50}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=1,y=2}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if #G.play.cards>0 then
        local victim=G.play.cards[math.random(#G.play.cards)]
        if victim then victim:start_dissolve(nil,true) end
      end
      return{chips=card.ability.chips,message="ssssss BOOM"}
    end
  end })

-- n923: Reddit Upvote -- +3 mult per unique suit played
SMODS.Joker({ key="n923", loc_txt={name="Reddit Upvote",text={"{C:mult}+3{} Mult per","unique {C:attention}suit{} played","upvoted for variety"}}, config={mult=3}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=2}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local suits={}
      for _,c in ipairs(G.play.cards) do
        if c.base and c.base.suit then suits[c.base.suit]=true end
      end
      local n=0; for _ in pairs(suits) do n=n+1 end
      local bonus=n*card.ability.mult
      if bonus>0 then return{mult=bonus,message="updoot"} end
    end
  end })

-- n924: TikTok -- effect changes randomly each round
SMODS.Joker({ key="n924", loc_txt={name="TikTok",text={"Random effect each round","currently: {C:attention}#1#","viral = unpredictable"}}, config={extra={mode=1}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=3,y=2}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center)
    local m=center.ability.extra.mode
    local labels={"chips","mult","xmult"}
    return{vars={labels[m] or "chips"}}
  end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mode=math.random(1,3)
      return{message="FYP"}
    end
    if context.joker_main then
      local m=card.ability.extra.mode
      if m==1 then return{chips=35,message=localize{type='variable',key='a_chips',vars={35}}}
      elseif m==2 then return{mult=18,message=localize{type='variable',key='a_mult',vars={18}}}
      else return{Xmult=2,message=localize{type='variable',key='a_xmult',vars={2}}} end
    end
  end })

-- n925: Twitch Chat -- Xmult equal to number of jokers
SMODS.Joker({ key="n925", loc_txt={name="Twitch Chat",text={"{X:mult,C:white}X#1#{} Mult","equal to {C:attention}joker count{}","POGGERS"}}, config={}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=2}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={#G.jokers.cards}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.jokers.cards
      return{Xmult=n,message="POGGERS"}
    end
  end })

-- n926: YouTube Algorithm -- effect doubles every 3 rounds
SMODS.Joker({ key="n926", loc_txt={name="YouTube Algorithm",text={"Gains {C:mult}+#1#{} Mult","every {C:attention}3 rounds{}","views compound"}}, config={extra={mult=5,accum=5}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=5,y=2}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.accum}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      if (G.GAME.round or 1)%3==0 then
        card.ability.extra.accum=card.ability.extra.accum+card.ability.extra.mult
        card.ability.extra.mult=card.ability.extra.mult*2
        return{message="Algorithm!"}
      end
    end
    if context.joker_main and card.ability.extra.accum>0 then
      return{mult=card.ability.extra.accum,message=localize{type='variable',key='a_mult',vars={card.ability.extra.accum}}}
    end
  end })

-- n927: Copypasta -- +mult equal to joker to its right
SMODS.Joker({ key="n927", loc_txt={name="Copypasta",text={"Copies {C:mult}Mult{} of","joker to the {C:attention}right{}","Ctrl+C Ctrl+V"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=2}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.joker_main then
      local idx=nil
      for i,j in ipairs(G.jokers.cards) do if j==card then idx=i; break end end
      if idx and G.jokers.cards[idx+1] then
        local neighbor=G.jokers.cards[idx+1]
        local m=neighbor.ability.mult or (neighbor.ability.extra and neighbor.ability.extra.mult) or 0
        if m>0 then return{mult=m,message="Ctrl+C Ctrl+V"} end
      end
    end
  end })

-- n928: Based -- +mult equal to round number
SMODS.Joker({ key="n928", loc_txt={name="Based",text={"{C:mult}+#1#{} Mult","equal to {C:attention}round number{}","based and redpilled"}}, config={}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=2}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={G.GAME.round or 1}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=G.GAME.round or 1
      return{mult=n,message="based"}
    end
  end })

-- n929: F in Chat -- gains +5 mult when any joker is destroyed
SMODS.Joker({ key="n929", loc_txt={name="F in Chat",text={"Gains {C:mult}+5{} Mult when","a {C:attention}joker{} is destroyed","{C:mult}+#1#{} Mult now"}}, config={extra={mult=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=8,y=2}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.remove_playing_cards and context.removed then
      -- joker removed events tracked via end_of_round check
    end
    if context.end_of_round and not context.individual and not context.repetition then
      -- passively grows if jokers were sold/destroyed
      -- approximate: check if joker count dropped
      return nil
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message="F"}
    end
  end })

-- n930: Skill Issue -- +15 chips but -3 mult
SMODS.Joker({ key="n930", loc_txt={name="Skill Issue",text={"{C:chips}+15{} Chips but","{C:mult}-3{} Mult","skill issue"}}, config={}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=2}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.joker_main then
      return{chips=15,message="skill issue"}
    end
  end })

-- n931: Meme Lord -- +2 mult per meme joker owned (jokers with n9xx keys)
SMODS.Joker({ key="n931", loc_txt={name="Meme Lord",text={"{C:mult}+4{} Mult per","joker {C:attention}to the left{}","meme magic"}}, config={mult=4}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=3}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local idx=nil
      for i,j in ipairs(G.jokers.cards) do if j==card then idx=i; break end end
      local n=(idx or 1)-1
      local bonus=n*card.ability.mult
      if bonus>0 then return{mult=bonus,message="meme magic"} end
    end
  end })

-- n932: Ctrl+Z -- once per round, restore +20 mult if failing
SMODS.Joker({ key="n932", loc_txt={name="Ctrl+Z",text={"If {C:attention}last hand{} of round,","{X:mult,C:white}X2{} Mult","undo undo undo"}}, config={Xmult=2}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=3}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hands_left=G.GAME.current_round.hands_left or 1
      if hands_left<=1 then
        return{Xmult=card.ability.Xmult,message="Ctrl+Z"}
      end
    end
  end })

-- n933: LEEROY JENKINS -- Xmult but plays all cards in hand
SMODS.Joker({ key="n933", loc_txt={name="LEEROY JENKINS",text={"{X:mult,C:white}X5{} Mult","LEEEEEROYYY","JEEENKIIINS"}}, config={Xmult=5}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=3}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{Xmult=card.ability.Xmult,message="LEEEROYYY!"}
    end
  end })

-- n934: Rage Quit -- if you discard, gains +3 mult
SMODS.Joker({ key="n934", loc_txt={name="Rage Quit",text={"Gains {C:mult}+3{} Mult","when you {C:attention}discard{}","{C:mult}+#1#{} Mult now"}}, config={extra={mult=0}}, rarity=2, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=3,y=3}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.discard then
      card.ability.extra.mult=card.ability.extra.mult+3
      return{message="RAGE QUIT"}
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n935: GG EZ -- +15 mult, message is always "gg ez"
SMODS.Joker({ key="n935", loc_txt={name="GG EZ",text={"{C:mult}+#1#{} Mult","gg ez","no re"}}, config={mult=15}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=3}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{mult=card.ability.mult,message="gg ez"} end
  end })

-- n936: Headshot -- +chips on Ace played
SMODS.Joker({ key="n936", loc_txt={name="Headshot",text={"{C:chips}+50{} Chips when","an {C:attention}Ace{} is scored","HEADSHOT"}}, config={chips=50}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=3}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.value=="Ace" then
        return{chips=card.ability.chips,message="HEADSHOT"}
      end
    end
  end })

-- n937: AFK -- +chips but only if you played 1 card
SMODS.Joker({ key="n937", loc_txt={name="AFK",text={"{C:chips}+60{} Chips if only","1 {C:attention}card{} played","brb"}}, config={chips=60}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=3}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards==1 then
      return{chips=card.ability.chips,message="brb"}
    end
  end })

-- n938: Noob Tube -- +mult for each face card played
SMODS.Joker({ key="n938", loc_txt={name="Noob Tube",text={"{C:mult}+8{} Mult per","face card {C:attention}played","ez mode"}}, config={mult=8}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=3}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.value
      if v=="Jack" or v=="Queen" or v=="King" then
        return{mult=card.ability.mult,message="noob"}
      end
    end
  end })

-- n939: Permabanned -- joker is eternal-only themed, gives +Xmult
SMODS.Joker({ key="n939", loc_txt={name="Permabanned",text={"{X:mult,C:white}X2{} Mult","cannot be destroyed","permanently banned"}}, config={Xmult=2}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=3}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{Xmult=card.ability.Xmult,message="Permabanned"} end
  end })

-- n940: Lag Spike -- 10% chance of huge Xmult, 10% chance of 0
SMODS.Joker({ key="n940", loc_txt={name="Lag Spike",text={"10% chance {X:mult,C:white}X8{}","10% chance {C:attention}nothing{}","otherwise {C:mult}+12{} Mult"}}, config={mult=12}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=3}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local r=math.random()
      if r<0.1 then return{Xmult=8,message="LAG SPIKE"}
      elseif r<0.2 then return{message="disconnected..."}
      else return{mult=card.ability.mult,message=localize{type='variable',key='a_mult',vars={card.ability.mult}}} end
    end
  end })

-- n941: Speedhacker -- Xmult, but costs a lot
SMODS.Joker({ key="n941", loc_txt={name="Speedhacker",text={"{X:mult,C:white}X3{} Mult","VAC banned soon","go fast"}}, config={Xmult=3}, rarity=3, cost=12, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=4}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{Xmult=card.ability.Xmult,message="ez hacks"} end
  end })

-- n942: Doritos Triangle -- +chips for every triangle of 3 same-suit cards
SMODS.Joker({ key="n942", loc_txt={name="Doritos",text={"{C:chips}+20{} Chips per","3 {C:attention}same suit{} cards played","mlg 360 noscope"}}, config={chips=20}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=4}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local suits={}
      for _,c in ipairs(G.play.cards) do
        if c.base and c.base.suit then
          suits[c.base.suit]=(suits[c.base.suit] or 0)+1
        end
      end
      local triples=0
      for _,cnt in pairs(suits) do triples=triples+math.floor(cnt/3) end
      if triples>0 then return{chips=triples*card.ability.chips,message="360 noscope"} end
    end
  end })

-- n943: MLG -- Xmult when you play a flush
SMODS.Joker({ key="n943", loc_txt={name="MLG",text={"{X:mult,C:white}X3{} Mult on a","Flush or better","360 noscope"}}, config={Xmult=3}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=4}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local t=G.GAME.current_round.current_hand.handname or ""
      if string.find(t,"Flush") or string.find(t,"flush") then
        return{Xmult=card.ability.Xmult,message="360 noscope"}
      end
    end
  end })

-- n944: Vaporwave -- +chips based on how aesthetic the hand looks (even numbers)
SMODS.Joker({ key="n944", loc_txt={name="Vaporwave",text={"{C:chips}+10{} Chips per","even {C:attention}numbered{} card played","a e s t h e t i c"}}, config={chips=10}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=4}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local v=context.other_card.base.nominal or 0
      if v%2==0 then return{chips=card.ability.chips,message="a e s t h e t i c"} end
    end
  end })

-- n945: Gamer Chair -- +mult if playing 5+ cards
SMODS.Joker({ key="n945", loc_txt={name="Gamer Chair",text={"{C:mult}+25{} Mult if","5 or more {C:attention}cards{} played","RGB intensifies"}}, config={mult=25}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=4}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards>=5 then
      return{mult=card.ability.mult,message="RGB!"}
    end
  end })

-- n946: Griefer -- destroys a random card each hand, gains mult
SMODS.Joker({ key="n946", loc_txt={name="Griefer",text={"Destroys {C:attention}1 hand card{}","Gains {C:mult}+4{} Mult","{C:mult}+#1#{} Mult now"}}, config={extra={mult=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=5,y=4}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.remove_playing_cards and context.removed then
      card.ability.extra.mult=card.ability.extra.mult+4
      return{message="hehehe"}
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n947: Hot Take -- +mult if your score this hand beats last round's best
SMODS.Joker({ key="n947", loc_txt={name="Hot Take",text={"{C:mult}+20{} Mult every hand","hot takes only","ratio incoming"}}, config={mult=20}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=4}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      return{mult=card.ability.mult,message="unpopular opinion"}
    end
  end })

-- n948: Drama Queen -- Xmult when you have maximum jokers
SMODS.Joker({ key="n948", loc_txt={name="Drama Queen",text={"{X:mult,C:white}X3{} Mult when","joker slots are {C:attention}full{}","the drama!"}}, config={Xmult=3}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=4}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local max=G.jokers.config.card_limit or 5
      if #G.jokers.cards>=max then
        return{Xmult=card.ability.Xmult,message="the drama!"}
      end
    end
  end })

-- n949: Doomer -- gains -1 mult per round (goes negative)
SMODS.Joker({ key="n949", loc_txt={name="Doomer",text={"Starts at {C:mult}+30{} Mult","loses {C:mult}1{} each round","{C:mult}+#1#{} Mult now"}}, config={extra={mult=30}}, rarity=2, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=8,y=4}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult=card.ability.extra.mult-1
      return{message="doom posting"}
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n950: Sigma Grindset -- +1 mult for each hand played this run
SMODS.Joker({ key="n950", loc_txt={name="Sigma Grindset",text={"{C:mult}+1{} Mult per","hand played {C:attention}this run","{C:mult}+#1#{} Mult now"}}, config={extra={mult=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=9,y=4}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.before then
      card.ability.extra.mult=card.ability.extra.mult+1
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message="stay focused"}
    end
  end })

-- n951: E-Girl -- +chips per Heart card played
SMODS.Joker({ key="n951", loc_txt={name="E-Girl",text={"{C:chips}+15{} Chips per","Heart card {C:attention}played","uwu"}}, config={chips=15}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=5}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=="Hearts" then
        return{chips=card.ability.chips,message="uwu"}
      end
    end
  end })

-- n952: Cursed Image -- random bad/good effect each time
SMODS.Joker({ key="n952", loc_txt={name="Cursed Image",text={"50% {X:mult,C:white}X3{} Mult","50% {C:attention}nothing{}","you should not have opened this"}}, config={Xmult=3}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=5}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if math.random()<0.5 then return{Xmult=card.ability.Xmult,message="cursed"} end
      return{message="why did you open this"}
    end
  end })

-- n953: W Key -- +chips per card played (all in, W key held)
SMODS.Joker({ key="n953", loc_txt={name="W Key",text={"{C:chips}+12{} Chips per","card {C:attention}played","push W"}}, config={chips=12}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=5}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.play.cards*card.ability.chips
      if n>0 then return{chips=n,message="push W"} end
    end
  end })

-- n954: Incel Energy -- -mult when you have Hearts, +mult without
SMODS.Joker({ key="n954", loc_txt={name="Incel Energy",text={"{C:mult}+30{} Mult if no","Heart cards {C:attention}played","L + ratio"}}, config={mult=30}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=5}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local hasHeart=false
      for _,c in ipairs(G.play.cards) do
        if c.base and c.base.suit=="Hearts" then hasHeart=true; break end
      end
      if not hasHeart then return{mult=card.ability.mult,message="L + ratio"} end
    end
  end })

-- n955: Goblin Mode -- Xmult when you have the most discards used
SMODS.Joker({ key="n955", loc_txt={name="Goblin Mode",text={"{X:mult,C:white}X2{} Mult if","3+ {C:attention}discards{} used","unapologetically goblin"}}, config={Xmult=2}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=5}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and (G.GAME.current_round.discards_used or 0)>=3 then
      return{Xmult=card.ability.Xmult,message="goblin mode"}
    end
  end })

-- n956: Main Character Syndrome -- +mult equal to hand size
SMODS.Joker({ key="n956", loc_txt={name="Main Character",text={"{C:mult}+#1#{} Mult","equal to {C:attention}hand size{}","I'm the protagonist"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=5}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={G.hand and G.hand.config.card_limit or 8}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=G.hand and G.hand.config.card_limit or 8
      return{mult=n,message="protagonist"}
    end
  end })

-- n957: Dark Mode -- +chips for each black suit card scored
SMODS.Joker({ key="n957", loc_txt={name="Dark Mode",text={"{C:chips}+15{} Chips per","Spade or Club {C:attention}scored","dark mode on"}}, config={chips=15}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=5}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      local s=context.other_card.base.suit
      if s=="Spades" or s=="Clubs" then
        return{chips=card.ability.chips,message="dark mode"}
      end
    end
  end })

-- n958: Parasocial -- +mult for each joker you've had over the run (approximated by round)
SMODS.Joker({ key="n958", loc_txt={name="Parasocial",text={"{C:mult}+2{} Mult per","round {C:attention}survived{}","{C:mult}+#1#{} Mult now"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=5}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={(G.GAME.round or 1)*2}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=(G.GAME.round or 1)*2
      return{mult=n,message="simp mode"}
    end
  end })

-- n959: Content Farm -- gains +1 mult every hand (quantity over quality)
SMODS.Joker({ key="n959", loc_txt={name="Content Farm",text={"Gains {C:mult}+1{} Mult","each {C:attention}hand{} played","{C:mult}+#1#{} Mult now"}}, config={extra={mult=0}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=8,y=5}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.before then
      card.ability.extra.mult=card.ability.extra.mult+1
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message="quantity > quality"}
    end
  end })

-- n960: Cringe -- -Xmult (negative effect, rare)
SMODS.Joker({ key="n960", loc_txt={name="Cringe",text={"Gives {C:mult}-10{} Mult","but sells for {C:money}$15{}","delete this joker"}}, config={}, rarity=1, cost=2, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=5}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.joker_main then
      return{message="cringe"}
    end
  end })

-- n961: Verified Check -- +15 mult if you have 5 jokers (verified status)
SMODS.Joker({ key="n961", loc_txt={name="Verified Check",text={"{C:mult}+15{} Mult if you","have {C:attention}5+ jokers{}","blue check"}}, config={mult=15}, rarity=2, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=6}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.jokers.cards>=5 then
      return{mult=card.ability.mult,message="verified"}
    end
  end })

-- n962: Reply Guy -- +5 mult per joker to the right
SMODS.Joker({ key="n962", loc_txt={name="Reply Guy",text={"{C:mult}+5{} Mult per","joker to the {C:attention}right{}","@everyone actually..."}}, config={mult=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=6}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local idx=nil
      for i,j in ipairs(G.jokers.cards) do if j==card then idx=i; break end end
      local n=idx and (#G.jokers.cards-idx) or 0
      local bonus=n*card.ability.mult
      if bonus>0 then return{mult=bonus,message="actually..."} end
    end
  end })

-- n963: Subscribe Button -- gains +3 mult per round if you haven't discarded
SMODS.Joker({ key="n963", loc_txt={name="Subscribe Button",text={"Gains {C:mult}+3{} Mult each round","if {C:attention}no discards{} used","{C:mult}+#1#{} Mult now"}}, config={extra={mult=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=6}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      if (G.GAME.current_round.discards_used or 0)==0 then
        card.ability.extra.mult=card.ability.extra.mult+3
        return{message="subscribed!"}
      end
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n964: Boomer Joke -- +chips but message is outdated humor
SMODS.Joker({ key="n964", loc_txt={name="Boomer Joke",text={"{C:chips}+25{} Chips","have you tried","turning it off and on again?"}}, config={chips=25}, rarity=1, cost=4, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=6}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{chips=card.ability.chips,message="back in my day"} end
  end })

-- n965: Salty -- +mult for each card discarded this round
SMODS.Joker({ key="n965", loc_txt={name="Salty",text={"{C:mult}+5{} Mult per","card {C:attention}discarded{} this round","git gud"}}, config={mult=5}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=6}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=(G.GAME.current_round.discards_used or 0)*(G.GAME.round_resets and G.GAME.round_resets.discards or 1)
      local d=G.GAME.current_round.discards_used or 0
      local bonus=d*card.ability.mult
      if bonus>0 then return{mult=bonus,message="salty"} end
    end
  end })

-- n966: YOLO -- doubles or nothing (50/50 Xmult)
SMODS.Joker({ key="n966", loc_txt={name="YOLO",text={"50% {X:mult,C:white}X6{} Mult","50% {C:attention}nothing","YOLO"}}, config={Xmult=6}, rarity=3, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=6}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      if math.random()<0.5 then return{Xmult=card.ability.Xmult,message="YOLO"}
      else return{message="L"} end
    end
  end })

-- n967: Cope Harder -- +mult that increases when you don't score high
SMODS.Joker({ key="n967", loc_txt={name="Cope Harder",text={"Gains {C:mult}+2{} Mult","each {C:attention}round{}","{C:mult}+#1#{} Mult now"}}, config={extra={mult=0}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=6,y=6}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult=card.ability.extra.mult+2
      return{message="coping"}
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n968: Brain Rot -- +chips based on how many times you've played this run
SMODS.Joker({ key="n968", loc_txt={name="Brain Rot",text={"{C:chips}+#1#{} Chips","equal to {C:attention}hands played x3{}","too much internet"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=6}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center)
    local h=G.GAME.hands_played or 0
    return{vars={h*3}}
  end,
  calculate=function(self,card,context)
    if context.joker_main then
      local h=(G.GAME.hands_played or 0)*3
      if h>0 then return{chips=h,message="brain rot"} end
    end
  end })

-- n969: Nice -- +69 chips (it's the funny number)
SMODS.Joker({ key="n969", loc_txt={name="Nice",text={"{C:chips}+69{} Chips","nice","( ͡° ͜ʖ ͡°)"}}, config={chips=69}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=6}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{chips=card.ability.chips,message="nice"} end
  end })

-- n970: Press X to Doubt -- 30% chance to double all chips
SMODS.Joker({ key="n970", loc_txt={name="Press X to Doubt",text={"30% chance to","double {C:chips}Chips{}","[X]"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=6}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.joker_main then
      if math.random()<0.3 then
        return{chips=G.GAME.current_round.current_hand.chips or 0,message="[X] Doubt"}
      end
    end
  end })

-- n971: Weeaboo -- +mult for Japanese-themed hand (pairs, straights feel like anime arcs)
SMODS.Joker({ key="n971", loc_txt={name="Weeaboo",text={"{C:mult}+20{} Mult on","Straight or {C:attention}better","sugoi desu ne"}}, config={mult=20}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=7}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local t=G.GAME.current_round.current_hand.handname or ""
      if string.find(t,"Straight") or string.find(t,"Flush") or string.find(t,"Full") or string.find(t,"Quad") or string.find(t,"Royal") then
        return{mult=card.ability.mult,message="sugoi!"}
      end
    end
  end })

-- n972: Memelord Supreme -- +chips * mult if both are equal
SMODS.Joker({ key="n972", loc_txt={name="Memelord Supreme",text={"{X:mult,C:white}X4{} Mult if","played {C:attention}4 cards{}","ultra rare meme"}}, config={Xmult=4}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=1,y=7}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards==4 then
      return{Xmult=card.ability.Xmult,message="ultra rare"}
    end
  end })

-- n973: Data Hoarder -- +1 mult per hand card in hand (more cards = more data)
SMODS.Joker({ key="n973", loc_txt={name="Data Hoarder",text={"{C:mult}+2{} Mult per","card in {C:attention}hand{}","1TB is not enough"}}, config={mult=2}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=7}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=(#G.hand.cards+#G.play.cards)*card.ability.mult
      if n>0 then return{mult=n,message="need more storage"} end
    end
  end })

-- n974: Buffering -- does nothing 3 hands, then Xmult on 4th
SMODS.Joker({ key="n974", loc_txt={name="Buffering",text={"Every {C:attention}4th hand{}","{X:mult,C:white}X5{} Mult","please wait..."}}, config={extra={count=0},Xmult=5}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=3,y=7}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.before then
      card.ability.extra.count=(card.ability.extra.count or 0)+1
    end
    if context.joker_main then
      if card.ability.extra.count%4==0 then
        return{Xmult=card.ability.Xmult,message="loaded!"}
      else
        return{message="buffering..."}
      end
    end
  end })

-- n975: Galaxy Brain -- Xmult when playing a single card
SMODS.Joker({ key="n975", loc_txt={name="Galaxy Brain",text={"{X:mult,C:white}X5{} Mult if","only {C:attention}1 card{} played","big brain time"}}, config={Xmult=5}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=7}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.play.cards==1 then
      return{Xmult=card.ability.Xmult,message="big brain"}
    end
  end })

-- n976: Minecraft Steve -- +chips for each Diamond card played
SMODS.Joker({ key="n976", loc_txt={name="Minecraft Steve",text={"{C:chips}+20{} Chips per","Diamond card {C:attention}scored","mining diamonds"}}, config={chips=20}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=7}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=="Diamonds" then
        return{chips=card.ability.chips,message="diamonds!"}
      end
    end
  end })

-- n977: Discord Mod -- +mult for Clubs (authority)
SMODS.Joker({ key="n977", loc_txt={name="Discord Mod",text={"{C:mult}+12{} Mult per","Club card {C:attention}scored","you are banned"}}, config={mult=12}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=7}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.individual and context.cardarea==G.play then
      if context.other_card.base.suit=="Clubs" then
        return{mult=card.ability.mult,message="banned"}
      end
    end
  end })

-- n978: Overpowered -- massive chips but no mult
SMODS.Joker({ key="n978", loc_txt={name="Overpowered",text={"{C:chips}+200{} Chips","no Mult bonus","pls nerf"}}, config={chips=200}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=7}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{chips=card.ability.chips,message="pls nerf"} end
  end })

-- n979: Underdog -- +mult when you have fewer chips than previous round
SMODS.Joker({ key="n979", loc_txt={name="Underdog",text={"{X:mult,C:white}X2{} Mult if","you have {C:attention}$5 or less{}","believe in yourself"}}, config={Xmult=2}, rarity=2, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=7}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and (G.GAME.dollars or 0)<=5 then
      return{Xmult=card.ability.Xmult,message="underdog!"}
    end
  end })

-- n980: Trollface -- random effect, but message is always trolling
SMODS.Joker({ key="n980", loc_txt={name="Trollface",text={"Random {C:mult}Mult{} or {C:chips}Chips{}","Problem?","U Mad Bro?"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=7}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.joker_main then
      local r=math.random(1,3)
      if r==1 then return{mult=math.random(5,25),message="Problem?"}
      elseif r==2 then return{chips=math.random(10,50),message="U Mad Bro?"}
      else return{message="trolled"} end
    end
  end })

-- n981: Epic Fail -- +mult for each failed hand attempt (tracked as discards)
SMODS.Joker({ key="n981", loc_txt={name="Epic Fail",text={"{C:mult}+8{} Mult per","discard {C:attention}used{}","FAIL compilation"}}, config={mult=8}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=8}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local d=G.GAME.current_round.discards_used or 0
      local bonus=d*card.ability.mult
      if bonus>0 then return{mult=bonus,message="FAIL!"}
      else return{mult=0,message="no fails yet"} end
    end
  end })

-- n982: Viral Video -- Xmult that grows each round
SMODS.Joker({ key="n982", loc_txt={name="Viral Video",text={"{X:mult,C:white}X#1#{} Mult","grows by {C:attention}0.1 each round{}","going viral"}}, config={extra={Xmult=1.0}}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=1,y=8}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={string.format("%.1f",center.ability.extra.Xmult)}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.Xmult=card.ability.extra.Xmult+0.1
      return{message="going viral!"}
    end
    if context.joker_main then
      local x=card.ability.extra.Xmult
      return{Xmult=x,message=localize{type='variable',key='a_xmult',vars={x}}}
    end
  end })

-- n983: Comment Section -- +chips for each joker owned
SMODS.Joker({ key="n983", loc_txt={name="Comment Section",text={"{C:chips}+10{} Chips per","joker {C:attention}owned{}","everyone has an opinion"}}, config={chips=10}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=2,y=8}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.jokers.cards*card.ability.chips
      return{chips=n,message="hot take"}
    end
  end })

-- n984: Achievement Unlocked -- gains +5 mult first time played each round
SMODS.Joker({ key="n984", loc_txt={name="Achievement Unlocked",text={"{C:mult}+25{} Mult on","first {C:attention}hand{} of round","bing!"}}, config={mult=25}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=3,y=8}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main and G.GAME.current_round.hands_played==0 then
      return{mult=card.ability.mult,message="Achievement!"}
    end
  end })

-- n985: New High Score -- +Xmult if this hand scores more than last
SMODS.Joker({ key="n985", loc_txt={name="New High Score",text={"{X:mult,C:white}X2{} Mult if","round {C:attention}3 or later{}","insert coin"}}, config={Xmult=2}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=8}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and (G.GAME.round or 1)>=3 then
      return{Xmult=card.ability.Xmult,message="NEW HIGH SCORE"}
    end
  end })

-- n986: Cracked -- +Xmult when you have max hands remaining
SMODS.Joker({ key="n986", loc_txt={name="Cracked",text={"{X:mult,C:white}X2{} Mult when","you have {C:attention}4+ hands{} left","cracked out"}}, config={Xmult=2}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=5,y=8}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and (G.GAME.current_round.hands_left or 0)>=4 then
      return{Xmult=card.ability.Xmult,message="cracked"}
    end
  end })

-- n987: Nerf This -- +30 mult but self-nerf: -5 mult each round
SMODS.Joker({ key="n987", loc_txt={name="Nerf This",text={"Starts {C:mult}+30{} Mult","loses {C:mult}5{} each round","{C:mult}+#1#{} Mult now"}}, config={extra={mult=30}}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=6,y=8}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult=math.max(0,card.ability.extra.mult-5)
      return{message="nerfed again"}
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n988: Patch Notes -- effect changes each round (simulating game updates)
SMODS.Joker({ key="n988", loc_txt={name="Patch Notes",text={"Effect changes each round","v{C:attention}#1#{} - currently","reading patch notes..."}}, config={extra={ver=1}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=7,y=8}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.ver}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.ver=card.ability.extra.ver+1
      return{message="new patch!"}
    end
    if context.joker_main then
      local v=card.ability.extra.ver%4
      if v==0 then return{mult=20,message="buffed!"}
      elseif v==1 then return{chips=40,message="reworked!"}
      elseif v==2 then return{Xmult=2,message="nerfed!"}
      else return{message="hotfix..."} end
    end
  end })

-- n989: Internet Explorer -- always applies, but slowly (lower priority implied)
SMODS.Joker({ key="n989", loc_txt={name="Internet Explorer",text={"{C:chips}+50{} Chips","loading...","please wait"}}, config={chips=50}, rarity=1, cost=3, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=8}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{chips=card.ability.chips,message="loading..."} end
  end })

-- n990: FOMO -- +Xmult when you have the least jokers compared to max
SMODS.Joker({ key="n990", loc_txt={name="FOMO",text={"{X:mult,C:white}X2{} Mult if you","have {C:attention}3 or fewer{} jokers","fear of missing out"}}, config={Xmult=2}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=8}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main and #G.jokers.cards<=3 then
      return{Xmult=card.ability.Xmult,message="FOMO"}
    end
  end })

-- n991: Gacha Pull -- random small or huge reward
SMODS.Joker({ key="n991", loc_txt={name="Gacha Pull",text={"5% {X:mult,C:white}X10{}","15% {X:mult,C:white}X3{}","80% {C:mult}+5{} Mult"}}, config={}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=0,y=9}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.joker_main then
      local r=math.random()
      if r<0.05 then return{Xmult=10,message="SSR PULL!"}
      elseif r<0.20 then return{Xmult=3,message="rare!"}
      else return{mult=5,message="common..."} end
    end
  end })

-- n992: Cancel Culture -- destroys joker to the right and gains its mult
SMODS.Joker({ key="n992", loc_txt={name="Cancel Culture",text={"On score: cancels","joker to the {C:attention}right{}","+its Mult, then poof"}}, config={}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=false, pos={x=1,y=9}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.joker_main then
      local idx=nil
      for i,j in ipairs(G.jokers.cards) do if j==card then idx=i; break end end
      if idx and G.jokers.cards[idx+1] then
        local victim=G.jokers.cards[idx+1]
        if not victim.eternal then
          local m=victim.ability.mult or (victim.ability.extra and victim.ability.extra.mult) or 5
          victim:start_dissolve(nil,true)
          return{mult=m,message="cancelled!"}
        end
      end
      return{message="nothing to cancel"}
    end
  end })

-- n993: OK Boomer -- +mult that resets each round (temporary buff)
SMODS.Joker({ key="n993", loc_txt={name="OK Boomer",text={"{C:mult}+25{} Mult","resets each {C:attention}round","ok boomer"}}, config={extra={mult=25,base=25}}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=2,y=9}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.mult=card.ability.extra.base
      return{message="ok boomer"}
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message="ok boomer"}
    end
  end })

-- n994: Stonks Not Stonks -- alternates +chips and -chips each round
SMODS.Joker({ key="n994", loc_txt={name="Not Stonks",text={"Alternates {C:chips}+50{} Chips","and {C:attention}nothing{} each round","stonks / not stonks"}}, config={extra={on=true}}, rarity=2, cost=5, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=3,y=9}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.end_of_round and not context.individual and not context.repetition then
      card.ability.extra.on=not card.ability.extra.on
      return{message=card.ability.extra.on and "stonks" or "not stonks"}
    end
    if context.joker_main then
      if card.ability.extra.on then return{chips=50,message="stonks"}
      else return{message="not stonks"} end
    end
  end })

-- n995: Power Level -- Xmult equal to round divided by 3 (over 9000 eventually)
SMODS.Joker({ key="n995", loc_txt={name="Power Level",text={"{X:mult,C:white}X#1#{} Mult","equal to {C:attention}round / 3{}","it's over 9000!"}}, config={}, rarity=3, cost=8, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=4,y=9}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center)
    local x=math.max(1,math.floor((G.GAME.round or 1)/3))
    return{vars={x}}
  end,
  calculate=function(self,card,context)
    if context.joker_main then
      local x=math.max(1,math.floor((G.GAME.round or 1)/3))
      return{Xmult=x,message="OVER 9000!"}
    end
  end })

-- n996: Internet Points -- +1 mult per unique hand type played this run
SMODS.Joker({ key="n996", loc_txt={name="Internet Points",text={"{C:mult}+10{} Mult per","unique {C:attention}hand type{} played","{C:mult}+#1#{} Mult now"}}, config={extra={hands={},mult=0}}, rarity=2, cost=6, unlocked=true, discovered=true, blueprint_compat=false, eternal_compat=true, perishable_compat=true, pos={x=5,y=9}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.extra.mult}} end,
  calculate=function(self,card,context)
    if context.before then
      local h=G.GAME.current_round.current_hand.handname or "Unknown"
      if not card.ability.extra.hands[h] then
        card.ability.extra.hands[h]=true
        card.ability.extra.mult=card.ability.extra.mult+10
      end
    end
    if context.joker_main and card.ability.extra.mult>0 then
      return{mult=card.ability.extra.mult,message=localize{type='variable',key='a_mult',vars={card.ability.extra.mult}}}
    end
  end })

-- n997: LOL -- +chips equal to number of letters in hand name
SMODS.Joker({ key="n997", loc_txt={name="LOL",text={"{C:chips}+5{} Chips per letter","in the hand {C:attention}name{}","lmao"}}, config={chips=5}, rarity=1, cost=5, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=6,y=9}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.chips}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local h=G.GAME.current_round.current_hand.handname or "Pair"
      local n=#h*card.ability.chips
      return{chips=n,message="lmao"}
    end
  end })

-- n998: Clout Chaser -- +mult based on how many jokers you have bought total
SMODS.Joker({ key="n998", loc_txt={name="Clout Chaser",text={"{C:mult}+5{} Mult per","joker {C:attention}owned{}","clout is everything"}}, config={mult=5}, rarity=2, cost=7, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=7,y=9}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.mult}} end,
  calculate=function(self,card,context)
    if context.joker_main then
      local n=#G.jokers.cards*card.ability.mult
      return{mult=n,message="clout"}
    end
  end })

-- n999: OP as F -- just huge Xmult, completely broken
SMODS.Joker({ key="n999", loc_txt={name="OP as F",text={"{X:mult,C:white}X10{} Mult","completely broken","please nerf"}}, config={Xmult=10}, rarity=3, cost=15, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=8,y=9}, atlas="cm_atlas_10",
  loc_vars=function(self,info_queue,center) return{vars={center.ability.Xmult}} end,
  calculate=function(self,card,context)
    if context.joker_main then return{Xmult=card.ability.Xmult,message="OP as F"} end
  end })

-- n1000: We Are All Going to Make It -- +chips and +mult, maximum hopium
SMODS.Joker({ key="n1000", loc_txt={name="WAGMI",text={"{C:chips}+30{} Chips and","{C:mult}+30{} Mult","we are all gonna make it"}}, config={}, rarity=3, cost=9, unlocked=true, discovered=true, blueprint_compat=true, eternal_compat=true, perishable_compat=true, pos={x=9,y=9}, atlas="cm_atlas_10",
  calculate=function(self,card,context)
    if context.joker_main then
      return{chips=30,mult=30,message="WAGMI"}
    end
  end })
