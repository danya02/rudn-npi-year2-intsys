(:action hero_earns_gold
    ;; The hero's gold increases by one.
    :parameters (
        ?next_phase - game_phase
        ?current_gold - enum
        ?next_gold - enum
        ?current_tick - enum
        ?next_tick - enum
    )
    :precondition (and 
        (phase earn_gold)
        (is_next_phase earn_gold ?next_phase)
        (hero_gold ?current_gold)
        (greater_than n255 ?current_gold)

        (succ ?current_gold ?next_gold)
    )
    :effect (and 
        (not (hero_gold ?current_gold))
        (hero_gold ?next_gold)
        (not (phase earn_gold))
        (phase ?next_phase)
    )
)

(:action hero_gold_earn_cap
    ;; The hero's gold is equal to 255, so it does not increase.
    :parameters (?next_phase - game_phase)
    :precondition (and 
        (phase earn_gold)
        (is_next_phase earn_gold ?next_phase)
        (hero_gold n255)
    )
    :effect (and 
        (not (phase earn_gold))
        (phase ?next_phase)
    )
)
