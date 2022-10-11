(define (domain maze)
    (:requirements :typing)

(:types
    location - type
    tile - location

    group - type
    teleport_group - group
    block_group - group

    robot - object
)
(:constants
    bgroup_colorless - block_group
    tgroup_unpaired - teleport_group
)


(:predicates
    (at ?r - robot ?x - tile) ;; the agent is at tile x
    (teleporter_at ?x - tile ?group - teleport_group) ;; there is a teleporter on tile x belonging to group
    (holding_item ?r - robot) ;; the agent is holding an item

    (adjacent ?x - tile ?y - tile) ;; tile x is adjacent to tile y
    (walkable ?x - tile) ;; tile x is walkable
    
    (block_at ?x - tile ?group - block_group) ;; there is a block on tile x belonging to group
    (block_target_at ?x - tile ?group - block_group) ;; there is a block target on tile x belonging to group
    (holding_block ?r - robot ?group - block_group) ;; the agent is holding a block belonging to group
    (item_at ?x - tile) ;; there is an item on tile x (i.e. you cannot place an item on this tile)

    (holding_tp ?r - robot ?group - teleport_group) ;; the agent is holding a teleporter belonging to group

    (color_remover_machine_at ?x - tile) ;; there is a color remover machine on tile x
    (color_assigner_machine_at ?x - tile ?group - block_group) ;; there is a color assigner machine on tile x belonging to group

    (teleport_unpairer_at ?x - tile) ;; there is a teleporter unpairer on tile x
    (teleport_pairer_at ?x - tile ?group - teleport_group) ;; there is a teleporter pairer on tile x belonging to group

    (gate_at ?x - tile ?group - block_group) ;; there is a gate on tile x belonging to group

)


(:action move
    ;; The agent moves from their current tile to an adjacent one
    :parameters (?r - robot ?x - tile ?y - tile)
    :precondition (and 
        (at ?r ?x)
        (adjacent ?x ?y)
        (walkable ?y)
    )
    :effect (and
        (not (at ?r ?x))
        (at ?r ?y)
    )
)

(:action use_teleporter
    ;; The agent is standing at a tile that is a teleporter,
    ;; and teleport to another teleporter in the same group
    :parameters (
        ?r - robot
        ?current - tile
        ?target - tile
        ?group - teleport_group
    )
    :precondition (and
        (at ?r ?current)
        (teleporter_at ?current ?group)
        (teleporter_at ?target ?group)
        (walkable ?target)
        (not (at ?r ?target)) ;; This is so that the agent does not teleport to the tile they are in --
        ;; if this is not here, the agent may waste time trying to teleport to the same tile

        (not (teleporter_at ?current tgroup_unpaired)) ;; This is so that unpaired teleporters don't work.
    )
    :effect (and
        (not (at ?r ?current))
        (at ?r ?target)
    )
)

(:action pick_up_block
    ;; The agent is standing at a tile where there is a block,
    ;; and starts holding the block
    :parameters (
        ?r - robot
        ?x - tile
        ?block - block_group)
    :precondition (and
        (at ?r ?x)
        (item_at ?x)
        (block_at ?x ?block)
        (not (holding_item ?r))
    )
    :effect (and
        (not (block_at ?x ?block))
        (not (item_at ?x))
        (holding_block ?r ?block)
        (holding_item ?r)
    )
)

(:action drop_block
    ;; The agent is holding a block,
    ;; and drops the block at the current tile
    :parameters (
        ?r - robot
        ?x - tile
        ?block - block_group)
    :precondition (and
        (at ?r ?x)
        (holding_block ?r ?block)
        (holding_item ?r)
        (not (item_at ?x))
        (not (block_at ?x ?block))
    )
    :effect (and
        (block_at ?x ?block)
        (item_at ?x)
        (not (holding_block ?r ?block))
        (not (holding_item ?r))
    )
)

(:action pick_up_tp
    ;; The agent is picking up a portal
    :parameters (
        ?r - robot
        ?x - tile
        ?group - teleport_group)
    :precondition (and
        (at ?r ?x)
        (item_at ?x)
        (teleporter_at ?x ?group)
        (not (holding_item ?r))
    )
    :effect (and
        (not (teleporter_at ?x ?group))
        (not (item_at ?x))
        (holding_item ?r)
        (holding_tp ?r ?group)

    )
)

(:action drop_tp
    ;; The agent is dropping a held portal
    :parameters (
        ?r - robot
        ?x - tile
        ?group - teleport_group
    )
    :precondition (and
        (at ?r ?x)
        (not (item_at ?x))
        (holding_item ?r)
        (holding_tp ?r ?group)
    )
    :effect (and
        (teleporter_at ?x ?group)
        (item_at ?x)
        (not (holding_item ?r))
        (not (holding_tp ?r ?group))
    )
)

(:action use_color_remover_machine
    ;; The agent is standing at a tile that is a color remover machine,
    ;; and removes the color of the block they are holding
    :parameters (
        ?r - robot
        ?x - tile
        ?block - block_group
    )
    :precondition (and
        (at ?r ?x)
        (holding_block ?r ?block)
        (holding_item ?r)
        (color_remover_machine_at ?x)
    )
    :effect (and
        (not (holding_block ?r ?block))
        (holding_block ?r bgroup_colorless)
    )
)

(:action use_color_assigner_machine
    ;; The agent is standing at a tile that is a color assigner machine,
    ;; and assigns the color of the block they are holding to the machine's color
    :parameters (
        ?r - robot
        ?x - tile
        ?block - block_group
    )
    :precondition (and
        (at ?r ?x)
        (holding_block ?r bgroup_colorless)
        (holding_item ?r)
        (color_assigner_machine_at ?x ?block)
    )
    :effect (and
        (not (holding_block ?r bgroup_colorless))
        (holding_block ?r ?block)
    )
)

(:action unpair_tp
    ;; The agent is standing at a tile that is a teleporter unpairer,
    ;; and unpairs the teleporter they are holding
    :parameters (
        ?r - robot
        ?x - tile
        ?group - teleport_group
    )
    :precondition (and
        (at ?r ?x)
        (holding_tp ?r ?group)
        (holding_item ?r)
        (teleport_unpairer_at ?x)
    )
    :effect (and
        (not (holding_tp ?r ?group))
        (holding_tp ?r tgroup_unpaired)
    )
)

(:action pair_tp
    ;; The agent is standing at a tile that is a teleporter pairer,
    ;; and pairs the teleporter they are holding to the pairer's teleporter group
    :parameters (
        ?r - robot
        ?x - tile
        ?group - teleport_group
    )
    :precondition (and
        (at ?r ?x)
        (holding_tp ?r tgroup_unpaired)
        (holding_item ?r)
        (teleport_pairer_at ?x ?group)
    )
    :effect (and
        (not (holding_tp ?r tgroup_unpaired))
        (holding_tp ?r ?group)
    )
)

(:action unlock_gate
    ;; The agent is standing on a tile adjacent to a gate,
    ;; and is holding a block of the same color as the gate,
    ;; and unlocks the gate, destroying the block,
    ;; removing the gate, and making the gate tile walkable

    :parameters (
        ?r - robot
        ?x - tile
        ?y - tile
        ?bgroup - block_group
    )
    :precondition (and
        (at ?r ?x)
        (adjacent ?x ?y)
        (gate_at ?y ?bgroup)
        (holding_block ?r ?bgroup)
        (holding_item ?r)
    )
    :effect (and
        (not (gate_at ?y ?bgroup))
        (not (holding_block ?r ?bgroup))
        (not (holding_item ?r))
        (walkable ?y)
    )
)
)