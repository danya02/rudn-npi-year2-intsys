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
  t0_7 - tile
  t1_7 - tile
  t2_7 - tile
  t3_7 - tile
  t4_7 - tile
  t5_7 - tile
  t6_7 - tile
  t7_7 - tile
  t8_7 - tile
  t9_7 - tile
  t10_7 - tile
  t0_8 - tile
  t1_8 - tile
  t2_8 - tile
  t3_8 - tile
  t4_8 - tile
  t5_8 - tile
  t6_8 - tile
  t7_8 - tile
  t8_8 - tile
  t9_8 - tile
  t10_8 - tile
  t0_9 - tile
  t1_9 - tile
  t2_9 - tile
  t3_9 - tile
  t4_9 - tile
  t5_9 - tile
  t6_9 - tile
  t7_9 - tile
  t8_9 - tile
  t9_9 - tile
  t10_9 - tile
  t0_10 - tile
  t1_10 - tile
  t2_10 - tile
  t3_10 - tile
  t4_10 - tile
  t5_10 - tile
  t6_10 - tile
  t7_10 - tile
  t8_10 - tile
  t9_10 - tile
  t10_10 - tile
 bgroup_item - block_group
  robot_h - robot
  robot_i - robot
  robot_d - robot
  robot_f - robot
  robot_a - robot
  robot_g - robot
  robot_e - robot
  robot_c - robot
  robot_b - robot
)

