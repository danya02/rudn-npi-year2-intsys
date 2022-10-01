(define (domain maze)
    (:requirements :typing)

(:types
    tile - object
    teleport_group - object
)


(:predicates
    (at ?x - tile) ;; the agent is at tile x
    (teleporter_at ?x - tile ?group - teleport_group) ;; there is a teleporter on tile x belonging to group
    (holding_item) ;; the agent is holding an item

    (adjacent ?x - tile ?y - tile) ;; tile x is adjacent to tile y
    (walkable ?x - tile) ;; tile x is walkable
)


(:action move
    ;; The agent moves from their current tile to an adjacent one
    :parameters (?x - tile ?y - tile)
    :precondition (and 
        (at ?x)
        (adjacent ?x ?y)
        (walkable ?y)
    )
    :effect (and
        (not (at ?x))
        (at ?y)
    )
)

(:action use_teleporter
    ;; The agent is standing at a tile that is a teleporter,
    ;; and teleport to another teleporter in the same group
    :parameters (
        ?current - tile
        ?target - tile
        ?group - teleport_group
    )
    :precondition (and
        (at ?current)
        (teleporter_at ?current ?group)
        (teleporter_at ?target ?group)
        (walkable ?target)
        (not (at ?target)) ;; This is so that the agent does not teleport to the tile they are in --
        ;; if this is not here, the agent may waste time trying to teleport to the same tile
    )
    :effect (and
        (not (at ?current))
        (at ?target)
    )
)
)
