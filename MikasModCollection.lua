--- STEAMODDED HEADER
--- MOD_NAME: Mika's Mod Collection
--- MOD_ID: MikasMods
--- PREFIX: mika
--- MOD_AUTHOR: [Mikadoe, elbe]
--- MOD_DESCRIPTION: A collection of Mika's Mods. Check the mod description on GitHub for more information :)
--- DISPLAY_NAME: Mika's Mod
--- BADGE_COLOUR: FD5DA8
----------------------------------------------
------------MOD CODE -------------------------

-- TODO: Fishing License, Harp Seal, Buy One Get One -- increase mod compat

function SMODS.poll_enhancement(args)
    args = args or {}
    local key = args.key or 'stdenhance'
    local mod = args.mod or 1
    local guaranteed = args.guaranteed or false
    local options = args.options or get_current_pool("Enhanced")
    local type_key = args.type_key or key.."type"..G.GAME.round_resets.ante
    key = key..G.GAME.round_resets.ante

    local available_enhancements = {}
    local total_weight = 0
    for _, v in ipairs(options) do
        if v ~= "UNAVAILABLE" then
            local enhanced_option = {}
            if type(v) == 'string' then
                assert(G.P_CENTERS[v])
                enhanced_option = { name = v, weight = G.P_CENTERS[v].weight or 5 } -- default weight set to 5 to replicate base game weighting
            elseif type(v) == 'table' then
                assert(G.P_CENTERS[v.name])
                enhanced_option = { name = v.name, weight = v.weight }
            end
            if enhanced_option.weight > 0 then
                table.insert(available_enhancements, enhanced_option)
                total_weight = total_weight + enhanced_option.weight
            end
        end
	end
    total_weight = total_weight + (total_weight / 2 * 98) -- set base rate to 2%

    local type_weight = 0 -- modified weight total
    for _,v in ipairs(available_enhancements) do
        v.weight = G.P_CENTERS[v.name].get_weight and G.P_CENTERS[v.name]:get_weight() or v.weight
        type_weight = type_weight + v.weight
    end

    local enhanced_poll = pseudorandom(pseudoseed(key or 'stdenhance'..G.GAME.round_resets.ante))
    if enhanced_poll > 1 - (type_weight*mod / total_weight) or guaranteed then -- is an enhancement generated
        local enhanced_type_poll = pseudorandom(pseudoseed(type_key)) -- which enhancement is generated
        local weight_i = 0
        for _, v in ipairs(available_enhancements) do
            weight_i = weight_i + v.weight
            if enhanced_type_poll > 1 - (weight_i / type_weight) then
                return v.name
            end
        end
    end
end

local dagonet_blacklist = {
    "Credit Card",
    "Juggler",
    "Turtle Bean",
    "Drunkard",
    "Troubadour",
    "Merry Andy"
}

local cicero_blacklist = {
    ["Misprint"] = true,
}

local cicero_whitelist = {
    ["Mr. Bones"] = true,
    ["printer"] = true,
}

-- Save attributes
local attributes = {
    mult = {
        key = "mult_dagonet",
        prev_key = "prev_mult_dagonet",
        min = 0
    },
    mult_mod = {
        key = "mult_mod_dagonet",
        prev_key = "prev_mult_mod_dagonet",
        min = 0
    },
    chips = {
        key = "chips_dagonet",
        prev_key = "prev_chips_dagonet",
        min = 0
    },
    chip_mod = {
        key = "chip_mod_dagonet",
        prev_key = "prev_chips_mod_dagonet",
        min = 0
    },
    Xmult = {
        key = "Xmult_dagonet",
        prev_key = "prev_Xmult_dagonet",
        min = 1
    },
    Xmult_mod = {
        key = "Xmult_mod_dagonet",
        prev_key = "prev_Xmult_mod_dagonet",
        min = 0
    },
    x_mult = {
        key = "x_mult_dagonet",
        prev_key = "prev_x_mult_dagonet",
        min = 1
    },
    t_mult = {
        key = "t_mult_dagonet",
        prev_key = "prev_t_mult_dagonet",
        min = 0
    },
    t_chips = {
        key = "t_chips_dagonet",
        prev_key = "prev_t_chips_dagonet",
        min = 0
    },
    s_mult = {
        key = "s_mult_dagonet",
        prev_key = "prev_s_mult_dagonet",
        min = 0
    },
    dollars = {
        key = "dollars_dagonet",
        prev_key = "prev_dollars_dagonet",
        min = 0
    },
    hand_add = {
        key = "hand_add_dagonet",
        prev_key = "prev_hand_add_dagonet",
        min = 0
    },
    discard_sub = {
        key = "discard_sub_dagonet",
        prev_key = "prev_discard_sub_dagonet",
        min = 0
    },
    odds = {
        key = "odds_dagonet",
        prev_key = "prev_odds_dagonet",
        min = 0
    },
    faces = {
        key = "faces_dagonet",
        prev_key = "prev_faces_dagonet",
        min = 0
    },
    max = {
        key = "max_dagonet",
        prev_key = "prev_max_dagonet",
        min = 0
    },
    min = {
        key = "min_dagonet",
        prev_key = "prev_min_dagonet",
        min = 0
    },
    every = {
        key = "every_dagonet",
        prev_key = "prev_every_dagonet",
        min = 0
    },
    increase = {
        key = "increase_dagonet",
        prev_key = "prev_increase_dagonet",
        min = 0
    },
    d_size = {
        key = "d_size_dagonet",
        prev_key = "prev_d_size_dagonet",
        min = 0
    },
    h_mod = {
        key = "h_mod_dagonet",
        prev_key = "prev_h_mod_dagonet",
        min = 0
    },
    h_plays = {
        key = "h_plays_dagonet",
        prev_key = "prev_h_plays_dagonet",
        min = 0
    },
    discards = {
        key = "discards_dagonet",
        prev_key = "prev_discards_dagonet",
        min = 0
    },
    req = {
        key = "req_dagonet",
        prev_key = "prev_req_dagonet",
        min = 0
    },
    percentage = {
        key = "percentage_dagonet",
        prev_key = "prev_percentage_dagonet",
        min = 0
    },
    base = {
        key = "base_dagonet",
        prev_key = "prev_base_dagonet",
        min = 0
    },
    extra = {
        key = "extra_dagonet",
        prev_key = "prev_extra_dagonet",
        min = 0
    }
}

-- Increase base attributes
local function increase_attributes(k, v, place, multiplier)
    local attr = attributes[k]

    if not attr or type(v) == "string" then
        return
    end

    -- Handle extra seperately
    if type(v) == "table" then
        for k2, v2 in pairs(place.extra) do
            increase_attributes(k2, v2, place.extra, multiplier)
        end
    elseif v > attr.min then
        if place[attr.prev_key] == nil then
            place[attr.prev_key] = multiplier
        end
        if place[attr.key] == nil then
            -- Save base value
            place[attr.key] = v
        else
            if not (v / multiplier == place[attr.key] and place[attr.prev_key] == multiplier) then
                if not (v / multiplier == place[attr.key] or v / place[attr.prev_key] == place[attr.key]) then
                    if v / multiplier ~= place[attr.key] and place[attr.prev_key] == multiplier then
                        -- Update base based on current multiplier
                        local increase = (v / multiplier - place[attr.key]) * multiplier
                        place[attr.key] = place[attr.key] + increase
                    else
                        -- Update base based on previous multiplier
                        local increase = (v / place[attr.prev_key] - place[attr.key]) * place[attr.prev_key]
                        place[attr.key] = place[attr.key] + increase
                    end
                end
            end
        end
        -- Multiply attribute
        place[k] = place[attr.key] * multiplier
        place[attr.prev_key] = multiplier
    end
end

local function create_tarot(joker, seed)
    -- Check consumeable space
    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        -- Add card
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
            trigger = "before",
            delay = 0.0,
            func = (function()
                local card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, nil, seed)
                card:add_to_deck()
                G.consumeables:emplace(card)
                G.GAME.consumeable_buffer = 0
                return true
            end)
        }))
        -- Show message
        card_eval_status_text(joker, "extra", nil, nil, nil, {
            message = localize("k_plus_tarot"),
            colour = G.C.PURPLE
        })
    else
        card_eval_status_text(joker, "extra", nil, nil, nil, {
            message = localize("k_no_space_ex")
        })
    end
end

local function create_planet(joker, seed, edition, other_joker)
    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit or (edition and edition["negative"]) then
        local card_type = "Planet"
        if not (edition and edition["negative"]) then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        end
        G.E_MANAGER:add_event(Event({
            trigger = "before",
            delay = 0.0,
            func = (function()
                if G.GAME.last_hand_played then
                    local _planet = 0
                    for _, v in pairs(G.P_CENTER_POOLS.Planet) do
                        if v.config.hand_type == G.GAME.last_hand_played then
                            _planet = v.key
                        end
                    end

                    local card = create_card(card_type, G.consumeables, nil, nil, nil, nil, _planet, seed)
                    if edition then
                        card:set_edition(edition, true)
                    end
                    card:add_to_deck()
                    G.consumeables:emplace(card)
                    if not (edition and edition["negative"]) then
                        G.GAME.consumeable_buffer = 0
                    end

                    if other_joker then
                        other_joker:juice_up(0.5, 0.5)
                    end
                end
                return true
            end)
        }))

        -- Show message
        card_eval_status_text(joker, "extra", nil, nil, nil, {
            message = localize("k_plus_planet"),
            colour = G.C.SECONDARY_SET.Planet
        })
    else
        card_eval_status_text(joker, "extra", nil, nil, nil, {
            message = localize("k_no_space_ex")
        })
    end
end

SMODS.Atlas{
	key = "prime_time",
	path = "j_mmc_prime_time.png",
	px = 71,
	py = 95,
}
local prime_time = SMODS.Joker{
	name = "prime_time",
	key = "prime_time",
	config = { extra = { Xmult = 1.2 } },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Prime Time",
        text = {
            "Each played {C:attention}2{},",
            "{C:attention}3{}, {C:attention}5{}, {C:attention}7{} or {C:attention}Ace{}, gives",
            "{X:mult,C:white}X#1#{} Mult when scored",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Gappie"
        }
	},
	rarity = 1,
	cost = 4,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "prime_time",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Xmult } }
	end,
	calculate = function(self, card, context)
        -- For each played card, if card is prime, add xmult
        if context.individual and context.cardarea == G.play and
            (context.other_card:get_id() == 2 or
             context.other_card:get_id() == 3 or
             context.other_card:get_id() == 5 or
             context.other_card:get_id() == 7 or
             context.other_card:get_id() == 14) then
            return {
                message = localize {
                    type = "variable",
                    key = "a_xmult",
                    vars = { card.ability.extra.Xmult }
                },
                x_mult = card.ability.extra.Xmult,
                card = card
            }
        end
	end,
}

SMODS.Atlas{
	key = "straight_nate",
	path = "j_mmc_straight_nate.png",
	px = 71,
	py = 95,
}
local straight_nate = SMODS.Joker{
	name = "straight_nate",
	key = "straight_nate",
	config = {
        extra = {
            Xmult = 4,
            j_slots = 1
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Straight Nate",
        text = {
            "{X:mult,C:white} X#1# {} Mult if played hand",
            "contains a {C:attention}Straight{} and you have",
            "both {C:attention}Odd Todd{} and {C:attention}Even Steven{}",
            "Gives {C:dark_edition}+#2#{} Joker slot"
        }
	},
	rarity = 3,
	cost = 7,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "straight_nate",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Xmult, center.ability.extra.j_slots } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            -- If hand played is a straight
            if next(context.poker_hands["Straight"]) then
                -- Add xmult
                if (next(find_joker("Odd Todd")) and next(find_joker("Even Steven"))) or next(find_joker("Dynamic Duo")) then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_xmult",
                            vars = { card.ability.extra.Xmult }
                        },
                        Xmult_mod = card.ability.extra.Xmult
                    }
                end
            end
        end
	end,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.j_slots
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.j_slots
    end,
    in_pool = function (self)
        if next(find_joker("Odd Todd")) or next(find_joker("Even Steven")) or next(find_joker("Dynamic Duo")) then
            return true
        end
        return false
    end
}

SMODS.Atlas{
	key = "fisherman",
	path = "j_mmc_fisherman.png",
	px = 71,
	py = 95,
}
local fisherman = SMODS.Joker{
	name = "fisherman",
	key = "fisherman",
	config = {
        extra = {
            current_h_size = 0,
            h_mod = 1
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "The Fisherman",
        text = {
            "{C:attention}+#2#{} hand size per discard",
            "{C:attention}-#2#{} hand size per hand played",
            "Resets every round",
            "{C:inactive}(Currently {C:attention}#3##1#{C:inactive} hand size)"
        }
	},
	rarity = 2,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "fisherman",
	loc_vars = function(self, info_queue, center)
        local modifier = ""
        if center.ability.extra.current_h_size >= 0 then
            modifier = "+"
        end
		return { vars = { center.ability.extra.current_h_size, center.ability.extra.h_mod, modifier} }
	end,
	calculate = function(self, card, context)
        -- Decrease hand size
        if context.joker_main then
            --if card.ability.extra.current_h_size > 0 then
                card.ability.extra.current_h_size = card.ability.extra.current_h_size - card.ability.extra.h_mod
                G.hand:change_size(-card.ability.extra.h_mod)
                -- Decrease message
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_mmc_hand_down")
                })
            --end
        end

        -- Increase hand size
        if context.pre_discard then
            card.ability.extra.current_h_size = card.ability.extra.current_h_size + card.ability.extra.h_mod
            G.hand:change_size(card.ability.extra.h_mod)
            -- Increase message
            card_eval_status_text(card, "extra", nil, nil, nil, {
                message = localize("k_mmc_hand_up")
            })
        end

        -- Reset hand size
        if context.end_of_round and not context.individual and not context.repetition then
            if card.ability.extra.current_h_size ~= 0 then
                G.hand:change_size(-card.ability.extra.current_h_size)
                card.ability.extra.current_h_size = 0
                -- Reset message
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_reset")
                })
            end
        end
	end,
    remove_from_deck = function(self, card, from_debuff)
        -- Reset hand size
        if card.ability.extra.current_h_size ~= 0 then
            G.hand:change_size(-card.ability.extra.current_h_size)
            card.ability.extra.current_h_size = 0
        end
    end,
}

SMODS.Atlas{
	key = "impatient",
	path = "j_mmc_impatient.png",
	px = 71,
	py = 95,
}
local impatient = SMODS.Joker{
	name = "impatient",
	key = "impatient",
	config = {
        extra = {
            mult_mod = 3,
            current_mult = 0
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Impatient Joker",
        text = {
            "{C:mult}+#2#{} Mult per card discarded",
            "Resets every round",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
        }
	},
	rarity = 2,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "impatient",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.current_mult, center.ability.extra.mult_mod } }
	end,
	calculate = function(self, card, context)
        -- Apply mult
        if context.joker_main then
            if card.ability.extra.current_mult > 0 then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_mult",
                        vars = { card.ability.extra.current_mult }
                    },
                    mult_mod = card.ability.extra.current_mult,
                    card = card
                }
            end
        end

        -- Increase mult for each discarded card
        if context.discard and not context.blueprint then
            card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_mod
            return {
                message = localize {
                    type = "variable",
                    key = "a_mult",
                    vars = { card.ability.extra.mult_mod }
                },
                colour = G.C.RED,
                card = card
            }
        end

        -- Reset mult
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if card.ability.extra.current_mult ~= 0 then
                card.ability.extra.current_mult = 0
                -- Reset message
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_reset")
                })
            end
        end
	end,
}

