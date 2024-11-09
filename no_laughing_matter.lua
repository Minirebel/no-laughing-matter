--- STEAMODDED HEADER
--- MOD_NAME: no laughing matter
--- MOD_ID: no_laughing_matter
--- MOD_AUTHOR: [MiniRebel, Modlich_303]
--- MOD_DESCRIPTION: this a mod based on Modlich_303's joker idea's
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]
--- PREFIX: mini
----------------------------------------------
------------MOD CODE -------------------------
-- thanks Modlich_303 for the amazing joker art and idea's! <3
-- [insert moditch's message]
-- and my self for the functionality :D
-- sorry for the code in advance! - mini
--possible use: G.last_tarrot
--G.GAME.probabilities[k] = v/2


--mod tag icon
SMODS.Atlas {
  key = "modicon",
  path = "NLM.png",
  px = 32,
  py = 32,
}

--meme
SMODS.Atlas {
  key = "side",
  path = "sideways.png",
  px = 95,
  py = 71,
}

------------------
---common
------------------


SMODS.Joker {
  key = 'squished',
  loc_txt = {
    name = 'Squished joker',
    text = {
      "{C:mult}+#1# {}Mult"
    }
  },
  config = { extra = { mult = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  rarity = 1,
  atlas = 'side',
  pos = { x = 0, y = 0 },
  cost = 2,
  blueprint_compat = true,
  calculate = function(self, card, context)
  if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
          }
    end
  end
}

--for real
SMODS.Atlas {
  key = 'jokies',
  path = 'NLM_jokies.png',
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'dunce',
  loc_txt = {
    name = 'Dunce',
    text = {
      "Each plajed {C:attention}2{}",
      "gifes {C:chips}+#2#{} ships and",
      "{C:mult}+#1#{} Mult when skored"
    }
  },
  config = { extra = { mult = 3, chips = 19 } },
  rarity = 1,
  atlas = 'jokies',
  pos = { x = 6, y = 3 },
  cost = 4,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card:get_id() == 2 then
          return {
              chips = card.ability.extra.chips,
              mult = card.ability.extra.mult,
              card = card
          }
        end
      end
    end
}

SMODS.Joker {
  key = 'clown',
  loc_txt = {
    name = 'Class Clown',
    text = {
      "Each played {C:attention}6 {}&{C:attention} 9{}",
      "gives {C:mult}+4{} mult and",
      "{C:chips}+20{} chips when scored"
    }
  },
  config = { extra = { mult = 4, chips = 20 } },
  rarity = 1,
  atlas = 'jokies',
  pos = { x = 4, y = 4 },
  cost = 4,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card:get_id() == 6 or context.other_card:get_id() == 9 then
          return {
              chips = card.ability.extra.chips,
              mult = card.ability.extra.mult,
              card = card
          }
        end
    end
  end
}

SMODS.Joker {
  key = 'Scopo',
  loc_txt = {
    name = 'Scopophobia',
    text = {
      "Each played {C:attention}face card{}",
      "gives {C:chips}+#1#{} chips and",
      "{C:mult}+#2#{} Mult when scored"
    }
  },
  config = { extra = { mult = 3, chips = 15 } },
  rarity = 1,
  atlas = 'jokies',
  pos = { x = 4, y = 2 },
  cost = 4,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card:is_face() then
          return {
              chips = card.ability.extra.chips,
              mult = card.ability.extra.mult,
              card = card
          }
      end
      end
    end

}
  
SMODS.Joker {
  key = 'jumping',
  loc_txt = {
    name = 'jumping jacks',
    text = {
      "gain {C:chips}+#2#{} chips",
      "when {C:money}jack{} is played",
      "lose {C:chips}-#3#{} chips",
      "when any {C:money}non-jack{} is played",
      "{C:inactive}currently: {C:chips}#1#{}{}"
    }
  },
  config = { extra = {chips = 0, chip_gain = 10, chip_lose = 5}},
  rarity = 1,
  atlas = 'jokies',
  pos = { x = 0, y = 6 },
  soul_pos = { x = 1, y = 6},
  cost = 2,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain, card.ability.extra.chip_lose} }
  end,
 
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
        card = self
      }
    end
    if context.individual and context.cardarea == G.play and not context.blueprint then
      if context.other_card:get_id() == 11 then
      card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
      return {
        message = 'Upgraded!',
        colour = G.C.CHIPS,
        card = self
      }
    end
    if context.individual and context.cardarea == G.play and not context.blueprint then
        if context.other_card:get_id() ~= 11 then
          card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_lose
          if card.ability.extra.chips <= 0 then
            card.ability.extra.chips = 0
        end
        return {
          message = 'Degraded!',
          colour = G.C.CHIPS,
          card = self
        }
      end
    end
  end
  end
}

