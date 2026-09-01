import type { BadgeVariants } from "@/components/ui/badge"
import type { ButtonVariants } from "@/components/ui/button"

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

export type DeliveryAction = {
  label: string
  variant?: ButtonVariants["variant"]
}

export const deliveryActions: Record<string, DeliveryAction[]> = {
  pending: [{ label: "Pick up" }, { label: "Fail", variant: "destructive" }],
  picked_up: [{ label: "Transit" }, { label: "Fail", variant: "destructive" }],
  in_transit: [{ label: "Deliver" }, { label: "Fail", variant: "destructive" }],
  delivered: [],
  failed: [],
}
