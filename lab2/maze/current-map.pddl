(define (problem simple_maze) (:domain maze)
(:objects 
  t0_0 - tile
  t1_0 - tile
  t2_0 - tile
  t3_0 - tile
  t4_0 - tile
  t5_0 - tile
  t6_0 - tile
  t0_1 - tile
  t1_1 - tile
  t2_1 - tile
  t3_1 - tile
  t4_1 - tile
  t5_1 - tile
  t6_1 - tile
  t0_2 - tile
  t1_2 - tile
  t2_2 - tile
  t3_2 - tile
  t4_2 - tile
  t5_2 - tile
  t6_2 - tile
  t0_3 - tile
  t1_3 - tile
  t2_3 - tile
  t3_3 - tile
  t4_3 - tile
  t5_3 - tile
  t6_3 - tile
  t0_4 - tile
  t1_4 - tile
  t2_4 - tile
  t3_4 - tile
  t4_4 - tile
  t5_4 - tile
  t6_4 - tile
  t0_5 - tile
  t1_5 - tile
  t2_5 - tile
  t3_5 - tile
  t4_5 - tile
  t5_5 - tile
  t6_5 - tile
  t0_6 - tile
  t1_6 - tile
  t2_6 - tile
  t3_6 - tile
  t4_6 - tile
  t5_6 - tile
  t6_6 - tile
 tgroup_t - teleport_group
 bgroup_y - block_group
 bgroup_k - block_group
 bgroup_b - block_group
 bgroup_l - block_group
 bgroup_p - block_group
)

(:init
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
  (color_remover_machine_at t3_0)
  (item_at t3_0) ;; cannot place blocks on machines
  (adjacent t4_0 t4_1)
  (adjacent t4_0 t3_0)
  (adjacent t4_0 t5_0)
  (walkable t4_0)
  (adjacent t5_0 t5_1)
  (adjacent t5_0 t4_0)
  (adjacent t5_0 t6_0)
  (walkable t5_0)
  (adjacent t0_1 t0_0)
  (adjacent t0_1 t0_2)
  (adjacent t0_1 t1_1)
  (walkable t0_1)
  (block_at t0_1 bgroup_y)
  (item_at t0_1)
  (adjacent t1_1 t1_0)
  (adjacent t1_1 t1_2)
  (adjacent t1_1 t0_1)
  (adjacent t1_1 t2_1)
  (walkable t1_1)
  (adjacent t2_1 t2_0)
  (adjacent t2_1 t2_2)
  (adjacent t2_1 t1_1)
  (adjacent t2_1 t3_1)
  (walkable t2_1)
  (adjacent t3_1 t3_0)
  (adjacent t3_1 t3_2)
  (adjacent t3_1 t2_1)
  (adjacent t3_1 t4_1)
  (walkable t3_1)
  (adjacent t4_1 t4_0)
  (adjacent t4_1 t4_2)
  (adjacent t4_1 t3_1)
  (adjacent t4_1 t5_1)
  (walkable t4_1)
  (adjacent t5_1 t5_0)
  (adjacent t5_1 t5_2)
  (adjacent t5_1 t4_1)
  (adjacent t5_1 t6_1)
  (walkable t5_1)
  (adjacent t6_1 t6_0)
  (adjacent t6_1 t6_2)
  (adjacent t6_1 t5_1)
  (walkable t6_1)
  (color_assigner_machine_at t6_1 bgroup_b)
  (item_at t6_1) ;; cannot place blocks on machines
  (adjacent t0_2 t0_1)
  (adjacent t0_2 t0_3)
  (adjacent t0_2 t1_2)
  (walkable t0_2)
  (block_at t0_2 bgroup_colorless)
  (item_at t0_2)
  (adjacent t1_2 t1_1)
  (adjacent t1_2 t1_3)
  (adjacent t1_2 t0_2)
  (adjacent t1_2 t2_2)
  (walkable t1_2)
  (adjacent t5_2 t5_1)
  (adjacent t5_2 t5_3)
  (adjacent t5_2 t4_2)
  (adjacent t5_2 t6_2)
  (walkable t5_2)
  (adjacent t6_2 t6_1)
  (adjacent t6_2 t6_3)
  (adjacent t6_2 t5_2)
  (walkable t6_2)
  (color_assigner_machine_at t6_2 bgroup_p)
  (item_at t6_2) ;; cannot place blocks on machines
  (adjacent t0_3 t0_2)
  (adjacent t0_3 t0_4)
  (adjacent t0_3 t1_3)
  (walkable t0_3)
  (block_at t0_3 bgroup_l)
  (item_at t0_3)
  (adjacent t1_3 t1_2)
  (adjacent t1_3 t1_4)
  (adjacent t1_3 t0_3)
  (adjacent t1_3 t2_3)
  (walkable t1_3)
  (adjacent t5_3 t5_2)
  (adjacent t5_3 t5_4)
  (adjacent t5_3 t4_3)
  (adjacent t5_3 t6_3)
  (walkable t5_3)
  (adjacent t6_3 t6_2)
  (adjacent t6_3 t6_4)
  (adjacent t6_3 t5_3)
  (walkable t6_3)
  (adjacent t0_4 t0_3)
  (adjacent t0_4 t0_5)
  (adjacent t0_4 t1_4)
  (walkable t0_4)
  (block_at t0_4 bgroup_k)
  (item_at t0_4)
  (adjacent t1_4 t1_3)
  (adjacent t1_4 t1_5)
  (adjacent t1_4 t0_4)
  (adjacent t1_4 t2_4)
  (walkable t1_4)
  (adjacent t5_4 t5_3)
  (adjacent t5_4 t5_5)
  (adjacent t5_4 t4_4)
  (adjacent t5_4 t6_4)
  (walkable t5_4)
  (adjacent t6_4 t6_3)
  (adjacent t6_4 t6_5)
  (adjacent t6_4 t5_4)
  (walkable t6_4)
  (adjacent t1_5 t1_4)
  (adjacent t1_5 t1_6)
  (adjacent t1_5 t0_5)
  (adjacent t1_5 t2_5)
  (walkable t1_5)
  (adjacent t5_5 t5_4)
  (adjacent t5_5 t5_6)
  (adjacent t5_5 t4_5)
  (adjacent t5_5 t6_5)
  (walkable t5_5)
  (adjacent t6_5 t6_4)
  (adjacent t6_5 t6_6)
  (adjacent t6_5 t5_5)
  (walkable t6_5)
  (adjacent t1_6 t1_5)
  (adjacent t1_6 t0_6)
  (adjacent t1_6 t2_6)
  (walkable t1_6)
  (adjacent t2_6 t2_5)
  (adjacent t2_6 t1_6)
  (adjacent t2_6 t3_6)
  (walkable t2_6)
  (adjacent t3_6 t3_5)
  (adjacent t3_6 t2_6)
  (adjacent t3_6 t4_6)
  (walkable t3_6)
  (at t3_6)  ;; This is the tile that the agent starts on
  (adjacent t4_6 t4_5)
  (adjacent t4_6 t3_6)
  (adjacent t4_6 t5_6)
  (walkable t4_6)
  (adjacent t5_6 t5_5)
  (adjacent t5_6 t4_6)
  (adjacent t5_6 t6_6)
  (walkable t5_6)
)

(:goal (and
  (block_at t3_1 bgroup_colorless)
  (block_at t6_3 bgroup_colorless)
  (block_at t6_4 bgroup_p)
  (block_at t6_5 bgroup_b)
  (at t3_6)  ;; This is the tile that the agent should end on

))

)