------------------
---uncommon
------------------

SMODS.Joker {
  key = 'faceblind',
  loc_txt = {
    name = 'face blind',
    text = {
      "all cards",
      "are considered",
      "{C:money}numbered{} cards"
    }
  },
  config = { extra = { }},
  rarity = 2,
  atlas = 'jokies',
  pos = { x = 4, y = 0 },
  cost = 5,
  blueprint_compat = false,
}

local is_faceRef = Card.is_face
function Card:is_face(from_boss)
  if SMODS.find_card('j_mini_faceblind')[1] then
  --if self.debuff and not from_boss then return end
  local id = self:get_id()
    if id == 11 or id == 12 or id == 13 then
       return false
    end
  end
  return is_faceRef(self, from_boss)
end

--fix dementia

SMODS.Joker {
    key = 'biden',
    loc_txt = {
      name = 'Dementia',
      text = {
        "{C:money}+{}/{C:money}-{} handsize",
        "#1#"
      }
    },
    config = { extra = { hand_size = 0 } },
    rarity = 2,
    atlas = 'jokies',
    pos = { x = 6, y = 1 },
    cost = 5,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.hand_size } }
    end,
    calculate = function(self, card, context)

      if context.setting_blind and not context.blueprint and not context.getting_sliced then
        card.ability.extra.hand_size = math.random(-3, 6)
        G.hand:change_size(card.ability.extra.hand_size)
        card.ability.extra.hand_size = 0
      end
  end,
  remove_from_deck = function(self, card, from_debuff)
      G.hand:change_size(card.ability.extra.hand_size)
  end,
}

SMODS.Joker {
    key = 'circus',
    loc_txt = {
      name = 'Ciscus',
      text = {
       "{C:mult}+#1# {}Mult"
      }
    },
    bp_compat = true,
    config = { extra = { mult = 100 } },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.mult } }
    end,
    rarity = 2,
    atlas = 'jokies',
    pos = { x = 3, y = 1 },
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
      if context.joker_main then
       return {
          mult_mod = card.ability.extra.mult,
          message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
          card = card
        }
    end
  end
}

SMODS.Joker {
  key = 'astrology',
  loc_txt = {
    name = 'Astrology',
    text = {
      'Create a {C:chips}planet{} card',
      'when {C:money}bind{} is selected',
      '{C:inactive}[must have room]{}',
    }
  },
  rarity = 2,
  atlas = 'jokies',
  pos = { x = 2, y = 0 },
  cost = 5,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not card.getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
          func = (function()
              G.E_MANAGER:add_event(Event({
                  func = function() 
                      local card = create_card('Planet',G.consumeables, nil, nil, nil, nil, nil, 'car')
                      card:add_to_deck()
                      G.consumeables:emplace(card)
                      G.GAME.consumeable_buffer = 0
                      return true
                  end}))   
                  card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.PURPLE})                       
              return true
          end)}))
          return {
            card = card
          }
        end
   end
}
    
