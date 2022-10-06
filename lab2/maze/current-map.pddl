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
  t11_7 - tile
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
  t11_8 - tile
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
  t11_9 - tile
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
  t11_10 - tile
  t0_11 - tile
  t1_11 - tile
  t2_11 - tile
  t3_11 - tile
  t4_11 - tile
  t5_11 - tile
  t6_11 - tile
  t7_11 - tile
  t8_11 - tile
  t9_11 - tile
  t10_11 - tile
  t11_11 - tile
 tgroup_exit - teleport_group
 tgroup_portal-room - teleport_group
 tgroup_unpaired - teleport_group
 bgroup_keya - block_group
 bgroup_uncolored - block_group
 bgroup_exit-gate - block_group
 bgroup_keyb - block_group
 bgroup_keyd - block_group
 bgroup_keyc - block_group
)

(:init
  (adjacent t0_0 t0_1)
  (adjacent t0_0 t1_0)
  (block_at t0_0 bgroup_uncolored)
  (item_at t0_0)
  (walkable t0_0)
  (adjacent t1_0 t1_1)
  (adjacent t1_0 t0_0)
  (adjacent t1_0 t2_0)
  (block_at t1_0 bgroup_uncolored)
  (item_at t1_0)
  (walkable t1_0)
  (adjacent t2_0 t2_1)
  (adjacent t2_0 t1_0)
  (adjacent t2_0 t3_0)
  (block_at t2_0 bgroup_uncolored)
  (item_at t2_0)
  (walkable t2_0)
  (adjacent t3_0 t3_1)
  (adjacent t3_0 t2_0)
  (adjacent t3_0 t4_0)
  (teleport_pairer_at t3_0 tgroup_portal-room)
  (item_at t3_0) ;; cannot place blocks on pairers
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
  (walkable t0_1)
  (adjacent t1_1 t1_0)
  (adjacent t1_1 t1_2)
  (adjacent t1_1 t0_1)
  (adjacent t1_1 t2_1)
  (block_at t1_1 bgroup_uncolored)
  (item_at t1_1)
  (walkable t1_1)
  (adjacent t2_1 t2_0)
  (adjacent t2_1 t2_2)
  (adjacent t2_1 t1_1)
  (adjacent t2_1 t3_1)
  (block_at t2_1 bgroup_uncolored)
  (item_at t2_1)
  (walkable t2_1)
  (adjacent t3_1 t3_0)
  (adjacent t3_1 t3_2)
  (adjacent t3_1 t2_1)
  (adjacent t3_1 t4_1)
  (block_at t3_1 bgroup_uncolored)
  (item_at t3_1)
  (walkable t3_1)
  (adjacent t5_1 t5_0)
  (adjacent t5_1 t5_2)
  (adjacent t5_1 t4_1)
  (adjacent t5_1 t6_1)
  (gate_at t5_1 bgroup_keyd)
  (item_at t5_1) ;; cannot place blocks on gates
  (adjacent t7_1 t7_0)
  (adjacent t7_1 t7_2)
  (adjacent t7_1 t6_1)
  (adjacent t7_1 t8_1)
  (walkable t7_1)
  (adjacent t8_1 t8_0)
  (adjacent t8_1 t8_2)
  (adjacent t8_1 t7_1)
  (adjacent t8_1 t9_1)
  (teleporter_at t8_1 tgroup_exit)
  (item_at t8_1)
  (walkable t8_1)
  (adjacent t9_1 t9_0)
  (adjacent t9_1 t9_2)
  (adjacent t9_1 t8_1)
  (adjacent t9_1 t10_1)
  (walkable t9_1)
  (adjacent t10_1 t10_0)
  (adjacent t10_1 t10_2)
  (adjacent t10_1 t9_1)
  (adjacent t10_1 t11_1)
  (walkable t10_1)
  (adjacent t11_1 t11_0)
  (adjacent t11_1 t11_2)
  (adjacent t11_1 t10_1)
  (walkable t11_1)
  (adjacent t0_2 t0_1)
  (adjacent t0_2 t0_3)
  (adjacent t0_2 t1_2)
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
  (adjacent t3_2 t3_1)
  (adjacent t3_2 t3_3)
  (adjacent t3_2 t2_2)
  (adjacent t3_2 t4_2)
  (block_at t3_2 bgroup_uncolored)
  (item_at t3_2)
  (walkable t3_2)
  (adjacent t5_2 t5_1)
  (adjacent t5_2 t5_3)
  (adjacent t5_2 t4_2)
  (adjacent t5_2 t6_2)
  (gate_at t5_2 bgroup_keyc)
  (item_at t5_2) ;; cannot place blocks on gates
  (adjacent t0_3 t0_2)
  (adjacent t0_3 t0_4)
  (adjacent t0_3 t1_3)
  (walkable t0_3)
  (adjacent t1_3 t1_2)
  (adjacent t1_3 t1_4)
  (adjacent t1_3 t0_3)
  (adjacent t1_3 t2_3)
  (walkable t1_3)
  (adjacent t2_3 t2_2)
  (adjacent t2_3 t2_4)
  (adjacent t2_3 t1_3)
  (adjacent t2_3 t3_3)
  (walkable t2_3)
  (adjacent t3_3 t3_2)
  (adjacent t3_3 t3_4)
  (adjacent t3_3 t2_3)
  (adjacent t3_3 t4_3)
  (walkable t3_3)
  (adjacent t5_3 t5_2)
  (adjacent t5_3 t5_4)
  (adjacent t5_3 t4_3)
  (adjacent t5_3 t6_3)
  (gate_at t5_3 bgroup_keyb)
  (item_at t5_3) ;; cannot place blocks on gates
  (adjacent t7_3 t7_2)
  (adjacent t7_3 t7_4)
  (adjacent t7_3 t6_3)
  (adjacent t7_3 t8_3)
  (walkable t7_3)
  (adjacent t8_3 t8_2)
  (adjacent t8_3 t8_4)
  (adjacent t8_3 t7_3)
  (adjacent t8_3 t9_3)
  (walkable t8_3)
  (adjacent t9_3 t9_2)
  (adjacent t9_3 t9_4)
  (adjacent t9_3 t8_3)
  (adjacent t9_3 t10_3)
  (walkable t9_3)
  (adjacent t10_3 t10_2)
  (adjacent t10_3 t10_4)
  (adjacent t10_3 t9_3)
  (adjacent t10_3 t11_3)
  (walkable t10_3)
  (adjacent t11_3 t11_2)
  (adjacent t11_3 t11_4)
  (adjacent t11_3 t10_3)
  (teleport_pairer_at t11_3 tgroup_exit)
  (item_at t11_3) ;; cannot place blocks on pairers
  (walkable t11_3)
  (adjacent t0_4 t0_3)
  (adjacent t0_4 t0_5)
  (adjacent t0_4 t1_4)
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
  (adjacent t3_4 t3_3)
  (adjacent t3_4 t3_5)
  (adjacent t3_4 t2_4)
  (adjacent t3_4 t4_4)
  (walkable t3_4)
  (adjacent t5_4 t5_3)
  (adjacent t5_4 t5_5)
  (adjacent t5_4 t4_4)
  (adjacent t5_4 t6_4)
  (gate_at t5_4 bgroup_keya)
  (item_at t5_4) ;; cannot place blocks on gates
  (adjacent t8_4 t8_3)
  (adjacent t8_4 t8_5)
  (adjacent t8_4 t7_4)
  (adjacent t8_4 t9_4)
  (gate_at t8_4 bgroup_keya)
  (item_at t8_4) ;; cannot place blocks on gates
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
  (adjacent t3_5 t3_4)
  (adjacent t3_5 t3_6)
  (adjacent t3_5 t2_5)
  (adjacent t3_5 t4_5)
  (walkable t3_5)
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
  (adjacent t7_5 t7_4)
  (adjacent t7_5 t7_6)
  (adjacent t7_5 t6_5)
  (adjacent t7_5 t8_5)
  (walkable t7_5)
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
  (adjacent t10_5 t11_5)
  (walkable t10_5)
  (adjacent t11_5 t11_4)
  (adjacent t11_5 t11_6)
  (adjacent t11_5 t10_5)
  (color_assigner_machine_at t11_5 bgroup_keya)
  (item_at t11_5) ;; cannot place blocks on machines
  (walkable t11_5)
  (adjacent t0_6 t0_5)
  (adjacent t0_6 t0_7)
  (adjacent t0_6 t1_6)
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
  (adjacent t3_6 t3_5)
  (adjacent t3_6 t3_7)
  (adjacent t3_6 t2_6)
  (adjacent t3_6 t4_6)
  (teleporter_at t3_6 tgroup_unpaired)
  (item_at t3_6)
  (walkable t3_6)
  (adjacent t4_6 t4_5)
  (adjacent t4_6 t4_7)
  (adjacent t4_6 t3_6)
  (adjacent t4_6 t5_6)
  (teleporter_at t4_6 tgroup_unpaired)
  (item_at t4_6)
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
  (adjacent t7_6 t7_5)
  (adjacent t7_6 t7_7)
  (adjacent t7_6 t6_6)
  (adjacent t7_6 t8_6)
  (color_assigner_machine_at t7_6 bgroup_exit-gate)
  (item_at t7_6) ;; cannot place blocks on machines
  (walkable t7_6)
  (adjacent t8_6 t8_5)
  (adjacent t8_6 t8_7)
  (adjacent t8_6 t7_6)
  (adjacent t8_6 t9_6)
  (walkable t8_6)
  (adjacent t9_6 t9_5)
  (adjacent t9_6 t9_7)
  (adjacent t9_6 t8_6)
  (adjacent t9_6 t10_6)
  (walkable t9_6)
  (adjacent t10_6 t10_5)
  (adjacent t10_6 t10_7)
  (adjacent t10_6 t9_6)
  (adjacent t10_6 t11_6)
  (walkable t10_6)
  (adjacent t11_6 t11_5)
  (adjacent t11_6 t11_7)
  (adjacent t11_6 t10_6)
  (color_assigner_machine_at t11_6 bgroup_keyb)
  (item_at t11_6) ;; cannot place blocks on machines
  (walkable t11_6)
  (adjacent t0_7 t0_6)
  (adjacent t0_7 t0_8)
  (adjacent t0_7 t1_7)
  (walkable t0_7)
  (adjacent t1_7 t1_6)
  (adjacent t1_7 t1_8)
  (adjacent t1_7 t0_7)
  (adjacent t1_7 t2_7)
  (walkable t1_7)
  (adjacent t2_7 t2_6)
  (adjacent t2_7 t2_8)
  (adjacent t2_7 t1_7)
  (adjacent t2_7 t3_7)
  (walkable t2_7)
  (adjacent t3_7 t3_6)
  (adjacent t3_7 t3_8)
  (adjacent t3_7 t2_7)
  (adjacent t3_7 t4_7)
  (teleporter_at t3_7 tgroup_unpaired)
  (item_at t3_7)
  (walkable t3_7)
  (adjacent t4_7 t4_6)
  (adjacent t4_7 t4_8)
  (adjacent t4_7 t3_7)
  (adjacent t4_7 t5_7)
  (teleporter_at t4_7 tgroup_unpaired)
  (item_at t4_7)
  (walkable t4_7)
  (adjacent t5_7 t5_6)
  (adjacent t5_7 t5_8)
  (adjacent t5_7 t4_7)
  (adjacent t5_7 t6_7)
  (walkable t5_7)
  (adjacent t6_7 t6_6)
  (adjacent t6_7 t6_8)
  (adjacent t6_7 t5_7)
  (adjacent t6_7 t7_7)
  (walkable t6_7)
  (adjacent t7_7 t7_6)
  (adjacent t7_7 t7_8)
  (adjacent t7_7 t6_7)
  (adjacent t7_7 t8_7)
  (walkable t7_7)
  (adjacent t8_7 t8_6)
  (adjacent t8_7 t8_8)
  (adjacent t8_7 t7_7)
  (adjacent t8_7 t9_7)
  (walkable t8_7)
  (adjacent t9_7 t9_6)
  (adjacent t9_7 t9_8)
  (adjacent t9_7 t8_7)
  (adjacent t9_7 t10_7)
  (walkable t9_7)
  (adjacent t10_7 t10_6)
  (adjacent t10_7 t10_8)
  (adjacent t10_7 t9_7)
  (adjacent t10_7 t11_7)
  (walkable t10_7)
  (adjacent t11_7 t11_6)
  (adjacent t11_7 t11_8)
  (adjacent t11_7 t10_7)
  (color_assigner_machine_at t11_7 bgroup_keyc)
  (item_at t11_7) ;; cannot place blocks on machines
  (walkable t11_7)
  (adjacent t0_8 t0_7)
  (adjacent t0_8 t0_9)
  (adjacent t0_8 t1_8)
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
  (adjacent t3_8 t3_7)
  (adjacent t3_8 t3_9)
  (adjacent t3_8 t2_8)
  (adjacent t3_8 t4_8)
  (walkable t3_8)
  (adjacent t4_8 t4_7)
  (adjacent t4_8 t4_9)
  (adjacent t4_8 t3_8)
  (adjacent t4_8 t5_8)
  (walkable t4_8)
  (adjacent t5_8 t5_7)
  (adjacent t5_8 t5_9)
  (adjacent t5_8 t4_8)
  (adjacent t5_8 t6_8)
  (walkable t5_8)
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
  (adjacent t3_9 t3_8)
  (adjacent t3_9 t3_10)
  (adjacent t3_9 t2_9)
  (adjacent t3_9 t4_9)
  (walkable t3_9)
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
  (adjacent t7_9 t7_8)
  (adjacent t7_9 t7_10)
  (adjacent t7_9 t6_9)
  (adjacent t7_9 t8_9)
  (teleporter_at t7_9 tgroup_portal-room)
  (item_at t7_9)
  (walkable t7_9)
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
  (adjacent t10_9 t11_9)
  (walkable t10_9)
  (adjacent t11_9 t11_8)
  (adjacent t11_9 t11_10)
  (adjacent t11_9 t10_9)
  (walkable t11_9)
  (adjacent t0_10 t0_9)
  (adjacent t0_10 t0_11)
  (adjacent t0_10 t1_10)
  (walkable t0_10)
  (adjacent t1_10 t1_9)
  (adjacent t1_10 t1_11)
  (adjacent t1_10 t0_10)
  (adjacent t1_10 t2_10)
  (walkable t1_10)
  (adjacent t2_10 t2_9)
  (adjacent t2_10 t2_11)
  (adjacent t2_10 t1_10)
  (adjacent t2_10 t3_10)
  (walkable t2_10)
  (adjacent t3_10 t3_9)
  (adjacent t3_10 t3_11)
  (adjacent t3_10 t2_10)
  (adjacent t3_10 t4_10)
  (walkable t3_10)
  (adjacent t4_10 t4_9)
  (adjacent t4_10 t4_11)
  (adjacent t4_10 t3_10)
  (adjacent t4_10 t5_10)
  (walkable t4_10)
  (adjacent t5_10 t5_9)
  (adjacent t5_10 t5_11)
  (adjacent t5_10 t4_10)
  (adjacent t5_10 t6_10)
  (walkable t5_10)
  (adjacent t7_10 t7_9)
  (adjacent t7_10 t7_11)
  (adjacent t7_10 t6_10)
  (adjacent t7_10 t8_10)
  (walkable t7_10)
  (adjacent t8_10 t8_9)
  (adjacent t8_10 t8_11)
  (adjacent t8_10 t7_10)
  (adjacent t8_10 t9_10)
  (walkable t8_10)
  (adjacent t9_10 t9_9)
  (adjacent t9_10 t9_11)
  (adjacent t9_10 t8_10)
  (adjacent t9_10 t10_10)
  (walkable t9_10)
  (adjacent t10_10 t10_9)
  (adjacent t10_10 t10_11)
  (adjacent t10_10 t9_10)
  (adjacent t10_10 t11_10)
  (walkable t10_10)
  (adjacent t11_10 t11_9)
  (adjacent t11_10 t11_11)
  (adjacent t11_10 t10_10)
  (walkable t11_10)
  (adjacent t0_11 t0_10)
  (adjacent t0_11 t1_11)
  (at t0_11)  ;; This is the tile that the agent starts on
  (walkable t0_11)
  (adjacent t1_11 t1_10)
  (adjacent t1_11 t0_11)
  (adjacent t1_11 t2_11)
  (walkable t1_11)
  (adjacent t2_11 t2_10)
  (adjacent t2_11 t1_11)
  (adjacent t2_11 t3_11)
  (color_assigner_machine_at t2_11 bgroup_keyd)
  (item_at t2_11) ;; cannot place blocks on machines
  (walkable t2_11)
  (adjacent t3_11 t3_10)
  (adjacent t3_11 t2_11)
  (adjacent t3_11 t4_11)
  (walkable t3_11)
  (adjacent t4_11 t4_10)
  (adjacent t4_11 t3_11)
  (adjacent t4_11 t5_11)
  (walkable t4_11)
  (adjacent t5_11 t5_10)
  (adjacent t5_11 t4_11)
  (adjacent t5_11 t6_11)
  (teleport_unpairer_at t5_11)
  (item_at t5_11) ;; cannot place blocks on machines
  (walkable t5_11)
  (adjacent t7_11 t7_10)
  (adjacent t7_11 t6_11)
  (adjacent t7_11 t8_11)
  (walkable t7_11)
  (adjacent t8_11 t8_10)
  (adjacent t8_11 t7_11)
  (adjacent t8_11 t9_11)
  (walkable t8_11)
  (adjacent t9_11 t9_10)
  (adjacent t9_11 t8_11)
  (adjacent t9_11 t10_11)
  (walkable t9_11)
  (adjacent t10_11 t10_10)
  (adjacent t10_11 t9_11)
  (adjacent t10_11 t11_11)
  (walkable t10_11)
  (adjacent t11_11 t11_10)
  (adjacent t11_11 t10_11)
  (color_assigner_machine_at t11_11 bgroup_exit-gate)
  (item_at t11_11) ;; cannot place blocks on machines
  (walkable t11_11)
)

(:goal (and
  (at t11_0)  ;; This is the tile that the agent should end on

))

)
