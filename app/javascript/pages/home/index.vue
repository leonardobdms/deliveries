<script setup lang="ts">
import { Head } from "@inertiajs/vue3"

import { DeliveryCard } from "@/components/delivery-card"
import type { HomeIndex } from "@/types"

const { deliveries } = defineProps<HomeIndex>()
</script>

<template>
  <Head title="Deliveries" />
  <div class="mx-auto flex min-h-dvh max-w-[1400px] flex-col gap-6 p-6 md:p-8">
    <h1 class="text-2xl font-semibold tracking-tight">Deliveries</h1>
    <p v-if="!deliveries.length" class="text-muted-foreground text-sm">
      No deliveries yet.
    </p>
    <div v-else class="grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3">
      <DeliveryCard
        v-for="delivery in deliveries"
        :key="delivery.id"
        :delivery="delivery"
      />
    </div>
  </div>
</template>
