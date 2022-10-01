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
  t9_0 - tile
  t10_0 - tile
  t11_0 - tile
  t0_1 - tile
  t1_1 - tile
  t2_1 - tile
  t3_1 - tile
  t4_1 - tile
  t5_1 - tile
  t6_1 - tile
  t7_1 - tile
  t8_1 - tile
  t9_1 - tile
  t10_1 - tile
  t11_1 - tile
  t0_2 - tile
  t1_2 - tile
  t2_2 - tile
  t3_2 - tile
  t4_2 - tile
  t5_2 - tile
  t6_2 - tile
  t7_2 - tile
  t8_2 - tile
  t9_2 - tile
  t10_2 - tile
  t11_2 - tile
  t0_3 - tile
  t1_3 - tile
  t2_3 - tile
  t3_3 - tile
  t4_3 - tile
  t5_3 - tile
  t6_3 - tile
  t7_3 - tile
  t8_3 - tile
  t9_3 - tile
  t10_3 - tile
  t11_3 - tile
  t0_4 - tile
  t1_4 - tile
  t2_4 - tile
  t3_4 - tile
  t4_4 - tile
  t5_4 - tile
  t6_4 - tile
  t7_4 - tile
  t8_4 - tile
  t9_4 - tile
  t10_4 - tile
  t11_4 - tile
  t0_5 - tile
  t1_5 - tile
  t2_5 - tile
  t3_5 - tile
  t4_5 - tile
  t5_5 - tile
  t6_5 - tile
  t7_5 - tile
  t8_5 - tile
  t9_5 - tile
  t10_5 - tile
  t11_5 - tile
  t0_6 - tile
  t1_6 - tile
  t2_6 - tile
  t3_6 - tile
  t4_6 - tile
  t5_6 - tile
  t6_6 - tile
  t7_6 - tile
  t8_6 - tile
  t9_6 - tile
  t10_6 - tile
  t11_6 - tile
 tgroup_1 - teleport_group
 bgroup_A - block_group
)