SMODS.Atlas{
	key = "cultist",
	path = "j_mmc_cultist.png",
	px = 71,
	py = 95,
}
local cultist = SMODS.Joker{
	name = "cultist",
	key = "cultist",
	config = {
        extra = {
            current_Xmult = 1,
            Xmult_mod = 1,
            old = 0
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Cultist",
        text = {
            "{X:mult,C:white}X#2#{} Mult per hand played",
            "Resets every round",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 3,
	cost = 8,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "cultist",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.current_Xmult, center.ability.extra.Xmult_mod } }
	end,
	calculate = function(self, card, context)
        -- Increment Xmult
        if context.before and not context.blueprint then
            card.ability.extra.old = card.ability.extra.current_Xmult
            card.ability.extra.current_Xmult = card.ability.extra.current_Xmult + card.ability.extra.Xmult_mod
        end

        -- Apply xmult
        if context.joker_main then
            if card.ability.extra.old > 1 then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_xmult",
                        vars = { card.ability.extra.old }
                    },
                    Xmult_mod = card.ability.extra.old,
                    card = card
                }
            end
        end

        -- Reset mult
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if card.ability.extra.current_Xmult ~= 1 then
                card.ability.extra.current_Xmult = 1
                -- Reset message
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_reset")
                })
            end
        end
	end,
}

SMODS.Atlas{
	key = "seal_collector",
	path = "j_mmc_seal_collector.png",
	px = 71,
	py = 95,
}
local seal_collector = SMODS.Joker{
	name = "seal_collector",
	key = "seal_collector",
	config = {
        extra = {
            current_chips = 25,
            chip_mod = 25
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Seal Collector",
        text = {
            "Gains {C:chips}+#2#{} Chips for",
            "every card with a {C:attention}seal",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Gappie"
        }
	},
	rarity = 1,
	cost = 4,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "seal_collector",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.current_chips, center.ability.extra.chip_mod } }
	end,
	calculate = function(self, card, context)
        -- Apply chips
        if context.joker_main then
            return {
                message = localize {
                    type = "variable",
                    key = "a_chips",
                    vars = { card.ability.extra.current_chips }
                },
                chip_mod = card.ability.extra.current_chips,
                card = card
            }
        end
	end,
    update = function(self, card)
        if G.playing_cards then
            card.ability.extra.current_chips = 0
            -- Count all seal cards
            for _, v in pairs(G.playing_cards) do
                if v.seal ~= nil then
                    -- Add chips to total
                    card.ability.extra.current_chips = card.ability.extra.current_chips + card.ability.extra.chip_mod
                end
            end
        end
    end
}

SMODS.Atlas{
	key = "camper",
	path = "j_mmc_camper.png",
	px = 71,
	py = 95,
}
local camper = SMODS.Joker{
	name = "camper",
	key = "camper",
	config = {
        extra = {
            chip_mod = 4
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Camper",
        text = {
            "Every discarded {C:attention}card{}",
            "permanently gains",
            "{C:chips}+#1#{} Chips"
        }
	},
	rarity = 2,
	cost = 5,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "camper",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chip_mod } }
	end,
	calculate = function(self, card, context)
        -- If discarded
        if context.discard then
            -- Add chips to card
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.chip_mod
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.CHIPS,
                card = card
            }
        end
	end,
}

SMODS.Atlas{
	key = "scratch_card",
	path = "j_mmc_scratch_card.png",
	px = 71,
	py = 95,
}
local scratch_card = SMODS.Joker{
	name = "scratch_card",
	key = "scratch_card",
	config = {
        extra = {
            base = 1,
            dollars = 0,
            seven_tally = 0
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Scratch Card",
        text = {
            "Gain {C:money}$#1#{}, {C:money}$#2#{}, {C:money}$#3#{}, {C:money}$#4#{},",
            "{C:money}$#5#{} when 1, 2, 3, 4 or 5",
            "{C:attention}7 cards{} are scored,",
            "respectively",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 1,
	cost = 4,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "scratch_card",
	loc_vars = function(self, info_queue, center)
		return { vars = {
            center.ability.extra.base,
            center.ability.extra.base * 3,
            center.ability.extra.base * 10,
            center.ability.extra.base * 25,
            center.ability.extra.base * 50
        }
    }
	end,
	calculate = function(self, card, context)
        -- Count sevens
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 and
            not context.blueprint then
                card.ability.extra.seven_tally = card.ability.extra.seven_tally + 1
        end

        if context.joker_main then
            -- Set dollars depending on amount of 7s
            if card.ability.extra.seven_tally == 1 then
                card.ability.extra.dollars = card.ability.extra.base
            elseif card.ability.extra.seven_tally == 2 then
                card.ability.extra.dollars = card.ability.extra.base * 3
            elseif card.ability.extra.seven_tally == 3 then
                card.ability.extra.dollars = card.ability.extra.base * 10
            elseif card.ability.extra.seven_tally == 4 then
                card.ability.extra.dollars = card.ability.extra.base * 25
            elseif card.ability.extra.seven_tally >= 5 then
                card.ability.extra.dollars = card.ability.extra.base * 50
            end

            -- Give money
            if card.ability.extra.seven_tally >= 1 then
                ease_dollars(card.ability.extra.dollars)
                return {
                    message = localize("$") .. card.ability.extra.dollars,
                    dollars = card.ability.extra.dollars,
                    colour = G.C.MONEY
                }
            end
        end

        -- Reset
        if context.after and not context.blueprint and context.cardarea == G.jokers then
            card.ability.extra.dollars = 0
            card.ability.extra.seven_tally = 0
        end
	end,
}

SMODS.Atlas{
	key = "deli_ticket",
	path = "j_mmc_deli_ticket.png",
	px = 71,
	py = 95,
}
local deli_ticket = SMODS.Joker{
	name = "deli_ticket",
	key = "deli_ticket",
	config = {
        extra = {
            mult = 20,
            chips = 100,
            Xmult = 1.5,
            every = 4,
            action_tally = 1
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Deli Ticket",
        text = {
            "Gives {C:mult}+#1#{} Mult, {C:chips}+#2#{}",
            "Chips and {X:mult,C:white}X#3#{} Mult on",
            "the {C:attention}#5#th{} action",
            "{C:inactive}(Current action: {C:attention}#4#{C:inactive} )",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 2,
	cost = 7,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "deli_ticket",
	loc_vars = function(self, info_queue, center)
		return { vars = {
            center.ability.extra.mult,
            center.ability.extra.chips,
            center.ability.extra.Xmult,
            center.ability.extra.action_tally,
            center.ability.extra.every
        }
    }
	end,
	calculate = function(self, card, context)
        -- Increment action tally
        if context.before and not context.blueprint then
            card.ability.extra.action_tally = card.ability.extra.action_tally + 1
        end

        -- Apply mult, chips and xmult
        if context.joker_main then
            if card.ability.extra.action_tally == card.ability.extra.every + 1 then
                return {
                    -- Return bonus message and apply bonus
                    mult_mod = card.ability.extra.mult,
                    chip_mod = card.ability.extra.chips,
                    Xmult_mod = card.ability.extra.Xmult,
                    message = localize("k_mmc_bonus"),
                    card = card
                }
            elseif not context.blueprint then
                -- Return charging message
                return {
                    message = localize("k_mmc_charging"),
                    colour = G.C.JOKER_GREY,
                    card = card
                }
            end
        end

        -- Reset action tally
        if context.after and not context.blueprint and context.cardarea == G.jokers then
            if card.ability.extra.action_tally == card.ability.extra.every + 1 then
                card.ability.extra.action_tally = 1
            end
        end

        -- Increment action tally
        if context.pre_discard and not context.blueprint and not context.hook then
            card.ability.extra.action_tally = (card.ability.extra.action_tally % card.ability.extra.every) + 1
            if card.ability.extra.action_tally == 1 then
                -- Reset message
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_reset")
                })
            else
                -- Charging message
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_mmc_charging"),
                    colour = G.C.JOKER_GREY
                })
            end
        end
	end,
}

SMODS.Atlas{
	key = "joker_of_the_month",
	path = "j_mmc_joker_of_the_month.png",
	px = 71,
	py = 95,
}
local showoff = SMODS.Joker{
	name = "joker_of_the_month",
	key = "joker_of_the_month",
	config = {
        extra = {
            current_Xmult = 1,
            Xmult_mod = 0.25,
            req = 2,
            total_chips = 0
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Joker of the Month",
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult when",
            "a blind is finished with",
            "{C:attention}X#3#{} the chip requirement",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 3,
	cost = 8,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "joker_of_the_month",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.current_Xmult, center.ability.extra.Xmult_mod, center.ability.extra.req } }
	end,
	calculate = function(self, card, context)
        -- Apply xmult
        if context.joker_main then
            if card.ability.extra.current_Xmult > 1 then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_xmult",
                        vars = { card.ability.extra.current_Xmult }
                    },
                    Xmult_mod = card.ability.extra.current_Xmult,
                    card = card
                }
            end
        end

        -- Add scored chips to total
        if context.mmc_scored_chips and not context.blueprint then
            card.ability.extra.total_chips = card.ability.extra.total_chips + context.mmc_scored_chips
        end

        -- See if total scored chips > 2 * blind chips, then increment xmult
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if card.ability.extra.total_chips > (card.ability.extra.req * to_number(G.GAME.blind.chips)) then
                card.ability.extra.current_Xmult = card.ability.extra.current_Xmult + card.ability.extra.Xmult_mod

                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.RED
                })
            end
            -- Reset total chip count
            card.ability.extra.total_chips = 0
        end
	end,
}

SMODS.Atlas{
	key = "sniper",
	path = "j_mmc_sniper.png",
	px = 71,
	py = 95,
}
local sniper = SMODS.Joker{
	name = "sniper",
	key = "sniper",
	config = {
        extra = {
            current_Xmult = 1,
            Xmult_mod = 2,
            percentage = 10,
            total_chips = 0
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "The Sniper",
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult when a",
            "blind is finished within {C:attention}#3#%{} of",
            "the {C:attention}exact{} chip requirement",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 3,
	cost = 10,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "sniper",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.current_Xmult, center.ability.extra.Xmult_mod, center.ability.extra.percentage } }
	end,
	calculate = function(self, card, context)
        -- Apply xmult
        if context.joker_main then
            if card.ability.extra.current_Xmult > 1 then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_xmult",
                        vars = { card.ability.extra.current_Xmult }
                    },
                    Xmult_mod = card.ability.extra.current_Xmult,
                    card = card
                }
            end
        end

        -- Add scored chips to total
        if context.mmc_scored_chips and not context.blueprint then
            card.ability.extra.total_chips = to_number(card.ability.extra.total_chips) + to_number(context.mmc_scored_chips)
        end

        -- See if total scored chips == blind chips, then increment xmult
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            if card.ability.extra.total_chips <= to_number(G.GAME.blind.chips) * (1 + card.ability.extra.percentage / 100) then
                card.ability.extra.current_Xmult = card.ability.extra.current_Xmult + card.ability.extra.Xmult_mod

                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.RED
                })
            end
            -- Reset total chip count
            card.ability.extra.total_chips = 0
        end
	end,
}

SMODS.Atlas{
	key = "blackjack",
	path = "j_mmc_blackjack.png",
	px = 71,
	py = 95,
}
local blackjack = SMODS.Joker{
	name = "blackjack",
	key = "blackjack",
	config = {
        extra = {
            Xmult = 3,
            rank_tally = { 0 },
            updated_rank_tally = {},
            req = 21,
            Xmult_mod = 0.5
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Blackjack Joker",
        text = {
            "Gives {X:mult,C:white}X#1#{} Mult when",
            "the ranks of all played",
            "cards is {C:attention}exactly #2#",
            "Gives {X:mult,C:white}X#3#{} Mult less for",
            "every point below #2#"
        }
	},
	rarity = 2,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "blackjack",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Xmult, center.ability.extra.req, center.ability.extra.Xmult_mod} }
	end,
	calculate = function(self, card, context)
        -- For full hand
        if context.before and not context.blueprint then
            -- For every played card
            for _, v in ipairs(context.full_hand) do
                local id = v:get_id()
                if id <= 10 then -- Numbered cards
                    for k, v in ipairs(card.ability.extra.rank_tally) do
                        card.ability.extra.rank_tally[k] = v + id
                    end
                elseif id < 14 then -- Face cards
                    for k, v in ipairs(card.ability.extra.rank_tally) do
                        card.ability.extra.rank_tally[k] = v + 10
                    end
                else -- Aces, need to be handled differently because they can either have a value of 1 or 11
                    for k, v in ipairs(card.ability.extra.rank_tally) do
                        -- If someone ever plays 32 aces in one hand, I'm doomed
                        card.ability.extra.rank_tally[k] = v + 11
                        table.insert(card.ability.extra.updated_rank_tally, v + 1)
                    end

                    -- Append updated_rank_tally to rank_tally
                    for _, v in ipairs(card.ability.extra.updated_rank_tally) do
                        table.insert(card.ability.extra.rank_tally, v)
                    end

                    -- Reset updated_rank_tally
                    card.ability.extra.updated_rank_tally = {}
                end
            end
        end

        -- When hand is played
        if context.joker_main then
            -- For every rank_tally, check if we got 21
            local Xmult = 1
            for _, v in ipairs(card.ability.extra.rank_tally) do
                local diff = card.ability.extra.req - v
                local new_Xmult = card.ability.extra.Xmult - diff * card.ability.extra.Xmult_mod
                -- Update Xmult if it is higher than saved Xmult, and score is not above the required score
                if diff >= 0 and new_Xmult > Xmult then
                    Xmult = new_Xmult
                end
            end

            -- Apply Xmult
            if Xmult > 1 then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_xmult",
                        vars = { Xmult }
                    },
                    Xmult_mod = Xmult,
                    card = card
                }
            end
        end

        -- Reset rank_tally
        if context.after and not context.blueprint and context.cardarea == G.jokers then
            card.ability.extra.rank_tally = { 0 }
        end
	end,
}

SMODS.Atlas{
	key = "batman",
	path = "j_mmc_batman.png",
	px = 71,
	py = 95,
}
local batman = SMODS.Joker{
	name = "batman",
	key = "batman",
	config = {
        extra = {
            current_mult = 1,
            mult_mod = 1,
            total_chips = 0,
            base = 1
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Batman",
        text = {
            "Gains {C:mult}+#2#{} Mult for",
            "every {C:attention}non-lethal{} hand played",
            "Mult gain increases for every",
            "Joker with {C:attention}\"Joker\"{} in the name",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
        }
	},
	rarity = 3,
	cost = 8,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "batman",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.current_mult, center.ability.extra.mult_mod } }
	end,
	calculate = function(self, card, context)
        -- When hand is played
        if context.joker_main then
            -- Apply mult
            return {
                message = localize {
                    type = "variable",
                    key = "a_mult",
                    vars = { card.ability.extra.current_mult }
                },
                mult_mod = card.ability.extra.current_mult
            }
        end

        -- Add scored chips to total
        if context.mmc_scored_chips and not context.blueprint then
            card.ability.extra.total_chips = card.ability.extra.total_chips + context.mmc_scored_chips

            if card.ability.extra.total_chips < G.GAME.blind.chips then
                card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_mod
            end
        end

        -- Reset total chip count
        if context.end_of_round and not context.individual and not context.repetition then
            -- Reset total chip count
            card.ability.extra.total_chips = 0
        end
	end,
    update = function(self, card)
        if G.jokers then
            card.ability.extra.mult_mod = card.ability.extra.base
            -- Count all jokers with "Joker" in the name
            for _, v in pairs(G.jokers.cards) do
                if string.find(v.ability.name, "Joker") then
                    -- Increase mult gain
                    card.ability.extra.mult_mod = card.ability.extra.mult_mod + 1
                end
            end
        end
    end
}

