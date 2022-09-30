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

  n0 - enum
  n1 - enum
  n2 - enum
  n3 - enum
  n4 - enum
  n5 - enum
  n6 - enum
  n7 - enum
  n8 - enum
  n9 - enum
  n10 - enum
  n11 - enum
  n12 - enum
  n13 - enum
  n14 - enum
  n15 - enum
  n16 - enum
  n17 - enum
  n18 - enum
  n19 - enum
  n20 - enum
  n21 - enum
  n22 - enum
  n23 - enum
  n24 - enum
  n25 - enum
  n26 - enum
  n27 - enum
  n28 - enum
  n29 - enum
  n30 - enum
  n31 - enum
  n32 - enum
  n33 - enum
  n34 - enum
  n35 - enum
  n36 - enum
  n37 - enum
  n38 - enum
  n39 - enum
  n40 - enum
  n41 - enum
  n42 - enum
  n43 - enum
  n44 - enum
  n45 - enum
  n46 - enum
  n47 - enum
  n48 - enum
  n49 - enum
  n50 - enum
  n51 - enum
  n52 - enum
  n53 - enum
  n54 - enum
  n55 - enum
  n56 - enum
  n57 - enum
  n58 - enum
  n59 - enum
  n60 - enum
  n61 - enum
  n62 - enum
  n63 - enum
  n64 - enum
  n65 - enum
  n66 - enum
  n67 - enum
  n68 - enum
  n69 - enum
  n70 - enum
  n71 - enum
  n72 - enum
  n73 - enum
  n74 - enum
  n75 - enum
  n76 - enum
  n77 - enum
  n78 - enum
  n79 - enum
  n80 - enum
  n81 - enum
  n82 - enum
  n83 - enum
  n84 - enum
  n85 - enum
  n86 - enum
  n87 - enum
  n88 - enum
  n89 - enum
  n90 - enum
  n91 - enum
  n92 - enum
  n93 - enum
  n94 - enum
  n95 - enum
  n96 - enum
  n97 - enum
  n98 - enum
  n99 - enum
  n100 - enum
  n101 - enum
  n102 - enum
  n103 - enum
  n104 - enum
  n105 - enum
  n106 - enum
  n107 - enum
  n108 - enum
  n109 - enum
  n110 - enum
  n111 - enum
  n112 - enum
  n113 - enum
  n114 - enum
  n115 - enum
  n116 - enum
  n117 - enum
  n118 - enum
  n119 - enum
  n120 - enum
  n121 - enum
  n122 - enum
  n123 - enum
  n124 - enum
  n125 - enum
  n126 - enum
  n127 - enum
  n128 - enum
  n129 - enum
  n130 - enum
  n131 - enum
  n132 - enum
  n133 - enum
  n134 - enum
  n135 - enum
  n136 - enum
  n137 - enum
  n138 - enum
  n139 - enum
  n140 - enum
  n141 - enum
  n142 - enum
  n143 - enum
  n144 - enum
  n145 - enum
  n146 - enum
  n147 - enum
  n148 - enum
  n149 - enum
  n150 - enum
  n151 - enum
  n152 - enum
  n153 - enum
  n154 - enum
  n155 - enum
  n156 - enum
  n157 - enum
  n158 - enum
  n159 - enum
  n160 - enum
  n161 - enum
  n162 - enum
  n163 - enum
  n164 - enum
  n165 - enum
  n166 - enum
  n167 - enum
  n168 - enum
  n169 - enum
  n170 - enum
  n171 - enum
  n172 - enum
  n173 - enum
  n174 - enum
  n175 - enum
  n176 - enum
  n177 - enum
  n178 - enum
  n179 - enum
  n180 - enum
  n181 - enum
  n182 - enum
  n183 - enum
  n184 - enum
  n185 - enum
  n186 - enum
  n187 - enum
  n188 - enum
  n189 - enum
  n190 - enum
  n191 - enum
  n192 - enum
  n193 - enum
  n194 - enum
  n195 - enum
  n196 - enum
  n197 - enum
  n198 - enum
  n199 - enum
  n200 - enum
  n201 - enum
  n202 - enum
  n203 - enum
  n204 - enum
  n205 - enum
  n206 - enum
  n207 - enum
  n208 - enum
  n209 - enum
  n210 - enum
  n211 - enum
  n212 - enum
  n213 - enum
  n214 - enum
  n215 - enum
  n216 - enum
  n217 - enum
  n218 - enum
  n219 - enum
  n220 - enum
  n221 - enum
  n222 - enum
  n223 - enum
  n224 - enum
  n225 - enum
  n226 - enum
  n227 - enum
  n228 - enum
  n229 - enum
  n230 - enum
  n231 - enum
  n232 - enum
  n233 - enum
  n234 - enum
  n235 - enum
  n236 - enum
  n237 - enum
  n238 - enum
  n239 - enum
  n240 - enum
  n241 - enum
  n242 - enum
  n243 - enum
  n244 - enum
  n245 - enum
  n246 - enum
  n247 - enum
  n248 - enum
  n249 - enum
  n250 - enum
  n251 - enum
  n252 - enum
  n253 - enum
  n254 - enum
  n255 - enum
  n256 - enum
  n257 - enum
  n258 - enum
  n259 - enum
  n260 - enum
  n261 - enum
  n262 - enum
  n263 - enum
  n264 - enum
  n265 - enum
  n266 - enum
  n267 - enum
  n268 - enum
  n269 - enum
  n270 - enum
  n271 - enum
  n272 - enum
  n273 - enum
  n274 - enum
  n275 - enum
  n276 - enum
  n277 - enum
  n278 - enum
  n279 - enum
  n280 - enum
  n281 - enum
  n282 - enum
  n283 - enum
  n284 - enum
  n285 - enum
  n286 - enum
  n287 - enum
  n288 - enum
  n289 - enum
  n290 - enum
  n291 - enum
  n292 - enum
  n293 - enum
  n294 - enum
  n295 - enum
  n296 - enum
  n297 - enum
  n298 - enum
  n299 - enum
  n300 - enum
  n301 - enum
  n302 - enum
  n303 - enum
  n304 - enum
  n305 - enum
  n306 - enum
  n307 - enum
  n308 - enum
  n309 - enum
  n310 - enum
  n311 - enum
  n312 - enum
  n313 - enum
  n314 - enum
  n315 - enum
  n316 - enum
  n317 - enum
  n318 - enum
  n319 - enum
  n320 - enum
  n321 - enum
  n322 - enum
  n323 - enum
  n324 - enum
  n325 - enum
  n326 - enum
  n327 - enum
  n328 - enum
  n329 - enum
  n330 - enum
  n331 - enum
  n332 - enum
  n333 - enum
  n334 - enum
  n335 - enum
  n336 - enum
  n337 - enum
  n338 - enum
  n339 - enum
  n340 - enum
  n341 - enum
  n342 - enum
  n343 - enum
  n344 - enum
  n345 - enum
  n346 - enum
  n347 - enum
  n348 - enum
  n349 - enum
  n350 - enum
  n351 - enum
  n352 - enum
  n353 - enum
  n354 - enum
  n355 - enum
  n356 - enum
  n357 - enum
  n358 - enum
  n359 - enum
  n360 - enum
  n361 - enum
  n362 - enum
  n363 - enum
  n364 - enum
  n365 - enum
  n366 - enum
  n367 - enum
  n368 - enum
  n369 - enum
  n370 - enum
  n371 - enum
  n372 - enum
  n373 - enum
  n374 - enum
  n375 - enum
  n376 - enum
  n377 - enum
  n378 - enum
  n379 - enum
  n380 - enum
  n381 - enum
  n382 - enum
  n383 - enum
  n384 - enum
  n385 - enum
  n386 - enum
  n387 - enum
  n388 - enum
  n389 - enum
  n390 - enum
  n391 - enum
  n392 - enum
  n393 - enum
  n394 - enum
  n395 - enum
  n396 - enum
  n397 - enum
  n398 - enum
  n399 - enum
  n400 - enum
  n401 - enum
  n402 - enum
  n403 - enum
  n404 - enum
  n405 - enum
  n406 - enum
  n407 - enum
  n408 - enum
  n409 - enum
  n410 - enum
  n411 - enum
  n412 - enum
  n413 - enum
  n414 - enum
  n415 - enum
  n416 - enum
  n417 - enum
  n418 - enum
  n419 - enum
  n420 - enum
  n421 - enum
  n422 - enum
  n423 - enum
  n424 - enum
  n425 - enum
  n426 - enum
  n427 - enum
  n428 - enum
  n429 - enum
  n430 - enum
  n431 - enum
  n432 - enum
  n433 - enum
  n434 - enum
  n435 - enum
  n436 - enum
  n437 - enum
  n438 - enum
  n439 - enum
  n440 - enum
  n441 - enum
  n442 - enum
  n443 - enum
  n444 - enum
  n445 - enum
  n446 - enum
  n447 - enum
  n448 - enum
  n449 - enum
  n450 - enum
  n451 - enum
  n452 - enum
  n453 - enum
  n454 - enum
  n455 - enum
  n456 - enum
  n457 - enum
  n458 - enum
  n459 - enum
  n460 - enum
  n461 - enum
  n462 - enum
  n463 - enum
  n464 - enum
  n465 - enum
  n466 - enum
  n467 - enum
  n468 - enum
  n469 - enum
  n470 - enum
  n471 - enum
  n472 - enum
  n473 - enum
  n474 - enum
  n475 - enum
  n476 - enum
  n477 - enum
  n478 - enum
  n479 - enum
  n480 - enum
  n481 - enum
  n482 - enum
  n483 - enum
  n484 - enum
  n485 - enum
  n486 - enum
  n487 - enum
  n488 - enum
  n489 - enum
  n490 - enum
  n491 - enum
  n492 - enum
  n493 - enum
  n494 - enum
  n495 - enum
  n496 - enum
  n497 - enum
  n498 - enum
  n499 - enum
  n500 - enum
  n501 - enum
  n502 - enum
  n503 - enum
  n504 - enum
  n505 - enum
  n506 - enum
  n507 - enum
  n508 - enum
  n509 - enum
  n510 - enum
  n511 - enum
)

