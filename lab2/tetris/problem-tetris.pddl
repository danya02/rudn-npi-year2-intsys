(define (problem tetris_problem)
(:domain tetris)
(:objects
  tile_0_0 - tile
  tile_0_1 - tile
  tile_0_2 - tile
  tile_0_3 - tile
  tile_0_4 - tile
  tile_0_5 - tile
  tile_0_6 - tile
  tile_0_7 - tile
  tile_0_8 - tile
  tile_0_9 - tile
  tile_1_0 - tile
  tile_1_1 - tile
  tile_1_2 - tile
  tile_1_3 - tile
  tile_1_4 - tile
  tile_1_5 - tile
  tile_1_6 - tile
  tile_1_7 - tile
  tile_1_8 - tile
  tile_1_9 - tile
  tile_2_0 - tile
  tile_2_1 - tile
  tile_2_2 - tile
  tile_2_3 - tile
  tile_2_4 - tile
  tile_2_5 - tile
  tile_2_6 - tile
  tile_2_7 - tile
  tile_2_8 - tile
  tile_2_9 - tile
  tile_3_0 - tile
  tile_3_1 - tile
  tile_3_2 - tile
  tile_3_3 - tile
  tile_3_4 - tile
  tile_3_5 - tile
  tile_3_6 - tile
  tile_3_7 - tile
  tile_3_8 - tile
  tile_3_9 - tile
  tile_4_0 - tile
  tile_4_1 - tile
  tile_4_2 - tile
  tile_4_3 - tile
  tile_4_4 - tile
  tile_4_5 - tile
  tile_4_6 - tile
  tile_4_7 - tile
  tile_4_8 - tile
  tile_4_9 - tile
  tile_5_0 - tile
  tile_5_1 - tile
  tile_5_2 - tile
  tile_5_3 - tile
  tile_5_4 - tile
  tile_5_5 - tile
  tile_5_6 - tile
  tile_5_7 - tile
  tile_5_8 - tile
  tile_5_9 - tile
  tile_6_0 - tile
  tile_6_1 - tile
  tile_6_2 - tile
  tile_6_3 - tile
  tile_6_4 - tile
  tile_6_5 - tile
  tile_6_6 - tile
  tile_6_7 - tile
  tile_6_8 - tile
  tile_6_9 - tile
  tile_7_0 - tile
  tile_7_1 - tile
  tile_7_2 - tile
  tile_7_3 - tile
  tile_7_4 - tile
  tile_7_5 - tile
  tile_7_6 - tile
  tile_7_7 - tile
  tile_7_8 - tile
  tile_7_9 - tile
  tile_8_0 - tile
  tile_8_1 - tile
  tile_8_2 - tile
  tile_8_3 - tile
  tile_8_4 - tile
  tile_8_5 - tile
  tile_8_6 - tile
  tile_8_7 - tile
  tile_8_8 - tile
  tile_8_9 - tile
  tile_9_0 - tile
  tile_9_1 - tile
  tile_9_2 - tile
  tile_9_3 - tile
  tile_9_4 - tile
  tile_9_5 - tile
  tile_9_6 - tile
  tile_9_7 - tile
  tile_9_8 - tile
  tile_9_9 - tile
  tile_10_0 - tile
  tile_10_1 - tile
  tile_10_2 - tile
  tile_10_3 - tile
  tile_10_4 - tile
  tile_10_5 - tile
  tile_10_6 - tile
  tile_10_7 - tile
  tile_10_8 - tile
  tile_10_9 - tile
  tile_11_0 - tile
  tile_11_1 - tile
  tile_11_2 - tile
  tile_11_3 - tile
  tile_11_4 - tile
  tile_11_5 - tile
  tile_11_6 - tile
  tile_11_7 - tile
  tile_11_8 - tile
  tile_11_9 - tile
  tile_12_0 - tile
  tile_12_1 - tile
  tile_12_2 - tile
  tile_12_3 - tile
  tile_12_4 - tile
  tile_12_5 - tile
  tile_12_6 - tile
  tile_12_7 - tile
  tile_12_8 - tile
  tile_12_9 - tile
  tile_13_0 - tile
  tile_13_1 - tile
  tile_13_2 - tile
  tile_13_3 - tile
  tile_13_4 - tile
  tile_13_5 - tile
  tile_13_6 - tile
  tile_13_7 - tile
  tile_13_8 - tile
  tile_13_9 - tile
  tile_14_0 - tile
  tile_14_1 - tile
  tile_14_2 - tile
  tile_14_3 - tile
  tile_14_4 - tile
  tile_14_5 - tile
  tile_14_6 - tile
  tile_14_7 - tile
  tile_14_8 - tile
  tile_14_9 - tile
  tile_15_0 - tile
  tile_15_1 - tile
  tile_15_2 - tile
  tile_15_3 - tile
  tile_15_4 - tile
  tile_15_5 - tile
  tile_15_6 - tile
  tile_15_7 - tile
  tile_15_8 - tile
  tile_15_9 - tile
  tile_16_0 - tile
  tile_16_1 - tile
  tile_16_2 - tile
  tile_16_3 - tile
  tile_16_4 - tile
  tile_16_5 - tile
  tile_16_6 - tile
  tile_16_7 - tile
  tile_16_8 - tile
  tile_16_9 - tile
  tile_17_0 - tile
  tile_17_1 - tile
  tile_17_2 - tile
  tile_17_3 - tile
  tile_17_4 - tile
  tile_17_5 - tile
  tile_17_6 - tile
  tile_17_7 - tile
  tile_17_8 - tile
  tile_17_9 - tile
  tile_18_0 - tile
  tile_18_1 - tile
  tile_18_2 - tile
  tile_18_3 - tile
  tile_18_4 - tile
  tile_18_5 - tile
  tile_18_6 - tile
  tile_18_7 - tile
  tile_18_8 - tile
  tile_18_9 - tile
  tile_19_0 - tile
  tile_19_1 - tile
  tile_19_2 - tile
  tile_19_3 - tile
  tile_19_4 - tile
  tile_19_5 - tile
  tile_19_6 - tile
  tile_19_7 - tile
  tile_19_8 - tile
  tile_19_9 - tile
)
(:init
  (left_of tile_0_1 tile_0_0)
  (left_of tile_0_2 tile_0_1)
  (left_of tile_0_3 tile_0_2)
  (left_of tile_0_4 tile_0_3)
  (left_of tile_0_5 tile_0_4)
  (left_of tile_0_6 tile_0_5)
  (left_of tile_0_7 tile_0_6)
  (left_of tile_0_8 tile_0_7)
  (left_of tile_0_9 tile_0_8)
  (left_of tile_1_1 tile_1_0)
  (left_of tile_1_2 tile_1_1)
  (left_of tile_1_3 tile_1_2)
  (left_of tile_1_4 tile_1_3)
  (left_of tile_1_5 tile_1_4)
  (left_of tile_1_6 tile_1_5)
  (left_of tile_1_7 tile_1_6)
  (left_of tile_1_8 tile_1_7)
  (left_of tile_1_9 tile_1_8)
  (left_of tile_2_1 tile_2_0)
  (left_of tile_2_2 tile_2_1)
  (left_of tile_2_3 tile_2_2)
  (left_of tile_2_4 tile_2_3)
  (left_of tile_2_5 tile_2_4)
  (left_of tile_2_6 tile_2_5)
  (left_of tile_2_7 tile_2_6)
  (left_of tile_2_8 tile_2_7)
  (left_of tile_2_9 tile_2_8)
  (left_of tile_3_1 tile_3_0)
  (left_of tile_3_2 tile_3_1)
  (left_of tile_3_3 tile_3_2)
  (left_of tile_3_4 tile_3_3)
  (left_of tile_3_5 tile_3_4)
  (left_of tile_3_6 tile_3_5)
  (left_of tile_3_7 tile_3_6)
  (left_of tile_3_8 tile_3_7)
  (left_of tile_3_9 tile_3_8)
  (left_of tile_4_1 tile_4_0)
  (left_of tile_4_2 tile_4_1)
  (left_of tile_4_3 tile_4_2)
  (left_of tile_4_4 tile_4_3)
  (left_of tile_4_5 tile_4_4)
  (left_of tile_4_6 tile_4_5)
  (left_of tile_4_7 tile_4_6)
  (left_of tile_4_8 tile_4_7)
  (left_of tile_4_9 tile_4_8)
  (left_of tile_5_1 tile_5_0)
  (left_of tile_5_2 tile_5_1)
  (left_of tile_5_3 tile_5_2)
  (left_of tile_5_4 tile_5_3)
  (left_of tile_5_5 tile_5_4)
  (left_of tile_5_6 tile_5_5)
  (left_of tile_5_7 tile_5_6)
  (left_of tile_5_8 tile_5_7)
  (left_of tile_5_9 tile_5_8)
  (left_of tile_6_1 tile_6_0)
  (left_of tile_6_2 tile_6_1)
  (left_of tile_6_3 tile_6_2)
  (left_of tile_6_4 tile_6_3)
  (left_of tile_6_5 tile_6_4)
  (left_of tile_6_6 tile_6_5)
  (left_of tile_6_7 tile_6_6)
  (left_of tile_6_8 tile_6_7)
  (left_of tile_6_9 tile_6_8)
  (left_of tile_7_1 tile_7_0)
  (left_of tile_7_2 tile_7_1)
  (left_of tile_7_3 tile_7_2)
  (left_of tile_7_4 tile_7_3)
  (left_of tile_7_5 tile_7_4)
  (left_of tile_7_6 tile_7_5)
  (left_of tile_7_7 tile_7_6)
  (left_of tile_7_8 tile_7_7)
  (left_of tile_7_9 tile_7_8)
  (left_of tile_8_1 tile_8_0)
  (left_of tile_8_2 tile_8_1)
  (left_of tile_8_3 tile_8_2)
  (left_of tile_8_4 tile_8_3)
  (left_of tile_8_5 tile_8_4)
  (left_of tile_8_6 tile_8_5)
  (left_of tile_8_7 tile_8_6)
  (left_of tile_8_8 tile_8_7)
  (left_of tile_8_9 tile_8_8)
  (left_of tile_9_1 tile_9_0)
  (left_of tile_9_2 tile_9_1)
  (left_of tile_9_3 tile_9_2)
  (left_of tile_9_4 tile_9_3)
  (left_of tile_9_5 tile_9_4)
  (left_of tile_9_6 tile_9_5)
  (left_of tile_9_7 tile_9_6)
  (left_of tile_9_8 tile_9_7)
  (left_of tile_9_9 tile_9_8)
  (left_of tile_10_1 tile_10_0)
  (left_of tile_10_2 tile_10_1)
  (left_of tile_10_3 tile_10_2)
  (left_of tile_10_4 tile_10_3)
  (left_of tile_10_5 tile_10_4)
  (left_of tile_10_6 tile_10_5)
  (left_of tile_10_7 tile_10_6)
  (left_of tile_10_8 tile_10_7)
  (left_of tile_10_9 tile_10_8)
  (left_of tile_11_1 tile_11_0)
  (left_of tile_11_2 tile_11_1)
  (left_of tile_11_3 tile_11_2)
  (left_of tile_11_4 tile_11_3)
  (left_of tile_11_5 tile_11_4)
  (left_of tile_11_6 tile_11_5)
  (left_of tile_11_7 tile_11_6)
  (left_of tile_11_8 tile_11_7)
  (left_of tile_11_9 tile_11_8)
  (left_of tile_12_1 tile_12_0)
  (left_of tile_12_2 tile_12_1)
  (left_of tile_12_3 tile_12_2)
  (left_of tile_12_4 tile_12_3)
  (left_of tile_12_5 tile_12_4)
  (left_of tile_12_6 tile_12_5)
  (left_of tile_12_7 tile_12_6)
  (left_of tile_12_8 tile_12_7)
  (left_of tile_12_9 tile_12_8)
  (left_of tile_13_1 tile_13_0)
  (left_of tile_13_2 tile_13_1)
  (left_of tile_13_3 tile_13_2)
  (left_of tile_13_4 tile_13_3)
  (left_of tile_13_5 tile_13_4)
  (left_of tile_13_6 tile_13_5)
  (left_of tile_13_7 tile_13_6)
  (left_of tile_13_8 tile_13_7)
  (left_of tile_13_9 tile_13_8)
  (left_of tile_14_1 tile_14_0)
  (left_of tile_14_2 tile_14_1)
  (left_of tile_14_3 tile_14_2)
  (left_of tile_14_4 tile_14_3)
  (left_of tile_14_5 tile_14_4)
  (left_of tile_14_6 tile_14_5)
  (left_of tile_14_7 tile_14_6)
  (left_of tile_14_8 tile_14_7)
  (left_of tile_14_9 tile_14_8)
  (left_of tile_15_1 tile_15_0)
  (left_of tile_15_2 tile_15_1)
  (left_of tile_15_3 tile_15_2)
  (left_of tile_15_4 tile_15_3)
  (left_of tile_15_5 tile_15_4)
  (left_of tile_15_6 tile_15_5)
  (left_of tile_15_7 tile_15_6)
  (left_of tile_15_8 tile_15_7)
  (left_of tile_15_9 tile_15_8)
  (left_of tile_16_1 tile_16_0)
  (left_of tile_16_2 tile_16_1)
  (left_of tile_16_3 tile_16_2)
  (left_of tile_16_4 tile_16_3)
  (left_of tile_16_5 tile_16_4)
  (left_of tile_16_6 tile_16_5)
  (left_of tile_16_7 tile_16_6)
  (left_of tile_16_8 tile_16_7)
  (left_of tile_16_9 tile_16_8)
  (left_of tile_17_1 tile_17_0)
  (left_of tile_17_2 tile_17_1)
  (left_of tile_17_3 tile_17_2)
  (left_of tile_17_4 tile_17_3)
  (left_of tile_17_5 tile_17_4)
  (left_of tile_17_6 tile_17_5)
  (left_of tile_17_7 tile_17_6)
  (left_of tile_17_8 tile_17_7)
  (left_of tile_17_9 tile_17_8)
  (left_of tile_18_1 tile_18_0)
  (left_of tile_18_2 tile_18_1)
  (left_of tile_18_3 tile_18_2)
  (left_of tile_18_4 tile_18_3)
  (left_of tile_18_5 tile_18_4)
  (left_of tile_18_6 tile_18_5)
  (left_of tile_18_7 tile_18_6)
  (left_of tile_18_8 tile_18_7)
  (left_of tile_18_9 tile_18_8)
  (left_of tile_19_1 tile_19_0)
  (left_of tile_19_2 tile_19_1)
  (left_of tile_19_3 tile_19_2)
  (left_of tile_19_4 tile_19_3)
  (left_of tile_19_5 tile_19_4)
  (left_of tile_19_6 tile_19_5)
  (left_of tile_19_7 tile_19_6)
  (left_of tile_19_8 tile_19_7)
  (left_of tile_19_9 tile_19_8)
  (right_of tile_0_0 tile_0_1)
  (right_of tile_0_1 tile_0_2)
  (right_of tile_0_2 tile_0_3)
  (right_of tile_0_3 tile_0_4)
  (right_of tile_0_4 tile_0_5)
  (right_of tile_0_5 tile_0_6)
  (right_of tile_0_6 tile_0_7)
  (right_of tile_0_7 tile_0_8)
  (right_of tile_0_8 tile_0_9)
  (right_of tile_1_0 tile_1_1)
  (right_of tile_1_1 tile_1_2)
  (right_of tile_1_2 tile_1_3)
  (right_of tile_1_3 tile_1_4)
  (right_of tile_1_4 tile_1_5)
  (right_of tile_1_5 tile_1_6)
  (right_of tile_1_6 tile_1_7)
  (right_of tile_1_7 tile_1_8)
  (right_of tile_1_8 tile_1_9)
  (right_of tile_2_0 tile_2_1)
  (right_of tile_2_1 tile_2_2)
  (right_of tile_2_2 tile_2_3)
  (right_of tile_2_3 tile_2_4)
  (right_of tile_2_4 tile_2_5)
  (right_of tile_2_5 tile_2_6)
  (right_of tile_2_6 tile_2_7)
  (right_of tile_2_7 tile_2_8)
  (right_of tile_2_8 tile_2_9)
  (right_of tile_3_0 tile_3_1)
  (right_of tile_3_1 tile_3_2)
  (right_of tile_3_2 tile_3_3)
  (right_of tile_3_3 tile_3_4)
  (right_of tile_3_4 tile_3_5)
  (right_of tile_3_5 tile_3_6)
  (right_of tile_3_6 tile_3_7)
  (right_of tile_3_7 tile_3_8)
  (right_of tile_3_8 tile_3_9)
  (right_of tile_4_0 tile_4_1)
  (right_of tile_4_1 tile_4_2)
  (right_of tile_4_2 tile_4_3)
  (right_of tile_4_3 tile_4_4)
  (right_of tile_4_4 tile_4_5)
  (right_of tile_4_5 tile_4_6)
  (right_of tile_4_6 tile_4_7)
  (right_of tile_4_7 tile_4_8)
  (right_of tile_4_8 tile_4_9)
  (right_of tile_5_0 tile_5_1)
  (right_of tile_5_1 tile_5_2)
  (right_of tile_5_2 tile_5_3)
  (right_of tile_5_3 tile_5_4)
  (right_of tile_5_4 tile_5_5)
  (right_of tile_5_5 tile_5_6)
  (right_of tile_5_6 tile_5_7)
  (right_of tile_5_7 tile_5_8)
  (right_of tile_5_8 tile_5_9)
  (right_of tile_6_0 tile_6_1)
  (right_of tile_6_1 tile_6_2)
  (right_of tile_6_2 tile_6_3)
  (right_of tile_6_3 tile_6_4)
  (right_of tile_6_4 tile_6_5)
  (right_of tile_6_5 tile_6_6)
  (right_of tile_6_6 tile_6_7)
  (right_of tile_6_7 tile_6_8)
  (right_of tile_6_8 tile_6_9)
  (right_of tile_7_0 tile_7_1)
  (right_of tile_7_1 tile_7_2)
  (right_of tile_7_2 tile_7_3)
  (right_of tile_7_3 tile_7_4)
  (right_of tile_7_4 tile_7_5)
  (right_of tile_7_5 tile_7_6)
  (right_of tile_7_6 tile_7_7)
  (right_of tile_7_7 tile_7_8)
  (right_of tile_7_8 tile_7_9)
  (right_of tile_8_0 tile_8_1)
  (right_of tile_8_1 tile_8_2)
  (right_of tile_8_2 tile_8_3)
  (right_of tile_8_3 tile_8_4)
  (right_of tile_8_4 tile_8_5)
  (right_of tile_8_5 tile_8_6)
  (right_of tile_8_6 tile_8_7)
  (right_of tile_8_7 tile_8_8)
  (right_of tile_8_8 tile_8_9)
  (right_of tile_9_0 tile_9_1)
  (right_of tile_9_1 tile_9_2)
  (right_of tile_9_2 tile_9_3)
  (right_of tile_9_3 tile_9_4)
  (right_of tile_9_4 tile_9_5)
  (right_of tile_9_5 tile_9_6)
  (right_of tile_9_6 tile_9_7)
  (right_of tile_9_7 tile_9_8)
  (right_of tile_9_8 tile_9_9)
  (right_of tile_10_0 tile_10_1)
  (right_of tile_10_1 tile_10_2)
  (right_of tile_10_2 tile_10_3)
  (right_of tile_10_3 tile_10_4)
  (right_of tile_10_4 tile_10_5)
  (right_of tile_10_5 tile_10_6)
  (right_of tile_10_6 tile_10_7)
  (right_of tile_10_7 tile_10_8)
  (right_of tile_10_8 tile_10_9)
  (right_of tile_11_0 tile_11_1)
  (right_of tile_11_1 tile_11_2)
  (right_of tile_11_2 tile_11_3)
  (right_of tile_11_3 tile_11_4)
  (right_of tile_11_4 tile_11_5)
  (right_of tile_11_5 tile_11_6)
  (right_of tile_11_6 tile_11_7)
  (right_of tile_11_7 tile_11_8)
  (right_of tile_11_8 tile_11_9)
  (right_of tile_12_0 tile_12_1)
  (right_of tile_12_1 tile_12_2)
  (right_of tile_12_2 tile_12_3)
  (right_of tile_12_3 tile_12_4)
  (right_of tile_12_4 tile_12_5)
  (right_of tile_12_5 tile_12_6)
  (right_of tile_12_6 tile_12_7)
  (right_of tile_12_7 tile_12_8)
  (right_of tile_12_8 tile_12_9)
  (right_of tile_13_0 tile_13_1)
  (right_of tile_13_1 tile_13_2)
  (right_of tile_13_2 tile_13_3)
  (right_of tile_13_3 tile_13_4)
  (right_of tile_13_4 tile_13_5)
  (right_of tile_13_5 tile_13_6)
  (right_of tile_13_6 tile_13_7)
  (right_of tile_13_7 tile_13_8)
  (right_of tile_13_8 tile_13_9)
  (right_of tile_14_0 tile_14_1)
  (right_of tile_14_1 tile_14_2)
  (right_of tile_14_2 tile_14_3)
  (right_of tile_14_3 tile_14_4)
  (right_of tile_14_4 tile_14_5)
  (right_of tile_14_5 tile_14_6)
  (right_of tile_14_6 tile_14_7)
  (right_of tile_14_7 tile_14_8)
  (right_of tile_14_8 tile_14_9)
  (right_of tile_15_0 tile_15_1)
  (right_of tile_15_1 tile_15_2)
  (right_of tile_15_2 tile_15_3)
  (right_of tile_15_3 tile_15_4)
  (right_of tile_15_4 tile_15_5)
  (right_of tile_15_5 tile_15_6)
  (right_of tile_15_6 tile_15_7)
  (right_of tile_15_7 tile_15_8)
  (right_of tile_15_8 tile_15_9)
  (right_of tile_16_0 tile_16_1)
  (right_of tile_16_1 tile_16_2)
  (right_of tile_16_2 tile_16_3)
  (right_of tile_16_3 tile_16_4)
  (right_of tile_16_4 tile_16_5)
  (right_of tile_16_5 tile_16_6)
  (right_of tile_16_6 tile_16_7)
  (right_of tile_16_7 tile_16_8)
  (right_of tile_16_8 tile_16_9)
  (right_of tile_17_0 tile_17_1)
  (right_of tile_17_1 tile_17_2)
  (right_of tile_17_2 tile_17_3)
  (right_of tile_17_3 tile_17_4)
  (right_of tile_17_4 tile_17_5)
  (right_of tile_17_5 tile_17_6)
  (right_of tile_17_6 tile_17_7)
  (right_of tile_17_7 tile_17_8)
  (right_of tile_17_8 tile_17_9)
  (right_of tile_18_0 tile_18_1)
  (right_of tile_18_1 tile_18_2)
  (right_of tile_18_2 tile_18_3)
  (right_of tile_18_3 tile_18_4)
  (right_of tile_18_4 tile_18_5)
  (right_of tile_18_5 tile_18_6)
  (right_of tile_18_6 tile_18_7)
  (right_of tile_18_7 tile_18_8)
  (right_of tile_18_8 tile_18_9)
  (right_of tile_19_0 tile_19_1)
  (right_of tile_19_1 tile_19_2)
  (right_of tile_19_2 tile_19_3)
  (right_of tile_19_3 tile_19_4)
  (right_of tile_19_4 tile_19_5)
  (right_of tile_19_5 tile_19_6)
  (right_of tile_19_6 tile_19_7)
  (right_of tile_19_7 tile_19_8)
  (right_of tile_19_8 tile_19_9)
  (below tile_1_0 tile_0_0)
  (below tile_1_1 tile_0_1)
  (below tile_1_2 tile_0_2)
  (below tile_1_3 tile_0_3)
  (below tile_1_4 tile_0_4)
  (below tile_1_5 tile_0_5)
  (below tile_1_6 tile_0_6)
  (below tile_1_7 tile_0_7)
  (below tile_1_8 tile_0_8)
  (below tile_1_9 tile_0_9)
  (below tile_2_0 tile_1_0)
  (below tile_2_1 tile_1_1)
  (below tile_2_2 tile_1_2)
  (below tile_2_3 tile_1_3)
  (below tile_2_4 tile_1_4)
  (below tile_2_5 tile_1_5)
  (below tile_2_6 tile_1_6)
  (below tile_2_7 tile_1_7)
  (below tile_2_8 tile_1_8)
  (below tile_2_9 tile_1_9)
  (below tile_3_0 tile_2_0)
  (below tile_3_1 tile_2_1)
  (below tile_3_2 tile_2_2)
  (below tile_3_3 tile_2_3)
  (below tile_3_4 tile_2_4)
  (below tile_3_5 tile_2_5)
  (below tile_3_6 tile_2_6)
  (below tile_3_7 tile_2_7)
  (below tile_3_8 tile_2_8)
  (below tile_3_9 tile_2_9)
  (below tile_4_0 tile_3_0)
  (below tile_4_1 tile_3_1)
  (below tile_4_2 tile_3_2)
  (below tile_4_3 tile_3_3)
  (below tile_4_4 tile_3_4)
  (below tile_4_5 tile_3_5)
  (below tile_4_6 tile_3_6)
  (below tile_4_7 tile_3_7)
  (below tile_4_8 tile_3_8)
  (below tile_4_9 tile_3_9)
  (below tile_5_0 tile_4_0)
  (below tile_5_1 tile_4_1)
  (below tile_5_2 tile_4_2)
  (below tile_5_3 tile_4_3)
  (below tile_5_4 tile_4_4)
  (below tile_5_5 tile_4_5)
  (below tile_5_6 tile_4_6)
  (below tile_5_7 tile_4_7)
  (below tile_5_8 tile_4_8)
  (below tile_5_9 tile_4_9)
  (below tile_6_0 tile_5_0)
  (below tile_6_1 tile_5_1)
  (below tile_6_2 tile_5_2)
  (below tile_6_3 tile_5_3)
  (below tile_6_4 tile_5_4)
  (below tile_6_5 tile_5_5)
  (below tile_6_6 tile_5_6)
  (below tile_6_7 tile_5_7)
  (below tile_6_8 tile_5_8)
  (below tile_6_9 tile_5_9)
  (below tile_7_0 tile_6_0)
  (below tile_7_1 tile_6_1)
  (below tile_7_2 tile_6_2)
  (below tile_7_3 tile_6_3)
  (below tile_7_4 tile_6_4)
  (below tile_7_5 tile_6_5)
  (below tile_7_6 tile_6_6)
  (below tile_7_7 tile_6_7)
  (below tile_7_8 tile_6_8)
  (below tile_7_9 tile_6_9)
  (below tile_8_0 tile_7_0)
  (below tile_8_1 tile_7_1)
  (below tile_8_2 tile_7_2)
  (below tile_8_3 tile_7_3)
  (below tile_8_4 tile_7_4)
  (below tile_8_5 tile_7_5)
  (below tile_8_6 tile_7_6)
  (below tile_8_7 tile_7_7)
  (below tile_8_8 tile_7_8)
  (below tile_8_9 tile_7_9)
  (below tile_9_0 tile_8_0)
  (below tile_9_1 tile_8_1)
  (below tile_9_2 tile_8_2)
  (below tile_9_3 tile_8_3)
  (below tile_9_4 tile_8_4)
  (below tile_9_5 tile_8_5)
  (below tile_9_6 tile_8_6)
  (below tile_9_7 tile_8_7)
  (below tile_9_8 tile_8_8)
  (below tile_9_9 tile_8_9)
  (below tile_10_0 tile_9_0)
  (below tile_10_1 tile_9_1)
  (below tile_10_2 tile_9_2)
  (below tile_10_3 tile_9_3)
  (below tile_10_4 tile_9_4)
  (below tile_10_5 tile_9_5)
  (below tile_10_6 tile_9_6)
  (below tile_10_7 tile_9_7)
  (below tile_10_8 tile_9_8)
  (below tile_10_9 tile_9_9)
  (below tile_11_0 tile_10_0)
  (below tile_11_1 tile_10_1)
  (below tile_11_2 tile_10_2)
  (below tile_11_3 tile_10_3)
  (below tile_11_4 tile_10_4)
  (below tile_11_5 tile_10_5)
  (below tile_11_6 tile_10_6)
  (below tile_11_7 tile_10_7)
  (below tile_11_8 tile_10_8)
  (below tile_11_9 tile_10_9)
  (below tile_12_0 tile_11_0)
  (below tile_12_1 tile_11_1)
  (below tile_12_2 tile_11_2)
  (below tile_12_3 tile_11_3)
  (below tile_12_4 tile_11_4)
  (below tile_12_5 tile_11_5)
  (below tile_12_6 tile_11_6)
  (below tile_12_7 tile_11_7)
  (below tile_12_8 tile_11_8)
  (below tile_12_9 tile_11_9)
  (below tile_13_0 tile_12_0)
  (below tile_13_1 tile_12_1)
  (below tile_13_2 tile_12_2)
  (below tile_13_3 tile_12_3)
  (below tile_13_4 tile_12_4)
  (below tile_13_5 tile_12_5)
  (below tile_13_6 tile_12_6)
  (below tile_13_7 tile_12_7)
  (below tile_13_8 tile_12_8)
  (below tile_13_9 tile_12_9)
  (below tile_14_0 tile_13_0)
  (below tile_14_1 tile_13_1)
  (below tile_14_2 tile_13_2)
  (below tile_14_3 tile_13_3)
  (below tile_14_4 tile_13_4)
  (below tile_14_5 tile_13_5)
  (below tile_14_6 tile_13_6)
  (below tile_14_7 tile_13_7)
  (below tile_14_8 tile_13_8)
  (below tile_14_9 tile_13_9)
  (below tile_15_0 tile_14_0)
  (below tile_15_1 tile_14_1)
  (below tile_15_2 tile_14_2)
  (below tile_15_3 tile_14_3)
  (below tile_15_4 tile_14_4)
  (below tile_15_5 tile_14_5)
  (below tile_15_6 tile_14_6)
  (below tile_15_7 tile_14_7)
  (below tile_15_8 tile_14_8)
  (below tile_15_9 tile_14_9)
  (below tile_16_0 tile_15_0)
  (below tile_16_1 tile_15_1)
  (below tile_16_2 tile_15_2)
  (below tile_16_3 tile_15_3)
  (below tile_16_4 tile_15_4)
  (below tile_16_5 tile_15_5)
  (below tile_16_6 tile_15_6)
  (below tile_16_7 tile_15_7)
  (below tile_16_8 tile_15_8)
  (below tile_16_9 tile_15_9)
  (below tile_17_0 tile_16_0)
  (below tile_17_1 tile_16_1)
  (below tile_17_2 tile_16_2)
  (below tile_17_3 tile_16_3)
  (below tile_17_4 tile_16_4)
  (below tile_17_5 tile_16_5)
  (below tile_17_6 tile_16_6)
  (below tile_17_7 tile_16_7)
  (below tile_17_8 tile_16_8)
  (below tile_17_9 tile_16_9)
  (below tile_18_0 tile_17_0)
  (below tile_18_1 tile_17_1)
  (below tile_18_2 tile_17_2)
  (below tile_18_3 tile_17_3)
  (below tile_18_4 tile_17_4)
  (below tile_18_5 tile_17_5)
  (below tile_18_6 tile_17_6)
  (below tile_18_7 tile_17_7)
  (below tile_18_8 tile_17_8)
  (below tile_18_9 tile_17_9)
  (below tile_19_0 tile_18_0)
  (below tile_19_1 tile_18_1)
  (below tile_19_2 tile_18_2)
  (below tile_19_3 tile_18_3)
  (below tile_19_4 tile_18_4)
  (below tile_19_5 tile_18_5)
  (below tile_19_6 tile_18_6)
  (below tile_19_7 tile_18_7)
  (below tile_19_8 tile_18_8)
  (below tile_19_9 tile_18_9)
  (above tile_0_0 tile_1_0)
  (above tile_0_1 tile_1_1)
  (above tile_0_2 tile_1_2)
  (above tile_0_3 tile_1_3)
  (above tile_0_4 tile_1_4)
  (above tile_0_5 tile_1_5)
  (above tile_0_6 tile_1_6)
  (above tile_0_7 tile_1_7)
  (above tile_0_8 tile_1_8)
  (above tile_0_9 tile_1_9)
  (above tile_1_0 tile_2_0)
  (above tile_1_1 tile_2_1)
  (above tile_1_2 tile_2_2)
  (above tile_1_3 tile_2_3)
  (above tile_1_4 tile_2_4)
  (above tile_1_5 tile_2_5)
  (above tile_1_6 tile_2_6)
  (above tile_1_7 tile_2_7)
  (above tile_1_8 tile_2_8)
  (above tile_1_9 tile_2_9)
  (above tile_2_0 tile_3_0)
  (above tile_2_1 tile_3_1)
  (above tile_2_2 tile_3_2)
  (above tile_2_3 tile_3_3)
  (above tile_2_4 tile_3_4)
  (above tile_2_5 tile_3_5)
  (above tile_2_6 tile_3_6)
  (above tile_2_7 tile_3_7)
  (above tile_2_8 tile_3_8)
  (above tile_2_9 tile_3_9)
  (above tile_3_0 tile_4_0)
  (above tile_3_1 tile_4_1)
  (above tile_3_2 tile_4_2)
  (above tile_3_3 tile_4_3)
  (above tile_3_4 tile_4_4)
  (above tile_3_5 tile_4_5)
  (above tile_3_6 tile_4_6)
  (above tile_3_7 tile_4_7)
  (above tile_3_8 tile_4_8)
  (above tile_3_9 tile_4_9)
  (above tile_4_0 tile_5_0)
  (above tile_4_1 tile_5_1)
  (above tile_4_2 tile_5_2)
  (above tile_4_3 tile_5_3)
  (above tile_4_4 tile_5_4)
  (above tile_4_5 tile_5_5)
  (above tile_4_6 tile_5_6)
  (above tile_4_7 tile_5_7)
  (above tile_4_8 tile_5_8)
  (above tile_4_9 tile_5_9)
  (above tile_5_0 tile_6_0)
  (above tile_5_1 tile_6_1)
  (above tile_5_2 tile_6_2)
  (above tile_5_3 tile_6_3)
  (above tile_5_4 tile_6_4)
  (above tile_5_5 tile_6_5)
  (above tile_5_6 tile_6_6)
  (above tile_5_7 tile_6_7)
  (above tile_5_8 tile_6_8)
  (above tile_5_9 tile_6_9)
  (above tile_6_0 tile_7_0)
  (above tile_6_1 tile_7_1)
  (above tile_6_2 tile_7_2)
  (above tile_6_3 tile_7_3)
  (above tile_6_4 tile_7_4)
  (above tile_6_5 tile_7_5)
  (above tile_6_6 tile_7_6)
  (above tile_6_7 tile_7_7)
  (above tile_6_8 tile_7_8)
  (above tile_6_9 tile_7_9)
  (above tile_7_0 tile_8_0)
  (above tile_7_1 tile_8_1)
  (above tile_7_2 tile_8_2)
  (above tile_7_3 tile_8_3)
  (above tile_7_4 tile_8_4)
  (above tile_7_5 tile_8_5)
  (above tile_7_6 tile_8_6)
  (above tile_7_7 tile_8_7)
  (above tile_7_8 tile_8_8)
  (above tile_7_9 tile_8_9)
  (above tile_8_0 tile_9_0)
  (above tile_8_1 tile_9_1)
  (above tile_8_2 tile_9_2)
  (above tile_8_3 tile_9_3)
  (above tile_8_4 tile_9_4)
  (above tile_8_5 tile_9_5)
  (above tile_8_6 tile_9_6)
  (above tile_8_7 tile_9_7)
  (above tile_8_8 tile_9_8)
  (above tile_8_9 tile_9_9)
  (above tile_9_0 tile_10_0)
  (above tile_9_1 tile_10_1)
  (above tile_9_2 tile_10_2)
  (above tile_9_3 tile_10_3)
  (above tile_9_4 tile_10_4)
  (above tile_9_5 tile_10_5)
  (above tile_9_6 tile_10_6)
  (above tile_9_7 tile_10_7)
  (above tile_9_8 tile_10_8)
  (above tile_9_9 tile_10_9)
  (above tile_10_0 tile_11_0)
  (above tile_10_1 tile_11_1)
  (above tile_10_2 tile_11_2)
  (above tile_10_3 tile_11_3)
  (above tile_10_4 tile_11_4)
  (above tile_10_5 tile_11_5)
  (above tile_10_6 tile_11_6)
  (above tile_10_7 tile_11_7)
  (above tile_10_8 tile_11_8)
  (above tile_10_9 tile_11_9)
  (above tile_11_0 tile_12_0)
  (above tile_11_1 tile_12_1)
  (above tile_11_2 tile_12_2)
  (above tile_11_3 tile_12_3)
  (above tile_11_4 tile_12_4)
  (above tile_11_5 tile_12_5)
  (above tile_11_6 tile_12_6)
  (above tile_11_7 tile_12_7)
  (above tile_11_8 tile_12_8)
  (above tile_11_9 tile_12_9)
  (above tile_12_0 tile_13_0)
  (above tile_12_1 tile_13_1)
  (above tile_12_2 tile_13_2)
  (above tile_12_3 tile_13_3)
  (above tile_12_4 tile_13_4)
  (above tile_12_5 tile_13_5)
  (above tile_12_6 tile_13_6)
  (above tile_12_7 tile_13_7)
  (above tile_12_8 tile_13_8)
  (above tile_12_9 tile_13_9)
  (above tile_13_0 tile_14_0)
  (above tile_13_1 tile_14_1)
  (above tile_13_2 tile_14_2)
  (above tile_13_3 tile_14_3)
  (above tile_13_4 tile_14_4)
  (above tile_13_5 tile_14_5)
  (above tile_13_6 tile_14_6)
  (above tile_13_7 tile_14_7)
  (above tile_13_8 tile_14_8)
  (above tile_13_9 tile_14_9)
  (above tile_14_0 tile_15_0)
  (above tile_14_1 tile_15_1)
  (above tile_14_2 tile_15_2)
  (above tile_14_3 tile_15_3)
  (above tile_14_4 tile_15_4)
  (above tile_14_5 tile_15_5)
  (above tile_14_6 tile_15_6)
  (above tile_14_7 tile_15_7)
  (above tile_14_8 tile_15_8)
  (above tile_14_9 tile_15_9)
  (above tile_15_0 tile_16_0)
  (above tile_15_1 tile_16_1)
  (above tile_15_2 tile_16_2)
  (above tile_15_3 tile_16_3)
  (above tile_15_4 tile_16_4)
  (above tile_15_5 tile_16_5)
  (above tile_15_6 tile_16_6)
  (above tile_15_7 tile_16_7)
  (above tile_15_8 tile_16_8)
  (above tile_15_9 tile_16_9)
  (above tile_16_0 tile_17_0)
  (above tile_16_1 tile_17_1)
  (above tile_16_2 tile_17_2)
  (above tile_16_3 tile_17_3)
  (above tile_16_4 tile_17_4)
  (above tile_16_5 tile_17_5)
  (above tile_16_6 tile_17_6)
  (above tile_16_7 tile_17_7)
  (above tile_16_8 tile_17_8)
  (above tile_16_9 tile_17_9)
  (above tile_17_0 tile_18_0)
  (above tile_17_1 tile_18_1)
  (above tile_17_2 tile_18_2)
  (above tile_17_3 tile_18_3)
  (above tile_17_4 tile_18_4)
  (above tile_17_5 tile_18_5)
  (above tile_17_6 tile_18_6)
  (above tile_17_7 tile_18_7)
  (above tile_17_8 tile_18_8)
  (above tile_17_9 tile_18_9)
  (above tile_18_0 tile_19_0)
  (above tile_18_1 tile_19_1)
  (above tile_18_2 tile_19_2)
  (above tile_18_3 tile_19_3)
  (above tile_18_4 tile_19_4)
  (above tile_18_5 tile_19_5)
  (above tile_18_6 tile_19_6)
  (above tile_18_7 tile_19_7)
  (above tile_18_8 tile_19_8)
  (above tile_18_9 tile_19_9)
  (on_ground tile_0_0)
  (on_ground tile_0_1)
  (on_ground tile_0_2)
  (on_ground tile_0_3)
  (on_ground tile_0_4)
  (on_ground tile_0_5)
  (on_ground tile_0_6)
  (on_ground tile_0_7)
  (on_ground tile_0_8)
  (on_ground tile_0_9)
  (on_left_wall tile_0_0)
  (on_right_wall tile_0_9)
  (on_left_wall tile_1_0)
  (on_right_wall tile_1_9)
  (on_left_wall tile_2_0)
  (on_right_wall tile_2_9)
  (on_left_wall tile_3_0)
  (on_right_wall tile_3_9)
  (on_left_wall tile_4_0)
  (on_right_wall tile_4_9)
  (on_left_wall tile_5_0)
  (on_right_wall tile_5_9)
  (on_left_wall tile_6_0)
  (on_right_wall tile_6_9)
  (on_left_wall tile_7_0)
  (on_right_wall tile_7_9)
  (on_left_wall tile_8_0)
  (on_right_wall tile_8_9)
  (on_left_wall tile_9_0)
  (on_right_wall tile_9_9)
  (on_left_wall tile_10_0)
  (on_right_wall tile_10_9)
  (on_left_wall tile_11_0)
  (on_right_wall tile_11_9)
  (on_left_wall tile_12_0)
  (on_right_wall tile_12_9)
  (on_left_wall tile_13_0)
  (on_right_wall tile_13_9)
  (on_left_wall tile_14_0)
  (on_right_wall tile_14_9)
  (on_left_wall tile_15_0)
  (on_right_wall tile_15_9)
  (on_left_wall tile_16_0)
  (on_right_wall tile_16_9)
  (on_left_wall tile_17_0)
  (on_right_wall tile_17_9)
  (on_left_wall tile_18_0)
  (on_right_wall tile_18_9)
  (on_left_wall tile_19_0)
  (on_right_wall tile_19_9)
  (spawn_tile tile_19_5)
  (color tile_0_0 cempty)
  (color tile_0_1 cempty)
  (color tile_0_2 cempty)
  (color tile_0_3 cempty)
  (color tile_0_4 cempty)
  (color tile_0_5 cempty)
  (color tile_0_6 cempty)
  (color tile_0_7 cempty)
  (color tile_0_8 cempty)
  (color tile_0_9 cempty)
  (color tile_1_0 cempty)
  (color tile_1_1 cempty)
  (color tile_1_2 cempty)
  (color tile_1_3 cempty)
  (color tile_1_4 cempty)
  (color tile_1_5 cempty)
  (color tile_1_6 cempty)
  (color tile_1_7 cempty)
  (color tile_1_8 cempty)
  (color tile_1_9 cempty)
  (color tile_2_0 cempty)
  (color tile_2_1 cempty)
  (color tile_2_2 cempty)
  (color tile_2_3 cempty)
  (color tile_2_4 cempty)
  (color tile_2_5 cempty)
  (color tile_2_6 cempty)
  (color tile_2_7 cempty)
  (color tile_2_8 cempty)
  (color tile_2_9 cempty)
  (color tile_3_0 cempty)
  (color tile_3_1 cempty)
  (color tile_3_2 cempty)
  (color tile_3_3 cempty)
  (color tile_3_4 cempty)
  (color tile_3_5 cempty)
  (color tile_3_6 cempty)
  (color tile_3_7 cempty)
  (color tile_3_8 cempty)
  (color tile_3_9 cempty)
  (color tile_4_0 cempty)
  (color tile_4_1 cempty)
  (color tile_4_2 cempty)
  (color tile_4_3 cempty)
  (color tile_4_4 cempty)
  (color tile_4_5 cempty)
  (color tile_4_6 cempty)
  (color tile_4_7 cempty)
  (color tile_4_8 cempty)
  (color tile_4_9 cempty)
  (color tile_5_0 cempty)
  (color tile_5_1 cempty)
  (color tile_5_2 cempty)
  (color tile_5_3 cempty)
  (color tile_5_4 cempty)
  (color tile_5_5 cempty)
  (color tile_5_6 cempty)
  (color tile_5_7 cempty)
  (color tile_5_8 cempty)
  (color tile_5_9 cempty)
  (color tile_6_0 cempty)
  (color tile_6_1 cempty)
  (color tile_6_2 cempty)
  (color tile_6_3 cempty)
  (color tile_6_4 cempty)
  (color tile_6_5 cempty)
  (color tile_6_6 cempty)
  (color tile_6_7 cempty)
  (color tile_6_8 cempty)
  (color tile_6_9 cempty)
  (color tile_7_0 cempty)
  (color tile_7_1 cempty)
  (color tile_7_2 cempty)
  (color tile_7_3 cempty)
  (color tile_7_4 cempty)
  (color tile_7_5 cempty)
  (color tile_7_6 cempty)
  (color tile_7_7 cempty)
  (color tile_7_8 cempty)
  (color tile_7_9 cempty)
  (color tile_8_0 cempty)
  (color tile_8_1 cempty)
  (color tile_8_2 cempty)
  (color tile_8_3 cempty)
  (color tile_8_4 cempty)
  (color tile_8_5 cempty)
  (color tile_8_6 cempty)
  (color tile_8_7 cempty)
  (color tile_8_8 cempty)
  (color tile_8_9 cempty)
  (color tile_9_0 cempty)
  (color tile_9_1 cempty)
  (color tile_9_2 cempty)
  (color tile_9_3 cempty)
  (color tile_9_4 cempty)
  (color tile_9_5 cempty)
  (color tile_9_6 cempty)
  (color tile_9_7 cempty)
  (color tile_9_8 cempty)
  (color tile_9_9 cempty)
  (color tile_10_0 cempty)
  (color tile_10_1 cempty)
  (color tile_10_2 cempty)
  (color tile_10_3 cempty)
  (color tile_10_4 cempty)
  (color tile_10_5 cempty)
  (color tile_10_6 cempty)
  (color tile_10_7 cempty)
  (color tile_10_8 cempty)
  (color tile_10_9 cempty)
  (color tile_11_0 cempty)
  (color tile_11_1 cempty)
  (color tile_11_2 cempty)
  (color tile_11_3 cempty)
  (color tile_11_4 cempty)
  (color tile_11_5 cempty)
  (color tile_11_6 cempty)
  (color tile_11_7 cempty)
  (color tile_11_8 cempty)
  (color tile_11_9 cempty)
  (color tile_12_0 cempty)
  (color tile_12_1 cempty)
  (color tile_12_2 cempty)
  (color tile_12_3 cempty)
  (color tile_12_4 cempty)
  (color tile_12_5 cempty)
  (color tile_12_6 cempty)
  (color tile_12_7 cempty)
  (color tile_12_8 cempty)
  (color tile_12_9 cempty)
  (color tile_13_0 cempty)
  (color tile_13_1 cempty)
  (color tile_13_2 cempty)
  (color tile_13_3 cempty)
  (color tile_13_4 cempty)
  (color tile_13_5 cempty)
  (color tile_13_6 cempty)
  (color tile_13_7 cempty)
  (color tile_13_8 cempty)
  (color tile_13_9 cempty)
  (color tile_14_0 cempty)
  (color tile_14_1 cempty)
  (color tile_14_2 cempty)
  (color tile_14_3 cempty)
  (color tile_14_4 cempty)
  (color tile_14_5 cempty)
  (color tile_14_6 cempty)
  (color tile_14_7 cempty)
  (color tile_14_8 cempty)
  (color tile_14_9 cempty)
  (color tile_15_0 cempty)
  (color tile_15_1 cempty)
  (color tile_15_2 cempty)
  (color tile_15_3 cempty)
  (color tile_15_4 cempty)
  (color tile_15_5 cempty)
  (color tile_15_6 cempty)
  (color tile_15_7 cempty)
  (color tile_15_8 cempty)
  (color tile_15_9 cempty)
  (color tile_16_0 cempty)
  (color tile_16_1 cempty)
  (color tile_16_2 cempty)
  (color tile_16_3 cempty)
  (color tile_16_4 cempty)
  (color tile_16_5 cempty)
  (color tile_16_6 cempty)
  (color tile_16_7 cempty)
  (color tile_16_8 cempty)
  (color tile_16_9 cempty)
  (color tile_17_0 cempty)
  (color tile_17_1 cempty)
  (color tile_17_2 cempty)
  (color tile_17_3 cempty)
  (color tile_17_4 cempty)
  (color tile_17_5 cempty)
  (color tile_17_6 cempty)
  (color tile_17_7 cempty)
  (color tile_17_8 cempty)
  (color tile_17_9 cempty)
  (color tile_18_0 cempty)
  (color tile_18_1 cempty)
  (color tile_18_2 cempty)
  (color tile_18_3 cempty)
  (color tile_18_4 cempty)
  (color tile_18_5 cempty)
  (color tile_18_6 cempty)
  (color tile_18_7 cempty)
  (color tile_18_8 cempty)
  (color tile_18_9 cempty)
  (color tile_19_0 cempty)
  (color tile_19_1 cempty)
  (color tile_19_2 cempty)
  (color tile_19_3 cempty)
  (color tile_19_4 cempty)
  (color tile_19_5 cempty)
  (color tile_19_6 cempty)
  (color tile_19_7 cempty)
  (color tile_19_8 cempty)
  (color tile_19_9 cempty)
)
(:goal (and
  (color tile_0_0 cempty)
  (color tile_0_1 cempty)
  (color tile_0_2 cempty)
  (color tile_0_3 cempty)
  (color tile_0_4 cempty)
  (color tile_0_5 cempty)
  (color tile_0_6 cempty)
  (color tile_0_7 cempty)
  (color tile_0_8 cempty)
  (color tile_0_9 cempty)
  (color tile_1_0 cempty)
  (color tile_1_1 cempty)
  (color tile_1_2 cempty)
  (color tile_1_3 cempty)
  (color tile_1_4 cempty)
  (color tile_1_5 cempty)
  (color tile_1_6 cempty)
  (color tile_1_7 cempty)
  (color tile_1_8 cempty)
  (color tile_1_9 cempty)
  (color tile_2_0 cempty)
  (color tile_2_1 cempty)
  (color tile_2_2 cempty)
  (color tile_2_3 cempty)
  (color tile_2_4 cempty)
  (color tile_2_5 cempty)
  (color tile_2_6 cempty)
  (color tile_2_7 cempty)
  (color tile_2_8 cempty)
  (color tile_2_9 cempty)
  (color tile_3_0 cempty)
  (color tile_3_1 cempty)
  (color tile_3_2 cempty)
  (color tile_3_3 cempty)
  (color tile_3_4 cempty)
  (color tile_3_5 cempty)
  (color tile_3_6 cempty)
  (color tile_3_7 cempty)
  (color tile_3_8 cempty)
  (color tile_3_9 cempty)
  (color tile_4_0 cempty)
  (color tile_4_1 cempty)
  (color tile_4_2 cempty)
  (color tile_4_3 cempty)
  (color tile_4_4 cempty)
  (color tile_4_5 cempty)
  (color tile_4_6 cempty)
  (color tile_4_7 cempty)
  (color tile_4_8 cempty)
  (color tile_4_9 cempty)
  (color tile_5_0 cempty)
  (color tile_5_1 cempty)
  (color tile_5_2 cempty)
  (color tile_5_3 cempty)
  (color tile_5_4 cempty)
  (color tile_5_5 cempty)
  (color tile_5_6 cempty)
  (color tile_5_7 cempty)
  (color tile_5_8 cempty)
  (color tile_5_9 cempty)
  (color tile_6_0 cempty)
  (color tile_6_1 cempty)
  (color tile_6_2 cempty)
  (color tile_6_3 cempty)
  (color tile_6_4 cempty)
  (color tile_6_5 cempty)
  (color tile_6_6 cempty)
  (color tile_6_7 cempty)
  (color tile_6_8 cempty)
  (color tile_6_9 cempty)
  (color tile_7_0 cempty)
  (color tile_7_1 cempty)
  (color tile_7_2 cempty)
  (color tile_7_3 cempty)
  (color tile_7_4 cempty)
  (color tile_7_5 cempty)
  (color tile_7_6 cempty)
  (color tile_7_7 cempty)
  (color tile_7_8 cempty)
  (color tile_7_9 cempty)
  (color tile_8_0 cempty)
  (color tile_8_1 cempty)
  (color tile_8_2 cempty)
  (color tile_8_3 cempty)
  (color tile_8_4 cempty)
  (color tile_8_5 cempty)
  (color tile_8_6 cempty)
  (color tile_8_7 cempty)
  (color tile_8_8 cempty)
  (color tile_8_9 cempty)
  (color tile_9_0 cempty)
  (color tile_9_1 cempty)
  (color tile_9_2 cempty)
  (color tile_9_3 cempty)
  (color tile_9_4 cempty)
  (color tile_9_5 cempty)
  (color tile_9_6 cempty)
  (color tile_9_7 cempty)
  (color tile_9_8 cempty)
  (color tile_9_9 cempty)
  (color tile_10_0 cempty)
  (color tile_10_1 cempty)
  (color tile_10_2 cempty)
  (color tile_10_3 cempty)
  (color tile_10_4 cempty)
  (color tile_10_5 cempty)
  (color tile_10_6 cempty)
  (color tile_10_7 cempty)
  (color tile_10_8 cempty)
  (color tile_10_9 cempty)
  (color tile_11_0 cempty)
  (color tile_11_1 cempty)
  (color tile_11_2 cempty)
  (color tile_11_3 cempty)
  (color tile_11_4 cempty)
  (color tile_11_5 cempty)
  (color tile_11_6 cempty)
  (color tile_11_7 cempty)
  (color tile_11_8 cempty)
  (color tile_11_9 cempty)
  (color tile_12_0 cempty)
  (color tile_12_1 cempty)
  (color tile_12_2 cempty)
  (color tile_12_3 cempty)
  (color tile_12_4 cempty)
  (color tile_12_5 cempty)
  (color tile_12_6 cempty)
  (color tile_12_7 cempty)
  (color tile_12_8 cempty)
  (color tile_12_9 cempty)
  (color tile_13_0 cempty)
  (color tile_13_1 cempty)
  (color tile_13_2 cempty)
  (color tile_13_3 cempty)
  (color tile_13_4 cempty)
  (color tile_13_5 cempty)
  (color tile_13_6 cempty)
  (color tile_13_7 cempty)
  (color tile_13_8 cempty)
  (color tile_13_9 cempty)
  (color tile_14_0 cempty)
  (color tile_14_1 cempty)
  (color tile_14_2 cempty)
  (color tile_14_3 cempty)
  (color tile_14_4 cempty)
  (color tile_14_5 cempty)
  (color tile_14_6 cempty)
  (color tile_14_7 cempty)
  (color tile_14_8 cempty)
  (color tile_14_9 cempty)
  (color tile_15_0 cempty)
  (color tile_15_1 cempty)
  (color tile_15_2 cempty)
  (color tile_15_3 cempty)
  (color tile_15_4 cempty)
  (color tile_15_5 cempty)
  (color tile_15_6 cempty)
  (color tile_15_7 cempty)
  (color tile_15_8 cempty)
  (color tile_15_9 cempty)
  (color tile_16_0 cempty)
  (color tile_16_1 cempty)
  (color tile_16_2 cempty)
  (color tile_16_3 cempty)
  (color tile_16_4 cempty)
  (color tile_16_5 cempty)
  (color tile_16_6 cempty)
  (color tile_16_7 cempty)
  (color tile_16_8 cempty)
  (color tile_16_9 cempty)
  (color tile_17_0 cempty)
  (color tile_17_1 cempty)
  (color tile_17_2 cempty)
  (color tile_17_3 cempty)
  (color tile_17_4 cempty)
  (color tile_17_5 cempty)
  (color tile_17_6 cempty)
  (color tile_17_7 cempty)
  (color tile_17_8 cempty)
  (color tile_17_9 cempty)
  (color tile_18_0 cempty)
  (color tile_18_1 cempty)
  (color tile_18_2 cempty)
  (color tile_18_3 cempty)
  (color tile_18_4 cempty)
  (color tile_18_5 cempty)
  (color tile_18_6 cempty)
  (color tile_18_7 cempty)
  (color tile_18_8 cempty)
  (color tile_18_9 cempty)
  (color tile_19_0 c1)
  (color tile_19_1 c1)
  (color tile_19_2 c1)
  (color tile_19_3 c1)
  (color tile_19_4 c1)
  (color tile_19_5 c1)
  (color tile_19_6 c1)
  (color tile_19_7 c1)
  (color tile_19_8 cempty)
  (color tile_19_9 cempty)
))
)