SMODS.Atlas{
	key = "bomb",
	path = "j_mmc_bomb.png",
	px = 71,
	py = 95,
}
local bomb = SMODS.Joker{
	name = "bomb",
	key = "bomb",
	config = {
        extra = {
            current_mult = 15,
            mult_mod = 15,
            _every = 3
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Bomb",
        text = {
            "Gains {C:mult}+#2#{} Mult per round",
            "self destructs after {C:attention}#3#{} rounds",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 1,
	cost = 5,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "bomb",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.current_mult, center.ability.extra.mult_mod, center.ability.extra._every } }
	end,
	calculate = function(self, card, context)
        -- Apply mult
        if context.joker_main then
            return {
                message = localize {
                    type = "variable",
                    key = "a_mult",
                    vars = { card.ability.extra.current_mult }
                },
                mult_mod = card.ability.extra.current_mult,
                card = card
            }
        end

        -- Decrease round_left counter or destroy
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra._every = card.ability.extra._every - 1

            if card.ability.extra._every <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        card:start_dissolve()
                        return true
                    end
                }))
            else
                -- Increase mult
                card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_mod
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_mmc_tick"),
                    colour = G.C.RED
                })
            end
        end
	end,
}

SMODS.Atlas{
	key = "eye_chart",
	path = "j_mmc_eye_chart.png",
	px = 71,
	py = 95,
}
local eye_chart = SMODS.Joker{
	name = "eye_chart",
	key = "eye_chart",
	config = {
        extra = {
            chips = 20,
            letter = ""
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Eye Chart",
        text = {
            "Gives {C:chips}+#1#{} Chips for every",
            "letter {C:attention}\"#2#\"{} in your Jokers",
            "Letter changes when this",
            "Joker first appears",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy" 
        }
	},
	rarity = 1,
	cost = 4,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "eye_chart",
	loc_vars = function(self, info_queue, center)
        if center.ability.extra.letter == "" then
            local letters = { "a", "b", "c", "d", "e", "é", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s",
                "t", "u", "v", "w", "x", "y", "z" }
            center.ability.extra.letter = string.upper(pseudorandom_element(letters, pseudoseed("eye_chart")))
        end
		return { vars = { center.ability.extra.chips, center.ability.extra.letter } }
	end,
	calculate = function(self, card, context)
        -- Check if Joker name contains letter and apply chips
        if context.other_joker and context.other_joker.ability.set == "Joker" then
            local ability_name = context.other_joker.ability.name:lower()

            -- Count letters
            local count = 0
            for _ in ability_name:gmatch(card.ability.extra.letter:lower()) do
                count = count + 1
            end
            local letter_tally = count

            -- Check if Joker name contains letter
            if letter_tally > 0 then
                -- Animate other Joker
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_joker:juice_up(0.5, 0.5)
                        return true
                    end
                }))
                -- Apply chips
                return {
                    message = localize {
                        type = "variable",
                        key = "a_chips",
                        vars = { card.ability.extra.chips * letter_tally }
                    },
                    chip_mod = card.ability.extra.chips * letter_tally
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "insect_specimen",
	path = "j_mmc_insect_specimen.png",
	px = 71,
	py = 95,
}
local insect_specimen = SMODS.Joker{
	name = "insect_specimen",
	key = "insect_specimen",
	config = {
        extra = {
            current_chips = 0,
            total_chips = 0,
            old_chips = 0,
            percentage = 25
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Insect Specimen",
        text = {
            "Lowers blind requirement",
            "with {C:attention}excess Chips{} from",
            "last round. Caps at {C:attention}#2#%",
            "of current blind's Chips",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 3,
	cost = 9,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "insect_specimen",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.current_chips, center.ability.extra.percentage } }
	end,
	calculate = function(self, card, context)
        -- Add scored chips to total
        if context.mmc_scored_chips and not context.blueprint then
            card.ability.extra.total_chips = card.ability.extra.total_chips + context.mmc_scored_chips
        end

        -- Apply chips
        if context.joker_main then
            if card.ability.extra.current_chips > 0 then
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize {
                        type = "variable",
                        key = "a_chips",
                        vars = { card.ability.extra.current_chips }
                    },
                    colour = G.C.CHIPS
                })
                -- Special thanks to Codex Arcanum
                G.GAME.blind.chips = math.max(G.GAME.blind.chips - card.ability.extra.current_chips, 0)
                G.E_MANAGER:add_event(Event({
                    delay = 0.0,
                    func = function()
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        local chips_UI = G.hand_text_area.blind_chips
                        G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                        G.HUD_blind:recalculate()
                        chips_UI:juice_up()
                        return true
                    end
                }))
            end
        end

        -- Reset chips
        if context.after and not context.blueprint and context.cardarea == G.jokers then
            card.ability.extra.current_chips = 0
        end

        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            -- Add excess chips to bonus
            if card.ability.extra.total_chips >= G.GAME.blind.chips then
                card.ability.extra.current_chips = card.ability.extra.total_chips - G.GAME.blind.chips
                card.ability.extra.current_chips = math.ceil(math.min(G.GAME.blind.chips *
                    card.ability.extra.percentage / 100, card.ability.extra.current_chips))
                -- Return message
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize {
                        type = "variable",
                        key = "a_chips",
                        vars = { card.ability.extra.current_chips }
                    },
                    colour = G.C.CHIPS
                })
            end
        end
	end,
}

SMODS.Atlas{
	key = "finishing_blow",
	path = "j_mmc_finishing_blow.png",
	px = 71,
	py = 95,
}
local finishing_blow = SMODS.Joker{
	name = "finishing_blow",
	key = "finishing_blow",
	config = {
        extra = {
            high_card = false,
            card_refs = {}
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Finishing Blow",
        text = {
            "If a blind is finished",
            "with a {C:attention}High Card{}, randomly",
            "{C:attention}Enhance{} scored cards"
        }
	},
	rarity = 2,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
	atlas = "finishing_blow",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.enhancement } }
	end,
	calculate = function(self, card, context)
        -- Check for high card and set card reference
        if context.cardarea == G.play and not context.repetition then
            if context.scoring_name == "High Card" then
                if context.other_card.ability.effect == "Base" then
                    card.ability.extra.high_card = true
                    table.insert(card.ability.extra.card_refs, context.other_card)
                end
            else
                card.ability.extra.high_card = false
            end
        end

        -- Give random enhancement if last hand was high card
        if context.end_of_round and not context.individual and not context.repetition then
            if card.ability.extra.high_card then
                for _, v in ipairs(card.ability.extra.card_refs) do
                    if type(v) == 'table' then
                        local enhancement = SMODS.poll_enhancement({key = "finishing_blow", guaranteed = true})
                        v:set_ability(G.P_CENTERS[enhancement])
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize("k_upgrade_ex"),
                            delay = 0.45
                        })
                    end
                end
           end
           -- Reset card_refs
           card.ability.extra.card_refs = {}
       end
	end,
}

SMODS.Atlas{
	key = "aurora_borealis",
	path = "j_mmc_aurora_borealis.png",
	px = 71,
	py = 95,
}
local aurora_borealis = SMODS.Joker{
	name = "aurora_borealis",
	key = "aurora_borealis",
	config = { },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Aurora Borealis",
        text = {
            "{C:attention}Blue Seals{} give an",
            "extra {C:dark_edition}negative {C:planet}Planet{} card",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 1,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
	atlas = "aurora_borealis",
	loc_vars = function(self, info_queue, center)
		return { vars = { } }
	end,
    
}

SMODS.Atlas{
	key = "historical",
	path = "j_mmc_historical.png",
	px = 71,
	py = 95,
}
local historical = SMODS.Joker{
	name = "historical",
	key = "historical",
	config = {
        extra = {
            prev_cards = {},
            current_cards = {},
            current_chips = 0,
            percentage = 25
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Historical Joker",
        text = {
            "If scored cards have the same",
            "{C:attention}ranks{} and {C:attention}order{} as previous",
            "hand, reduce blind requirement",
            "by previous hands {C:chips}Chips{}. Caps at",
            "{C:attention}#1#%{} of current blind's Chips",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 3,
	cost = 9,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "historical",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.percentage } }
	end,
	calculate = function(self, card, context)
        -- Save previous cards
        if context.before and not context.blueprint then
            for _, v in ipairs(context.full_hand) do
                table.insert(card.ability.extra.current_cards, v.base.id)
            end
        end

        -- Calculate chip score
        if context.mmc_scored_chips and not context.blueprint then
            card.ability.extra.current_chips = context.mmc_scored_chips
            card.ability.extra.current_chips = math.ceil(to_number(math.min(
                G.GAME.blind.chips * card.ability.extra.percentage / 100, card.ability.extra.current_chips)))
        end

        -- Apply chips if previous cards are the same as the current cards
        if context.joker_main then
            if table.concat(card.ability.extra.prev_cards) == table.concat(card.ability.extra.current_cards) then
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize {
                        type = "variable",
                        key = "a_chips",
                        vars = { card.ability.extra.current_chips }
                    },
                    colour = G.C.CHIPS
                })
                -- Special thanks to Codex Arcanum
                G.GAME.blind.chips =  math.max(G.GAME.blind.chips - card.ability.extra.current_chips, 0)
                G.E_MANAGER:add_event(Event({
                    delay = 0.0,
                    func = function()
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        local chips_UI = G.hand_text_area.blind_chips
                        G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                        G.HUD_blind:recalculate()
                        chips_UI:juice_up()
                        return true
                    end
                }))
            end
        end

        -- Save previous hand
        if context.after and not context.blueprint and context.cardarea == G.jokers then
            local t2 = {}
            for k, v in pairs(card.ability.extra.current_cards) do
                t2[k] = v
            end
            card.ability.extra.prev_cards = t2
            card.ability.extra.current_cards = {}
        end
	end,
}

