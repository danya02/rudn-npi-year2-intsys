(define (domain maze)
    (:requirements :typing)

(:types
    tile - object
    teleport_group - object
    block_group - object
)


(:predicates
    (at ?x - tile) ;; the agent is at tile x
    (teleporter_at ?x - tile ?group - teleport_group) ;; there is a teleporter on tile x belonging to group
    (holding_item) ;; the agent is holding an item

    (adjacent ?x - tile ?y - tile) ;; tile x is adjacent to tile y
    (walkable ?x - tile) ;; tile x is walkable
    
    (block_at ?x - tile ?group - block_group) ;; there is a block on tile x belonging to group
    (block_target_at ?x - tile ?group - block_group) ;; there is a block target on tile x belonging to group
    (holding_block ?group - block_group) ;; the agent is holding a block belonging to group
    (item_at ?x - tile) ;; there is an item on tile x

    (holding_tp ?group - teleport_group) ;; the agent is holding a teleporter belonging to group
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

(:action pick_up_block
    ;; The agent is standing at a tile where there is a block,
    ;; and starts holding the block
    :parameters (
        ?x - tile
        ?block - block_group)
    :precondition (and
        (at ?x)
        (item_at ?x)
        (block_at ?x ?block)
        (not (holding_item))
    )
    :effect (and
        (not (block_at ?x ?block))
        (not (item_at ?x))
        (holding_block ?block)
        (holding_item)
    )
)

(:action drop_block
    ;; The agent is holding a block,
    ;; and drops the block at the current tile
    :parameters (
        ?x - tile
        ?block - block_group)
    :precondition (and
        (at ?x)
        (holding_block ?block)
        (holding_item)
        (not (item_at ?x))
        (not (block_at ?x ?block))
    )
    :effect (and
        (block_at ?x ?block)
        (item_at ?x)
        (not (holding_block ?block))
        (not (holding_item))
    )
)

(:action pick_up_tp
    ;; The agent is picking up a portal
    :parameters (
        ?x - tile
        ?group - teleport_group)
    :precondition (and
        (at ?x)
        (item_at ?x)
        (teleporter_at ?x ?group)
        (not (holding_item))
    )
    :effect (and
        (not (teleporter_at ?x ?group))
        (not (item_at ?x))
        (holding_item)
        (holding_tp ?group)

    )
)

(:action drop_tp
    ;; The agent is dropping a held portal
    :parameters (
        ?x - tile
        ?group - teleport_group
    )
    :precondition (and
        (at ?x)
        (not (item_at ?x))
        (holding_item)
        (holding_tp ?group)
    )
    :effect (and
        (teleporter_at ?x ?group)
        (item_at ?x)
        (not (holding_item))
        (not (holding_tp ?group))
    )
)
)