SMODS.Joker {
  key = 'earner',
  loc_txt = {
    name = 'Big Earner',
    text = {
      "Earn {C:money}$#1#{} at",
      "end of round"
    }
  },
  config = { extra = { money = 10 } },
  rarity = 2,
  atlas = 'jokies',
  pos = { x = 0, y = 3 },
  cost = 5,
  blueprint_compat = false,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  calc_dollar_bonus = function(self, card)
    local bonus = card.ability.extra.money
    if bonus > 0 then return bonus end
  end
}
     
SMODS.Joker {
  key = 'spam',
  loc_txt = {
    name = 'Big Shot',
    text = {
      "Earn {C:money}$random{} at",
      "end of round"
    }
  },
  config = { extra = { 
    money_min = 1,
    money_max = 10,
    odds = 10
} },
  rarity = 2,
  atlas = 'jokies',
  pos = { x = 6, y = 4 },
  soul_pos = { x = 6, y = 5 },
  cost = 5,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  calc_dollar_bonus = function(self, card)
    local money_min = card.ability.extra.money_min
    local money_max = card.ability.extra.money_max
    card.ability.extra.money = math.random(money_min, money_max)
    
    local bonus = card.ability.extra.money
    if bonus > 0 then return bonus end
end
}   

SMODS.Joker {
  key = 'scout',
  loc_txt = {
    name = 'Scout',
    text = {
      "gives a {C:money}double tag{}",
      "when blind is skipped",
      "[gives after the skip tag is given]"
    }
  },
  rarity = 2,
  atlas = 'jokies',
  pos = { x = 5, y = 5 },
  cost = 4,
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.skip_blind and not context.blueprint then
           G.E_MANAGER:add_event(Event({func = (function()
          add_tag(Tag('tag_double'))
          play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
          return true
        end)}))
        return{
          card:juice_up(),
        }
      end
    end
}

---------------
---rare
---------------

SMODS.Joker {
  key = 'lobo',
  loc_txt = {
      name = 'Lobotomy',
      text = {
          "{X:mult} Xrandom {} mult"
      }
  },
  config = {
      extra = {
          Xmult_min = 0,  -- Minimum value for xmult
          Xmult_max = 15, -- Maximum value for xmult
          odds = 10
      }
  },
  loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult } }
  end,
  rarity = 3,
  atlas = 'jokies',
  pos = { x = 1, y = 2 },
  cost = 6,
  blueprint_compat = true,
  calculate = function(self, card, context) 
      if context.joker_main then
          local Xmult_min = card.ability.extra.Xmult_min
          local Xmult_max = card.ability.extra.Xmult_max
          card.ability.extra.Xmult = math.random(Xmult_min, Xmult_max)

          return {
              Xmult_mod = card.ability.extra.Xmult,
              message = localize {
                  type = 'variable',
                  key = 'a_xmult',
                  vars = { card.ability.extra.Xmult },
                  card:juice_up()
              }
          }
      end
  end
}     

SMODS.Joker {
  key = 'dream',
  loc_txt = {
    name = 'Dream',
    text = {
    'create a {C:spectral}spectral{} card',
    'when {C:money}bind{} is selected',
    '{C:inactive}[must have room]{}'
    }
  },
  rarity = 3,
  atlas = 'jokies',
  pos = { x = 5, y = 3 },
  cost = 6,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not card.getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
          func = (function()
              G.E_MANAGER:add_event(Event({
                  func = function() 
                      local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'car')
                      card:add_to_deck()
                      G.consumeables:emplace(card)
                      G.GAME.consumeable_buffer = 0
                      return true
                  end}))   
                  card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.PURPLE})                       
              return true
          end)}))
          return {
          card:juice_up(),
          message = 'zzzzz!',
          colour = G.C.GREY,
          }
        end
   end
}

-- here to fix the flush joker because i hate seeing smeared effect disrespected
--                      - SpaD_Overolls
SMODS.Joker {
  key = 'chrome',
  loc_txt = {
    name = 'Monochrome',
    text = {
    'All cards are',
    '{C:attention}one suit{}',
    }
  },
  rarity = 3,
  atlas = 'jokies',
  pos = { x = 2, y = 2 },
  cost = 6,
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.setting_blind then
      return{
        message = 'go wild!',
        colour = G.C.GREY,
        card:juice_up()
      }
    end
  end
      --no code ainst blueprint cuz if all suit is the same then blueprint won't change anything
}

