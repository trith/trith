/* This is free and unencumbered software released into the public domain. */

#ifndef TRITH_H
#define TRITH_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include <glib.h>

//////////////////////////////////////////////////////////////////////////////
// Constants

extern const char* const trith_version_string;

//////////////////////////////////////////////////////////////////////////////
// Machine API

typedef GQueue trith_stack;
typedef GQueue trith_queue;
typedef GHashTable trith_table;

typedef struct {
  struct trith_context* parent;
  trith_table* locals;
} trith_context;

typedef struct {
  trith_stack stack;
  trith_queue queue;
  trith_context context;
  void* user_data;
} trith_machine;

extern trith_machine* trith_machine_alloc();
extern trith_machine* trith_machine_new();
extern trith_machine* trith_machine_copy(const trith_machine* machine);
extern void trith_machine_init(trith_machine* machine);
extern void trith_machine_free(trith_machine* machine);

//////////////////////////////////////////////////////////////////////////////
// Operators

//////////////////////////////////////////////////////////////////////////////
// Utilities

#define trith_malloc      g_malloc0
#define trith_calloc      g_malloc0_n
#define trith_realloc     g_realloc
#define trith_free        g_free
#define trith_slice_alloc g_slice_alloc0
#define trith_slice_copy  g_slice_copy
#define trith_slice_free  g_slice_free1
#define trith_memmove     g_memmove

//////////////////////////////////////////////////////////////////////////////
// Miscellaneous

#ifdef __cplusplus
}
#endif

#endif // TRITH_H
