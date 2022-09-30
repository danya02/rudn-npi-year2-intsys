(:action hero_unalive
    ;; If the hero is at zero health and they are alive, they become dead.
    :parameters (
        ?next_phase - game_phase
        ?death_timer - enum
    )
    :precondition (and
        (hero_alive)
        (hero_hp n0)
        (phase hero_life_check)
        (is_next_phase hero_life_check ?next_phase)
        (death_timer ?death_timer)
    )
    :effect (and 
        (phase ?next_phase)
        (not (phase hero_life_check))
        (not (hero_alive))
        (hero_death_timer ?death_timer)
    )
)

(:action hero_stay_alive
    ;; The hero's health is not 0, so they stay alive.
    :parameters (
        ?next_phase - game_phase
        ?hero_hp - enum
        )
    :precondition (and
        (hero_alive)
        (hero_hp ?hero_hp)
        (greater_than ?hero_hp n0)
        (phase hero_life_check)
        (is_next_phase hero_life_check ?next_phase)
    )
    :effect (and 
        (phase ?next_phase)
        (not (phase hero_life_check))
    )
)

(:action hero_undeadify
    ;; If the hero is dead and the death timer is at zero
    ;; they become alive, their health is full, and they are positioned at a fountain tile.
    :parameters (
        ?fountain_tile - tile
    )
    :precondition (and 
        (phase hero_life_check)
        (not (hero_alive))
        (hero_death_timer n0)
        (fountain ?fountain_tile)
    )
    :effect (and 
        (not (phase hero_life_check))
        (phase hero_become_alive)
        (not (hero_death_timer n0))
    )
)

(:action hero_stay_dead
    ;; The hero is dead and the death timer is not at zero; the timer gets decremented.
    :parameters (
        ?next_phase - game_phase
        ?cur_death_timer - enum
        ?next_death_timer - enum
    )
    :precondition (and
        (phase hero_life_check)
        (is_next_phase hero_life_check ?next_phase)
        (not (hero_alive))
        (hero_death_timer ?cur_death_timer)
        (succ ?next_death_timer ?cur_death_timer)
    )
    :effect (and
        (not (hero_death_timer ?cur_death_timer))
        (hero_death_timer ?next_death_timer)
        (not (phase hero_life_check))
        (phase ?next_phase)
    )
)
