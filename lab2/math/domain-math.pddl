(define (domain i8080)

;; The Intel 8080 CPU

(:requirements :strips :typing :negative-preconditions)

(:types 
    register - object
    register8 - register
    value - object
    u8 - value
)

(:predicates
    (holds ?r - register8 ?v - u8)
    (succ ?v1 - u8 ?v2 - u8)  ; v1 succeeds v2
    (prec ?v1 - u8 ?v2 - u8)   ; v1 precedes v2
)

;(:action load_u8
;    :parameters (?r - register8 ?v - u8)
;    :precondition (not (holds ?r ?v))  ; Preconditions are syntactically required, so we have to add this
;    :effect (holds ?r ?v)
;)

(:action incr
    :parameters (?r - register8 ?old_v - u8 ?new_v - u8)
    :precondition (and (holds ?r ?old_v) (succ ?new_v ?old_v))
    :effect (holds ?r ?new_v)
)

(:action decr
    :parameters (?r - register8 ?old_v - u8 ?new_v - u8)
    :precondition (and (holds ?r ?old_v) (prec ?new_v ?old_v))
    :effect (holds ?r ?new_v)
)

)