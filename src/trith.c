/* This is free and unencumbered software released into the public domain. */

#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <math.h>
#include "trith.h"
#include "config.h"

//////////////////////////////////////////////////////////////////////////////
// Constants

const char* const trith_version_string = PACKAGE_VERSION;

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
  g_queue_init(&machine->stack);
  g_queue_init(&machine->queue);
  machine->context.parent = NULL;
  machine->context.locals = g_hash_table_new(NULL, NULL);
}

void
trith_machine_free(trith_machine* machine) {
  assert(machine != NULL);
  g_queue_clear(&machine->stack);
  g_queue_clear(&machine->queue);
  if (machine->context.locals) {
    g_hash_table_destroy(machine->context.locals);
  }
  trith_slice_free(sizeof(trith_machine), machine);
}

//////////////////////////////////////////////////////////////////////////////
// Operators
