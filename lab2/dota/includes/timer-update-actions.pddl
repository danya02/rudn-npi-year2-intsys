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