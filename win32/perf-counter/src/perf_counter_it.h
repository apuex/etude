/*  =========================================================================
    perf_counter_it - performance counter enumerator

    Copyright (c) the Authors
    =========================================================================
*/

#ifndef PERF_COUNTER_IT_H_INCLUDED
#define PERF_COUNTER_IT_H_INCLUDED

#ifdef __cplusplus
extern "C" {
#endif

//  @interface
//  Create a new perf_counter_it
PERF_COUNTER_PRIVATE perf_counter_it_t *
    perf_counter_it_new (void);

//  Destroy the perf_counter_it
PERF_COUNTER_PRIVATE void
    perf_counter_it_destroy (perf_counter_it_t **self_p);

//  Self test of this class
PERF_COUNTER_PRIVATE void
    perf_counter_it_test (bool verbose);

//  @end

#ifdef __cplusplus
}
#endif

#endif
