(define (domain tetris)
    (:requirements :typing :negative-preconditions)

(:types
    tile
    in_piece_index
    color
)

(:constants
   pi1 pi2 pi3 pi4 - in_piece_index 
   c1 c2 c3 c4 c5 c6 c7 cempty - color
)

(:predicates
    (color ?tile - tile ?color - color);; The tile's color
    (above ?tile1 - tile ?tile2 - tile) ;; tile1 is above tile2
    (below ?tile1 - tile ?tile2 - tile) ;; tile1 is below tile2
    (left_of ?tile1 - tile ?tile2 - tile) ;; tile1 is left of tile2
    (right_of ?tile1 - tile ?tile2 - tile) ;; tile1 is right of tile2
    (on_ground ?tile - tile) ;; the tile is on the ground
    (on_left_wall ?tile - tile) ;; the tile is on the left wall
    (on_right_wall ?tile - tile) ;; the tile is on the right wall
    (spawn_tile ?tile - tile) ;; the tile is the spawn tile
)

;; Here are all the 19 rotations of the tetrominos, with the color assigned to them:

;; I:
;; 1111
;;
;; 1
;; 1
;; 1
;; 1

;; J:
;; 222
;; __2
;;
;; _2 
;; _2
;; 22
;;
;; 2__
;; 222
;;
;; 22
;; 2_
;; 2_

;; L:
;; 333
;; 3__
;;
;; 33
;; _3
;; _3
;;
;; __3
;; 333
;;
;; 3_
;; 3_
;; 33

;; O:
;; 44
;; 44

;; S:
;; _55
;; 55_
;;
;; 5_
;; 55
;; _5

;; T:
;; 666
;; _6_
;;
;; _6
;; 66
;; _6
;;
;; _6_
;; 666
;;
;; 6_
;; 66
;; 6_

;; Z:
;; 77_
;; _77
;;
;; _7
;; 77
;; 7_

;; The destroy-line action is variadic in the width of the field.

(:action destroy-line
    :parameters (
        
        ?tile1 - tile
        ?color1 - color
        
        ?tile2 - tile
        ?color2 - color
        
        ?tile3 - tile
        ?color3 - color
        
        ?tile4 - tile
        ?color4 - color
        
        ?tile5 - tile
        ?color5 - color
        
        ?tile6 - tile
        ?color6 - color
        
        ?tile7 - tile
        ?color7 - color
        
        ?tile8 - tile
        ?color8 - color
        
        ?tile9 - tile
        ?color9 - color
        
        ?tile10 - tile
        ?color10 - color
        
    )
    :precondition (and
        
        ;; Tile 1 has the color 1
        (color ?tile1 ?color1)
        ;; The color that the title has is not empty
        (not (= ?color1 cempty))

        
        ;; Tile 1 is next to the left wall 
        (on_left_wall ?tile1)
        ;; Tile 1 has tile 2 to its right
        (right_of ?tile1 ?tile2)
        
        
        
        
        ;; Tile 2 has the color 2
        (color ?tile2 ?color2)
        ;; The color that the title has is not empty
        (not (= ?color2 cempty))

        
        ;; Tile 2 has tile 1 to its left
        (left_of ?tile2 ?tile1)
        ;; Tile 2 has tile 3 to its right
        (right_of ?tile2 ?tile3)
        
        
        
        
        ;; Tile 3 has the color 3
        (color ?tile3 ?color3)
        ;; The color that the title has is not empty
        (not (= ?color3 cempty))

        
        ;; Tile 3 has tile 2 to its left
        (left_of ?tile3 ?tile2)
        ;; Tile 3 has tile 4 to its right
        (right_of ?tile3 ?tile4)
        
        
        
        
        ;; Tile 4 has the color 4
        (color ?tile4 ?color4)
        ;; The color that the title has is not empty
        (not (= ?color4 cempty))

        
        ;; Tile 4 has tile 3 to its left
        (left_of ?tile4 ?tile3)
        ;; Tile 4 has tile 5 to its right
        (right_of ?tile4 ?tile5)
        
        
        
        
        ;; Tile 5 has the color 5
        (color ?tile5 ?color5)
        ;; The color that the title has is not empty
        (not (= ?color5 cempty))

        
        ;; Tile 5 has tile 4 to its left
        (left_of ?tile5 ?tile4)
        ;; Tile 5 has tile 6 to its right
        (right_of ?tile5 ?tile6)
        
        
        
        
        ;; Tile 6 has the color 6
        (color ?tile6 ?color6)
        ;; The color that the title has is not empty
        (not (= ?color6 cempty))

        
        ;; Tile 6 has tile 5 to its left
        (left_of ?tile6 ?tile5)
        ;; Tile 6 has tile 7 to its right
        (right_of ?tile6 ?tile7)
        
        
        
        
        ;; Tile 7 has the color 7
        (color ?tile7 ?color7)
        ;; The color that the title has is not empty
        (not (= ?color7 cempty))

        
        ;; Tile 7 has tile 6 to its left
        (left_of ?tile7 ?tile6)
        ;; Tile 7 has tile 8 to its right
        (right_of ?tile7 ?tile8)
        
        
        
        
        ;; Tile 8 has the color 8
        (color ?tile8 ?color8)
        ;; The color that the title has is not empty
        (not (= ?color8 cempty))

        
        ;; Tile 8 has tile 7 to its left
        (left_of ?tile8 ?tile7)
        ;; Tile 8 has tile 9 to its right
        (right_of ?tile8 ?tile9)
        
        
        
        
        ;; Tile 9 has the color 9
        (color ?tile9 ?color9)
        ;; The color that the title has is not empty
        (not (= ?color9 cempty))

        
        ;; Tile 9 has tile 8 to its left
        (left_of ?tile9 ?tile8)
        ;; Tile 9 has tile 10 to its right
        (right_of ?tile9 ?tile10)
        
        
        
        
        ;; Tile 10 has the color 10
        (color ?tile10 ?color10)
        ;; The color that the title has is not empty
        (not (= ?color10 cempty))

        
        ;; Tile 10 is next to the right wall
        (on_right_wall ?tile10)
        ;; Tile 10 has tile 9 to its left
        (left_of ?tile10 ?tile9)
        
        
        
        
    )
    :effect (and
        
        ;; Tile 1 is now empty
        (not (color ?tile1 ?color_1))
        (color ?tile1 cempty)
        
        ;; Tile 2 is now empty
        (not (color ?tile2 ?color_2))
        (color ?tile2 cempty)
        
        ;; Tile 3 is now empty
        (not (color ?tile3 ?color_3))
        (color ?tile3 cempty)
        
        ;; Tile 4 is now empty
        (not (color ?tile4 ?color_4))
        (color ?tile4 cempty)
        
        ;; Tile 5 is now empty
        (not (color ?tile5 ?color_5))
        (color ?tile5 cempty)
        
        ;; Tile 6 is now empty
        (not (color ?tile6 ?color_6))
        (color ?tile6 cempty)
        
        ;; Tile 7 is now empty
        (not (color ?tile7 ?color_7))
        (color ?tile7 cempty)
        
        ;; Tile 8 is now empty
        (not (color ?tile8 ?color_8))
        (color ?tile8 cempty)
        
        ;; Tile 9 is now empty
        (not (color ?tile9 ?color_9))
        (color ?tile9 cempty)
        
        ;; Tile 10 is now empty
        (not (color ?tile10 ?color_10))
        (color ?tile10 cempty)
        
    )
)



)
