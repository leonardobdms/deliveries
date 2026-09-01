<script setup lang="ts">
import { Form } from "@inertiajs/vue3"

import { Badge } from "@/components/ui/badge"
import { Button, type ButtonVariants } from "@/components/ui/button"
import {
  Card,
  CardAction,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import { delivery as deliveryPath } from "@/routes"
import type { Delivery } from "@/types"

import { deliveryStatusVariant, formatStatus } from "."

defineProps<{ delivery: Delivery }>()

function buttonVariant(variant: string): ButtonVariants["variant"] {
  return variant === "destructive" ? "destructive" : "default"
}
</script>

<template>
  <Card class="gap-4 py-4">
    <CardHeader class="px-4">
      <CardTitle class="font-mono">Order #{{ delivery.order_id }}</CardTitle>
      <CardDescription class="line-clamp-2">
        {{ delivery.address }}
      </CardDescription>
      <CardAction>
        <Badge
          class="capitalize"
          :variant="deliveryStatusVariant[delivery.status]"
        >
          {{ formatStatus(delivery.status) }}
        </Badge>
      </CardAction>
    </CardHeader>
    <CardFooter v-if="delivery.actions.length" class="gap-2 px-4">
      <Form
        v-for="action in delivery.actions"
        :key="action.event"
        :action="deliveryPath(delivery.id)"
        :options="{ preserveScroll: true }"
        disable-while-processing
      >
        <input type="hidden" name="event" :value="action.event" />
        <Button type="submit" size="sm" :variant="buttonVariant(action.variant)">
          {{ action.label }}
        </Button>
      </Form>
    </CardFooter>
  </Card>
</template>
