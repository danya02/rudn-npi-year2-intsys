(:action hero_death_turn
    ;; The hero is dead and not buying back.
    :parameters (
        ?next_phase - game_phase
        )
    :precondition (and
        (phase hero_action)  ;; Currently in the hero action phase
        (is_next_phase hero_action ?next_phase)  ;; Get the next phase
        (not (hero_alive))
    )
    :effect (and
        (phase ?next_phase)  ;; Set the next phase
        (not (phase hero_action))  ;; Set the next phase
    )
)

(:action hero_death_buyback
    ;; The hero is dead and buying back.
    :parameters (
        ?next_phase - game_phase     ;; The next phase
        ?bb_cost - enum
        ?hero_gold_now - enum
        ?hero_gold_after - enum
        ?bb_cd - enum
    )
    :precondition (and
        (phase hero_action)
        (is_next_phase hero_action ?next_phase)  ;; Get the next phase
        (not (hero_alive))
        (hero_buyback_cooldown n0)  ;; The hero's buyback cooldown is 0
        (buyback_cooldown ?bb_cd)
        (buyback_cost ?bb_cost)
        (hero_gold ?hero_gold_now)
        (adds_to ?hero_gold_after ?bb_cost ?hero_gold_now)
    )
    :effect (and 
        (not (phase hero_life_check))
        (phase hero_become_alive)

        (not (hero_buyback_cooldown n0))
        (hero_buyback_cooldown ?bb_cd)

        (not (hero_gold ?hero_gold_now))
        (hero_gold ?hero_gold_after)

    )
)