local is_suitRef = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if SMODS.find_card('j_mini_chrome')[1] and (bypass_debuff or not self.debuff) then
       return true
    end
    return is_suitRef(self, suit, bypass_debuff, flush_calc)
end
--thanks SpaD_Overolls
--   -minirebel

--thanks Xxjimbolover420xX <3
SMODS.Joker {
  key = 'silly',
  loc_txt = {
    name = 'the silly',
    text = {
      "when on last discard",
      "a random played card",
      "gets destroyed and",
      "gain {X:mult}X0.1{}",
      "{C:inactive}(Currently {X:mult}X#1#{C:inactive} XMult)"
    }
  },
  config = { extra = { Xmult = 1, Xmult_gain = 0.1 } },
  rarity = 3,
  atlas = 'jokies',
  pos = { x = 5, y = 2 },
  cost = 5,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain } }
  end,
  calculate = function(self, card, context)
      if context.cardarea == G.jokers and context.before and G.GAME.current_round.discards_left == 3 then --and #context.full_hand == 2 then
        pseudorandom_element(context.full_hand,pseudoseed('random_destroyIDFK')):start_dissolve()
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
        return {
          card:juice_up(),
          message = 'Upgraded!',
          colour = G.C.RED,
        }
    end
    if context.joker_main then
      return {
        card:juice_up(),
        Xmult_mod = card.ability.extra.Xmult,
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
      }
  end
end
}

SMODS.Joker {
  key = 'stone_counting',
  loc_txt = {
    name = 'stone skipping',
    text = {
      "{C:money}stone cards{} retrigger as",
      "as many times as the {C:money}amount of{}",
      "{C:money}stone cards{} in played hand"
    }
  },
  config = { extra = {repetitions = 1, stone_count = 0}},
  rarity = 3,
  atlas = 'jokies',
  pos = { x = 4, y = 5 },
  cost = 4,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.repetitions, card.ability.extra.stone_count } }
  end,
  calculate = function(self, card, context)
    --thanks larswijn! <3
      if context.before then
          card.ability.extra.stone_count = 0
          for i = 1, #context.scoring_hand do
              if context.scoring_hand[i].ability.name == "Stone Card" then
                  card.ability.extra.stone_count = card.ability.extra.stone_count + 1
              end
          end
      end
      if context.cardarea == G.play and context.repetition and context.other_card.ability.name == "Stone Card" then
          return {
            message = 'Again!',
            repetitions = card.ability.extra.repetitions*card.ability.extra.stone_count,
            card = context.other_card
          }
      end
      if context.after then
        card.ability.extra.count = 0
      end
  end
}

--future joker!!! still needs name & art
--[[
SMODS.Joker {
  key = 'triggered',
  loc_txt = {
    name = 'triggered',
    text = {
      "face cards give retriggers",
      "{C:inactive}like 3, gives 3 triggers{}",
      "{C:inactive}like 4, gives 4 triggers{}"
    }
  },
  config = { extra = {repetitions = 1, count = 0}},
  rarity = 3,
  atlas = 'jokies',
  pos = { x = 0, y = 0 },
  cost = 5,
  blueprint_compat = false,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.repetitions, card.ability.extra.count } }
  end,
  calculate = function(self, card, context)
    --if context.before then
    --counting
  if context.other_card:is_face() then
    if context.individual and context.cardarea == G.play then
      card.ability.extra.count = card.ability.extra.stone + 1
    end
  --end
  --retriggers? hopefully
    if context.cardarea == G.play and context.repetition then
      return {
        message = 'Again!',
        repetitions = card.ability.extra.repetitions*card.ability.extra.count,
        card = context.other_card
      }
    end
  end
    if context.after then
      card.ability.extra.count = 0
    end
end
}
--]]

