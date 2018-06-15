(module
  (func $print (import "lib" "logString") (param i32 i32))
  (func $debug (import "debug" "debugger") (param i32 i32))
  (memory $d (import "memory" "memory") 21)
  (data (i32.const 0) "Factorial of:")
  (data (i32.const 13) "Equals: ")
  (func
    $add_strings (param $str1 i32) (param $len1 i32) (param $str2 i32) (param $len2 i32) (result i32)
    (local $pos i32)
    (local $currPos i32)
    (set_local $pos 
       (grow_memory (i32.add (get_local $len1) (get_local $len2)))
    )
    (set_local $currPos (get_local $pos))
    (if (i32.ne (get_local $len1) (i32.const 0))
      (then
        (block 
          (loop 
            (i32.store
              (get_local $currPos)
              (i32.load
                (get_local $str1)
              )
            )
            (set_local $str1 (i32.add (get_local $str1) (i32.const 1)))
            (set_local $len1 (i32.sub (get_local $len1) (i32.const 1)))
            (set_local $currPos (i32.add (get_local $currPos) (i32.const 1)))
            (br_if 1 (i32.eq (get_local $len1) (i32.const 0)))
            (br 0)
          )
        )
      )
    )
    (if (i32.ne (get_local $len2) (i32.const 0))
      (then
        (block 
          (loop 
            (i32.store
              (get_local $currPos)
              (i32.load
                (get_local $str2)
              )
            )
            (set_local $str2 (i32.add (get_local $str2) (i32.const 1)))
            (set_local $len2 (i32.sub (get_local $len2) (i32.const 1)))
            (set_local $currPos (i32.add (get_local $currPos) (i32.const 1)))
            (br_if 1 (i32.eq (get_local $len2) (i32.const 0)))
            (br 0)
          )
        )
      )
    )
    (return (get_local $pos))
  )
  (func $factorial (param $n i32) (result i32)
    (if
      (i32.le_s
        (get_local $n)
        (i32.const 0)
      )
      (then
        (return
          (i32.const 1)
        )
      )
    )
    (return
      (i32.mul
        (get_local $n)
        (call $factorial
          (i32.sub
            (get_local $n)
            (i32.const 1)
          )
        )
      )
    )
  )
  (func $main  
    (local $str1 i32)
    (local $str2 i32)
    (local $len1 i32)
    (local $len2 i32)

    (set_local $str1 (i32.const 0))
    (set_local $str2 (i32.const 13))
    (set_local $len1 (i32.const 13))
    (set_local $len2 (i32.const 8))
    (call $print
      (call $add_strings 
        (get_local $str1)
        (get_local $len1)
        (get_local $str2)
        (get_local $len2)
      )
      (i32.add (get_local $len1) (get_local $len2))
    )
  )
  (start $main)
)
