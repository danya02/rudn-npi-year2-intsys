(define (problem simple_maze) (:domain maze)
(:objects 
  t0_0 - tile
  t1_0 - tile
  t2_0 - tile
  t3_0 - tile
  t4_0 - tile
  t5_0 - tile
  t6_0 - tile
  t7_0 - tile
  t8_0 - tile
  t0_1 - tile
  t1_1 - tile
  t2_1 - tile
  t3_1 - tile
  t4_1 - tile
  t5_1 - tile
  t6_1 - tile
  t7_1 - tile
  t8_1 - tile
  t0_2 - tile
  t1_2 - tile
  t2_2 - tile
  t3_2 - tile
  t4_2 - tile
  t5_2 - tile
  t6_2 - tile
  t7_2 - tile
  t8_2 - tile
  t0_3 - tile
  t1_3 - tile
  t2_3 - tile
  t3_3 - tile
  t4_3 - tile
  t5_3 - tile
  t6_3 - tile
  t7_3 - tile
  t8_3 - tile
  t0_4 - tile
  t1_4 - tile
  t2_4 - tile
  t3_4 - tile
  t4_4 - tile
  t5_4 - tile
  t6_4 - tile
  t7_4 - tile
  t8_4 - tile
 tgroup_W - teleport_group
 tgroup_Q - teleport_group
 bgroup_a - block_group
 bgroup_b - block_group
  robot_a - robot
  robot_b - robot
)

(:init
  (adjacent t0_0 t0_1)
  (adjacent t0_0 t1_0)
  (block_at t0_0 bgroup_a)
  (item_at t0_0)
  (walkable t0_0)
  (adjacent t1_0 t1_1)
  (adjacent t1_0 t0_0)
  (adjacent t1_0 t2_0)
  (walkable t1_0)
  (adjacent t2_0 t2_1)
  (adjacent t2_0 t1_0)
  (adjacent t2_0 t3_0)
  (walkable t2_0)
  (adjacent t3_0 t3_1)
  (adjacent t3_0 t2_0)
  (adjacent t3_0 t4_0)
  (walkable t3_0)
  (adjacent t5_0 t5_1)
  (adjacent t5_0 t4_0)
  (adjacent t5_0 t6_0)
  (walkable t5_0)
  (adjacent t6_0 t6_1)
  (adjacent t6_0 t5_0)
  (adjacent t6_0 t7_0)
  (walkable t6_0)
  (adjacent t7_0 t7_1)
  (adjacent t7_0 t6_0)
  (adjacent t7_0 t8_0)
  (walkable t7_0)
  (adjacent t8_0 t8_1)
  (adjacent t8_0 t7_0)
  (color_remover_machine_at t8_0)
  (item_at t8_0) ;; cannot place blocks on machines
  (walkable t8_0)
  (adjacent t0_1 t0_0)
  (adjacent t0_1 t0_2)
  (adjacent t0_1 t1_1)
  (walkable t0_1)
  (adjacent t1_1 t1_0)
  (adjacent t1_1 t1_2)
  (adjacent t1_1 t0_1)
  (adjacent t1_1 t2_1)
  (walkable t1_1)
  (adjacent t7_1 t7_0)
  (adjacent t7_1 t7_2)
  (adjacent t7_1 t6_1)
  (adjacent t7_1 t8_1)
  (walkable t7_1)
  (adjacent t8_1 t8_0)
  (adjacent t8_1 t8_2)
  (adjacent t8_1 t7_1)
  (at robot_b t8_1)
  (walkable t8_1)
  (adjacent t0_2 t0_1)
  (adjacent t0_2 t0_3)
  (adjacent t0_2 t1_2)
  (walkable t0_2)
  (adjacent t1_2 t1_1)
  (adjacent t1_2 t1_3)
  (adjacent t1_2 t0_2)
  (adjacent t1_2 t2_2)
  (teleporter_at t1_2 tgroup_Q)
  (item_at t1_2)
  (walkable t1_2)
  (adjacent t3_2 t3_1)
  (adjacent t3_2 t3_3)
  (adjacent t3_2 t2_2)
  (adjacent t3_2 t4_2)
  (teleporter_at t3_2 tgroup_Q)
  (item_at t3_2)
  (walkable t3_2)
  (adjacent t4_2 t4_1)
  (adjacent t4_2 t4_3)
  (adjacent t4_2 t3_2)
  (adjacent t4_2 t5_2)
  (walkable t4_2)
  (adjacent t5_2 t5_1)
  (adjacent t5_2 t5_3)
  (adjacent t5_2 t4_2)
  (adjacent t5_2 t6_2)
  (teleporter_at t5_2 tgroup_W)
  (item_at t5_2)
  (walkable t5_2)
  (adjacent t7_2 t7_1)
  (adjacent t7_2 t7_3)
  (adjacent t7_2 t6_2)
  (adjacent t7_2 t8_2)
  (teleporter_at t7_2 tgroup_W)
  (item_at t7_2)
  (walkable t7_2)
  (adjacent t8_2 t8_1)
  (adjacent t8_2 t8_3)
  (adjacent t8_2 t7_2)
  (walkable t8_2)
  (adjacent t0_3 t0_2)
  (adjacent t0_3 t0_4)
  (adjacent t0_3 t1_3)
  (at robot_a t0_3)
  (walkable t0_3)
  (adjacent t1_3 t1_2)
  (adjacent t1_3 t1_4)
  (adjacent t1_3 t0_3)
  (adjacent t1_3 t2_3)
  (walkable t1_3)
  (adjacent t7_3 t7_2)
  (adjacent t7_3 t7_4)
  (adjacent t7_3 t6_3)
  (adjacent t7_3 t8_3)
  (walkable t7_3)
  (adjacent t8_3 t8_2)
  (adjacent t8_3 t8_4)
  (adjacent t8_3 t7_3)
  (walkable t8_3)
  (adjacent t0_4 t0_3)
  (adjacent t0_4 t1_4)
  (walkable t0_4)
  (adjacent t1_4 t1_3)
  (adjacent t1_4 t0_4)
  (adjacent t1_4 t2_4)
  (walkable t1_4)
  (adjacent t2_4 t2_3)
  (adjacent t2_4 t1_4)
  (adjacent t2_4 t3_4)
  (walkable t2_4)
  (adjacent t3_4 t3_3)
  (adjacent t3_4 t2_4)
  (adjacent t3_4 t4_4)
  (walkable t3_4)
  (adjacent t5_4 t5_3)
  (adjacent t5_4 t4_4)
  (adjacent t5_4 t6_4)
  (walkable t5_4)
  (adjacent t6_4 t6_3)
  (adjacent t6_4 t5_4)
  (adjacent t6_4 t7_4)
  (walkable t6_4)
  (adjacent t7_4 t7_3)
  (adjacent t7_4 t6_4)
  (adjacent t7_4 t8_4)
  (walkable t7_4)
  (adjacent t8_4 t8_3)
  (adjacent t8_4 t7_4)
  (color_assigner_machine_at t8_4 bgroup_b)
  (item_at t8_4) ;; cannot place blocks on machines
  (walkable t8_4)
)

(:goal (and
  (at robot_a t0_1)
  (at robot_b t8_3)
  (block_at t0_4 bgroup_b)

))

)
