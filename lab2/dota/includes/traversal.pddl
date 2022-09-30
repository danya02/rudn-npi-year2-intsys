(:action teleport_with_scroll
    ;; The hero holds a TP scroll and uses it, teleporting them to a tile that is a teleportable tile and finishing their turn.
    :parameters (
        ?target_tile - tile
        ?prev_location - tile
        ?next_phase - game_phase
        ?hero_tp_scrolls_now - enum
        ?hero_tp_scrolls_after - enum
        ?tp_cooldown - enum
        )
    :precondition (and 
        (hero_at ?prev_location)
        (phase hero_action)
        (is_next_phase hero_action ?next_phase)
        (hero_tp_scrolls ?hero_tp_scrolls_now)
        (succ ?hero_tp_scrolls_after ?hero_tp_scrolls_now)
        (hero_tp_scroll_cooldown n0)
        (teleportable ?target_tile)
        (tp_scroll_cooldown ?tp_cooldown)
    )
    :effect (and 
        (hero_at ?target_tile)
        (not (hero_at ?prev_location))
        (not (hero_tp_scrolls ?hero_tp_scrolls_now))
        (hero_tp_scrolls ?hero_tp_scrolls_after)
        (not (hero_tp_scroll_cooldown n0))
        (hero_tp_scroll_cooldown ?tp_cooldown)
        (not (phase hero_action))
        (phase ?next_phase)
    )
)

(:action walk
    ;; The hero walks into an adjacent tile, finishing their turn.
    :parameters (?target_tile - tile ?prev_location - tile ?next_phase - game_phase)
    :precondition (and 
        (hero_at ?prev_location)
        (phase hero_action)
        (is_next_phase hero_action ?next_phase)
        (adjacent ?prev_location ?target_tile)
        (walkable ?target_tile)
    )
    :effect (and 
        (hero_at ?target_tile)
        (not (hero_at ?prev_location))
        (not (phase hero_action))
        (phase ?next_phase)
    )
)
