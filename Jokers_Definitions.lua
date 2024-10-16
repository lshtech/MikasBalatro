local jd_def = JokerDisplay.Definitions

jd_def['j_mika_prime_time'] = {
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" }
    },
    calc_function = function(card)
        card.joker_display_values.localized_text = "(" .. localize("Ace", "ranks") .. ",7,5,3,2)"
    end
}

jd_def['j_mika_straight_nate'] = {
    text = {
        {
            border_nodes = {
                { text = 'X'},
                { ref_table = 'card.joker_display_values', ref_value = 'x_mult', retrigger_type = 'exp' },
            }
        }
    },
    calc_function = function (card)
        local _, poker_hands, _ = JokerDisplay.evaluate_hand()
        if poker_hands['Straight'] and next(poker_hands['Straight']) and (next(find_joker("Odd Todd")) and next(find_joker("Even Steven"))) or next(find_joker("Dynamic Duo")) then
            card.joker_display_values.x_mult = card.ability.extra.Xmult
        else
            card.joker_display_values.x_mult = 1
        end
    end
}

jd_def['j_mika_fisherman'] = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" }
    },
    text_config = { colour = G.C.WHITE },
    calc_function = function(card)
        local modifier = ""
        if card.ability.extra.current_h_size >= 0 then
            modifier = "+"
        end
        card.joker_display_values.localized_text = modifier .. card.ability.extra.current_h_size .. " Hand Size"
    end
}

jd_def['j_mika_impatient'] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT }
}

jd_def['j_mika_cultist'] = {
    text = {
        {
            border_nodes = {
                { text = 'X'},
                { ref_table = 'card.ability.extra', ref_value = 'current_Xmult', retrigger_type = 'exp' },
            }
        }
    }
}

jd_def['j_mika_seal_collector'] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "current_chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
}

jd_def['j_mika_scratch_card'] = {
    text = {
        { text = "+$" },
        { ref_table = 'card.joker_display_values', ref_value = "dollars" },
    },
    text_config = { colour = G.C.GOLD },
    calc_function = function(card)
        local _, _, scoring_hand = JokerDisplay.evaluate_hand()
        local seven_tally = 0
        local dollars = 0
        for _, scoring_card in pairs(scoring_hand) do
            if scoring_card:get_id() and scoring_card:get_id() == 7 then
                seven_tally = seven_tally + 1
            end
        end
        if seven_tally == 1 then
            dollars = card.ability.extra.base
        elseif seven_tally == 2 then
            dollars = card.ability.extra.base * 3
        elseif seven_tally == 3 then
            dollars = card.ability.extra.base * 10
        elseif seven_tally == 4 then
            dollars = card.ability.extra.base * 25
        elseif seven_tally >= 5 then
            dollars = card.ability.extra.base * 50
        end
        card.joker_display_values.dollars = dollars
    end
}

jd_def['j_mika_delayed'] = {
    text = {
        { text = "+",                              colour = G.C.CHIPS },
        { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" },
        { text = " +",                             colour = G.C.MULT },
        { ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult" },
        { text = " " },
        {
            border_nodes = {
                { text = 'X'},
                { ref_table = 'card.joker_display_values', ref_value = 'Xmult', retrigger_type = 'exp' },
            }
        }
    },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "countdown" }
    },
    calc_function = function(card)
        local chips, mult, Xmult = 0, 0, 1
        card.joker_display_values.countdown = (card.ability.extra.every - card.ability.extra.action_tally) .. " Turns Remaining"
        if card.ability.extra.action_tally == card.ability.extra.every then
            chips = card.ability.extra.chips
            mult = card.ability.extra.mult
            Xmult = card.ability.extra.Xmult
            card.joker_display_values.countdown = ""
        end
        card.joker_display_values.chips = chips
        card.joker_display_values.mult = mult
        card.joker_display_values.Xmult = Xmult
    end
}

jd_def['j_mika_showoff'] = {
    text = {
        {
            border_nodes = {
                { text = 'X'},
                { ref_table = 'card.ability.extra', ref_value = 'current_Xmult', retrigger_type = 'exp' },
            }
        }
    }
}

jd_def['j_mika_sniper'] = {
    text = {
        {
            border_nodes = {
                { text = 'X'},
                { ref_table = 'card.ability.extra', ref_value = 'current_Xmult', retrigger_type = 'exp' },
            }
        }
    }
}