SMODS.Atlas{
	key = "suit_alley",
	path = "j_mmc_suit_alley.png",
	px = 71,
	py = 95,
}
local suit_alley = SMODS.Joker{
	name = "suit_alley",
	key = "suit_alley",
	config = {
        extra = {
            mult = 3,
            chips = 12
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Suit Alley",
        text = {
            "{C:diamonds}Diamond{} and {C:clubs}Club{} cards",
            "gain {C:chips}+#1#{} Chips when scored",
            "{C:hearts}Heart{} and {C:spades}Spade{} cards",
            "gain {C:mult}+#2#{} Mult when scored"
        }
	},
	rarity = 1,
	cost = 4,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "suit_alley",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips, center.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and not context.repetition then
            local mult = 0
            local chips = 0
            if context.other_card:is_suit("Diamonds") or context.other_card:is_suit("Clubs") then
                -- Add chips if suit is Diamonds or Clubs
                chips = card.ability.extra.chips
            end
            if context.other_card:is_suit("Hearts") or context.other_card:is_suit("Spades") then
                -- Add mult if Hearts or Spades
                mult = card.ability.extra.mult
            end

            if mult > 0 and chips > 0 then
                return {
                    chips = chips,
                    mult = mult,
                    card = card
                }
            elseif chips > 0 then
                return {
                    chips = chips,
                    card = card
                }
            elseif mult > 0 then
                return {
                    mult = mult,
                    card = card
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "test_print",
	path = "j_mmc_test_print.png",
	px = 71,
	py = 95,
}
local test_print = SMODS.Joker{
	name = "test_print",
	key = "test_print",
	config = {
        extra = {
            hand = {}
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Test Print",
        text = {
            "If hand scores more than",
            "blind's Chips, {C:attention}duplicate{}",
            "played cards",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 3,
	cost = 9,
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
	atlas = "test_print",
	loc_vars = function(self, info_queue, center)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
        -- Save cards
        if context.before then
            for _, v in ipairs(context.full_hand) do
                table.insert(card.ability.extra.hand, v)
            end
        end

        -- Calculate chip score and duplicate cards
        if context.mmc_scored_chips then
            if context.mmc_scored_chips >= G.GAME.blind.chips then
                -- Loop over hand
                for _, v in ipairs(card.ability.extra.hand) do
                    -- Copy card
                    local _card = copy_card(v, nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.deck:emplace(_card)
                    _card.states.visible = nil

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card:start_materialize()
                            return true
                        end
                    }))
                    -- Show message
                    card_eval_status_text(card, "extra", nil, nil, nil, {
                        message = localize("k_copied_ex"),
                        colour = G.C.CHIPS,
                        card = card,
                        playing_cards_created = { true }
                    })
                end
            end
            -- Reset hand
            card.ability.extra.hand = {}
        end
	end,
}

SMODS.Atlas{
	key = "training_wheels",
	path = "j_mmc_training_wheels.png",
	px = 71,
	py = 95,
}
local training_wheels = SMODS.Joker{
	name = "training_wheels",
	key = "training_wheels",
	config = {
        extra = {
            current_Xmult = 1,
            Xmult_mod = 0.1,
            card_count = 0,
            req = 10
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Training Wheels",
        text = {
            "{X:mult,C:white}X#1#{} Mult, gains {X:mult,C:white}X#2#{}",
            "Mult per {C:attention}#4# cards{} scored",
            "{C:inactive}Currently {C:attention}#3# {C:inactive}cards scored",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 2,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "training_wheels",
	loc_vars = function(self, info_queue, center)
		return { vars = {
            center.ability.extra.current_Xmult,
            center.ability.extra.Xmult_mod,
            center.ability.extra.card_count,
            center.ability.extra.req
        }
    }
	end,
	calculate = function(self, card, context)
        -- Add xmult for every played card
        if context.individual and context.cardarea == G.play and not context.blueprint then
            card.ability.extra.card_count = card.ability.extra.card_count + 1
            if card.ability.extra.card_count >= 10 then
                card.ability.extra.card_count = 0
                card.ability.extra.current_Xmult = card.ability.extra.current_Xmult + card.ability.extra.Xmult_mod
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize {
                        type = "variable",
                        key = "a_xmult",
                        vars = { card.ability.extra.current_Xmult }
                    },
                    colour = G.C.MULT
                })
            end
        end

        -- Apply xmult
        if context.joker_main then
            if card.ability.extra.current_Xmult > 1 then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_xmult",
                        vars = { card.ability.extra.current_Xmult }
                    },
                    Xmult_mod = card.ability.extra.current_Xmult,
                    card = card
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "horseshoe",
	path = "j_mmc_horseshoe.png",
	px = 71,
	py = 95,
}
local horseshoe = SMODS.Joker{
	name = "horseshoe",
	key = "horseshoe",
	config = {
        extra = 1
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Horseshoe",
        text = {
            "Retrigger all",
            "scored {C:attention}Lucky{} cards",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 2,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "horseshoe",
	loc_vars = function(self, info_queue, center)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
        -- Retrigger lucky cards
        if context.repetition and context.cardarea == G.play then
            if context.other_card.ability.effect == "Lucky Card" then
                return {
                    message = localize("k_again_ex"),
                    repetitions = card.ability.extra,
                    card = card
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "incomplete",
	path = "j_mmc_incomplete.png",
	px = 71,
	py = 95,
}
local incomplete = SMODS.Joker{
	name = "incomplete",
	key = "incomplete",
	config = {
        extra = {
            chips = 100,
            req = 3
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Incomplete Joker",
        text = {
            "{C:chips}+#1#{} Chips if played",
            "hand contains",
            "{C:attention}#2#{} or fewer cards"
        }
	},
	rarity = 1,
	cost = 4,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "incomplete",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips, center.ability.extra.req } }
	end,
	calculate = function(self, card, context)
        -- Check if hand is less than 3 cards, then apply chips
        if context.joker_main and context.full_hand then
            if #context.full_hand <= card.ability.extra.req then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_chips",
                        vars = { card.ability.extra.chips }
                    },
                    chip_mod = card.ability.extra.chips
                }
            end
        end
	end,
    add_to_deck = function(self, card, from_debuff)
        if next(find_joker("glue")) and next(find_joker("Half Joker")) then
            local glue = find_joker("glue")[1]
            glue.ability.extra.triggered = true
            G.jokers.config.card_limit = G.jokers.config.card_limit + glue.ability.extra.j_slots
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if next(find_joker("glue")) and next(find_joker("Half Joker")) then
            local glue = find_joker("glue")[1]
            glue.ability.extra.triggered = false
            G.jokers.config.card_limit = G.jokers.config.card_limit - glue.ability.extra.j_slots
        end
    end
}

SMODS.Atlas{
	key = "abbey_road",
	path = "j_mmc_abbey_road.png",
	px = 71,
	py = 95,
}
local abbey_road = SMODS.Joker{
	name = "abbey_road",
	key = "abbey_road",
	config = {
        extra = {
            Xmult = 4,
            req = 5,
            hand_equal_count = {},
            should_trigger = false
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Abbey Road",
        text = {
            "If at least {C:attention}#2#{} poker hands",
            "have been played the same",
            "amount of times, give {X:mult,C:white}X#1#{} Mult",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 2,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "abbey_road",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Xmult, center.ability.extra.req } }
	end,
	calculate = function(self, card, context)
        if context.after and not context.blueprint and context.cardarea == G.jokers then
            -- Reset
            card.ability.extra.should_trigger = false
            card.ability.extra.hand_equal_count = {}

            -- Count occurance of all hands
            for _, v in ipairs(G.handlist) do
                if G.GAME.hands[v].played > 0 then
                    if card.ability.extra.hand_equal_count[G.GAME.hands[v].played] == nil then
                        card.ability.extra.hand_equal_count[G.GAME.hands[v].played] = 1
                    else
                        card.ability.extra.hand_equal_count[G.GAME.hands[v].played] = card.ability.extra
                            .hand_equal_count[G.GAME
                            .hands[v].played] + 1
                    end
                end
            end
            -- If any count is higher than req, apply mult
            for _, v in pairs(card.ability.extra.hand_equal_count) do
                if v >= card.ability.extra.req then
                    card.ability.extra.should_trigger = true
                end
            end
        end

        -- Apply Xmult
        if context.joker_main then
            if card.ability.extra.should_trigger then
                card.ability.extra.should_trigger = false
                return {
                    message = localize {
                        type = "variable",
                        key = "a_xmult",
                        vars = { card.ability.extra.Xmult }
                    },
                    Xmult_mod = card.ability.extra.Xmult,
                    card = card
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "fishing_license",
	path = "j_mmc_fishing_license.png",
	px = 71,
	py = 95,
}
local fishing_license = SMODS.Joker{
	name = "fishing_license",
	key = "fishing_license",
	config = { },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Fishing License",
        text = {
            "{C:attention}Copies{} effects of all",
            "scored {C:attention}Enhanced{} cards",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 3,
	cost = 8,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "fishing_license",
	loc_vars = function(self, info_queue, center)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.effect == "Bonus Card" or
               context.other_card.ability.effect == "Stone Card" then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_chips",
                        vars = { context.other_card.ability.bonus }
                    },
                    chips = context.other_card.ability.bonus,
                    card = card
                }
            elseif context.other_card.ability.effect == "Mult Card" then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_mult",
                        vars = { context.other_card.ability.mult }
                    },
                    mult = context.other_card.ability.mult,
                    card = card
                }
            elseif context.other_card.ability.effect == "Glass Card" then
                return {
                    message = localize {
                        type = "variable",
                        key = "x_mult",
                        vars = { context.other_card.ability.x_mult }
                    },
                    x_mult = context.other_card.ability.x_mult,
                    card = card
                }
            elseif context.other_card.ability.effect == "Lucky Card" then
                if pseudorandom("lucky_money") < G.GAME.probabilities.normal / 15 then
                    ease_dollars(context.other_card.ability.p_dollars)
                    card_eval_status_text(card, "extra", nil, nil, nil, {
                        message = localize("$") .. context.other_card.ability.p_dollars,
                        dollars = context.other_card.ability.p_dollars,
                        colour = G.C.MONEY,
                        delay = 0.45
                    })
                end
                if pseudorandom("lucky_mult") < G.GAME.probabilities.normal / 5 then
                    return {
                        message = localize {
                            type = "variable",
                            key = "a_mult",
                            vars = { context.other_card.ability.mult }
                        },
                        mult = context.other_card.ability.mult,
                        card = card
                    }
                end
            end
        end
	end,
}

SMODS.Atlas{
	key = "gold_bar",
	path = "j_mmc_gold_bar.png",
	px = 71,
	py = 95,
}
local gold_bar = SMODS.Joker{
	name = "gold_bar",
	key = "gold_bar",
	config = {
        extra = {
            dollars = 2
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Gold Bar",
        text = {
            "Earn {C:money}$#1#{} for every",
            "{C:attention}Gold Seal{} and {C:attention}Gold card{}",
            "at end of round",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 1,
	cost = 5,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "gold_bar",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.dollars } }
	end,
	calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
            local gold_tally = 0
            -- Count all Gold Cards and Gold Seals
            for _, v in pairs(G.playing_cards) do
                if v.ability.name == "Gold Card" then
                    gold_tally = gold_tally + 1
                end
                if v.seal == "Gold" then
                    gold_tally = gold_tally + 1
                end
            end

            -- Give money and reset
            if gold_tally > 0 then
                ease_dollars(gold_tally * card.ability.extra.dollars)
                return {
                    message = localize("$") .. gold_tally * card.ability.extra.dollars,
                    dollars = gold_tally * card.ability.extra.dollars,
                    colour = G.C.MONEY
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "rigged",
	path = "j_mmc_rigged.png",
	px = 71,
	py = 95,
}
local rigged = SMODS.Joker{
	name = "rigged",
	key = "rigged",
	config = {
        extra = {
            probability = 0,
            increase = 1,
            has_triggered = false
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Rigged Joker",
        text = {
            "Once per hand, add {C:attention}+#1#{} to all",
            "listed {C:green,E:1,S:1.1}probabilities{} whenever a",
            "{C:attention}Lucky{} card does not trigger",
            "Resets every round"
        }
	},
	rarity = 1,
	cost = 5,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "rigged",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.increase } }
	end,
	calculate = function(self, card, context)
        -- Check if lucky card does not trigger
        if context.individual and context.cardarea == G.play and context.other_card.ability.effect == "Lucky Card" and
            not context.blueprint then
            if not context.other_card.lucky_trigger and not card.ability.extra.has_triggered then
                card.ability.extra.has_triggered = true
            end
        end

        -- Increase probabilities and reset has_triggered
        if context.joker_main then
            if card.ability.extra.has_triggered then
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_mmc_luck"),
                    colour = G.C.GREEN
                })
                card.ability.extra.probability = card.ability.extra.probability + card.ability.extra.increase
                for k, v in pairs(G.GAME.probabilities) do
                    G.GAME.probabilities[k] = v + card.ability.extra.increase
                end
            end
            card.ability.extra.has_triggered = false
        end

        -- Reset probabilities
        if context.end_of_round and not context.individual and not context.repetition then
            if card.ability.extra.probability > 0 then
                for k, v in pairs(G.GAME.probabilities) do
                    G.GAME.probabilities[k] = v - card.ability.extra.probability
                end
                card.ability.extra.probability = 0
                -- Reset message
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_reset")
                })
            end
        end
	end,
    remove_from_deck = function(self, card, from_debuff)
        -- Reset probabilities
        if card.ability.extra.probability > 0 then
            for k, v in pairs(G.GAME.probabilities) do
                G.GAME.probabilities[k] = v - card.ability.extra.probability
            end
            card.ability.extra.probability = 0
        end
    end
}

SMODS.Atlas{
	key = "sticker_sheet",
	path = "j_mmc_sticker_sheet.png",
	px = 71,
	py = 95,
}
local sticker_sheet = SMODS.Joker{
	name = "sticker_sheet",
	key = "sticker_sheet",
	config = { extra = { req = 1 } },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Sticker Sheet",
        text = {
            "If {C:attention}first hand{} of round",
            "has only {C:attention}#1#{} card, give it a",
            "random {C:attention}Enhancement{}, {C:attention}Seal",
            "and {C:attention}Edition",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 3,
	cost = 9,
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
	atlas = "sticker_sheet",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.req } }
	end,
	calculate = function(self, card, context)
        -- Animate card
        if context.first_hand_drawn then
            local eval = function()
                return G.GAME.current_round.hands_played == 0
            end
            juice_card_until(card, eval, true)
        end

        -- If first hand is single card, upgrade
        if G.GAME.current_round.hands_played == 0 then
            if context.before then
                if #context.full_hand == card.ability.extra.req then
                    for _, _card in ipairs(context.full_hand) do
                        -- Animate card
                        G.E_MANAGER:add_event(Event({
                            delay = 0.5,
                            func = function()
                                _card:juice_up(0.3, 0.5)
                                -- Add seal and edition
                                if _card.ability.seal == nil then
                                    local seal = SMODS.poll_seal({key = "commander", guaranteed = true})
                                    _card:set_seal(seal)
                                end
                                if _card.edition == nil then
                                    local edition = poll_edition("commander", nil, true, true)
                                    _card:set_edition(edition)
                                end
                                return true
                            end
                        }))

                        -- Add enhancement, outside of animate because this has a delay for some reason
                        if _card.ability.effect == "Base" then
                            local enhancement = SMODS.poll_enhancement({key = "commander", guaranteed = true})
                            _card:set_ability(G.P_CENTERS[enhancement])
                        end

                        -- Return message
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize("k_upgrade_ex")
                        })
                    end
                end
            end
        end
	end,
}

SMODS.Atlas{
	key = "blue_moon",
	path = "j_mmc_blue_moon.png",
	px = 71,
	py = 95,
}
local blue_moon = SMODS.Joker{
	name = "blue_moon",
	key = "blue_moon",
	config = {
        extra = {
            req = 3,
            lucky_tally = 0
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Blue Moon",
        text = {
            "If {C:attention}#1# Lucky cards{} trigger",
            "in one hand, create a",
            "random {C:dark_edition}negative{} Joker",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 2,
	cost = 8,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "blue_moon",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.req } }
	end,
	calculate = function(self, card, context)
        -- Count lucky triggers
        if context.individual and context.cardarea == G.play and not context.blueprint then
            for _, v in ipairs(context.full_hand) do
                if v.lucky_trigger then
                    card.ability.extra.lucky_tally = card.ability.extra.lucky_tally + 1
                end
            end
        end

        -- Check for 5 lucky triggers
        if context.joker_main then
            if card.ability.extra.lucky_tally >= card.ability.extra.req then
                -- Create new negative Joker
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil, "blue_moon")
                        card:set_edition({
                            negative = true
                        })
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        card:start_materialize()
                        return true
                    end
                }))
                -- Return message
                return {
                    message = localize("k_plus_joker"),
                    colour = G.C.BLUE
                }
            else
                -- Nope!
                return {
                    message = localize("k_nope_ex"),
                    colour = G.C.SECONDARY_SET.Tarot
                }
            end
        end

        -- Reset tally
        if context.after and not context.blueprint and context.cardarea == G.jokers then
            card.ability.extra.lucky_tally = 0
        end
	end,
}

SMODS.Atlas{
	key = "dagonet",
	path = "j_mmc_dagonet.png",
	px = 71,
	py = 95,
}
local dagonet = SMODS.Joker{
	name = "dagonet",
	key = "dagonet",
	config = {
        extra = {
            _mult = 2,
            _base = 2,
            triggered = false
        }
    },
	pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
	loc_txt = {
        name = "Dagonet",
        text = {
            "{C:attention}Doubles{} all base values",
            "on other Jokers",
            "{C:inactive}(If possible)"
        }
	},
	rarity = 4,
	cost = 20,
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
	atlas = "dagonet",
	loc_vars = function(self, info_queue, center)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
        if not context.repetition or context.individual then
            -- Reset defaults
            local other_dagonet_trigger = false
            card.ability.extra.triggered = false

            -- Increase multiplier based on how many Dagonets there are
            card.ability.extra._mult = card.ability.extra._base
            for _, v in ipairs(find_joker("dagonet")) do
                if v ~= card then
                    if v.ability.extra.triggered then
                        other_dagonet_trigger = true
                    end
                    card.ability.extra._mult = card.ability.extra._mult * 2
                end
            end

            -- Loop over all jokers (excluding self)
            if not other_dagonet_trigger then
                card.ability.extra.triggered = true
                for _, v in ipairs(G.jokers.cards) do
                    if v ~= card and dagonet_blacklist[v.ability.name] == nil then
                        for k2, v2 in pairs(v.ability) do
                            -- Increase attributes
                            increase_attributes(k2, v2, v.ability, card.ability.extra._mult)
                        end
                    end
                end
            end
        end
	end,
    remove_from_deck = function(self, card, from_debuff)
        -- Return attributes to defaults
        for _, v in ipairs(G.jokers.cards) do
            if v ~= card then
                if v.ability.name == 'dagonet' and v.ability.extra._mult ~= 2 then
                    v.ability.extra._mult = v.ability.extra._mult / 2
                end
                for k2, v2 in pairs(v.ability) do
                    increase_attributes(k2, v2, v.ability, card.ability.extra._mult / 2)
                end
            end
        end
    end
}

SMODS.Atlas{
	key = "glue",
	path = "j_mmc_glue.png",
	px = 71,
	py = 95,
}
local glue = SMODS.Joker{
	name = "glue",
	key = "glue",
	config = {
        extra = {
            Xmult = 5,
            j_slots = 2,
            triggered = false
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Glue",
        text = {
            "If you have both {C:attention}Half",
            "and {C:attention}Incomplete Joker{}, give",
            "{C:dark_edition}+#2#{} Joker slots and {X:mult,C:white}X#1#{} Mult",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 1,
	cost = 5,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "glue",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Xmult, center.ability.extra.j_slots } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            -- Add xmult if we have both Half and Incomplete Joker
            if next(find_joker("Half Joker")) and next(find_joker("incomplete")) then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_xmult",
                        vars = { card.ability.extra.Xmult }
                    },
                    Xmult_mod = card.ability.extra.Xmult
                }
            end
        end
	end,
    add_to_deck = function(self, card, from_debuff)
        -- Update Glue Variables
        if next(find_joker("Half Joker")) and next(find_joker("incomplete")) then
            card.ability.extra.triggered = true
            G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.j_slots
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        -- Reset Glue variables
        if card.ability.extra.triggered then
            card.ability.extra.triggered = false
            G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.j_slots
        end
    end,
    in_pool = function (self)
        if next(find_joker("incomplete")) or next(find_joker("Half Joker")) then
            return true
        end
        return false
    end
}

