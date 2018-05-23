(module
  (func $print (import "lib" "logString") (param i32 i32))
  ;; (func $debug (import "debug" "debugger") (param i32 i32) )
  (memory $d (import "memory" "memory") 1)
  (data (i32.const 0) "Hello!")

  (func $printNTimes (param $n i32) (param $str i32) (param $len i32)
    (local $a i32)
    (set_local $a (i32.const 0))

    (block
      (loop

        (get_local $str)
        (get_local $len)
        (call $print)

        (set_local $a (i32.add (get_local $a) (i32.const 1)))

        (br_if 0
          (i32.lt_s
             (get_local $a)
             (get_local $n)
          )
         )
        (br 1)
      )
    )
  )

  (func $main
    (call $printNTimes (i32.const 10) (i32.const 0) (i32.const 6))
  )

  (start $main)
)
