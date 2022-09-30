(define (problem hurt_self) (:domain dota)
(:objects
;;<!--MAPLIST-->
)

(:init
    ;;<!--NUMRULES-->
    ;;<!--MAPRULES-->
    (phase hero_action)
    (is_next_phase hero_action enemy_action)
    (is_next_phase enemy_action hero_life_check)
    (is_next_phase hero_life_check earn_gold)
    (is_next_phase earn_gold hero_action)
    (is_next_phase hero_become_alive earn_gold)

    (buyback_cost n50)
    (buyback_cooldown n20)
    (death_timer n50)
    (hero_health_cost n5)
    (hero_attack_cost n5)
    (tp_scroll_cost n10)
    (tp_scroll_cooldown n15)
    (healing_item_cost n5)
    (healing_item_regen n20)
    (fountain_regen n50)
    (hero_attack n1)
    (hero_gold n30)
    
    (update_timer_index n0)

    (hero_tp_scrolls n2)
    (hero_tp_scroll_cooldown n0)
    (hero_healing_items n0)
    (hero_death_timer n0)
    (hero_buyback_cooldown n0)
    (hero_hp n20)
    (hero_max_hp n100)
    (hero_alive n1)
    (hero_at t0_0)
)

(:goal (and
    (hero_hp n10)
    ;(= (hero_alive) 0)
    ;(phase earn_gold)
    ;(hero_at t0_0)

))
)
