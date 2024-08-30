--- STEAMODDED HEADER
--- MOD_NAME: MiniLitch
--- MOD_ID: minilitch
--- MOD_AUTHOR: [MiniRebel, modlitch]
--- MOD_DESCRIPTION: this a mod based on modlitch's joker idea's
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]

----------------------------------------------
------------MOD CODE -------------------------
--thanks modlitch for the amazing joker art and idea's! <3
--and my self for the functionality :D


SMODS.Atlas {
    key = 'jokies',
    path = 'jokies.png',
    px = 71,
    py = 95
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
            xmult_min = 0,  -- Minimum value for xmult
            xmult_max = 15, -- Maximum value for xmult
            odds = 10
        }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    rarity = 3,
    atlas = 'jokies',
    pos = { x = 1, y = 2 },
    cost = 6,
    calculate = function(self, card, context)
        if context.joker_main then
            local xmult_min = card.ability.extra.xmult_min
            local xmult_max = card.ability.extra.xmult_max
            card.ability.extra.xmult = math.random(xmult_min, xmult_max)

            return {
                mult_mod = card.ability.extra.xmult,
                message = localize {
                    type = 'variable',
                    key = 'a_xmult',
                    vars = { card.ability.extra.xmult }
                }
            }
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
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.hand_size } }
    end,
    calculate = function(self, card, context)
      if context.setting_blind and not card.getting_sliced then
        card.ability.extra.hand_size = math.random(-3, 10)
        G.hand:change_size(card.ability.extra.hand_size) 
      end
      if context.end_of_round then
        card.ability.extra.hand_size = 0
        G.hand:change_size(-card.ability.extra.hand_size)
      end
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
    config = { extra = { mult = 100 } },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.mult } }
    end,
    rarity = 3,
    atlas = 'jokies',
    pos = { x = 3, y = 1 },
    cost = 6,
    calculate = function(self, card, context)
      if context.joker_main then
       return {
          mult_mod = card.ability.extra.mult,
           message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
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
        "gifes {C:chips}+#1#{} ships and",
        "{C:mult}+#2#{} Mult when skored"
      }
    },
    config = { extra = { chips = 19, mult = 3 } },
    rarity = 1,
    atlas = 'jokies',
    pos = { x = 6, y = 3 },
    cost = 4,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
        if context.other_card:get_id() == 2 then
          return {
            chips = card.ability.extra.chips,
            mult = card.ability.extra.mult,
            card = context.other_card
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
        "gives {C:chips}+#1#{} chips and",
        "{C:mult}+#2#{} Mult when scored"
      }
    },
    config = { extra = { mult = 4, chips = 20 } },
    rarity = 1,
    atlas = 'jokies',
    pos = { x = 4, y = 4 },
    cost = 4,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
        if context.other_card:get_id() == 6 or context.other_card:get_id() == 9 then
          return {
            chips = card.ability.extra.chips,
            mult = card.ability.extra.mult,
            card = context.other_card
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
      loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
      end,
      calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
          if context.other_card:is_face() then
            return {
              chips = card.ability.extra.chips,
              mult = card.ability.extra.mult,
              card = context.other_card
            }
          end
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
      calculate = function(self, card, context)
        if context.setting_blind and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
                      card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.PURPLE})                       
                  return true
              end)}))
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
      calculate = function(self, card, context)
        if context.setting_blind and not (context.blueprint_card or self).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
                      card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.PURPLE})                       
                  return true
              end)}))
            end
       end
    }

----------------------------------------------
------------MOD CODE END----------------------