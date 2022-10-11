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
  t12_0 - tile
  t13_0 - tile
  t14_0 - tile
  t15_0 - tile
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
  t12_1 - tile
  t13_1 - tile
  t14_1 - tile
  t15_1 - tile
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
  t12_2 - tile
  t13_2 - tile
  t14_2 - tile
  t15_2 - tile
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
  t12_3 - tile
  t13_3 - tile
  t14_3 - tile
  t15_3 - tile
 tgroup_t - teleport_group
 bgroup_a - block_group
 bgroup_c - block_group
 bgroup_d - block_group
 bgroup_b - block_group
  robot_a - robot
)

(:init
  (adjacent t0_0 t0_1)
  (adjacent t0_0 t1_0)
  (at robot_a t0_0)
  (walkable t0_0)
  (adjacent t1_0 t1_1)
  (adjacent t1_0 t0_0)
  (adjacent t1_0 t2_0)
  (walkable t1_0)
  (adjacent t2_0 t2_1)
  (adjacent t2_0 t1_0)
  (adjacent t2_0 t3_0)
  (color_remover_machine_at t2_0)
  (item_at t2_0) ;; cannot place blocks on machines
  (walkable t2_0)
  (adjacent t3_0 t3_1)
  (adjacent t3_0 t2_0)
  (adjacent t3_0 t4_0)
  (walkable t3_0)
  (adjacent t4_0 t4_1)
  (adjacent t4_0 t3_0)
  (adjacent t4_0 t5_0)
  (walkable t4_0)
  (adjacent t6_0 t6_1)
  (adjacent t6_0 t5_0)
  (adjacent t6_0 t7_0)
  (walkable t6_0)
  (adjacent t7_0 t7_1)
  (adjacent t7_0 t6_0)
  (adjacent t7_0 t8_0)
  (color_assigner_machine_at t7_0 bgroup_b)
  (item_at t7_0) ;; cannot place blocks on machines
  (walkable t7_0)
  (adjacent t8_0 t8_1)
  (adjacent t8_0 t7_0)
  (adjacent t8_0 t9_0)
  (walkable t8_0)
  (adjacent t10_0 t10_1)
  (adjacent t10_0 t9_0)
  (adjacent t10_0 t11_0)
  (walkable t10_0)
  (adjacent t11_0 t11_1)
  (adjacent t11_0 t10_0)
  (adjacent t11_0 t12_0)
  (color_assigner_machine_at t11_0 bgroup_c)
  (item_at t11_0) ;; cannot place blocks on machines
  (walkable t11_0)
  (adjacent t12_0 t12_1)
  (adjacent t12_0 t11_0)
  (adjacent t12_0 t13_0)
  (walkable t12_0)
  (adjacent t13_0 t13_1)
  (adjacent t13_0 t12_0)
  (adjacent t13_0 t14_0)
  (gate_at t13_0 bgroup_c)
  (item_at t13_0) ;; cannot place blocks on gates
  (adjacent t14_0 t14_1)
  (adjacent t14_0 t13_0)
  (adjacent t14_0 t15_0)
  (walkable t14_0)
  (adjacent t15_0 t15_1)
  (adjacent t15_0 t14_0)
  (color_assigner_machine_at t15_0 bgroup_d)
  (item_at t15_0) ;; cannot place blocks on machines
  (walkable t15_0)
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
  (gate_at t5_1 bgroup_a)
  (item_at t5_1) ;; cannot place blocks on gates
  (adjacent t6_1 t6_0)
  (adjacent t6_1 t6_2)
  (adjacent t6_1 t5_1)
  (adjacent t6_1 t7_1)
  (walkable t6_1)
  (adjacent t7_1 t7_0)
  (adjacent t7_1 t7_2)
  (adjacent t7_1 t6_1)
  (adjacent t7_1 t8_1)
  (walkable t7_1)
  (adjacent t8_1 t8_0)
  (adjacent t8_1 t8_2)
  (adjacent t8_1 t7_1)
  (adjacent t8_1 t9_1)
  (walkable t8_1)
  (adjacent t10_1 t10_0)
  (adjacent t10_1 t10_2)
  (adjacent t10_1 t9_1)
  (adjacent t10_1 t11_1)
  (walkable t10_1)
  (adjacent t11_1 t11_0)
  (adjacent t11_1 t11_2)
  (adjacent t11_1 t10_1)
  (adjacent t11_1 t12_1)
  (walkable t11_1)
  (adjacent t12_1 t12_0)
  (adjacent t12_1 t12_2)
  (adjacent t12_1 t11_1)
  (adjacent t12_1 t13_1)
  (walkable t12_1)
  (adjacent t14_1 t14_0)
  (adjacent t14_1 t14_2)
  (adjacent t14_1 t13_1)
  (adjacent t14_1 t15_1)
  (walkable t14_1)
  (adjacent t15_1 t15_0)
  (adjacent t15_1 t15_2)
  (adjacent t15_1 t14_1)
  (walkable t15_1)
  (adjacent t0_2 t0_1)
  (adjacent t0_2 t0_3)
  (adjacent t0_2 t1_2)
  (block_at t0_2 bgroup_a)
  (item_at t0_2)
  (walkable t0_2)
  (adjacent t1_2 t1_1)
  (adjacent t1_2 t1_3)
  (adjacent t1_2 t0_2)
  (adjacent t1_2 t2_2)
  (block_at t1_2 bgroup_a)
  (item_at t1_2)
  (walkable t1_2)
  (adjacent t2_2 t2_1)
  (adjacent t2_2 t2_3)
  (adjacent t2_2 t1_2)
  (adjacent t2_2 t3_2)
  (block_at t2_2 bgroup_a)
  (item_at t2_2)
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
  (teleporter_at t4_2 tgroup_t)
  (item_at t4_2)
  (walkable t4_2)
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
  (adjacent t10_2 t10_1)
  (adjacent t10_2 t10_3)
  (adjacent t10_2 t9_2)
  (adjacent t10_2 t11_2)
  (walkable t10_2)
  (adjacent t11_2 t11_1)
  (adjacent t11_2 t11_3)
  (adjacent t11_2 t10_2)
  (adjacent t11_2 t12_2)
  (walkable t11_2)
  (adjacent t12_2 t12_1)
  (adjacent t12_2 t12_3)
  (adjacent t12_2 t11_2)
  (adjacent t12_2 t13_2)
  (walkable t12_2)
  (adjacent t14_2 t14_1)
  (adjacent t14_2 t14_3)
  (adjacent t14_2 t13_2)
  (adjacent t14_2 t15_2)
  (walkable t14_2)
  (adjacent t15_2 t15_1)
  (adjacent t15_2 t15_3)
  (adjacent t15_2 t14_2)
  (walkable t15_2)
  (adjacent t0_3 t0_2)
  (adjacent t0_3 t1_3)
  (block_at t0_3 bgroup_a)
  (item_at t0_3)
  (walkable t0_3)
  (adjacent t1_3 t1_2)
  (adjacent t1_3 t0_3)
  (adjacent t1_3 t2_3)
  (block_at t1_3 bgroup_a)
  (item_at t1_3)
  (walkable t1_3)
  (adjacent t2_3 t2_2)
  (adjacent t2_3 t1_3)
  (adjacent t2_3 t3_3)
  (block_at t2_3 bgroup_a)
  (item_at t2_3)
  (walkable t2_3)
  (adjacent t3_3 t3_2)
  (adjacent t3_3 t2_3)
  (adjacent t3_3 t4_3)
  (walkable t3_3)
  (adjacent t4_3 t4_2)
  (adjacent t4_3 t3_3)
  (adjacent t4_3 t5_3)
  (teleporter_at t4_3 tgroup_t)
  (item_at t4_3)
  (walkable t4_3)
  (adjacent t6_3 t6_2)
  (adjacent t6_3 t5_3)
  (adjacent t6_3 t7_3)
  (walkable t6_3)
  (adjacent t7_3 t7_2)
  (adjacent t7_3 t6_3)
  (adjacent t7_3 t8_3)
  (walkable t7_3)
  (adjacent t8_3 t8_2)
  (adjacent t8_3 t7_3)
  (adjacent t8_3 t9_3)
  (walkable t8_3)
  (adjacent t9_3 t9_2)
  (adjacent t9_3 t8_3)
  (adjacent t9_3 t10_3)
  (gate_at t9_3 bgroup_b)
  (item_at t9_3) ;; cannot place blocks on gates
  (adjacent t10_3 t10_2)
  (adjacent t10_3 t9_3)
  (adjacent t10_3 t11_3)
  (walkable t10_3)
  (adjacent t11_3 t11_2)
  (adjacent t11_3 t10_3)
  (adjacent t11_3 t12_3)
  (walkable t11_3)
  (adjacent t12_3 t12_2)
  (adjacent t12_3 t11_3)
  (adjacent t12_3 t13_3)
  (walkable t12_3)
  (adjacent t14_3 t14_2)
  (adjacent t14_3 t13_3)
  (adjacent t14_3 t15_3)
  (walkable t14_3)
  (adjacent t15_3 t15_2)
  (adjacent t15_3 t14_3)
  (walkable t15_3)
)

(:goal (and
  (block_at t14_2 bgroup_d)
  (block_at t15_2 bgroup_d)
  (block_at t7_3 bgroup_d)
  (at robot_a t15_3)

))

)
