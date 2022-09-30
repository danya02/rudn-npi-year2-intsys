(:action hero_buy_tp
    ;; The hero is in the fountain and buys a TP scroll.
    :parameters (
        ?fountain_tile - tile
        ?hero_gold_now - enum
        ?hero_gold_after - enum
        ?tp_scroll_cost - enum
        ?tp_scrolls_now - enum
        ?tp_scrolls_after - enum
    )
    :precondition (and 
        (phase hero_action)
        (hero_at ?fountain_tile)
        (fountain ?fountain_tile)
        (hero_gold ?hero_gold_now)
        (hero_tp_scrolls ?tp_scrolls_now)
        (succ ?tp_scrolls_now ?tp_scrolls_after)
        (adds_to ?hero_gold_after ?tp_scroll_cost ?hero_gold_now)
    )
    :effect (and 
        (not (hero_gold ?hero_gold_now))
        (hero_gold ?hero_gold_after)
        (not (hero_tp_scrolls ?tp_scrolls_now))
        (hero_tp_scrolls ?tp_scrolls_after)
    )
)

(:action hero_buy_healing
    ;; The hero is in the fountain and buys a healing item.
    :parameters (
        ?fountain_tile - tile
        ?hero_gold_now - enum
        ?hero_gold_after - enum
        ?healing_cost - enum
        ?healing_now - enum
        ?healing_after - enum
    )
    :precondition (and 
        (phase hero_action)
        (hero_at ?fountain_tile)
        (fountain ?fountain_tile)
        (hero_gold ?hero_gold_now)
        (hero_healing_items ?healing_now)
        (succ ?healing_now ?healing_after)
        (adds_to ?hero_gold_after ?healing_cost ?hero_gold_now)
    )
    :effect (and 
        (not (hero_gold ?hero_gold_now))
        (hero_gold ?hero_gold_after)
        (not (hero_healing_items ?healing_now))
        (hero_healing_items ?healing_after)
    )
)