SMODS.Joker:take_ownership('j_half', {
    add_to_deck = function(self, card, from_debuff)
        -- Check for Glue Joker
        if next(find_joker("glue")) and next(find_joker("incomplete")) then
            local glue = find_joker("glue")[1]
            glue.ability.extra.triggered = true
            G.jokers.config.card_limit = G.jokers.config.card_limit + glue.ability.extra.j_slots
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        -- Check for Glue Joker
        if next(find_joker("glue")) and next(find_joker("incomplete")) then
            local glue = find_joker("glue")[1]
            glue.ability.extra.triggered = false
            G.jokers.config.card_limit = G.jokers.config.card_limit - glue.ability.extra.j_slots
        end
    end
}, true)

SMODS.Atlas{
	key = "harp_seal",
	path = "j_mmc_harp_seal.png",
	px = 71,
	py = 95,
}
local harp_seal = SMODS.Joker{
	name = "harp_seal",
	key = "harp_seal",
	config = { extra = { Xmult = 1.2 } },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Harp Seal",
        text = {
            "{C:attention}Doubles{} the effect",
            "of all {C:attention}Seals",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 2,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
	atlas = "harp_seal",
	loc_vars = function(self, info_queue, center)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
        -- Give $3 for each Gold Seal
        if context.individual and context.cardarea == G.play and not context.repetition then
            if context.other_card.seal == "Gold" and not context.other_card.debuff then
                ease_dollars(3)
                return {
                    message = localize("$") .. 3,
                    dollars = 3,
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end

        -- Repeat Red Seals
        if context.repetition and context.cardarea == G.play then
            if context.other_card.seal == "Red" and not context.other_card.debuff then
                return {
                    message = localize("k_again_ex"),
                    repetitions = 1,
                    card = card
                }
            end
        end
        if context.repetition and context.cardarea == G.hand then
            if context.other_card.seal == "Red" and (next(context.card_effects[1]) or #context.card_effects > 1) and not context.other_card.debuff then
                return {
                    message = localize("k_again_ex"),
                    repetitions = 1,
                    card = card
                }
            end
        end

        -- Create tarot card for each Purple Seal
        if context.discard then
            if context.other_card.seal == "Purple" and not context.other_card.debuff then
                -- Check consumeable space
                create_tarot(card, "harp_seal")
            end
        end
	end,
}

SMODS.Atlas{
	key = "football_card",
	path = "j_mmc_football_card.png",
	px = 71,
	py = 95,
}
local football_card = SMODS.Joker{
	name = "football_card",
	key = "football_card",
	config = {
        extra = {
            chips = 50
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Football Card",
        text = {
            "{C:blue}Common{} Jokers",
            "each give {C:chips}+#1#{} Chips"
        }
	},
	rarity = 2,
	cost = 7,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "football_card",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips } }
	end,
	calculate = function(self, card, context)
        if context.other_joker and context.other_joker ~= card then
            if context.other_joker.config.center.rarity == 1 then
                -- Animate
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_joker:juice_up(0.5, 0.5)
                        return true
                    end
                }))
                -- Apply chips
                return {
                    message = localize {
                        type = "variable",
                        key = "a_chips",
                        vars = { card.ability.extra.chips }
                    },
                    chip_mod = card.ability.extra.chips
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "special_edition",
	path = "j_mmc_special_edition.png",
	px = 71,
	py = 95,
}
local special_edition = SMODS.Joker{
	name = "special_edition",
	key = "special_edition",
	config = {
        extra = {
            current_mult = 0,
            mult_mod = 2,
            current_chips = 0,
            chip_mod = 10,
            current_Xmult = 1,
            Xmult_mod = 0.1,
            base = 0
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Special Edition Joker",
        text = {
            "Gains {C:mult}+#2#{} Mult per {C:attention}Seal{}, {C:chips}+#4#{}",
            "Chips per {C:attention}Enhancement{} and {X:mult,C:white}X#6#{} Mult",
            "per {C:attention}Edition{} for every card in deck",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult, {C:chips}+#3#{C:inactive}, Chips and {X:mult,C:white}X#5#{C:inactive} Mult)"
        }
	},
	rarity = 2,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "special_edition",
	loc_vars = function(self, info_queue, center)
		return { vars = {
            center.ability.extra.current_mult,
            center.ability.extra.mult_mod,
            center.ability.extra.current_chips,
            center.ability.extra.chip_mod,
            center.ability.extra.current_Xmult,
            center.ability.extra.Xmult_mod
         } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.extra.current_mult > 0 or card.ability.extra.current_chips > 0 or
            card.ability.extra.current_Xmult > 1 then
                return {
                    -- Return bonus message and apply bonus
                    mult_mod = card.ability.extra.current_mult,
                    chip_mod = card.ability.extra.current_chips,
                    Xmult_mod = card.ability.extra.current_Xmult,
                    message = localize("k_mmc_bonus"),
                    card = card
                }
            end
        end
	end,
    update = function(self, card)
        -- Reset defaults
        card.ability.extra.current_mult = 0
        card.ability.extra.current_chips = 0
        card.ability.extra.current_Xmult = 1
        -- Count all special cards
        if G.playing_cards then
            for _, v in pairs(G.playing_cards) do
                if v.seal ~= nil then
                    card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_mod
                end
                if v.ability.set == "Enhanced" then
                    card.ability.extra.current_chips = card.ability.extra.current_chips + card.ability.extra.chip_mod
                end
                if v.edition ~= nil then
                    card.ability.extra.current_Xmult = card.ability.extra.current_Xmult + card.ability.extra.Xmult_mod
                end
            end
        end
    end
}

SMODS.Atlas{
	key = "stockpiler",
	path = "j_mmc_stockpiler.png",
	px = 71,
	py = 95,
}
local stockpiler = SMODS.Joker{
	name = "stockpiler",
	key = "stockpiler",
	config = {
        extra = {
            current_h_size = 0,
            h_mod = 1,
            base = 52,
            every = 4
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "The Stockpiler",
        text = {
            "{C:attention}+#2#{} hand size for every #4#",
            "cards in deck above {C:attention}#3#{}",
            "Caps at the current Ante",
            "{C:inactive}(Currently {C:attention}+#1#{C:inactive} hand size)"
        }
	},
	rarity = 1,
	cost = 4,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "stockpiler",
	loc_vars = function(self, info_queue, center)
		return { vars = {
            center.ability.extra.current_h_size,
            center.ability.extra.h_mod,
            center.ability.extra.base,
            center.ability.extra.every
         } }
	end,
	calculate = function(self, card, context)
        if not context.repetition or context.individual then
            -- Increase hand size based on number of cards in deck
            local extra_cards = #G.playing_cards - card.ability.extra.base
            if extra_cards > 0 then
                local bonus = math.floor(extra_cards / card.ability.extra.every) * card.ability.extra.h_mod
                bonus = math.min(bonus, G.GAME.round_resets.ante)
                if bonus ~= card.ability.extra.current_h_size then
                    G.hand:change_size(bonus - card.ability.extra.current_h_size)
                    card.ability.extra.current_h_size = bonus
                end
            else
                -- Reset hand size
                if card.ability.extra.current_h_size > 0 then
                    G.hand:change_size(-card.ability.extra.current_h_size)
                    card.ability.extra.current_h_size = 0
                end
            end
        end
	end,
    remove_from_deck = function(self, card, from_debuff)
        -- Reset hand size
        G.hand:change_size(-card.ability.extra.current_h_size)
    end
}

SMODS.Atlas{
	key = "student_loans",
	path = "j_mmc_student_loans.png",
	px = 71,
	py = 95,
}
local student_loans = SMODS.Joker{
	name = "student_loans",
	key = "student_loans",
	config = {
        extra = {
            negative_bal = 100,
            every = 25,
            discards = 0,
            discard_sub = 1
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Student Loans",
        text = {
            "Go up to {C:red}-$#1#{} in debt",
            "Gives -#4# {C:red}discard{}",
            "for every {C:red}-$#2#{} in debt",
            "{C:inactive}(Currently {C:attention}#3#{C:inactive} discards)"
        }
	},
	rarity = 2,
	cost = 4,
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
	atlas = "student_loans",
	loc_vars = function(self, info_queue, center)
		return { vars = {
            center.ability.extra.negative_bal,
            center.ability.extra.every,
            center.ability.extra.discards,
            center.ability.extra.discard_sub
         } }
	end,
	add_to_deck = function(self, card, from_debuff)
        -- Lower bankrupt limit and discards
        G.GAME.bankrupt_at = G.GAME.bankrupt_at - card.ability.extra.negative_bal
    end,
    remove_from_deck = function(self, card, from_debuff)
        -- Reset bankrupt limit and discards
        G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extra.negative_bal
        ease_discard(-card.ability.extra.discards)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
    end,
    update = function(self, card)
        if card.added_to_deck then
            -- Decrease discards based on negative balance
            local negative_bal = G.GAME.dollars
            if negative_bal < 0 then
                local debuffs = math.floor(negative_bal / card.ability.extra.every) * card.ability.extra.discard_sub
                if debuffs ~= card.ability.extra.discards then
                    debuffs = debuffs - card.ability.extra.discards
                    ease_discard(debuffs)
                    G.GAME.round_resets.discards = G.GAME.round_resets.discards + debuffs
                    card.ability.extra.discards = card.ability.extra.discards + debuffs
                end
            elseif card.ability.extra.discards ~= 0 then
                -- Reset discards
                ease_discard(1)
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
                card.ability.extra.discards = 0
            end
        end
    end
}

SMODS.Atlas{
	key = "broke",
	path = "j_mmc_broke.png",
	px = 71,
	py = 95,
}
local broke = SMODS.Joker{
	name = "broke",
	key = "broke",
	config = {
        extra = {
            current_mult = 0,
            mult_mod = 1,
            every = 2
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Broke Joker",
        text = {
            "Gains {C:mult}+#1#{} Mult",
            "per {C:red}-$#3#",
            "{C:inactive}(Currently {C:mult}#2#{C:inactive} Mult)"
        }
	},
	rarity = 1,
	cost = 2,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "broke",
	loc_vars = function(self, info_queue, center)
		return { vars = { 
            center.ability.extra.mult_mod,
            center.ability.extra.current_mult,
            center.ability.extra.every
         } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            -- Apply mult
            if card.ability.extra.current_mult > 0 then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_mult",
                        vars = { card.ability.extra.current_mult }
                    },
                    mult_mod = card.ability.extra.current_mult,
                    card = card
                }
            end
        end
	end,
    update = function(self, card)
        -- Update mult based on negative balance
        local negative_bal = G.GAME.dollars
        if negative_bal < 0 then
            local new_mult = -1 * math.ceil(negative_bal / card.ability.extra.every) *
                card.ability.extra.mult_mod
            if card.ability.extra.current_mult ~= new_mult then
                card.ability.extra.current_mult = new_mult
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.0,
                    func = (function()
                        if card.added_to_deck then
                            card_eval_status_text(card, "extra", nil, nil, nil, {
                                message = localize {
                                    type = "variable",
                                    key = "a_mult",
                                    vars = { card.ability.extra.current_mult }
                                },
                                colour = G.C.MULT
                            })
                        end
                        return true
                    end)
                }))
            end
        elseif card.ability.extra.current_mult ~= 0 then
            -- Reset mult
            card.ability.extra.current_mult = 0
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.0,
                func = (function()
                    if card.added_to_deck then
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize {
                                type = "variable",
                                key = "a_mult",
                                vars = { card.ability.extra.current_mult }
                            },
                            colour = G.C.MULT
                        })
                    end
                    return true
                end)
            }))
        end
    end
}

SMODS.Atlas{
	key = "go_for_broke",
	path = "j_mmc_go_for_broke.png",
	px = 71,
	py = 95,
}
local go_for_broke = SMODS.Joker{
	name = "go_for_broke",
	key = "go_for_broke",
	config = {
        extra = {
            current_chips = 0,
            every = 1,
            chip_mod = 4
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Go For Broke",
        text = {
            "Gains {C:chips}+#1#{} Chips",
            "per {C:red}-$#3#",
            "{C:inactive}(Currently {C:chips}#2#{C:inactive} Chips)",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Wam"
        }
	},
	rarity = 1,
	cost = 4,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "go_for_broke",
	loc_vars = function(self, info_queue, center)
		return { vars = {
            center.ability.extra.chip_mod,
            center.ability.extra.current_chips,
            center.ability.extra.every
         } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            -- Apply chips
            if card.ability.extra.current_chips > 0 then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_chips",
                        vars = { card.ability.extra.current_chips }
                    },
                    chip_mod = card.ability.extra.current_chips,
                    card = card
                }
            end
        end
	end,
    update = function(self, card)
        -- Update chips based on negative balance
        local negative_bal = G.GAME.dollars
        if negative_bal < 0 then
            local new_chips = -1 * math.ceil(negative_bal / card.ability.extra.every) *
                card.ability.extra.chip_mod
            if card.ability.extra.current_chips ~= new_chips then
                card.ability.extra.current_chips = new_chips
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.0,
                    func = (function()
                        if card.added_to_deck then
                            card_eval_status_text(card, "extra", nil, nil, nil, {
                                message = localize {
                                    type = "variable",
                                    key = "a_chips",
                                    vars = { card.ability.extra.current_chips },
                                    delay = 0.0
                                },
                                colour = G.C.CHIPS
                            })
                        end
                        return true
                    end)
                }))
            end
        elseif card.ability.extra.current_chips ~= 0 then
            -- Reset chips
            card.ability.extra.current_chips = 0
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.0,
                func = (function()
                    if card.added_to_deck then
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize {
                                type = "variable",
                                key = "a_chips",
                                vars = { card.ability.extra.current_chips },
                                delay = 0.0
                            },
                            colour = G.C.CHIPS
                        })
                    end
                    return true
                end)
            }))
        end
    end
}