SMODS.Joker {
  key = 'geode',
  loc_txt = {
    name = 'crystal geode',
    text = {
      "played {C:money}stone cards{} give",
      "{C:mult}+#1#{} mult when scored"
    }
  },
  config = { extra = {mult = 5}},
  rarity = 3,
  atlas = 'jokies',
  pos = { x = 1, y = 5 },
  cost = 5,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { mult = 5 } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.ability.name == "Stone Card" then
          return {
              chips = card.ability.extra.mult,
              card = card
          }
        end
    end
  end
}


--legendary needs 2x Xchips!
SMODS.Joker {
  key = 'coulro',
  loc_txt = {
    name = 'coulrophobia',
    text = {
      "depending on the rarity",
      "gain {C:chips}+#1#{}/{C:chips}+#2#{}/{C:chips}+#3#{}/{C:chips}+#4#{}",
      "chips per joker"
    }
  },
  config = { extra = { chip1 = 15, chip2 = 50, chip3 = 150, chip4 = 500 }},
  rarity = 3,
  atlas = 'jokies',
  pos = { x = 5, y = 4 },
  cost = 5,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chip1, card.ability.extra.chip2, card.ability.extra.chip3, card.ability.extra.chip4 } }
  end,
  calculate = function(self, card, context)
  if context.other_joker then
    --common
    if context.other_joker.config.center.rarity == 1 and card ~= context.other_joker then
      G.E_MANAGER:add_event(Event({
          func = function()
              context.other_joker:juice_up(0.5, 0.5)
              return true
          end
      })) 
      return {
          message = localize{type='variable',key='a_chips',vars={card.ability.extra.chip1}},
          chip_mod = card.ability.extra.chip1
      }
  end
--uncommon
  if context.other_joker.config.center.rarity == 2 and card ~= context.other_joker then
    G.E_MANAGER:add_event(Event({
      func = function()
          context.other_joker:juice_up(0.5, 0.5)
          return true
      end
    })) 
  return {
      message = localize{type='variable',key='a_chips',vars={card.ability.extra.chip2}},
      chip_mod = card.ability.extra.chip2
  }
  end
--rare
  if context.other_joker.config.center.rarity == 3 and card ~= context.other_joker then
    G.E_MANAGER:add_event(Event({
      func = function()
          context.other_joker:juice_up(0.5, 0.5)
          return true
      end
  })) 
  return {
      message = localize{type='variable',key='a_chips',vars={card.ability.extra.chip3}},
      chip_mod = card.ability.extra.chip3
  }
  end
--legendary
  if context.other_joker.config.center.rarity == 4 and card ~= context.other_joker then
    G.E_MANAGER:add_event(Event({
        func = function()
            context.other_joker:juice_up(0.5, 0.5)
            return true
        end
    })) 
    return {
      message = localize{type='variable',key='a_chips',vars={card.ability.extra.chip4}},
      chip_mod = card.ability.extra.chip4
  }
  end
end
end
}

------------------
---legendary
-----------------

SMODS.Joker {
  key = 'neo',
  loc_txt = {
    name = 'Power of NEO',
    text = {
      "earn {X:money}X2{} after",
      "defeating a blind"
    }
  },
  config = { extra = { } },
  rarity = 4,
  atlas = 'jokies',
  pos = { x = 2, y = 6 },
  soul_pos = { x = 3, y = 6 },
  cost = 5,
  blueprint_compat = false,
  calculate = function(self, card, context)
    if G.GAME.round_resets.blind_states == 'Defeated' and not context.blueprint then
local mod = math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0)) * (1))
        ease_dollars(mod)
  return {
    card:juice_up(),
    message = 'big shot!',
    colour = G.C.MULT,
  }
end
end
}

