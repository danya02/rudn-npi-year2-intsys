(define (problem hurt_self) (:domain dota)
(:objects
;;<!--MAPLIST-->
)

(:init
    ;;<!--MAPRULES-->
    (phase hero_action)
    (is_next_phase hero_action enemy_action)
    (is_next_phase enemy_action hero_life_check)
    (is_next_phase hero_life_check earn_gold)
    (is_next_phase earn_gold hero_action)
    (is_next_phase hero_become_alive earn_gold)

    (= (buyback_cost) 50)
    (= (buyback_cooldown) 20)
    (= (death_timer) 50)
    (= (hero_health_cost) 5)
    (= (hero_attack_cost) 5)
    (= (tp_scroll_cost) 10)
    (= (tp_scroll_cooldown) 15)
    (= (healing_item_cost) 5)
    (= (healing_item_regen) 20)
    (= (fountain_regen) 50)

    (= (hero_attack) 1)
    (= (hero_gold) 30)
    
    (= (hero_tp_scrolls) 2)
    (= (hero_tp_scroll_cooldown) 0)
    (= (hero_healing_items) 0)
    (= (hero_death_timer) 0)
    (= (hero_buyback_cooldown) 0)


    (= (hero_hp) 20)
    (= (hero_max_hp) 100)
    (= (hero_alive) 1)
    (hero_at t0_0)
)

(:goal (and
    (= (hero_hp) 100)
    ;(= (hero_alive) 0)
    ;(phase earn_gold)
    (hero_at t0_0)

))
(:metric minimize (current_tick))

)