SMODS.Atlas{
	key = "street_fighter",
	path = "j_mmc_street_fighter.png",
	px = 71,
	py = 95,
}
local street_fighter = SMODS.Joker{
	name = "street_fighter",
	key = "street_fighter",
	config = {
        extra = {
            Xmult = 4,
            req = 20
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Street Fighter",
        text = {
            "Gives {X:mult,C:white}X#1#{} Mult",
            "when balance is",
            "at or below {C:red}-$#2#"
        }
	},
	rarity = 2,
	cost = 7,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "street_fighter",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.Xmult, center.ability.extra.req } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            -- Apply xmult if balance is below negative requirement
            if G.GAME.dollars <= -1 * card.ability.extra.req then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_xmult",
                        vars = { card.ability.extra.Xmult }
                    },
                    Xmult_mod = card.ability.extra.Xmult
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "checklist",
	path = "j_mmc_checklist.png",
	px = 71,
	py = 95,
}
local checklist = SMODS.Joker{
	name = "checklist",
	key = "checklist",
	config = {
        extra = {
            poker_hand = "High Card",
            increase = 1
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Checklist",
        text = {
            "Playing {C:attention}#1#{} upgrades",
            "it by #2# level,",
            "poker hand changes",
            "at end of round",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Gappie"
        }
	},
	rarity = 2,
	cost = 7,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "checklist",
	loc_vars = function(self, info_queue, center)
		return { vars = { localize(center.ability.extra.poker_hand, "poker_hands"), center.ability.extra.increase } }
	end,
	calculate = function(self, card, context)
        -- Level up poker hand
        if context.before and context.scoring_name == card.ability.extra.poker_hand then
            card_eval_status_text(card, "extra", nil, nil, nil, {
                message = localize("k_upgrade_ex")
            })
            level_up_hand(card, context.scoring_name, false, card.ability.extra.increase)
        end

        -- Get new random poker hand at end of round
        if context.end_of_round and not context.individual and
            not context.repetition and not context.blueprint then
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible and k ~= card.ability.extra.poker_hand then _poker_hands[#_poker_hands + 1] = k end
            end
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands, pseudoseed("checklist"))
            return {
                message = localize("k_reset")
            }
        end
	end,
    set_ability = function(self, card, initial, delay_sprites)
        local _poker_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.visible then _poker_hands[#_poker_hands + 1] = k end
        end
        local old_hand = card.ability.extra.poker_hand
        card.ability.extra.poker_hand = nil
        while not card.ability.extra.poker_hand do
            card.ability.extra.poker_hand = pseudorandom_element(_poker_hands,
                pseudoseed((card.area and card.area.config.type == "title") and "false_checklist" or "checklist"))
            if card.ability.extra.poker_hand == old_hand then card.ability.extra.poker_hand = nil end
        end
    end
}

SMODS.Atlas{
	key = "one_of_us",
	path = "j_mmc_one_of_us.png",
	px = 71,
	py = 95,
}
local one_of_us = SMODS.Joker{
	name = "one_of_us",
	key = "one_of_us",
	config = {
        extra = {
            req = 5
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "One Of Us",
        text = {
            "If played hand",
            "contains {C:attention}#1# Enhanced cards,",
            "give a random Joker",
            "a random {C:attention}Edition",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Gappie"
        }
	},
	rarity = 2,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "one_of_us",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.req } }
	end,
	calculate = function(self, card, context)
        if context.joker_main and context.full_hand then
            -- Count enhanced cards
            local enhanced_tally = 0
            for _, v in ipairs(context.full_hand) do
                if v.ability.set == "Enhanced" then
                    enhanced_tally = enhanced_tally + 1
                end
            end

            -- Check for required enhanced cards
            if enhanced_tally >= card.ability.extra.req then
                -- Get editionless Jokers
                local editionless_jokers = {}
                for _, v in pairs(G.jokers.cards) do
                    if v.ability.set == "Joker" and (not v.edition) then
                        table.insert(editionless_jokers, v)
                    end
                end
                -- Add edition to random Joker
                if #editionless_jokers > 0 then
                    local joker = pseudorandom_element(editionless_jokers, pseudoseed("one_of_us"))
                    local edition = poll_edition("one_of_us", nil, false, true)
                    -- Animate card
                    G.E_MANAGER:add_event(Event({
                        delay = 0.5,
                        func = function()
                            joker:juice_up(0.3, 0.5)
                            joker:set_edition(edition, true)
                            return true
                        end
                    }))
                    -- Return message
                    return {
                        message = localize("k_upgrade_ex"),
                        colour = G.C.SECONDARY_SET.Tarot
                    }
                end
            end
        end
	end,
}

SMODS.Atlas{
	key = "investor",
	path = "j_mmc_investor.png",
	px = 71,
	py = 95,
}
local investor = SMODS.Joker{
	name = "investor",
	key = "investor",
	config = {
        extra = {
            dollars = 5,
            odds = 4
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "The Investor",
        text = {
            "Gives {C:money}$#1#{} at end of",
            "round. {C:green}#3# in #2#{} chance to",
            "give {C:red}-$#1#{} instead"
        }
	},
	rarity = 1,
	cost = 4,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "investor",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.dollars, center.ability.extra.odds,
            "" .. (G.GAME and G.GAME.probabilities.normal or 1) } }
	end,
	calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
            -- Give money between min and max
            local dollars = card.ability.extra.dollars
            if pseudorandom("investor") < G.GAME.probabilities.normal / card.ability.extra.odds then
                dollars = dollars * -1
            end
            ease_dollars(dollars)
            -- Return message
            return {
                message = localize("$") .. dollars,
                dollars = dollars,
                colour = G.C.MONEY
            }
        end
	end,
}

SMODS.Atlas{
	key = "mountain_climber",
	path = "j_mmc_mountain_climber.png",
	px = 71,
	py = 95,
}
local mountain_climber = SMODS.Joker{
	name = "mountain_climber",
	key = "mountain_climber",
	config = { extra = { mult = 1 } },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Mountain Climber",
        text = {
            "Every played {C:attention}card{}",
            "permanently gains",
            "{C:mult}+#1#{} Mult when scored"
        }
	},
	rarity = 2,
	cost = 7,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "mountain_climber",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult
            card_eval_status_text(card, "extra", nil, nil, nil, {
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT,
            })
        end
	end,
}

SMODS.Atlas{
	key = "shackles",
	path = "j_mmc_shackles.png",
	px = 71,
	py = 95,
}
local shackles = SMODS.Joker{
	name = "shackles",
	key = "shackles",
	config = {
        extra = {
            _hand_add = 1,
            _h_size = 1,
            _discards = 1,
            req = 4
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Shackles",
        text = {
            "{C:blue}+#1#{} hand, {C:red}+#2#{} discard,",
            "{C:attention}+#3#{} hand size. Destroyed",
            "if you play more than",
            "{C:attention}#4#{} cards in one hand"
        }
	},
	rarity = 1,
	cost = 5,
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
	atlas = "shackles",
	loc_vars = function(self, info_queue, center)
		return { vars = {
            center.ability.extra._hand_add,
            center.ability.extra._discards,
            center.ability.extra._h_size,
            center.ability.extra.req
         } }
	end,
	calculate = function(self, card, context)
        if context.joker_main and context.full_hand then
            -- Destroy if more cards than required are played
            if #context.full_hand > card.ability.extra.req then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        card:start_dissolve()
                        return true
                    end
                }))
            end
        end
	end,
    add_to_deck = function(self, card, from_debuff)
        -- Add hands, discards and hand size
        ease_hands_played(card.ability.extra._hand_add)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra._hand_add
        ease_discard(card.ability.extra._discards)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra._discards
        G.hand:change_size(card.ability.extra._h_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        -- Remove hands, discards and hand size
        ease_hands_played(-card.ability.extra._hand_add)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra._hand_add
        ease_discard(-card.ability.extra._discards)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra._discards
        G.hand:change_size(-card.ability.extra._h_size)
    end
}

SMODS.Atlas{
	key = "buy_one_get_one",
	path = "j_mmc_buy_one_get_one.png",
	px = 71,
	py = 95,
}
local buy_one_get_one = SMODS.Joker{
	name = "buy_one_get_one",
	key = "buy_one_get_one",
	config = {
        extra = {
            odds = 4
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Buy One Get One",
        text = {
            "{C:green}#2# in #1#{} chance to",
            "get a random {C:attention}extra card{}",
            "of whatever you're buying",
            "{C:inactive}(Must have room)"
        }
	},
	rarity = 1,
	cost = 5,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "buy_one_get_one",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.odds, "" .. (G.GAME and G.GAME.probabilities.normal or 1) } }
	end,
	calculate = function(self, card, context)
        if context.buying_card then
            -- Calculate odds
            if pseudorandom("buy_one_get_one") < G.GAME.probabilities.normal / card.ability.extra.odds then
                if context.card.ability.set == "Joker" then
                    -- Give extra Joker
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if #G.jokers.cards < G.jokers.config.card_limit then
                                local card = create_card("Joker", G.jokers, nil, nil, nil, nil, nil,
                                    "buy_one_get_one")
                                card:add_to_deck()
                                G.jokers:emplace(card)
                                card:start_materialize()
                                card_eval_status_text(card, "extra", nil, nil, nil, {
                                    message = localize("k_plus_joker"),
                                    colour = G.C.BLUE
                                })
                            else
                                card_eval_status_text(card, "extra", nil, nil, nil, {
                                    message = localize("k_no_space_ex")
                                })
                            end
                            return true
                        end
                    }))
                elseif context.card.ability.set == "Tarot" then
                    -- Give extra Tarot card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if G.consumeables.config.card_limit > #G.consumeables.cards then
                                play_sound("timpani")
                                local card = create_card("Tarot", G.consumeables, nil, nil, nil, nil, nil,
                                    "buy_one_get_one")
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                card_eval_status_text(card, "extra", nil, nil, nil, {
                                    message = localize("k_plus_tarot"),
                                    colour = G.C.SECONDARY_SET.Tarot
                                })
                            else
                                card_eval_status_text(card, "extra", nil, nil, nil, {
                                    message = localize("k_no_space_ex")
                                })
                            end
                            return true
                        end
                    }))
                elseif context.card.ability.set == "Spectral" then
                    -- Give extra Spectral card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if G.consumeables.config.card_limit > #G.consumeables.cards then
                                play_sound("timpani")
                                local card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil,
                                    "buy_one_get_one")
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                card_eval_status_text(card, "extra", nil, nil, nil, {
                                    message = localize("k_plus_spectral"),
                                    colour = G.C.SECONDARY_SET.Spectral
                                })
                            else
                                card_eval_status_text(card, "extra", nil, nil, nil, {
                                    message = localize("k_no_space_ex")
                                })
                            end
                            return true
                        end
                    }))
                elseif context.card.ability.set == "Planet" then
                    G.E_MANAGER:add_event(Event({
                        -- Give extra Planet card
                        func = (function()
                            if G.consumeables.config.card_limit > #G.consumeables.cards then
                                local card = create_card("Planet", G.consumeables, nil, nil, nil, nil, nil,
                                    "buy_one_get_one")
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                card_eval_status_text(card, "extra", nil, nil, nil, {
                                    message = localize("k_plus_planet"),
                                    colour = G.C.SECONDARY_SET.Planet
                                })
                            else
                                card_eval_status_text(card, "extra", nil, nil, nil, {
                                    message = localize("k_no_space_ex")
                                })
                            end
                            return true
                        end)
                    }))
                elseif context.card.ability.set == "Default" then
                    -- Give extra Playing Card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local _card = create_playing_card({
                                front = pseudorandom_element(G.P_CARDS, pseudoseed("buy_one_get_one")),
                                center = G.P_CENTERS.c_base
                            }, G.deck, nil, nil, { G.C.SECONDARY_SET.Enhanced })
                            _card:add_to_deck()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            card_eval_status_text(card, "extra", nil, nil, nil, {
                                message = localize("k_mmc_plus_card"),
                                colour = G.C.Blue
                            })
                            return true
                        end
                    }))
                end
            else
                -- Nope!
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_nope_ex"),
                    colour = G.C.SECONDARY_SET.Tarot
                })
            end
        end
	end,
}

SMODS.Atlas{
	key = "pack_a_punch",
	path = "j_mmc_pack_a_punch.png",
	px = 71,
	py = 95,
}
local pack_a_punch = SMODS.Joker{
	name = "pack_a_punch",
	key = "pack_a_punch",
	config = {
        extra = {
            dollars = 20
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Pack A Punch",
        text = {
            "When {C:attention}Blind{} is selected,",
            "lose {C:money}$#1#{} and give the",
            "{C:attention}left-most{} Joker",
            "a random {C:attention}Edition",
            "{C:inactive}(Will replace current edition)"
        }
	},
	rarity = 3,
	cost = 10,
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
	atlas = "pack_a_punch",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.dollars } }
	end,
	calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced then
            local joker = G.jokers.cards[1]
            if joker then
                ease_dollars(-card.ability.extra.dollars)
                local edition = poll_edition("pack_a_punch", nil, false, true)
                -- Animate card
                G.E_MANAGER:add_event(Event({
                    delay = 0.5,
                    func = function()
                        -- Set Joker edition
                        joker:juice_up(0.3, 0.5)
                        if joker.edition and joker.edition.negative then
                            G.jokers.config.card_limit = G.jokers.config.card_limit - 1
                        end
                        joker:set_edition(edition, true)
                        -- Show message
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize("k_upgrade_ex")
                        })
                        -- Delete self if over Joker limit
                        if G.jokers.config.card_limit < #G.jokers.cards then
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    play_sound("tarot1")
                                    card:start_dissolve()
                                    return true
                                end
                            }))
                        end
                        return true
                    end
                }))
                -- Return message
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.SECONDARY_SET.Tarot
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "seal_steal",
	path = "j_mmc_seal_steal.png",
	px = 71,
	py = 95,
}
local seal_steal = SMODS.Joker{
	name = "seal_steal",
	key = "seal_steal",
	config = { },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Seal Steal",
        text = {
            "Played {C:purple}Purple{} and",
            "{C:blue}Blue{} Seals trigger",
            "when {C:attention}scored"
        }
	},
	rarity = 1,
	cost = 5,
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
	atlas = "seal_steal",
	loc_vars = function(self, info_queue, center)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.seal == "Purple" and not context.other_card.debuff then
                -- Check for Harp Seal
                local harp_seal
                for _, v in ipairs(find_joker("harp_seal")) do
                    harp_seal = v
                    break
                end
                create_tarot(card, "seal_steal")

                -- Repeat for Harp Seal
                if harp_seal then
                    -- Show Harp Seal message
                    card_eval_status_text(harp_seal, "extra", nil, nil, nil, {
                        message = localize("k_again_ex")
                    })
                    create_tarot(card, "seal_steal")
                end
            elseif context.other_card.seal == "Blue" and not context.other_card.debuff then
                -- Check for Harp Seal and Aurora Borealis
                local harp_seal
                local aurora_borealis
                for _, v in ipairs(G.jokers.cards) do
                    if v.ability.name == "harp_seal" then
                        harp_seal = v
                    elseif v.ability.name == "aurora_borealis" then
                        aurora_borealis = v
                    end
                end

                -- Add card
                create_planet(card, "seal_steal")
                if aurora_borealis then
                    create_planet(aurora_borealis, "seal_steal", { negative = true }, card)
                end

                -- Repeat for harp seal
                if harp_seal then
                    -- Show Harp Seal message
                    card_eval_status_text(harp_seal, "extra", nil, nil, nil, {
                        message = localize("k_again_ex")
                    })

                    -- Add card
                    create_planet(card, "seal_steal")
                    if aurora_borealis then
                        create_planet(aurora_borealis, "seal_steal", { negative = true }, card)
                    end
                end
            end
        end
	end,
}

SMODS.Atlas{
	key = "tax_collector",
	path = "j_mmc_tax_collector.png",
	px = 71,
	py = 95,
}
local tax_collector = SMODS.Joker{
	name = "tax_collector",
	key = "tax_collector",
	config = {
        extra = {
            dollars = 1
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Tax Collector",
        text = {
            "Gives {C:green}$#1#{}, {C:red}$#2#{} or {C:legendary}$#3#",
            "per Joker with the",
            "respective {C:attention}rarity",
            "at end of round"
        }
	},
	rarity = 1,
	cost = 4,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "tax_collector",
	loc_vars = function(self, info_queue, center)
		return { vars = {
            center.ability.extra.dollars,
            center.ability.extra.dollars * 2,
            center.ability.extra.dollars * 4
        }
    }
	end,
	calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
            for _, v in ipairs(G.jokers.cards) do
                -- Give dollars for every Joker, based on their rarity
                if v ~= card and type(v.config.center.rarity) == "number" and v.config.center.rarity > 1 then
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.7,
                        func = (function()
                            -- Give dollars
                            local dollars = card.ability.extra.dollars * (v.config.center.rarity - 1)
                            if v.config.center.rarity == 4 then
                                dollars = dollars + 1
                            end
                            ease_dollars(dollars, true)

                            -- Show message
                            card_eval_status_text(v, "extra", nil, nil, nil, {
                                message = localize("$") .. dollars,
                                dollars = dollars,
                                colour = G.C.MONEY,
                                instant = true
                            })

                            -- Animate cards
                            if v ~= card then
                                v:juice_up(0.5, 0.5)
                            end
                            card:juice_up(0.5, 0.5)
                            return true
                        end)
                    }))
                end
            end
        end
	end,
}

