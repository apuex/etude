{-# OPTIONS_GHC -fno-warn-unused-imports #-}
#include <bindings.dsl.h>
#include "struct-test.h"
module StructTest.Base.StructTest where
import Foreign.Ptr
#strict_import

{- typedef struct struct_test {
            int id; char name[64];
        } struct_test_t; -}
#starttype struct struct_test
#field id , CInt
#array_field name , CChar
#stoptype
#synonym_t struct_test_t , <struct struct_test>
#ccall print_struct_test , Ptr <struct struct_test> -> IO ()
