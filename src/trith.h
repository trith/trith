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
// Types

typedef GQueue trith_stack;
typedef GQueue trith_queue;
typedef GHashTable trith_table;

typedef struct {
  struct trith_context* parent;
  trith_table* locals;
} trith_context;

typedef enum {
  TRITH_ERROR_NONE = 0,
  TRITH_ERROR_STACK_UNDERFLOW,
} trith_error;

typedef struct {
  trith_error error;
  trith_stack stack;
  trith_queue queue;
  trith_context context;
  void* user_data;
} trith_machine;

typedef enum {
  TRITH_NIL = 0,
  TRITH_BOOL,
  TRITH_INT,
  TRITH_LIST,
  TRITH_OP,
} trith_type;

typedef void (*trith_op)(trith_machine* machine);

typedef struct {
  trith_type type;
  union value {
    bool boolean;
    gint integer;
  } value;
} trith_value;

//////////////////////////////////////////////////////////////////////////////
// Constants

extern const char* const trith_version_string;

#ifndef __TRITH_INIT__
extern const trith_value trith_false;
extern const trith_value trith_true;
#endif

//////////////////////////////////////////////////////////////////////////////
// Machine

extern trith_machine* trith_machine_alloc();
extern trith_machine* trith_machine_new();
extern trith_machine* trith_machine_copy(const trith_machine* machine);
extern void trith_machine_init(trith_machine* machine);
extern void trith_machine_free(trith_machine* machine);
extern trith_value* trith_machine_peek(const trith_machine* machine);
extern trith_value* trith_machine_pop(trith_machine* machine);
extern void trith_machine_push(trith_machine* machine, trith_value* value);

//////////////////////////////////////////////////////////////////////////////
// Operators

// Control operators
extern void trith_op_halt(trith_machine* machine);
extern void trith_op_reset(trith_machine* machine);
extern void trith_op_nop(trith_machine* machine);

// Stack operators
extern void trith_op_clear(trith_machine* machine);
extern void trith_op_depth(trith_machine* machine);
extern void trith_op_pop(trith_machine* machine);
extern void trith_op_pop2(trith_machine* machine);
extern void trith_op_pop3(trith_machine* machine);
extern void trith_op_dup(trith_machine* machine);
extern void trith_op_dup2(trith_machine* machine);
extern void trith_op_dup3(trith_machine* machine);
extern void trith_op_swap(trith_machine* machine);

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