SMODS.Atlas{
	key = "glass_cannon",
	path = "j_mmc_glass_cannon.png",
	px = 71,
	py = 95,
}
local glass_cannon = SMODS.Joker{
	name = "glass_cannon",
	key = "glass_cannon",
	config = {
        extra = {
            repetitions = 1,
            trash_list = {}
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Glass Cannon",
        text = {
            "{C:attention}Retrigger{} all {C:attention}Glass",
            "{C:attention}Cards{}, but they are",
            "{C:red}guaranteed{} to break"
        }
	},
	rarity = 2,
	cost = 7,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "glass_cannon",
	loc_vars = function(self, info_queue, center)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
        -- Retrigger glass cards
        if context.repetition and context.cardarea == G.play then
            if context.other_card.ability.effect == "Glass Card" then
                return {
                    message = localize("k_again_ex"),
                    repetitions = card.ability.extra.repetitions,
                    card = card
                }
            end
        end

        -- Mark played glass cards
        if context.individual and context.cardarea == G.play and not context.repetition then
            if context.other_card.ability.effect == "Glass Card" then
                context.other_card.played = true
            end
        end

        -- Destroy played glass cards
        if context.joker_main and context.full_hand then
            for _, v in ipairs(context.full_hand) do
                if v.played then
                    G.E_MANAGER:add_event(Event({
                        trigger = "before",
                        delay = 0.9,
                        func = (function()
                            card_eval_status_text(card, "extra", nil, nil, nil, {
                                message = localize("k_mmc_destroy"),
                                colour = G.C.RED,
                                instant = true
                            })
                            table.insert(card.ability.extra.trash_list, v)
                            v:shatter()
                            return true
                        end)
                    }))
                end
            end
        end

        -- Clean up trash
        if context.end_of_round and not context.individual and not context.repetition then
            for _, v in ipairs(card.ability.extra.trash_list) do
                v:start_dissolve(nil, true, 0, true)
            end
            card.ability.extra.trash_list = {}
        end
	end,
}

SMODS.Atlas{
	key = "scoring_test",
	path = "j_mmc_scoring_test.png",
	px = 71,
	py = 95,
}
local scoring_test = SMODS.Joker{
	name = "scoring_test",
	key = "scoring_test",
	config = {
        extra = {
            percentage = 1,
            played_hand = {},
            trash_list = {}
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Scoring Test",
        text = {
            "If played hand",
            "scores less than {C:attention}#1#%",
            "of blind requirement",
            "{C:red}destroy{} it"
        }
	},
	rarity = 2,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
	atlas = "scoring_test",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.percentage } }
	end,
	calculate = function(self, card, context)
        if context.joker_main and context.full_hand then
            -- Get played hand
            card.ability.extra.played_hand = {}
            for _, v in ipairs(context.full_hand) do
                table.insert(card.ability.extra.played_hand, v)
            end
        end

        if context.mmc_scored_chips then
            if context.mmc_scored_chips < G.GAME.blind.chips * card.ability.extra.percentage / 100 then
                -- Destroy played hand if it's less than 1% of blind requirement
                for _, v in ipairs(card.ability.extra.played_hand) do
                    G.E_MANAGER:add_event(Event({
                        trigger = "before",
                        delay = 0.9,
                        func = (function()
                            card_eval_status_text(card, "extra", nil, nil, nil, {
                                message = localize("k_mmc_destroy"),
                                colour = G.C.RED,
                                instant = true
                            })
                            table.insert(card.ability.extra.trash_list, v)
                            v:start_dissolve()
                            return true
                        end)
                    }))
                end
            end
        end

        -- Clean up trash
        if context.end_of_round and not context.individual and not context.repetition then
            for _, v in ipairs(card.ability.extra.trash_list) do
                v:start_dissolve(nil, true, 0, true)
            end
            card.ability.extra.trash_list = {}
        end
	end,
}

SMODS.Atlas{
	key = "cicero",
	path = "j_mmc_cicero.png",
	px = 71,
	py = 95,
}
local cicero = SMODS.Joker{
	name = "cicero",
	key = "cicero",
	config = { },
	pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
	loc_txt = {
        name = "Cicero",
        text = {
            "Jokers that do not",
            "give {C:mult}Mult{}, {C:chips}Chips{} or",
            "{C:attention}retriggers{} will be",
            "{C:dark_edition}negative{} in the shop"
        }
	},
	rarity = 4,
	cost = 20,
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
	atlas = "cicero",
	loc_vars = function(self, info_queue, center)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
	end,
}

SMODS.Atlas{
	key = "dawn",
	path = "j_mmc_dawn.png",
	px = 71,
	py = 95,
}
local dawn = SMODS.Joker{
	name = "dawn",
	key = "dawn",
	config = { extra = { repetitions = 1 } },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Dawn",
        text = {
            "Retrigger all played",
            "cards in {C:attention}first",
            "{C:attention}hand{} of round"
        }
	},
	rarity = 2,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "dawn",
	loc_vars = function(self, info_queue, center)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
        -- Retrigger first hand
        if context.repetition and context.cardarea == G.play then
            if context.other_card and G.GAME.current_round.hands_played == 0 then
                return {
                    message = localize("k_again_ex"),
                    repetitions = card.ability.extra.repetitions,
                    card = card
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "savings",
	path = "j_mmc_savings.png",
	px = 71,
	py = 95,
}
local savings = SMODS.Joker{
	name = "savings",
	key = "savings",
	config = {
        extra = {
            mult_mod = 5,
            current_mult = 0
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Savings",
        text = {
            "{C:mult}+#1#{} Mult per round",
            "Resets when",
            "buying a {C:attention}card",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Flowr"
        }
	},
	rarity = 2,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "savings",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult_mod, center.ability.extra.current_mult } }
	end,
	calculate = function(self, card, context)
        -- Reset mult on purchase
        if context.buying_card and not context.blueprint then
            if card.ability.extra.current_mult ~= 0 then
                card.ability.extra.current_mult = 0
                -- Reset message
                card_eval_status_text(card, "extra", nil, nil, nil, {
                    message = localize("k_reset")
                })
            end
        end

        -- Apply mult
        if context.joker_main then
            if card.ability.extra.current_mult > 0 then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_mult",
                        vars = { card.ability.extra.current_mult }
                    },
                    mult_mod = card.ability.extra.current_mult,
                    card = card
                }
            end
        end

        -- Increase mult
        if context.end_of_round and not context.individual and
            not context.repetition and not context.blueprint then
                card.ability.extra.current_mult = card.ability.extra.current_mult + card.ability.extra.mult_mod
            return {
                message = localize {
                    type = "variable",
                    key = "a_mult",
                    vars = { card.ability.extra.mult_mod }
                },
                colour = G.C.RED,
                card = card
            }
        end
	end,
}

SMODS.Atlas{
	key = "title_deed",
	path = "j_mmc_title_deed.png",
	px = 71,
	py = 95,
}
local title_deed = SMODS.Joker{
	name = "title_deed",
	key = "title_deed",
	config = {
        extra = {
            current_Xmult = 1,
            _Xmult_mod = 0.5,
            _req = 10,
            _base = 10,
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Title Deed",
        text = {
            "{X:mult,C:white}X#1#{} Mult, gains",
            "{X:mult,C:white}X#2#{} Mult at {C:money}$#3#{},",
            "requirement doubles",
            "when met",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 3,
	cost = 10,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "title_deed",
	loc_vars = function(self, info_queue, center)
		return { vars = {
            center.ability.extra.current_Xmult,
            center.ability.extra._Xmult_mod,
            center.ability.extra._req
         } }
	end,
	calculate = function(self, card, context)
        -- Apply xmult
        if context.joker_main then
            if card.ability.extra.current_Xmult > 1 then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_xmult",
                        vars = { card.ability.extra.current_Xmult }
                    },
                    Xmult_mod = card.ability.extra.current_Xmult,
                    card = card
                }
            end
        end
	end,
    update = function(self, card)
        local bal = G.GAME.dollars
        if bal >= card.ability.extra._req then
            -- Increase Xmult and req
            card.ability.extra.current_Xmult = card.ability.extra.current_Xmult + card.ability.extra._Xmult_mod
            card.ability.extra._req = card.ability.extra._req * 2
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.0,
                func = (function()
                    if card.added_to_deck then
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize {
                                type = "variable",
                                key = "a_xmult",
                                vars = { card.ability.extra.current_Xmult }
                            },
                            colour = G.C.MULT
                        })
                    end
                    return true
                end)
            }))
        elseif card.ability.extra._req ~= card.ability.extra._base and
            bal < (card.ability.extra._req / 2) then
            -- Decrease Xmult and req
            card.ability.extra.current_Xmult = card.ability.extra.current_Xmult - card.ability.extra._Xmult_mod
            card.ability.extra._req = card.ability.extra._req / 2
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.0,
                func = (function()
                    if card.added_to_deck then
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize {
                                type = "variable",
                                key = "a_xmult",
                                vars = { card.ability.extra.current_Xmult }
                            },
                            colour = G.C.MULT
                        })
                    end
                    return true
                end)
            }))
        end
    end
}

SMODS.Atlas{
	key = "nebula",
	path = "j_mmc_nebula.png",
	px = 71,
	py = 95,
}
local nebula = SMODS.Joker{
	name = "nebula",
	key = "nebula",
	config = { extra = { req = 1 } },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Nebula",
        text = {
            "Adds all {C:attention}poker",
            "{C:attention}hand{} levels above",
            "#1# to {C:mult}Mult",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Gappie"
        }
	},
	rarity = 1,
	cost = 5,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "nebula",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.req } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
            -- Get level of all hands
            local _tally = 0
            for _, v in ipairs(G.handlist) do
                if G.GAME.hands[v].visible and G.GAME.hands[v].level > card.ability.extra.req then
                    _tally = _tally + G.GAME.hands[v].level - card.ability.extra.req
                end
            end
            -- Apply mult
            if _tally > 0 then
                return {
                    message = localize {
                        type = "variable",
                        key = "a_mult",
                        vars = { _tally }
                    },
                    mult_mod = _tally,
                    card = card
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "cheapskate",
	path = "j_mmc_cheapskate.png",
	px = 71,
	py = 95,
}
local cheapskate = SMODS.Joker{
	name = "cheapskate",
	key = "cheapskate",
	config = {
        extra = {
            cost = 0
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Cheapskate",
        text = {
            "If a {C:attention}Booster Pack",
            "is skipped, earn",
            "half of it's {C:money}cost"
        }
	},
	rarity = 1,
	cost = 4,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "cheapskate",
	loc_vars = function(self, info_queue, center)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
        if context.open_booster then
            card.ability.extra.cost = math.floor(context.card.cost / 2)
        end

        if context.skipping_booster then
            ease_dollars(card.ability.extra.cost)
            card_eval_status_text(card, "extra", nil, nil, nil, {
                message = localize("$") .. card.ability.extra.cost,
                dollars = card.ability.extra.cost,
                colour = G.C.MONEY
            })
        end
	end,
}

SMODS.Atlas{
	key = "psychic",
	path = "j_mmc_psychic.png",
	px = 71,
	py = 95,
}
local psychic = SMODS.Joker{
	name = "psychic",
	key = "psychic",
	config = {
        extra = {
            chips = 150,
            req = 5
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Psychic Joker",
        text = {
            "{C:chips}+#1#{} Chips, destroyed",
            "if you play less",
            "than {C:attention}#2#{} cards",
            "in one hand"
        }
	},
	rarity = 1,
	cost = 5,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "psychic",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips, center.ability.extra.req } }
	end,
	calculate = function(self, card, context)
        if context.joker_main and context.full_hand then
            -- Destroy if less cards than required are played
            if #context.full_hand < card.ability.extra.req then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound("tarot1")
                        card:start_dissolve()
                        return true
                    end
                }))
            else
                return {
                    message = localize {
                        type = "variable",
                        key = "a_chips",
                        vars = { card.ability.extra.chips }
                    },
                    chip_mod = card.ability.extra.chips
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "cheat",
	path = "j_mmc_cheat.png",
	px = 71,
	py = 95,
}
local cheat = SMODS.Joker{
	name = "cheat",
	key = "cheat",
	config = {
        extra = {
            repetitions = 1
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Cheat",
        text = {
            "Retrigger all cards",
            "if played hand",
            "contains a {C:attention}Straight{}",
        }
	},
	rarity = 2,
	cost = 6,
    unlocked = true,
    discovered = false,
	blueprint_compat = true,
	atlas = "cheat",
	loc_vars = function(self, info_queue, center)
		return { vars = { } }
	end,
	calculate = function(self, card, context)
        -- Retrigger hand if it contains a straight
        if context.repetition and context.cardarea == G.play then
            if context.other_card and context.poker_hands and next(context.poker_hands["Straight"]) then
                return {
                    message = localize("k_again_ex"),
                    repetitions = card.ability.extra.repetitions,
                    card = card
                }
            end
        end
	end,
}

SMODS.Atlas{
	key = "gym_membership",
	path = "j_mmc_gym_membership.png",
	px = 71,
	py = 95,
}
local gym_membership = SMODS.Joker{
	name = "gym_membership",
	key = "gym_membership",
	config = {
        extra = {
            increase = 1
        }
    },
	pos = { x = 0, y = 0 },
	loc_txt = {
        name = "Gym Membership",
        text = {
            "Increases rank",
            "of scored cards by",
            "{C:attention}#1#{} on the {C:attention}first",
            "{C:attention}hand{} of round",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
	},
	rarity = 3,
	cost = 8,
    unlocked = true,
    discovered = false,
	blueprint_compat = false,
	atlas = "gym_membership",
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.increase } }
	end,
	calculate = function(self, card, context)
        -- Upgrade ranks of first hand
        if context.individual and context.cardarea == G.play then
            if G.GAME.current_round.hands_played == 0 then
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.0,
                    func = (function()
                        -- Increase rank
                        local card = context.other_card
                        local suit_prefix = SMODS.Suits[card.base.suit].card_key .. "_"
                        local rank_suffix = card.base.id == 14 and 2 or math.min(card.base.id + 1, 14)
                        if rank_suffix < 10 then
                            rank_suffix = tostring(rank_suffix)
                        elseif rank_suffix == 10 then
                            rank_suffix = "T"
                        elseif rank_suffix == 11 then
                            rank_suffix = "J"
                        elseif rank_suffix == 12 then
                            rank_suffix = "Q"
                        elseif rank_suffix == 13 then
                            rank_suffix = "K"
                        elseif rank_suffix == 14 then
                            rank_suffix = "A"
                        end
                        card:set_base(G.P_CARDS[suit_prefix .. rank_suffix])
                        -- Show message
                        card_eval_status_text(card, "extra", nil, nil, nil, {
                            message = localize("k_upgrade_ex"),
                            instant = true
                        })
                        return true
                    end)
                }))
            end
        end
	end,
}

