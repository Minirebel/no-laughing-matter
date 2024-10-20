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
--no calculation so no shake i think
SMODS.Atlas {
  key = 'jokies',
  path = 'jokies.png',
  px = 71,
  py = 95
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
  rarity = 1,
  atlas = 'jokies',
  pos = { x = 5, y = 5 },
  cost = 4,
  blueprint_compat = true,
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
      "gives {C:mult}+#1#{} mult and",
      "{C:chips}+#2#{} chips when scored"
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
    key = 'biden',
    loc_txt = {
      name = 'Dementia',
      text = {
        "{C:money}+{}/{C:money}-{} handsize"
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
      if context.end_of_round or context.selling_car or card.getting_sliced then
        card.ability.extra.hand_size = 0
        G.hand:change_size(card.ability.extra.hand_size)
      
      if context.setting_blind and not card.getting_sliced and not context.blueprint then
        card.ability.extra.hand_size = math.random(-3, 10)
        G.hand:change_size(card.ability.extra.hand_size) 
        return{
          card = card
        }
      end
  end
end
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
          '{C:aint working yet}[must have room]{}',
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
      config = { extra = { money = 15 } },
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
        '{C:aint working yet}[must have room]{}'
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


--thanks Xxjimbolover420xX <3
SMODS.Joker {
  key = 'silly',
  loc_txt = {
    name = 'the silly',
    text = {
      "when on last hand",
      "a random played card",
      "gets destroyed and",
      "gain {X:mult}X0.1{}",
      "{C:inactive}(Currently {C:mult}X#1#{C:inactive} XMult)"
    }
  },
  config = { extra = { Xmult = 1, Xmult_gain = 0.1 } },
  rarity = 3,
  atlas = 'jokies',
  pos = { x = 5, y = 2 },
  cost = 5,
  blueprint_compat = false,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain } }
  end,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers and G.GAME.current_round.hands_left == 0 and not context.blueprint then
        pseudorandom_element(context.full_hand, pseudoseed('random_destroyIDFK')):start_dissolve()
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
        return {
          card:juice_up(),
          message = 'Upgraded!',
          colour = G.C.RED,
        }
    end
    if context.joker_main and not context.blueprint then
        return {
          card:juice_up(),
          Xmult_mod = card.ability.extra.Xmult,
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
        }
    end
end,
}
----------------------------------------------
------------MOD CODE END----------------------
