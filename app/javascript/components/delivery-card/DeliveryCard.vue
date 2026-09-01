<script setup lang="ts">
import { Badge } from "@/components/ui/badge"
import { Button } from "@/components/ui/button"
import {
  Card,
  CardAction,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card"
import type { Delivery } from "@/types"

import {
  deliveryActions,
  deliveryStatusVariant,
  formatStatus,
} from "."

defineProps<{ delivery: Delivery }>()
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
    <CardFooter
      v-if="deliveryActions[delivery.status]?.length"
      class="gap-2 px-4"
    >
      <Button
        v-for="action in deliveryActions[delivery.status]"
        :key="action.label"
        type="button"
        size="sm"
        :variant="action.variant"
      >
        {{ action.label }}
      </Button>
    </CardFooter>
  </Card>
</template>
