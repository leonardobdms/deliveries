import type { BadgeVariants } from "@/components/ui/badge"

export { default as DeliveryCard } from "./DeliveryCard.vue"

export function formatStatus(status: string) {
  return status.replaceAll("_", " ")
}

export const deliveryStatusVariant: Record<string, BadgeVariants["variant"]> = {
  pending: "pending",
  picked_up: "picked_up",
  in_transit: "in_transit",
  delivered: "delivered",
  failed: "failed",
}