(:predicates
    ;; Basic predicates
    (phase ?x - game_phase)             ;; the game is in phase X
    (is_next_phase ?a - game_phase ?b - game_phase) ;; B is the next phase after A
(succ ?n ?m) ;; M = N+1
(adds_to ?x ?y ?z) ;; X+Y = Z
(greater_than ?x ?y) ;; X > Y
(overflows ?x ?y)  ;; X+Y overflows
(hero_gold ?x - enum) ;; hero has x gold
(hero_attack ?x - enum) ;; hero has x attack
(hero_tp_scrolls ?x - enum) ;; hero has x teleport scrolls
(hero_tp_scroll_cooldown ?x - enum) ;; hero has x teleport scroll cooldown
(hero_buyback_cooldown ?x - enum) ;; hero has x buyback cooldown
(hero_healing_items ?x - enum) ;; hero has x healing items
(hero_death_timer ?x - enum) ;; hero has x death timer
(current_tick ?x - enum) ;; current tick
(update_timer_index ?x - enum) ;; update timer index

(hero_at ?t - tile) ;; hero is at tile t
(hero_alive) ;; hero is alive

(hero_hp ?x - enum) ;; hero has x hp
(hero_max_hp ?x - enum) ;; hero has x max hp
(buyback_cost ?x - enum) ;; buyback costs X
(buyback_cooldown ?x - enum) ;; buyback cooldown is X
(death_timer ?x - enum) ;; death timer is X
(hero_health_cost ?x - enum) ;; hero health cost is X
(hero_attack_cost ?x - enum) ;; hero attack cost is X
(tp_scroll_cost ?x - enum) ;; tp scroll cost is X
(tp_scroll_cooldown ?x - enum) ;; tp scroll cooldown is X
(healing_item_cost ?x - enum) ;; healing item cost is X
(healing_item_regen ?x - enum) ;; healing item regen is X
(fountain_regen ?x - enum) ;; fountain regen is X
    (adjacent ?x - tile ?y - tile)      ;; X and Y are adjacent tiles.
    (teleportable ?x - tile)               ;; X is a valid teleport target.
    (fountain ?x - tile)                ;; X is in the fountain.
    (walkable ?x - tile)                    ;; X can be walked into.

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


(:action start_updating_timers
    ;; The timer update is to begin now.
    :parameters ()
    :precondition (and
        (phase update_timers)
        (update_timer_index n0)
    )
    :effect (and
        (not (update_timer_index n0))
        (update_timer_index n99)
    )
)

(:action finish_updating_timers
    ;; The timer update is to finish now.
    :parameters (?next_phase - game_phase)
    :precondition (and
        (phase update_timers)
        (update_timer_index n99)
        (is_next_phase update_timers ?next_phase)
    )
    :effect (and
        (not (update_timer_index n99))
        (update_timer_index n0)
        (not (phase update_timers))
        (phase ?next_phase)
    )
)

)

