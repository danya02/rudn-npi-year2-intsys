(define (domain dota)
    (:requirements :typing :negative-preconditions)

(:types
    hero - object
    enum - object
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

    ;;<!--NUMLIST-->
)

(:predicates
    ;; Basic predicates
    (phase ?x - game_phase)             ;; the game is in phase X
    (is_next_phase ?a - game_phase ?b - game_phase) ;; B is the next phase after A
    ;; <!--include-->;includes/predicates-enum.pddl
    ;; <!--include-->;includes/predicates-hero-state.pddl
    ;; <!--include-->;includes/predicates-global-config.pddl
    ;; <!--include-->;includes/predicates-map-config.pddl

)


(:action hero_become_alive_phase
    ;; The hero is currently respawning
    :parameters (
        ?next_phase - game_phase
        ?fountain_tile - tile
        ?old_death_timer - enum
        ?old_hero_hp - enum
        ?hero_max_hp - enum
        )
    :precondition (and
        (phase hero_become_alive)
        (is_next_phase hero_become_alive ?next_phase)
        (fountain ?fountain_tile)
        (hero_death_timer ?old_death_timer)
        (hero_hp ?old_hero_hp)
    )
    :effect (and 
        (not (phase hero_become_alive))
        (phase ?next_phase)
        (not (hero_death_timer ?old_death_timer))
        (hero_death_timer n0)
        (not (hero_hp ?old_hero_hp))
        (hero_hp ?hero_max_hp)
        (hero_alive)
        (hero_at ?fountain_tile)
    )
)

(:action hero_hurt_self
    ;; The hero reduces their health by one point.
    ;; Because this is a strictly negative action, it is assumed that this will never occur in a plan.
    :parameters (?hero_hp - enum ?hero_new_hp - enum)
    :precondition (and
        (hero_alive)
        (phase hero_action)
        (hero_hp ?hero_hp)
        (succ ?hero_new_hp ?hero_hp)
    )
    :effect (and 
        (not (hero_hp ?hero_hp))
        (hero_hp ?hero_new_hp)
        ;; Does not change the game phase since this is an instant action.
    )
)

(:action hero_action_wait
    ;; The hero does not move and skips the turn.
    :parameters (?next_phase - game_phase)
    :precondition (and
        (hero_alive)
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

