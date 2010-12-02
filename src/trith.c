/* This is free and unencumbered software released into the public domain. */

#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <math.h>

#define __TRITH_INIT__
#include "trith.h"
#include "config.h"

//////////////////////////////////////////////////////////////////////////////
// Constants

const char* const trith_version_string = PACKAGE_VERSION;

trith_value trith_false = { .type = TRITH_BOOL, .value.boolean = FALSE };
trith_value trith_true  = { .type = TRITH_BOOL, .value.boolean = TRUE };

//////////////////////////////////////////////////////////////////////////////
// Machine internals

static inline void
trith_stack_init(trith_stack* stack) {
  assert(stack != NULL);
  g_queue_init(stack);
}

static inline void
trith_stack_clear(trith_stack* stack) {
  assert(stack != NULL);
  // TODO: deallocate values
  g_queue_clear(stack);
}

static inline guint
trith_stack_size(const trith_stack* stack) {
  return g_queue_get_length((trith_stack*)stack);
}

static inline bool
trith_stack_is_empty(const trith_stack* stack) {
  return trith_stack_size(stack) == 0;
}

static inline trith_value*
trith_stack_peek(const trith_stack* stack) {
  assert(stack != NULL);
  return g_queue_peek_head((trith_stack*)stack);
}

static inline trith_value*
trith_stack_pop(trith_stack* stack) {
  assert(stack != NULL);
  return g_queue_pop_head(stack);
}

static inline void
trith_stack_push(trith_stack* stack, trith_value* value) {
  assert(stack != NULL);
  g_queue_push_head(stack, value);
}

static inline bool
trith_ensure_stack_size(trith_machine* machine, size_t size) {
  if (trith_stack_size(&machine->stack) < size) {
    machine->error = TRITH_ERROR_STACK_UNDERFLOW;
    return FALSE;
  }
  return TRUE;
}

//////////////////////////////////////////////////////////////////////////////
// Machine API

trith_machine*
trith_machine_alloc() {
  return trith_slice_alloc(sizeof(trith_machine));
}

trith_machine*
trith_machine_new() {
  trith_machine* machine = trith_machine_alloc();
  trith_machine_init(machine);
  return machine;
}

trith_machine*
trith_machine_copy(const trith_machine* machine) {
  assert(machine != NULL);
  trith_machine* copy = trith_machine_new();
  // copy the stack:
  for (GList* list = machine->stack.head; list != NULL; list = list->next) {
    g_queue_push_tail(&copy->stack, list->data);
  }
  // copy the queue:
  for (GList* list = machine->queue.head; list != NULL; list = list->next) {
    g_queue_push_tail(&copy->queue, list->data);
  }
  // copy the context:
  copy->context.parent = machine->context.parent;
  GHashTableIter iter;
  gpointer key, value;
  g_hash_table_iter_init(&iter, machine->context.locals);
  while (g_hash_table_iter_next(&iter, &key, &value) != FALSE) {
    g_hash_table_insert(copy->context.locals, &key, &value);
  }
  return copy;
}

void
trith_machine_init(trith_machine* machine) {
  assert(machine != NULL);
  machine->error = TRITH_ERROR_NONE;
  trith_stack_init(&machine->stack);
  trith_stack_init(&machine->queue);
  machine->context.parent = NULL;
  machine->context.locals = g_hash_table_new(NULL, NULL);
}

void
trith_machine_free(trith_machine* machine) {
  assert(machine != NULL);
  trith_stack_clear(&machine->stack);
  trith_stack_clear(&machine->queue);
  if (machine->context.locals) {
    g_hash_table_destroy(machine->context.locals);
  }
  trith_slice_free(sizeof(trith_machine), machine);
}

trith_value*
trith_machine_peek(const trith_machine* machine) {
  assert(machine != NULL);
  return trith_stack_peek(&machine->stack);
}

trith_value*
trith_machine_pop(trith_machine* machine) {
  assert(machine != NULL);
  return trith_stack_pop(&machine->stack);
}

void
trith_machine_push(trith_machine* machine, trith_value* value) {
  assert(machine != NULL);
  trith_stack_push(&machine->stack, value);
}

//////////////////////////////////////////////////////////////////////////////
// Control operators

void
trith_op_halt(trith_machine* machine) {
  assert(machine != NULL);
  trith_stack_clear(&machine->queue);
}

void
trith_op_reset(trith_machine* machine) {
  assert(machine != NULL);
  machine->error = TRITH_ERROR_NONE;
  trith_stack_clear(&machine->stack);
  trith_stack_clear(&machine->queue);
  g_hash_table_remove_all(machine->context.locals);
}

void
trith_op_nop(trith_machine* machine) {
  assert(machine != NULL);
  // do nothing
}

//////////////////////////////////////////////////////////////////////////////
// Stack operators

void
trith_op_clear(trith_machine* machine) {
  assert(machine != NULL);
  trith_stack_clear(&machine->stack);
}

void
trith_op_depth(trith_machine* machine) {
  assert(machine != NULL);
  trith_value* depth = trith_malloc(sizeof(trith_value));
  depth->value.integer = trith_stack_size(&machine->stack);
  trith_stack_push(&machine->stack, depth);
}

void
trith_op_pop(trith_machine* machine) {
  assert(machine != NULL);
  if (trith_ensure_stack_size(machine, 1)) {
    trith_stack_pop(&machine->stack);
  }
}

void
trith_op_pop2(trith_machine* machine) {
  assert(machine != NULL);
  if (trith_ensure_stack_size(machine, 2)) {
    trith_stack_pop(&machine->stack);
    trith_stack_pop(&machine->stack);
  }
}

void
trith_op_pop3(trith_machine* machine) {
  assert(machine != NULL);
  if (trith_ensure_stack_size(machine, 3)) {
    trith_stack_pop(&machine->stack);
    trith_stack_pop(&machine->stack);
    trith_stack_pop(&machine->stack);
  }
}

void
trith_op_dup(trith_machine* machine) {
  assert(machine != NULL);
  if (trith_ensure_stack_size(machine, 1)) {
    trith_stack_push(&machine->stack, trith_stack_peek(&machine->stack));
  }
}

void
trith_op_dup2(trith_machine* machine) {
  assert(machine != NULL);
  if (trith_ensure_stack_size(machine, 2)) {
    trith_value* a = trith_stack_pop(&machine->stack);
    trith_value* b = trith_stack_pop(&machine->stack);
    trith_stack_push(&machine->stack, b);
    trith_stack_push(&machine->stack, a);
    trith_stack_push(&machine->stack, b);
    trith_stack_push(&machine->stack, a);
  }
}

void
trith_op_dup3(trith_machine* machine) {
  assert(machine != NULL);
  if (trith_ensure_stack_size(machine, 3)) {
    trith_value* a = trith_stack_pop(&machine->stack);
    trith_value* b = trith_stack_pop(&machine->stack);
    trith_value* c = trith_stack_pop(&machine->stack);
    trith_stack_push(&machine->stack, c);
    trith_stack_push(&machine->stack, b);
    trith_stack_push(&machine->stack, a);
    trith_stack_push(&machine->stack, c);
    trith_stack_push(&machine->stack, b);
    trith_stack_push(&machine->stack, a);
  }
}

void
trith_op_swap(trith_machine* machine) {
  assert(machine != NULL);
  if (trith_ensure_stack_size(machine, 2)) {
    trith_value* a = trith_stack_pop(&machine->stack);
    trith_value* b = trith_stack_pop(&machine->stack);
    trith_stack_push(&machine->stack, a);
    trith_stack_push(&machine->stack, b);
  }
}
