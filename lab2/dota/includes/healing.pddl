(:action hero_heal_with_item_not_full
    ;; The hero holds a healing item and uses it, restoring the hero's health by the healing item's amount (but not to full HP).
    :parameters (
        ?hero_hp_now - enum
        ?hero_hp_after - enum
        ?hero_max_hp - enum
        ?healing_items_now - enum
        ?healing_items_after - enum
        ?healing_item_regen - enum

    )
    :precondition (and
        (phase hero_action)
        (hero_healing_items ?healing_items_now)  ;; Now have `healing_items_now` healing items.
        (succ ?healing_items_after ?healing_items_now)  ;; After using the healing item, we have `healing_items_after` healing items.
        (hero_hp ?hero_hp_now)  ;; Now have `hero_hp_now` HP.
        (hero_max_hp ?hero_max_hp)  ;; Maximum HP is `hero_max_hp`.
        (healing_item_regen ?healing_item_regen)
        (adds_to ?hero_hp_now ?healing_item_regen ?hero_hp_after)  ;; After using the healing item, we have `hero_hp_after` HP.
        (not (greater_than ?hero_hp_after ?hero_max_hp)) ;; `hero_hp_after` is not greater than `hero_max_hp`.
    )
    :effect (and 
        (not (hero_hp ?hero_hp_now)) 
        (hero_hp ?hero_hp_after)  ;; After using the healing item, we have `hero_hp_after` HP.
        (not (hero_healing_items ?healing_items_now))
        (hero_healing_items ?healing_items_after)  ;; After using the healing item, we have `healing_items_after` healing items.
    )
)

(:action hero_heal_with_item_full
    ;; The hero uses a healing item to cap their HP at the maximum.
    :parameters (
        ?hero_hp_now - enum
        ?hero_hp_after - enum
        ?hero_max_hp - enum
        ?healing_items_now - enum
        ?healing_items_after - enum
        ?healing_item_regen - enum

    )
    :precondition (and
        (phase hero_action)
        (hero_healing_items ?healing_items_now)  ;; Now have `healing_items_now` healing items.
        (succ ?healing_items_after ?healing_items_now)  ;; After using the healing item, we have `healing_items_after` healing items.
        (hero_hp ?hero_hp_now)  ;; Now have `hero_hp_now` HP.
        (hero_max_hp ?hero_max_hp)  ;; Maximum HP is `hero_max_hp`.
        (healing_item_regen ?healing_item_regen)
        (adds_to ?hero_hp_now ?healing_item_regen ?hero_hp_after)  ;; After using the healing item, we have `hero_hp_after` HP.
        (greater_than ?hero_hp_after ?hero_max_hp) ;; `hero_hp_after` is greater than `hero_max_hp`.
    )
    :effect (and 
        (not (hero_hp ?hero_hp_now)) 
        (hero_hp ?hero_max_hp)  ;; After using the healing item, we have `hero_max_hp` HP.
        (not (hero_healing_items ?healing_items_now))
        (hero_healing_items ?healing_items_after)  ;; After using the healing item, we have `healing_items_after` healing items.
    )
)

(:action hero_heal_at_fountain_not_full
    ;; The hero spends their turn waiting at the fountain, restoring their HP by the fountain's amount (but not to full HP).
    :parameters (
        ?hero_hp_now - enum
        ?hero_hp_after - enum
        ?hero_max_hp - enum
        ?fountain_regen - enum
        ?fountain_tile - tile
        ?next_phase - game_phase
    )
    :precondition (and
        (phase hero_action)
        (hero_at ?fountain_tile)  ;; The hero is at the fountain.
        (fountain ?fountain_tile)  ;; The fountain is at the fountain tile.
        (fountain_regen ?fountain_regen)  ;; The fountain gives `fountain_regen` HP per turn.
        (hero_hp ?hero_hp_now)  ;; Now have `hero_hp_now` HP.
        (hero_max_hp ?hero_max_hp)  ;; Maximum HP is `hero_max_hp`.
        (adds_to ?hero_hp_now ?fountain_regen ?hero_hp_after)  ;; After waiting at the fountain, we would have `hero_hp_after` HP.
        (not (greater_than ?hero_hp_after ?hero_max_hp)) ;; `hero_hp_after` is not greater than `hero_max_hp`.
        (is_next_phase hero_action ?next_phase)
    )
    :effect (and 
        (not (hero_hp ?hero_hp_now)) 
        (hero_hp ?hero_hp_after)  ;; After waiting at the fountain, we have `hero_hp_after` HP.
        (not (phase hero_action))
        (phase ?next_phase)
    )
)

(:action hero_heal_at_fountain_full
    ;; The hero spends their turn waiting at the fountain, capping their HP at the maximum.
    :parameters (
        ?hero_hp_now - enum
        ?hero_hp_after - enum
        ?hero_max_hp - enum
        ?fountain_regen - enum
        ?fountain_tile - tile
        ?next_phase - game_phase
    )
    :precondition (and
        (phase hero_action)
        (hero_at ?fountain_tile)  ;; The hero is at the fountain.
        (fountain ?fountain_tile)  ;; The fountain is at the fountain tile.
        (fountain_regen ?fountain_regen)  ;; The fountain gives `fountain_regen` HP per turn.
        (hero_hp ?hero_hp_now)  ;; Now have `hero_hp_now` HP.
        (hero_max_hp ?hero_max_hp)  ;; Maximum HP is `hero_max_hp`.
        (adds_to ?hero_hp_now ?fountain_regen ?hero_hp_after)  ;; After waiting at the fountain, we would have `hero_hp_after` HP.
        (greater_than ?hero_hp_after ?hero_max_hp) ;; `hero_hp_after` is greater than `hero_max_hp`.
        (is_next_phase hero_action ?next_phase)
    )
    :effect (and 
        (not (hero_hp ?hero_hp_now)) 
        (hero_hp ?hero_max_hp)  ;; After waiting at the fountain, we have `hero_max_hp` HP.
        (not (phase hero_action))
        (phase ?next_phase)
    )
)