jd_def['j_mika_blackjack'] = {
    text = {
        {
            border_nodes = {
                { text = 'X'},
                { ref_table = 'card.joker_display_values', ref_value = 'Xmult', retrigger_type = 'exp' },
            }
        }
    },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "ranks" }
    },
    calc_function = function(card)
        local ranks = 0
        local Xmult = 1
        if G.hand and G.hand.cards then
            for _, selected_card in ipairs(G.hand.cards) do
                if selected_card.highlighted then
                    if selected_card:get_id() then
                        if selected_card:get_id() <= 10 then
                            ranks = ranks + selected_card:get_id()
                        elseif selected_card:get_id() < 14 then
                            ranks = ranks + 10
                        end
                    end
                end
            end
            for _, selected_card in ipairs(G.hand.cards) do
                if selected_card.highlighted then
                    if selected_card:get_id() then
                        if selected_card:get_id() == 14 then
                            if ranks <= 10 then
                                ranks = ranks + 11
                            else
                                ranks = ranks + 1
                            end
                        end
                    end
                end
            end
        end
        local diff = card.ability.extra.req - ranks
        local new_Xmult = card.ability.extra.Xmult - diff * card.ability.extra.Xmult_mod
        -- Update Xmult if it is higher than saved Xmult, and score is not above the required score
        if diff >= 0 and new_Xmult > Xmult then
            Xmult = new_Xmult
        end
        card.joker_display_values.Xmult = Xmult
        card.joker_display_values.ranks = ranks
    end
}

jd_def['j_mika_batman'] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT }
}

jd_def['j_mika_bomb'] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "current_mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "countdown" }
    },
    calc_function = function(card)
        card.joker_display_values.countdown = card.ability.extra._every .. " Rounds Left"
    end
}

jd_def['j_mika_eye_chart'] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    calc_function = function(card)
        local chips = 0
        if G.jokers then
            for _,v in pairs(G.jokers.cards) do
                local ability_name = v.ability.name:lower()
                local count = 0
                for _ in ability_name:gmatch(card.ability.extra.letter:lower()) do
                    count = count + 1
                end
                chips = chips + (count * card.ability.extra.chips)
            end
        end
        card.joker_display_values.chips = chips
    end
}

jd_def['j_mika_drudgeful'] = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "current_chips"}
    },
    text_config = { colour = G.C.CHIPS }
}

jd_def['j_mika_suit_alley'] = {
    text = {
        { text = "+",                              colour = G.C.CHIPS },
        { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS, retrigger_type = "mult" },
        { text = " +",                             colour = G.C.MULT },
        { ref_table = "card.joker_display_values", ref_value = "mult",  colour = G.C.MULT,  retrigger_type = "mult" }
    },
    calc_function = function(card)
        local chips, mult = 0, 0        
        local _, _, scoring_hand = JokerDisplay.evaluate_hand()
        for _, scoring_card in pairs(scoring_hand) do
            if scoring_card:is_suit("Diamonds") or scoring_card:is_suit("Clubs") then
                -- Add chips if suit is Diamonds or Clubs
                chips = chips + card.ability.extra.chips
            end
            if scoring_card:is_suit("Hearts") or scoring_card:is_suit("Spades") then
                -- Add mult if Hearts or Spades
                mult = mult + card.ability.extra.mult
            end
        end

        card.joker_display_values.chips = chips
        card.joker_display_values.mult = mult
    end
}

jd_def['j_mika_training_wheels'] = {
    text = {
        {
            border_nodes = {
                { text = 'X'},
                { ref_table = 'card.ability.extra', ref_value = 'current_Xmult', retrigger_type = 'exp' },
            }
        }
    },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "countdown" }
    },
    calc_function = function(card)
        card.joker_display_values.countdown = card.ability.extra.card_count .. " Cards Scored"
    end
}

jd_def['j_mika_incomplete'] = {
    text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
    calc_function = function(card)
        local card_count = 0
        if G.hand and G.hand.cards then
            for _, selected_card in ipairs(G.hand.cards) do
                if selected_card.highlighted then
                    card_count = card_count + 1
                end
            end
        end
        if card_count < 1 or card_count > card.ability.extra.req then
            card.joker_display_values.chips = 0
        else
            card.joker_display_values.chips = card.ability.extra.chips
        end
    end
}

jd_def['j_mika_abbey_road'] = {
    text = {
        {
            border_nodes = {
                { text = 'X'},
                { ref_table = 'card.joker_display_values', ref_value = 'xmult', retrigger_type = 'exp' },
            }
        }
    },
    calc_function = function(card)
        if card.ability.extra.should_trigger then
            card.joker_display_values.xmult = card.ability.extra.Xmult
        else
            card.joker_display_values.xmult = 1
        end
    end
}

jd_def['j_mika_gold_bar'] = {
    text = {
        { text = "+$" },
        { ref_table = 'card.joker_display_values', ref_value = "dollars" },
    },
    text_config = { colour = G.C.GOLD },
    calc_function = function(card)
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
        card.joker_display_values.dollars = gold_tally * card.ability.extra.dollars
    end
}

jd_def['j_mika_glue'] = {
    text = {
        {
            border_nodes = {
                { text = 'X'},
                { ref_table = 'card.joker_display_values', ref_value = 'xmult', retrigger_type = 'exp' },
            }
        }
    },
    calc_function = function(card)
        if next(find_joker("Half Joker")) and next(find_joker("incomplete")) then
            card.joker_display_values.xmult = card.ability.extra.Xmult
        else
            card.joker_display_values.xmult = 1
        end
    end
}

