(module
  (func $print (import "lib" "logString") (param i32 i32))
  (memory $d (import "memory" "memory") 1)

  (func $pow (param $value i32) (param $exp i32) (result i32)
    (local $result i32)
    (set_local $result (get_local $value))  
    (block
      (loop 
        (set_local $result 
          (i32.mul 
            (get_local $result)
            (get_local $value)
          )
        )
        (set_local $exp 
          (i32.sub 
            (get_local $exp)
            (i32.const 1)
          )
        )
        (br_if 1 (i32.eq (get_local $exp) (i32.const 1)))
        (br 0)
      )
    )
    (get_local $result)
  )

  (func $printNumbers (param $start i32) (param $digits i32 ) 
    (local $digit i32)
    (local $depth i32)
    (set_local $digit (i32.const 0))  
    (set_local $depth 
      (call $pow 
        (i32.const 10) 
        (i32.sub
          (get_local $digits)
          (i32.const 1)
        )
      )  
    )
    (block
      (loop 
        (i32.add
          (i32.load (i32.const 0))
          (get_local $digit)
        )
        (i32.rem_u
          (i32.div_u
            (i32.load (get_local $start))  
            (get_local $depth)
          )
          (i32.const 10)
        )
        (i32.const 48)
        (i32.add)
        (i32.store)
        (set_local $digit 
          (i32.add 
            (get_local $digit)
            (i32.const 1)
          )
        )
        (set_local $depth 
          (i32.div_u
            (get_local $depth)
            (i32.const 10)
          )
        )
        (br_if 1 
           (i32.eq 
             (get_local $digit) 
             (get_local $digits)
           )
         )
        (br 0)
      )
    )

    (i32.load (i32.const 0))
    (get_local $digits)
    (call $print)
  )

  (func $setup
;;    (i32.store 
;;      (i32.const 0) 
;;      (i32.const 61234)
;;    )
    (i32.store 
      (i32.const 0) 
      (i32.const 61234)
    )
  )

  (func $main
    (call $setup)
    (i32.const 0)
    (call $pow (i32.const 10) (i32.const 3))
    (i32.store)

    (call $printNumbers
      (i32.const 0)
      (i32.const 4)
    )
  )

  (start $main)
)