--next joker i want to be done (make stone still have suit and rank)
--[[
SMODS.Joker {
  key = 'carved',
  loc_txt = {
    name = 'carved',
    text = {

    }
  },
  config = { extra = { }},
  rarity = 3,
  atlas = 'jokies',
  pos = { x = 4, y = 5 },
  cost = 5,
  blueprint_compat = false,
}


if SMODS.find_card('j_mini_carved')[1] then

SMODS.Enhancement:take_ownership('m_stone', {
  no_suit = false,
  no_rank = false,
})

end
--]]


--need to be work with modlitch

--================
--   challenges
--================
--[[
SMODS.Challenge{
  name = "Multiplier",
  key =  'C_multiplier',
  rules = {
    custom = {
    },
      modifiers = {
      }
  },
  jokers = {
      
  },
  consumeables = {
  },
  vouchers = {
  },
  deck = {
      type = 'Challenge Deck'
  },
  restrictions = {
      banned_cards = {
        {id = 'j_sly'},
        {id = 'j_willy'},
        {id = 'j_celver'},
        {id = 'j_devious'},
        {id = 'j_crafty'},
        {id = 'j_banner'},
        {id = 'j_scary_face'},
        {id = 'j_odd_todd'},
        {id = 'j_scholar'},
        {id = 'j_runner'},
        {id = 'j_ice_cream'},
        {id = 'j_hiker'},
        {id = 'j_square'},
        {id = 'j_stone'},
        {id = 'j_bull'},
        {id = 'j_walkie_talkie'},
        {id = 'j_castle'},
        {id = 'j_wee'},
        {id = 'j_stuntman'},
        --SMODS.find_card('')
        
      },
      banned_tags = {
      },
      banned_other = {
        --{id = 'e_foil'}
      }
  },
}


SMODS.Challenge{
  name = "no tarrot",
  key = 'C_anti-tarrot',
  id = 'C_anti-tarrot',
  rules = {
      custom = {
      },
      modifiers = {
        id = 'joker_slots',
        value = 0
      }
  },
  jokers = {
      {id = 'j_mini_lobo', eternal = true},
  },
  consumeables = {
  },
  vouchers = {
  },
  deck = {
      type = 'Challenge Deck'
  },
  restrictions = {
      banned_cards = {
      },
      banned_tags = {
      },
      banned_other = {
      }
  }
}

SMODS.Challenge{
  name = "one big family",
  key = 'C_family',
  id = 'C_family',
  rules = {
      custom = {
      },
      modifiers = {
      }
  },
  jokers = {
      {id = 'j_mini_chrome', eternal = true},
  },
  consumeables = {
  },
  vouchers = {
  },
  deck = {
      type = 'Challenge Deck'
  },
  restrictions = {
      banned_cards = {
      },
      banned_tags = {
      },
      banned_other = {
      }
  }
}

SMODS.Challenge{
  name = "go to a doctor!",
  key = 'C_doctor',
  id = 'C_doctor',
  rules = {
      custom = {
      },
      modifiers = {
      }
  },
  jokers = {
      {id = 'j_mini_lobo', eternal = true},
  },
  consumeables = {
  },
  vouchers = {
  },
  deck = {
      type = 'Challenge Deck'
  },
  restrictions = {
      banned_cards = {
      },
      banned_tags = {
      },
      banned_other = {
      }
  }
}

SMODS.Challenge{
  name = "where am I?",
  --idk witch one works
  key = 'C_biden',
  id = 'C_biden',
  rules = {
      custom = {
      },
      modifiers = {
      }
  },
  jokers = {
      {id = 'j_mini_biden', edition = 'negative', eternal = true},
      {id = 'j_mini_biden', edition = 'negative', eternal = true},
      {id = 'j_mini_biden', edition = 'negative', eternal = true},
      {id = 'j_mini_biden', edition = 'negative', eternal = true},
      {id = 'j_mini_biden', edition = 'negative', eternal = true}
    },
  consumeables = {
  },
  vouchers = {
  },
  deck = {
      type = 'Challenge Deck'
  },
  restrictions = {
      banned_cards = {
      },
      banned_tags = {
      },
      banned_other = {
      }
  }
}
--]]



----------------------------------------------
------------MOD CODE END----------------------