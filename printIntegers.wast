(module
  (func $print (import "lib" "logString") (param i32 i32))
  (func $debug (import "debug" "debugger") (param i32 i32))
  (memory $d (import "memory" "memory") 1)
  (func $pow (param $value i32) (param $exp i32) (result i32)
    (if
      (i32.le_s
        (get_local $exp)
        (i32.const 0)
      )
      (then
        (return (i32.const 1))
      )
      (else
        (if
          (i32.eq
            (get_local $exp)
            (i32.const 1)
          )
          (then
            (return (get_local $value))
          )
          (else 
            (return (i32.const 5)
              (i32.mul
                (get_local $value)
                (call $pow
                  (get_local $value)
                  (i32.sub
                    (get_local $exp)
                    (i32.const 1)
                  )
                )
              )
            )
          )
        )
      )
    )
    (return (i32.const -1))
  )
  (func $length (param $value i32) (result i32)
    (local $len i32)
    (set_local $len (i32.const 0))
    (block
      (loop
        (set_local $len
          (i32.add
            (get_local $len)
            (i32.const 1)
          )
        )
        (set_local $value
          (i32.div_s
            (get_local $value)
            (i32.const 10) 
          )
        )
        (br_if 1 
          (i32.eq
            (get_local $value) 
            (i32.const 0)
          )
        )
        (br 0)
      )
    )
    (get_local $len)
  )
  (func $intRepr (param $value i32) (result i32)
    (local $digit i32)
    (local $location i32)
    (local $currLocation i32)
    (local $len i32)
    (set_local $len (call $length (get_local $value)))
    (set_local $location (grow_memory (get_local $len)))
    (set_local $digit 
      (call $pow
        (i32.const 10)
        (i32.sub (get_local $len) (i32.const 1))
      )
    )
    (set_local $currLocation (get_local $location))
    (block
      (loop
        (i32.store
          (get_local $currLocation)
          (i32.add
            (i32.rem_s
              (i32.div_s
                (get_local $value)
                (get_local $digit)
              )
              (i32.const 10)
            )
            (i32.const 48)
          )
        )
        (set_local $currLocation
          (i32.add
            (get_local $currLocation)
            (i32.const 1)
          )
        )
        (set_local $digit
          (i32.div_s
            (get_local $digit)
            (i32.const 10) 
          )
        )
        (br_if 1 
          (i32.le_s
            (get_local $digit) 
            (i32.const 0)
          )
        )
        (br 0)
      )
    )
    (get_local $location)
  )
  (func $main 
    (local $n i32)
    (set_local $n (i32.const 2341451))
    (call $print
      (call $intRepr (get_local $n))
      (call $length (get_local $n))
    )
  )
  (start $main)
)