(:init
  (adjacent t0_0 t0_1)
  (adjacent t0_0 t1_0)
  (block_at t0_0 bgroup_item)
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
  (adjacent t4_0 t4_1)
  (adjacent t4_0 t3_0)
  (adjacent t4_0 t5_0)
  (block_at t4_0 bgroup_item)
  (item_at t4_0)
  (walkable t4_0)
  (adjacent t5_0 t5_1)
  (adjacent t5_0 t4_0)
  (adjacent t5_0 t6_0)
  (walkable t5_0)
  (adjacent t6_0 t6_1)
  (adjacent t6_0 t5_0)
  (adjacent t6_0 t7_0)
  (walkable t6_0)
  (adjacent t8_0 t8_1)
  (adjacent t8_0 t7_0)
  (adjacent t8_0 t9_0)
  (block_at t8_0 bgroup_item)
  (item_at t8_0)
  (walkable t8_0)
  (adjacent t9_0 t9_1)
  (adjacent t9_0 t8_0)
  (adjacent t9_0 t10_0)
  (walkable t9_0)
  (adjacent t10_0 t10_1)
  (adjacent t10_0 t9_0)
  (walkable t10_0)
  (adjacent t0_1 t0_0)
  (adjacent t0_1 t0_2)
  (adjacent t0_1 t1_1)
  (walkable t0_1)
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
  (adjacent t6_1 t7_1)
  (walkable t6_1)
  (adjacent t8_1 t8_0)
  (adjacent t8_1 t8_2)
  (adjacent t8_1 t7_1)
  (adjacent t8_1 t9_1)
  (walkable t8_1)
  (adjacent t9_1 t9_0)
  (adjacent t9_1 t9_2)
  (adjacent t9_1 t8_1)
  (adjacent t9_1 t10_1)
  (walkable t9_1)
  (adjacent t10_1 t10_0)
  (adjacent t10_1 t10_2)
  (adjacent t10_1 t9_1)
  (walkable t10_1)
  (adjacent t0_2 t0_1)
  (adjacent t0_2 t0_3)
  (adjacent t0_2 t1_2)
  (at robot_a t0_2)
  (walkable t0_2)
  (adjacent t1_2 t1_1)
  (adjacent t1_2 t1_3)
  (adjacent t1_2 t0_2)
  (adjacent t1_2 t2_2)
  (walkable t1_2)
  (adjacent t2_2 t2_1)
  (adjacent t2_2 t2_3)
  (adjacent t2_2 t1_2)
  (adjacent t2_2 t3_2)
  (walkable t2_2)
  (adjacent t4_2 t4_1)
  (adjacent t4_2 t4_3)
  (adjacent t4_2 t3_2)
  (adjacent t4_2 t5_2)
  (at robot_b t4_2)
  (walkable t4_2)
  (adjacent t5_2 t5_1)
  (adjacent t5_2 t5_3)
  (adjacent t5_2 t4_2)
  (adjacent t5_2 t6_2)
  (walkable t5_2)
  (adjacent t6_2 t6_1)
  (adjacent t6_2 t6_3)
  (adjacent t6_2 t5_2)
  (adjacent t6_2 t7_2)
  (walkable t6_2)
  (adjacent t8_2 t8_1)
  (adjacent t8_2 t8_3)
  (adjacent t8_2 t7_2)
  (adjacent t8_2 t9_2)
  (at robot_c t8_2)
  (walkable t8_2)
  (adjacent t9_2 t9_1)
  (adjacent t9_2 t9_3)
  (adjacent t9_2 t8_2)
  (adjacent t9_2 t10_2)
  (walkable t9_2)
  (adjacent t10_2 t10_1)
  (adjacent t10_2 t10_3)
  (adjacent t10_2 t9_2)
  (walkable t10_2)
  (adjacent t0_4 t0_3)
  (adjacent t0_4 t0_5)
  (adjacent t0_4 t1_4)
  (block_at t0_4 bgroup_item)
  (item_at t0_4)
  (walkable t0_4)
  (adjacent t1_4 t1_3)
  (adjacent t1_4 t1_5)
  (adjacent t1_4 t0_4)
  (adjacent t1_4 t2_4)
  (walkable t1_4)
  (adjacent t2_4 t2_3)
  (adjacent t2_4 t2_5)
  (adjacent t2_4 t1_4)
  (adjacent t2_4 t3_4)
  (walkable t2_4)
  (adjacent t4_4 t4_3)
  (adjacent t4_4 t4_5)
  (adjacent t4_4 t3_4)
  (adjacent t4_4 t5_4)
  (block_at t4_4 bgroup_item)
  (item_at t4_4)
  (walkable t4_4)
  (adjacent t5_4 t5_3)
  (adjacent t5_4 t5_5)
  (adjacent t5_4 t4_4)
  (adjacent t5_4 t6_4)
  (walkable t5_4)
  (adjacent t6_4 t6_3)
  (adjacent t6_4 t6_5)
  (adjacent t6_4 t5_4)
  (adjacent t6_4 t7_4)
  (walkable t6_4)
  (adjacent t8_4 t8_3)
  (adjacent t8_4 t8_5)
  (adjacent t8_4 t7_4)
  (adjacent t8_4 t9_4)
  (block_at t8_4 bgroup_item)
  (item_at t8_4)
  (walkable t8_4)
  (adjacent t9_4 t9_3)
  (adjacent t9_4 t9_5)
  (adjacent t9_4 t8_4)
  (adjacent t9_4 t10_4)
  (walkable t9_4)
  (adjacent t10_4 t10_3)
  (adjacent t10_4 t10_5)
  (adjacent t10_4 t9_4)
  (walkable t10_4)
  (adjacent t0_5 t0_4)
  (adjacent t0_5 t0_6)
  (adjacent t0_5 t1_5)
  (walkable t0_5)
  (adjacent t1_5 t1_4)
  (adjacent t1_5 t1_6)
  (adjacent t1_5 t0_5)
  (adjacent t1_5 t2_5)
  (walkable t1_5)
  (adjacent t2_5 t2_4)
  (adjacent t2_5 t2_6)
  (adjacent t2_5 t1_5)
  (adjacent t2_5 t3_5)
  (walkable t2_5)
  (adjacent t4_5 t4_4)
  (adjacent t4_5 t4_6)
  (adjacent t4_5 t3_5)
  (adjacent t4_5 t5_5)
  (walkable t4_5)
  (adjacent t5_5 t5_4)
  (adjacent t5_5 t5_6)
  (adjacent t5_5 t4_5)
  (adjacent t5_5 t6_5)
  (walkable t5_5)
  (adjacent t6_5 t6_4)
  (adjacent t6_5 t6_6)
  (adjacent t6_5 t5_5)
  (adjacent t6_5 t7_5)
  (walkable t6_5)
  (adjacent t8_5 t8_4)
  (adjacent t8_5 t8_6)
  (adjacent t8_5 t7_5)
  (adjacent t8_5 t9_5)
  (walkable t8_5)
  (adjacent t9_5 t9_4)
  (adjacent t9_5 t9_6)
  (adjacent t9_5 t8_5)
  (adjacent t9_5 t10_5)
  (walkable t9_5)
  (adjacent t10_5 t10_4)
  (adjacent t10_5 t10_6)
  (adjacent t10_5 t9_5)
  (walkable t10_5)
  (adjacent t0_6 t0_5)
  (adjacent t0_6 t0_7)
  (adjacent t0_6 t1_6)
  (at robot_d t0_6)
  (walkable t0_6)
  (adjacent t1_6 t1_5)
  (adjacent t1_6 t1_7)
  (adjacent t1_6 t0_6)
  (adjacent t1_6 t2_6)
  (walkable t1_6)
  (adjacent t2_6 t2_5)
  (adjacent t2_6 t2_7)
  (adjacent t2_6 t1_6)
  (adjacent t2_6 t3_6)
  (walkable t2_6)
  (adjacent t4_6 t4_5)
  (adjacent t4_6 t4_7)
  (adjacent t4_6 t3_6)
  (adjacent t4_6 t5_6)
  (at robot_e t4_6)
  (walkable t4_6)
  (adjacent t5_6 t5_5)
  (adjacent t5_6 t5_7)
  (adjacent t5_6 t4_6)
  (adjacent t5_6 t6_6)
  (walkable t5_6)
  (adjacent t6_6 t6_5)
  (adjacent t6_6 t6_7)
  (adjacent t6_6 t5_6)
  (adjacent t6_6 t7_6)
  (walkable t6_6)
  (adjacent t8_6 t8_5)
  (adjacent t8_6 t8_7)
  (adjacent t8_6 t7_6)
  (adjacent t8_6 t9_6)
  (at robot_f t8_6)
  (walkable t8_6)
  (adjacent t9_6 t9_5)
  (adjacent t9_6 t9_7)
  (adjacent t9_6 t8_6)
  (adjacent t9_6 t10_6)
  (walkable t9_6)
  (adjacent t10_6 t10_5)
  (adjacent t10_6 t10_7)
  (adjacent t10_6 t9_6)
  (walkable t10_6)
  (adjacent t0_8 t0_7)
  (adjacent t0_8 t0_9)
  (adjacent t0_8 t1_8)
  (block_at t0_8 bgroup_item)
  (item_at t0_8)
  (walkable t0_8)
  (adjacent t1_8 t1_7)
  (adjacent t1_8 t1_9)
  (adjacent t1_8 t0_8)
  (adjacent t1_8 t2_8)
  (walkable t1_8)
  (adjacent t2_8 t2_7)
  (adjacent t2_8 t2_9)
  (adjacent t2_8 t1_8)
  (adjacent t2_8 t3_8)
  (walkable t2_8)
  (adjacent t4_8 t4_7)
  (adjacent t4_8 t4_9)
  (adjacent t4_8 t3_8)
  (adjacent t4_8 t5_8)
  (block_at t4_8 bgroup_item)
  (item_at t4_8)
  (walkable t4_8)
  (adjacent t5_8 t5_7)
  (adjacent t5_8 t5_9)
  (adjacent t5_8 t4_8)
  (adjacent t5_8 t6_8)
  (walkable t5_8)
  (adjacent t6_8 t6_7)
  (adjacent t6_8 t6_9)
  (adjacent t6_8 t5_8)
  (adjacent t6_8 t7_8)
  (walkable t6_8)
  (adjacent t8_8 t8_7)
  (adjacent t8_8 t8_9)
  (adjacent t8_8 t7_8)
  (adjacent t8_8 t9_8)
  (block_at t8_8 bgroup_item)
  (item_at t8_8)
  (walkable t8_8)
  (adjacent t9_8 t9_7)
  (adjacent t9_8 t9_9)
  (adjacent t9_8 t8_8)
  (adjacent t9_8 t10_8)
  (walkable t9_8)
  (adjacent t10_8 t10_7)
  (adjacent t10_8 t10_9)
  (adjacent t10_8 t9_8)
  (walkable t10_8)
  (adjacent t0_9 t0_8)
  (adjacent t0_9 t0_10)
  (adjacent t0_9 t1_9)
  (walkable t0_9)
  (adjacent t1_9 t1_8)
  (adjacent t1_9 t1_10)
  (adjacent t1_9 t0_9)
  (adjacent t1_9 t2_9)
  (walkable t1_9)
  (adjacent t2_9 t2_8)
  (adjacent t2_9 t2_10)
  (adjacent t2_9 t1_9)
  (adjacent t2_9 t3_9)
  (walkable t2_9)
  (adjacent t4_9 t4_8)
  (adjacent t4_9 t4_10)
  (adjacent t4_9 t3_9)
  (adjacent t4_9 t5_9)
  (walkable t4_9)
  (adjacent t5_9 t5_8)
  (adjacent t5_9 t5_10)
  (adjacent t5_9 t4_9)
  (adjacent t5_9 t6_9)
  (walkable t5_9)
  (adjacent t6_9 t6_8)
  (adjacent t6_9 t6_10)
  (adjacent t6_9 t5_9)
  (adjacent t6_9 t7_9)
  (walkable t6_9)
  (adjacent t8_9 t8_8)
  (adjacent t8_9 t8_10)
  (adjacent t8_9 t7_9)
  (adjacent t8_9 t9_9)
  (walkable t8_9)
  (adjacent t9_9 t9_8)
  (adjacent t9_9 t9_10)
  (adjacent t9_9 t8_9)
  (adjacent t9_9 t10_9)
  (walkable t9_9)
  (adjacent t10_9 t10_8)
  (adjacent t10_9 t10_10)
  (adjacent t10_9 t9_9)
  (walkable t10_9)
  (adjacent t0_10 t0_9)
  (adjacent t0_10 t1_10)
  (at robot_g t0_10)
  (walkable t0_10)
  (adjacent t1_10 t1_9)
  (adjacent t1_10 t0_10)
  (adjacent t1_10 t2_10)
  (walkable t1_10)
  (adjacent t2_10 t2_9)
  (adjacent t2_10 t1_10)
  (adjacent t2_10 t3_10)
  (walkable t2_10)
  (adjacent t4_10 t4_9)
  (adjacent t4_10 t3_10)
  (adjacent t4_10 t5_10)
  (at robot_h t4_10)
  (walkable t4_10)
  (adjacent t5_10 t5_9)
  (adjacent t5_10 t4_10)
  (adjacent t5_10 t6_10)
  (walkable t5_10)
  (adjacent t6_10 t6_9)
  (adjacent t6_10 t5_10)
  (adjacent t6_10 t7_10)
  (walkable t6_10)
  (adjacent t8_10 t8_9)
  (adjacent t8_10 t7_10)
  (adjacent t8_10 t9_10)
  (at robot_i t8_10)
  (walkable t8_10)
  (adjacent t9_10 t9_9)
  (adjacent t9_10 t8_10)
  (adjacent t9_10 t10_10)
  (walkable t9_10)
  (adjacent t10_10 t10_9)
  (adjacent t10_10 t9_10)
  (walkable t10_10)
)

(:goal (and
  (block_at t2_0 bgroup_item)
  (block_at t6_0 bgroup_item)
  (block_at t10_0 bgroup_item)
  (at robot_a t2_2)
  (at robot_b t6_2)
  (at robot_c t10_2)
  (block_at t2_4 bgroup_item)
  (block_at t6_4 bgroup_item)
  (block_at t10_4 bgroup_item)
  (at robot_d t2_6)
  (at robot_e t6_6)
  (at robot_f t10_6)
  (block_at t2_8 bgroup_item)
  (block_at t6_8 bgroup_item)
  (block_at t10_8 bgroup_item)
  (at robot_g t2_10)
  (at robot_h t6_10)
  (at robot_i t10_10)

))

)