SMODS.Atlas{
	key = "incense",
	path = "c_mmc_incense.png",
	px = 71,
	py = 95,
}
local incense = SMODS.Consumable{
    key = 'incense',
    set = 'Spectral',
    pos = {
        x = 0,
        y = 0,
    },
    config = { extra = { dollars = 50, j_slots = 1, increase = 25 } },
    atlas = 'incense',
    loc_txt = {
        name = "Incense",
        text = {
            "Add {C:dark_edition}Negative{} to",
            "a random {C:attention}Joker{},",
            "{C:red}-$#1#{}, ignores",
            "spending limit",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
    },
    cost = 4,
    unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
        return  {vars = { G.GAME.mmc_incense_cost or card.ability.extra.dollars, card.ability.extra.j_slots }}
    end,
    can_use = function(self, card)
        for _, v in pairs(G.jokers.cards) do
            if v.ability.set == "Joker" and (not v.edition) then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        -- Get cost
        G.GAME.mmc_incense_cost = G.GAME.mmc_incense_cost or card.ability.extra.dollars
        -- Get editionless Jokers
        local editionless_jokers = {}
        for _, v in pairs(G.jokers.cards) do
            if v.ability.set == "Joker" and (not v.edition) then
                table.insert(editionless_jokers, v)
            end
        end
        -- Add negative to random Joker
        if #editionless_jokers > 0 then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    -- Set joker edition
                    local joker = pseudorandom_element(editionless_jokers, pseudoseed("incense"))
                    ease_dollars(-G.GAME.mmc_incense_cost)
                    card:juice_up(0.3, 0.5)
                    joker:set_edition({ negative = true }, true)
                    -- Change Cost
                    G.GAME.mmc_incense_cost = G.GAME.mmc_incense_cost + card.ability.extra.increase
                    return true
                end
            }))
        end
        delay(0.6)
    end,
}

SMODS.Atlas{
	key = "ace_of_pentacles",
	path = "c_mmc_ace_of_pentacles.png",
	px = 71,
	py = 95,
}
local ace_of_pentacles = SMODS.Consumable{
    key = "ace_of_pentacles",
    set = "Tarot",
    config = { extra = { odds = 4 } },
    pos = {
        x = 0,
        y = 0,
    },
    cost = 4,
    atlas = "ace_of_pentacles",
    loc_txt = {
        name = "Ace Of Pentacles",
        text = {
            "{C:red}#2# in #1#{} chance",
            "to set money to",
            "{C:money}$0{}, otherwise",
            "{C:attention}double{} your money",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
    },
    unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
        return {vars = { card.ability.extra.odds, "" .. (G.GAME and G.GAME.probabilities.normal or 1) }}
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        if pseudorandom("ace_of_pentacles") < G.GAME.probabilities.normal / card.ability.extra.odds then
            -- Nope!
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.4,
                func = function()
                    attention_text({
                        text = localize("k_nope_ex"),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and "tm" or
                            "cm",
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0 },
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = "after",
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound("tarot2", 0.76, 0.4); return true
                        end
                    }))
                    play_sound("tarot2", 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    ease_dollars(-G.GAME.dollars)
                    return true
                end
            }))
            delay(0.6)
        else
            -- Double money
            delay(0.6)
            ease_dollars(G.GAME.dollars)
        end
    end
}

SMODS.Atlas{
	key = "page_of_pentacles",
	path = "c_mmc_page_of_pentacles.png",
	px = 71,
	py = 95,
}
local page_of_pentacles = SMODS.Consumable{
    key = "page_of_pentacles",
    set = "Tarot",
    config = { },
    pos = {
        x = 0,
        y = 0,
    },
    cost = 4,
    atlas = "page_of_pentacles",
    loc_txt = {
        name = "Page Of Pentacles",
        text = {
            "Multiply",
            "money by {C:red}-1",
            "{C:inactive}Art by {C:green,E:1,S:1.1}Grassy"
        }
    },
    unlocked = true,
    discovered = false,
    loc_vars = function(self, info_queue, card)
        return {vars = { }}
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        -- Turn money into negative
        if G.GAME.dollars ~= 0 then
            delay(0.6)
            ease_dollars(-G.GAME.dollars * 2)
        end
    end
}

local function is_even(card)
    local id = card:get_id()
    return id <= 10 and id % 2 == 0
end

local function is_odd(card)
    local id = card:get_id()
    return (id % 2 ~= 0 and id < 10) or id == 14
end

local function is_fibo(card)
    local id = card:get_id()
    return id == 2 or id == 3 or id == 5 or id == 8 or id == 14
end

local function is_face(card)
    local id = card:get_id()
    return id == 11 or id == 12 or id == 13
end

local for_hire_counter = 1

SMODS.Back {
    key = 'evenStevenDeck',
    loc_txt = {
        name = "Even Steven's Deck",
        text = {
            "Start run with only",
            "{C:attention}even cards{} and",
            "the {C:attention}Even Steven{} joker"
        }
    },
    name = "Even Steven's Deck",
    --atlas = "decks",
    pos = {x = 5, y = 2},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Loop over all cards
                for i = #G.playing_cards, 1, -1 do
                    -- Remove odd cards
                    if not is_even(G.playing_cards[i]) then
                        G.playing_cards[i]:start_dissolve(nil, true)
                    end
                end

                -- Add Even Steven Joker
                add_joker("j_even_steven", nil, true, false)

                -- Return
                G.GAME.starting_deck_size = 20
                return true
            end
        }))
    end,
    unlocked = true,
}

SMODS.Back {
    key = 'oddToddDeck',
    loc_txt = {
        name = "Odd Todd's Deck",
        text = {
            "Start run with only",
            "{C:attention}odd cards{} and",
            "the {C:attention}Odd Todd{} joker"
        }
    },
    name = "Odd Todd's Deck",
    --atlas = "decks",
    pos = {x = 5, y = 2},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Loop over all cards
                for i = #G.playing_cards, 1, -1 do
                    -- Remove even cards
                    if not is_odd(G.playing_cards[i]) then
                        G.playing_cards[i]:start_dissolve(nil, true)
                    end
                end

                -- Add Odd Todd Joker
                add_joker("j_odd_todd", nil, true, false)

                -- Return
                G.GAME.starting_deck_size = 20
                return true
            end
        }))
    end,
    unlocked = true,
}

SMODS.Back {
    key = 'fibonacciDeck',
    loc_txt = {
        name = "Fibonacci Deck",
        text = {
            "Start run with only",
            "{C:attention}Fibonacci cards{} and",
            "the {C:attention}Fibonacci{} joker"
        }
    },
    name = "Fibonacci Deck",
    --atlas = "decks",
    pos = {x = 5, y = 2},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Loop over all cards
                for i = #G.playing_cards, 1, -1 do
                    -- Remove non fibonacci cards
                    if not is_fibo(G.playing_cards[i]) then
                        G.playing_cards[i]:start_dissolve(nil, true)
                    end
                end

                -- Add Fibonacci Joker
                add_joker("j_fibonacci", nil, true, false)

                -- Return
                G.GAME.starting_deck_size = 20
                return true
            end
        }))
    end,
    unlocked = true,
}

SMODS.Back {
    key = 'primeDeck',
    loc_txt = {
        name = "Prime Deck",
        text = {
            "Start run with",
            "only {C:attention}prime cards{} and",
            "the {C:attention}Prime Time{} joker"
        }
    },
    name = "Prime Deck",
    --atlas = "decks",
    pos = {x = 5, y = 2},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Loop over all cards
                for i = #G.playing_cards, 1, -1 do
                    -- Remove non prime cards
                    if not is_prime(G.playing_cards[i]) then
                        G.playing_cards[i]:start_dissolve(nil, true)
                    end
                end

                -- Add Prime Joker
                add_joker("j_mmc_prime_time", nil, true, false)

                -- Return
                G.GAME.starting_deck_size = 20
                return true
            end
        }))
    end,
    unlocked = true,
}

SMODS.Back {
    key = 'midasDeck',
    loc_txt = {
        name = "Midas's Deck",
        text = {
            "Start run with only",
            "{C:attention}Gold Face cards{} and",
            "the {C:attention}Midas Mask{} joker"
        }
    },
    name = "Midas's Deck",
    --atlas = "decks",
    pos = {x = 6, y = 0},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Loop over all cards
                for i = #G.playing_cards, 1, -1 do
                    if not is_face(G.playing_cards[i]) then
                        -- Remove non face cards
                        G.playing_cards[i]:start_dissolve(nil, true)
                    else
                        -- Set to gold
                        G.playing_cards[i]:set_ability(G.P_CENTERS.m_gold)
                    end
                end

                -- Add Midas Mask Joker
                add_joker("j_midas_mask", nil, true, false)

                -- Return
                G.GAME.starting_deck_size = 12
                return true
            end
        }))
    end,
    unlocked = true,
}

SMODS.Back {
    key = 'jokersForHireDeck',
    loc_txt = {
        name = "\"Jokers for Hire\" Deck",
        text = {
            "All Jokers give {C:dark_edition}+1{}",
            "Joker slot. Price of",
            "{C:attention}Jokers{} and {C:attention}Buffoon Packs",
            "{C:red}increases{} per Joker"
        }
    },
    name = "Jokers for Hire",
    --atlas = "decks",
    pos = {x = 6, y = 0},
    config = {
        mmc_for_hire = true
    },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Set joker slots to 1
                G.jokers.config.card_limit = 1

                -- Add effect to starting params
                G.GAME.starting_params.mmc_for_hire = true
                -- Reset counter
                for_hire_counter = 1
                return true
            end
        }))
    end,
    unlocked = true,
}

SMODS.Back {
    key = 'perfectPrecisionDeck',
    loc_txt = {
        name = "Perfect Precision Deck",
        text = {
            "+1 {C:blue}hands{}, {C:red}discards{} and",
            "{C:attention}hand size{}. Start with",
            "a {C:dark_edition}negative {C:attention}The Sniper{}",
            "Joker. Ante scales {C:attention}X1.5{}",
            "as fast"
        }
    },
    name = "Perfect Precision",
    config = {
        ante_scaling = 1.5,
        discards = 1,
        hands = 1,
        hand_size = 1
    },
    --atlas = "decks",
    pos = {x = 5, y = 2},
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Add The Sniper Joker
                add_joker("j_mika_sniper", "negative", true, false)
                return true
            end
        }))
    end,
    unlocked = true,
}

---Localization
G.localization.descriptions.Other.card_extra_mult = { text = { "{C:mult}+#1#{} extra Mult" } }
G.localization.misc.dictionary.k_mmc_charging = "Charging..."
G.localization.misc.dictionary.k_mmc_bonus = "Bonus!"
G.localization.misc.dictionary.k_mmc_hand_up = "+ Hand Size!"
G.localization.misc.dictionary.k_mmc_hand_down = "- Hand Size!"
G.localization.misc.dictionary.k_mmc_tick = "Tick..."
G.localization.misc.dictionary.k_mmc_plus_card = "Card!"
G.localization.misc.dictionary.k_mmc_luck = "+ Luck!"
G.localization.misc.dictionary.k_mmc_destroy = "Destroy!"

init_localization()

-- Stretch card back of odd shaped Jokers
local flip_ref = Card.flip
function Card:flip()
    local scale = 1
    local H = G.CARD_H
    local W = G.CARD_W

    if self.ability.name == "historical" then
        if self.facing == "front" then
            self.T.h = H * scale
            self.T.w = W * scale / 1.5 * scale
        else
            self.T.h = H * scale
            self.T.w = W * scale
        end
    end

    flip_ref(self)
end

-- Center odd shaped Jokers
local set_spritesref = Card.set_sprites
function Card:set_sprites(_center, _front)
    set_spritesref(self, _center, _front)

    local X, Y, W, H = self.T.x, self.T.y, self.T.w, self.T.h

    if _center then
        if _center.set then
            if _center.name == "incomplete" and (_center.discovered or self.bypass_discovery_center) then
                self.children.center.scale.y = self.children.center.scale.y / 1.7
                H = H / 1.7
                self.T.h = H
            end
        end
    end
end

-- Handle card addition/removing
local add_to_deckref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    if G.GAME.starting_params.mmc_for_hire and self.ability.set == "Joker" then
        -- Add Joker slot and increment counter
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
        for_hire_counter = for_hire_counter + 1
    end
    add_to_deckref(self, from_debuff)
end

local remove_from_deckref = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    if G.GAME.starting_params.mmc_for_hire and self.ability.set == "Joker" then
        -- Remove Joker slot and decrement counter
        G.jokers.config.card_limit = G.jokers.config.card_limit - 1
        for_hire_counter = for_hire_counter - 1
    end

    remove_from_deckref(self, from_debuff)
end

-- Handle cost increase
local set_costref = Card.set_cost
function Card:set_cost()
    set_costref(self)
    if G.GAME.starting_params.mmc_for_hire and
        (self.ability.set == "Joker" or string.find(self.ability.name, "Buffoon")) then
        -- Multiply cost linearly with counter

        self.cost = self.cost * for_hire_counter

        if self.ability.name == "Riff-raff" then
            -- No fun allowed
            self.cost = 1000000000
        end
    end
end

-- Set card edition
local set_edition_ref = Card.set_edition
function Card.set_edition(self, edition, immediate, silent)
    set_edition_ref(self, edition, immediate, silent)
    if G.jokers and self.ability then
        if not self.added_to_deck and self.ability.set == "Joker" and (self.edition == nil or not edition.negative) then
            if next(find_joker("cicero")) then
                local support = true
                for _, v in ipairs(G.localization.descriptions.Joker[self.config.center.key].text) do
                    support = support and
                        not (string.find(v:lower(), "mult") or string.find(v:lower(), "chips") or string.find(v:lower(), "retrigger"))
                end
                if (support and cicero_blacklist[self.ability.name] == nil) or cicero_whitelist[self.ability.name] ~= nil then
                    self:set_edition({ negative = true })
                end
            end
        end
    end
end

-- Calculate Chips
local evaluate_playref = G.FUNCS.evaluate_play
function G.FUNCS.evaluate_play(self, e)
    evaluate_playref(self, e)

    for i = 1, #G.jokers.cards do
        local effects = eval_card(G.jokers.cards[i], {
            card = G.consumeables,
            after = true,
            mmc_scored_chips = hand_chips * mult
        })
        if effects.jokers then
            card_eval_status_text(G.jokers.cards[i], "jokers", nil, 0.3, nil, effects.jokers)
        end
    end
end

-- Handle end of round card effects
local get_end_of_round_effectref = Card.get_end_of_round_effect
function Card.get_end_of_round_effect(self, context)
    -- Call base function
    local ret = get_end_of_round_effectref(self, context)

    if self.seal == "Blue" and not self.debuff then
        for _, v in pairs(G.jokers.cards) do
            -- Check for Aurora Borealis Joker and consumeable space
            if v.ability.name == "aurora_borealis" then
                -- Add card
                create_planet(v, "aurora_borealis", { negative = true })

                for _, v2 in pairs(G.jokers.cards) do
                    if v2.ability.name == "harp_seal" then
                        create_planet(v, "aurora_borealis", { negative = true }, v2)
                    end
                end
            end

            -- Create planet for each Blue Seal
            if v.ability.name == "harp_seal" then
                create_planet(v, "harp_seal")
            end
        end
    end

    -- Return result
    return ret
end

local get_chip_mult_ref = Card.get_chip_mult
function Card:get_chip_mult()
    if not SMODS.Mods["BetmmaSpells"] and self.ability.perma_mult then
        return self.ability.mult + self.ability.perma_mult
    end
    return get_chip_mult_ref(self)
end

local mod_path = SMODS.current_mod.path
-- JokerDisplay mod support
if _G["JokerDisplay"] then
	NFS.load(mod_path .. "Jokers_Definitions.lua")()
end

----------------------------------------------
------------MOD CODE END----------------------
