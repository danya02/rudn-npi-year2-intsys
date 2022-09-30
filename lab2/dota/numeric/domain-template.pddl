(define (domain dota)
    (:requirements :typing :negative-preconditions :numeric-fluents)

(:types
    hero - object
    u8 - object
    game_phase - object
    tile - object
)


(:constants
    hero_action - game_phase      ;; During this phase, the hero performs an action.
    hero_life_check - game_phase  ;; During this phase, the hero may change their life state. This must happen after the hero action.
    enemy_action - game_phase     ;; During this phase, the enemy performs an action.
    earn_gold - game_phase        ;; During this phase, the hero earns passive gold.
    update_timers - game_phase    ;; During this phase, the timers are updated.

    hero_become_alive - game_phase;; During this phase, the hero respawns
    ;; This is not part of the main cycle, but is instead used to gather code for respawning the hero.
)

(:functions
    ;; Global config
    (buyback_cost) - number  ;; How much does it cost to buyback
    (buyback_cooldown) - number  ;; How many turns does it take after one buyback
    (death_timer) - number  ;; How many turns spent dead until respawning
    (hero_health_cost) - number ;; How much does it cost to buy 1 health point
    (hero_attack_cost) - number   ;; How much does 1 point of attack cost
    (tp_scroll_cost) - number  ;; How much does it cost to buy a tp scroll
    (tp_scroll_cooldown) - number  ;; How many turns does it take to use a tp scroll again
    (healing_item_cost) - number  ;; How much does it cost to buy a healing item
    (healing_item_regen) - number  ;; How much health does a single healing item restore instantly
    (fountain_regen) - number  ;; How much health does the fountain restore per turn

    (hero_gold) - number ;; The amount of gold the hero has
    (hero_attack) - number ;; The amount of attack points the hero has

    (hero_tp_scrolls) - number ;; The amount of tp scrolls the hero has
    (hero_tp_scroll_cooldown) - number ;; The amount of turns left until the hero can use a tp scroll again

    (hero_buyback_cooldown) - number ;; The amount of turns left until the hero can buyback again
    (hero_healing_items) - number ;; The number of healing items the hero has

    (hero_hp) - number ;; The amount of health points the hero currently has
    (hero_max_hp) - number ;; The maximum amount of health points the hero can have

    (hero_death_timer) - number ;; The amount of turns left until the hero can respawn

    (hero_alive) - number
    ;; Whether the hero is alive (1) or not (0)
    ;; Using a function and not a predicate
    ;; because OPTIC can't handle negative preconditions.

    (current_tick) - number ;; The current tick of the game (increments by 1 at the end of the earn_gold phase)

    (update_timer_index) - number ;; The index of the timer currently being updated
)

(:predicates
    ;; Basic predicates
    (phase ?x - game_phase)             ;; the game is in phase X
    (is_next_phase ?a - game_phase ?b - game_phase) ;; B is the next phase after A

    ;; Map configuration
    (adjacent ?x - tile ?y - tile)      ;; X and Y are adjacent tiles.
    (teleportable ?x - tile)               ;; X is a valid teleport target.
    (fountain ?x - tile)                ;; X is in the fountain.
    (walkable ?x - tile)                    ;; X can be walked into.


    ;; Hero's state
    (hero_at ?t - tile)                ;; The hero is at tile T.
)


(:action hero_become_alive_phase
    ;; The hero is currently respawning
    :parameters (?next_phase - game_phase ?fountain_tile - tile)
    :precondition (and
        (phase hero_become_alive)
        (is_next_phase hero_become_alive ?next_phase)
        (fountain ?fountain_tile)
    )
    :effect (and 
        (phase ?next_phase)
        (not (phase hero_become_alive))
        (assign (hero_death_timer) 0)
        (assign (hero_hp) (hero_max_hp))
        (assign (hero_alive) 1)
        (hero_at ?fountain_tile)
    )
    )

(:action hero_hurt_self
    ;; The hero reduces their health by one point.
    ;; Because this is a strictly negative action, it is assumed that this will never occur in a plan.
    :parameters ()
    :precondition (and
        (= (hero_alive) 1)
        (phase hero_action)
    )
    :effect (and 
        (decrease (hero_hp) 1)
        ;; Does not change the game phase since this is an instant action.
    )
)

(:action hero_action_wait
    ;; The hero does not move and skips the turn.
    :parameters (?next_phase - game_phase)
    :precondition (and
        (= (hero_alive) 1)
        (phase hero_action)
        (is_next_phase hero_action ?next_phase)
    )
    :effect (and 
        (phase ?next_phase)
        (not (phase hero_action))
    )
)



(:action enemy_skip_turn
    ;; The enemy skips a turn.
    ;; NB: disable this action when there exists enemy behavior, because otherwise this will be picked often
    ;; because it is a better option than when the enemy performs harmful actions.
    :parameters (?next_phase - game_phase)
    :precondition (and 
        (phase enemy_action)
        (is_next_phase enemy_action ?next_phase)
    )
    :effect (and 
        (not (phase enemy_action))
        (phase ?next_phase)
    )
)

;<!--include-->;includes/passive-gold.pddl
;<!--include-->;includes/hero-life-check.pddl
;<!--include-->;includes/hero-dead-actions.pddl

;<!--include-->;includes/shopping.pddl
;<!--include-->;includes/traversal.pddl
;<!--include-->;includes/healing.pddl


;<!--include-->;includes/timer-update-actions.pddl

)

