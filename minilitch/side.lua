--- STEAMODDED HEADER
--- MOD_NAME: side
--- MOD_ID: side
--- MOD_AUTHOR: [someone23832]
--- MOD_DESCRIPTION: sideways joker
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]
--- BADGE_COLOR: c7638f
----------------------------------------------
------------MOD CODE -------------------------


SMODS.Atlas {
  key = "side",
  path = "sideways.png",
  px = 95,
  py = 71,
}


SMODS.Joker {
  key = 'side',
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
calculate = function(self, card, context)
if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
        }
    end
  end
}



----------------------------------------------
------------MOD CODE END----------------------