(:init
  (adjacent t0_0 t0_1)
  (adjacent t0_0 t1_0)
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
  (adjacent t4_0 t4_1)
  (adjacent t4_0 t3_0)
  (adjacent t4_0 t5_0)
  (walkable t4_0)
  (adjacent t5_0 t5_1)
  (adjacent t5_0 t4_0)
  (adjacent t5_0 t6_0)
  (walkable t5_0)
  (adjacent t6_0 t6_1)
  (adjacent t6_0 t5_0)
  (adjacent t6_0 t7_0)
  (walkable t6_0)
  (teleporter_at t6_0 tgroup_1)
  (item_at t6_0)
  (adjacent t7_0 t7_1)
  (adjacent t7_0 t6_0)
  (adjacent t7_0 t8_0)
  (walkable t7_0)
  (adjacent t8_0 t8_1)
  (adjacent t8_0 t7_0)
  (adjacent t8_0 t9_0)
  (walkable t8_0)
  (adjacent t9_0 t9_1)
  (adjacent t9_0 t8_0)
  (adjacent t9_0 t10_0)
  (walkable t9_0)
  (adjacent t10_0 t10_1)
  (adjacent t10_0 t9_0)
  (adjacent t10_0 t11_0)
  (walkable t10_0)
  (adjacent t11_0 t11_1)
  (adjacent t11_0 t10_0)
  (walkable t11_0)
  (adjacent t0_1 t0_0)
  (adjacent t0_1 t0_2)
  (adjacent t0_1 t1_1)
  (adjacent t1_1 t1_0)
  (adjacent t1_1 t1_2)
  (adjacent t1_1 t0_1)
  (adjacent t1_1 t2_1)
  (adjacent t2_1 t2_0)
  (adjacent t2_1 t2_2)
  (adjacent t2_1 t1_1)
  (adjacent t2_1 t3_1)
  (adjacent t3_1 t3_0)
  (adjacent t3_1 t3_2)
  (adjacent t3_1 t2_1)
  (adjacent t3_1 t4_1)
  (adjacent t4_1 t4_0)
  (adjacent t4_1 t4_2)
  (adjacent t4_1 t3_1)
  (adjacent t4_1 t5_1)
  (adjacent t5_1 t5_0)
  (adjacent t5_1 t5_2)
  (adjacent t5_1 t4_1)
  (adjacent t5_1 t6_1)
  (adjacent t6_1 t6_0)
  (adjacent t6_1 t6_2)
  (adjacent t6_1 t5_1)
  (adjacent t6_1 t7_1)
  (adjacent t7_1 t7_0)
  (adjacent t7_1 t7_2)
  (adjacent t7_1 t6_1)
  (adjacent t7_1 t8_1)
  (adjacent t8_1 t8_0)
  (adjacent t8_1 t8_2)
  (adjacent t8_1 t7_1)
  (adjacent t8_1 t9_1)
  (adjacent t9_1 t9_0)
  (adjacent t9_1 t9_2)
  (adjacent t9_1 t8_1)
  (adjacent t9_1 t10_1)
  (adjacent t10_1 t10_0)
  (adjacent t10_1 t10_2)
  (adjacent t10_1 t9_1)
  (adjacent t10_1 t11_1)
  (adjacent t11_1 t11_0)
  (adjacent t11_1 t11_2)
  (adjacent t11_1 t10_1)
  (adjacent t0_2 t0_1)
  (adjacent t0_2 t0_3)
  (adjacent t0_2 t1_2)
  (walkable t0_2)
  (teleporter_at t0_2 tgroup_1)
  (item_at t0_2)
  (adjacent t1_2 t1_1)
  (adjacent t1_2 t1_3)
  (adjacent t1_2 t0_2)
  (adjacent t1_2 t2_2)
  (adjacent t2_2 t2_1)
  (adjacent t2_2 t2_3)
  (adjacent t2_2 t1_2)
  (adjacent t2_2 t3_2)
  (walkable t2_2)
  (adjacent t3_2 t3_1)
  (adjacent t3_2 t3_3)
  (adjacent t3_2 t2_2)
  (adjacent t3_2 t4_2)
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
  (adjacent t6_2 t6_1)
  (adjacent t6_2 t6_3)
  (adjacent t6_2 t5_2)
  (adjacent t6_2 t7_2)
  (walkable t6_2)
  (adjacent t7_2 t7_1)
  (adjacent t7_2 t7_3)
  (adjacent t7_2 t6_2)
  (adjacent t7_2 t8_2)
  (walkable t7_2)
  (adjacent t8_2 t8_1)
  (adjacent t8_2 t8_3)
  (adjacent t8_2 t7_2)
  (adjacent t8_2 t9_2)
  (walkable t8_2)
  (adjacent t9_2 t9_1)
  (adjacent t9_2 t9_3)
  (adjacent t9_2 t8_2)
  (adjacent t9_2 t10_2)
  (adjacent t10_2 t10_1)
  (adjacent t10_2 t10_3)
  (adjacent t10_2 t9_2)
  (adjacent t10_2 t11_2)
  (walkable t10_2)
  (adjacent t11_2 t11_1)
  (adjacent t11_2 t11_3)
  (adjacent t11_2 t10_2)
  (walkable t11_2)
  (block_at t11_2 bgroup_A)
  (item_at t11_2)
  (adjacent t0_3 t0_2)
  (adjacent t0_3 t0_4)
  (adjacent t0_3 t1_3)
  (walkable t0_3)
  (adjacent t1_3 t1_2)
  (adjacent t1_3 t1_4)
  (adjacent t1_3 t0_3)
  (adjacent t1_3 t2_3)
  (adjacent t2_3 t2_2)
  (adjacent t2_3 t2_4)
  (adjacent t2_3 t1_3)
  (adjacent t2_3 t3_3)
  (walkable t2_3)
  (adjacent t3_3 t3_2)
  (adjacent t3_3 t3_4)
  (adjacent t3_3 t2_3)
  (adjacent t3_3 t4_3)
  (adjacent t4_3 t4_2)
  (adjacent t4_3 t4_4)
  (adjacent t4_3 t3_3)
  (adjacent t4_3 t5_3)
  (walkable t4_3)
  (adjacent t5_3 t5_2)
  (adjacent t5_3 t5_4)
  (adjacent t5_3 t4_3)
  (adjacent t5_3 t6_3)
  (adjacent t6_3 t6_2)
  (adjacent t6_3 t6_4)
  (adjacent t6_3 t5_3)
  (adjacent t6_3 t7_3)
  (walkable t6_3)
  (adjacent t7_3 t7_2)
  (adjacent t7_3 t7_4)
  (adjacent t7_3 t6_3)
  (adjacent t7_3 t8_3)
  (adjacent t8_3 t8_2)
  (adjacent t8_3 t8_4)
  (adjacent t8_3 t7_3)
  (adjacent t8_3 t9_3)
  (walkable t8_3)
  (adjacent t9_3 t9_2)
  (adjacent t9_3 t9_4)
  (adjacent t9_3 t8_3)
  (adjacent t9_3 t10_3)
  (adjacent t10_3 t10_2)
  (adjacent t10_3 t10_4)
  (adjacent t10_3 t9_3)
  (adjacent t10_3 t11_3)
  (walkable t10_3)
  (adjacent t11_3 t11_2)
  (adjacent t11_3 t11_4)
  (adjacent t11_3 t10_3)
  (walkable t11_3)
  (block_at t11_3 bgroup_A)
  (item_at t11_3)
  (adjacent t0_4 t0_3)
  (adjacent t0_4 t0_5)
  (adjacent t0_4 t1_4)
  (walkable t0_4)
  (adjacent t1_4 t1_3)
  (adjacent t1_4 t1_5)
  (adjacent t1_4 t0_4)
  (adjacent t1_4 t2_4)
  (adjacent t2_4 t2_3)
  (adjacent t2_4 t2_5)
  (adjacent t2_4 t1_4)
  (adjacent t2_4 t3_4)
  (walkable t2_4)
  (adjacent t3_4 t3_3)
  (adjacent t3_4 t3_5)
  (adjacent t3_4 t2_4)
  (adjacent t3_4 t4_4)
  (adjacent t4_4 t4_3)
  (adjacent t4_4 t4_5)
  (adjacent t4_4 t3_4)
  (adjacent t4_4 t5_4)
  (walkable t4_4)
  (adjacent t5_4 t5_3)
  (adjacent t5_4 t5_5)
  (adjacent t5_4 t4_4)
  (adjacent t5_4 t6_4)
  (adjacent t6_4 t6_3)
  (adjacent t6_4 t6_5)
  (adjacent t6_4 t5_4)
  (adjacent t6_4 t7_4)
  (walkable t6_4)
  (adjacent t7_4 t7_3)
  (adjacent t7_4 t7_5)
  (adjacent t7_4 t6_4)
  (adjacent t7_4 t8_4)
  (adjacent t8_4 t8_3)
  (adjacent t8_4 t8_5)
  (adjacent t8_4 t7_4)
  (adjacent t8_4 t9_4)
  (walkable t8_4)
  (adjacent t9_4 t9_3)
  (adjacent t9_4 t9_5)
  (adjacent t9_4 t8_4)
  (adjacent t9_4 t10_4)
  (adjacent t10_4 t10_3)
  (adjacent t10_4 t10_5)
  (adjacent t10_4 t9_4)
  (adjacent t10_4 t11_4)
  (walkable t10_4)
  (adjacent t11_4 t11_3)
  (adjacent t11_4 t11_5)
  (adjacent t11_4 t10_4)
  (walkable t11_4)
  (block_at t11_4 bgroup_A)
  (item_at t11_4)
  (adjacent t0_5 t0_4)
  (adjacent t0_5 t0_6)
  (adjacent t0_5 t1_5)
  (walkable t0_5)
  (adjacent t1_5 t1_4)
  (adjacent t1_5 t1_6)
  (adjacent t1_5 t0_5)
  (adjacent t1_5 t2_5)
  (adjacent t2_5 t2_4)
  (adjacent t2_5 t2_6)
  (adjacent t2_5 t1_5)
  (adjacent t2_5 t3_5)
  (walkable t2_5)
  (adjacent t3_5 t3_4)
  (adjacent t3_5 t3_6)
  (adjacent t3_5 t2_5)
  (adjacent t3_5 t4_5)
  (adjacent t4_5 t4_4)
  (adjacent t4_5 t4_6)
  (adjacent t4_5 t3_5)
  (adjacent t4_5 t5_5)
  (walkable t4_5)
  (adjacent t5_5 t5_4)
  (adjacent t5_5 t5_6)
  (adjacent t5_5 t4_5)
  (adjacent t5_5 t6_5)
  (adjacent t6_5 t6_4)
  (adjacent t6_5 t6_6)
  (adjacent t6_5 t5_5)
  (adjacent t6_5 t7_5)
  (walkable t6_5)
  (adjacent t7_5 t7_4)
  (adjacent t7_5 t7_6)
  (adjacent t7_5 t6_5)
  (adjacent t7_5 t8_5)
  (adjacent t8_5 t8_4)
  (adjacent t8_5 t8_6)
  (adjacent t8_5 t7_5)
  (adjacent t8_5 t9_5)
  (walkable t8_5)
  (adjacent t9_5 t9_4)
  (adjacent t9_5 t9_6)
  (adjacent t9_5 t8_5)
  (adjacent t9_5 t10_5)
  (adjacent t10_5 t10_4)
  (adjacent t10_5 t10_6)
  (adjacent t10_5 t9_5)
  (adjacent t10_5 t11_5)
  (walkable t10_5)
  (adjacent t11_5 t11_4)
  (adjacent t11_5 t11_6)
  (adjacent t11_5 t10_5)
  (walkable t11_5)
  (adjacent t0_6 t0_5)
  (adjacent t0_6 t1_6)
  (walkable t0_6)
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
  (adjacent t4_6 t4_5)
  (adjacent t4_6 t3_6)
  (adjacent t4_6 t5_6)
  (walkable t4_6)
  (adjacent t5_6 t5_5)
  (adjacent t5_6 t4_6)
  (adjacent t5_6 t6_6)
  (walkable t5_6)
  (adjacent t6_6 t6_5)
  (adjacent t6_6 t5_6)
  (adjacent t6_6 t7_6)
  (walkable t6_6)
  (adjacent t7_6 t7_5)
  (adjacent t7_6 t6_6)
  (adjacent t7_6 t8_6)
  (adjacent t8_6 t8_5)
  (adjacent t8_6 t7_6)
  (adjacent t8_6 t9_6)
  (walkable t8_6)
  (adjacent t9_6 t9_5)
  (adjacent t9_6 t8_6)
  (adjacent t9_6 t10_6)
  (walkable t9_6)
  (adjacent t10_6 t10_5)
  (adjacent t10_6 t9_6)
  (adjacent t10_6 t11_6)
  (walkable t10_6)
  (adjacent t11_6 t11_5)
  (adjacent t11_6 t10_6)
  (walkable t11_6)
  (at t11_6)  ;; This is the tile that the agent starts on
)

(:goal (and
  (block_at t0_0 bgroup_A)
  (block_at t3_0 bgroup_A)
  (block_at t11_0 bgroup_A)
  (at t11_6)  ;; This is the tile that the agent should end on

))

)
