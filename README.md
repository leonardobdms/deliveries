# Deliveries

App Rails de entregas — parte do laboratório EDA. Gerencia `deliveries` e, no futuro, consome eventos de pedido do Kafka e publica atualizações de status de entrega.

## Stack

- Ruby 4.0 / Rails 8.1
- SQLite
- Inertia.js + Vue 3 + Vite + Tailwind
- Alba + Typelizer
- AASM (máquina de estados)
- Solid Cache / Queue / Cable

## Schema

Tabela `deliveries`:

| Coluna | Tipo | Notas |
|--------|------|-------|
| `order_id` | integer | NOT NULL — referência lógica ao `orders.id` do Sales |
| `status` | string | default `pending` |
| `address` | string | NOT NULL |

**Statuses:** `pending`, `picked_up`, `in_transit`, `delivered`, `failed`

Diagrama: [db/diagram/deliveries.dbml](db/diagram/deliveries.dbml)

## Máquina de estados (AASM)

O model `Delivery` define transições explícitas. Exemplo no console:

```ruby
delivery = Delivery.create!(order_id: 1, address: "Rua B, 2")
delivery.pick_up!        # pending → picked_up
delivery.start_transit! # picked_up → in_transit
delivery.deliver!      # in_transit → delivered

delivery.fail!         # de pending, picked_up ou in_transit
```

| Evento | De | Para |
|--------|----|------|
| `pick_up` | `pending` | `picked_up` |
| `start_transit` | `picked_up` | `in_transit` |
| `deliver` | `in_transit` | `delivered` |
| `fail` | `pending`, `picked_up`, `in_transit` | `failed` |

No EDA, `fail` será disparado ao consumir `order.cancelled`; mudanças de status publicam `delivery.status_changed`.

Não há foreign key entre os bancos. O `order_id` é uma convenção de integração entre serviços.

## Papel no EDA

- **Consumer:** escuta `order.created`, `order.confirmed`, `order.cancelled` no tópico `sales.orders` e cria/atualiza deliveries
- **Producer:** publica `delivery.status_changed` no tópico `deliveries.deliveries`

> Kafka/Karafka ainda não estão implementados. Veja o [README da raiz](../README.md) para o contrato de eventos.

## Setup

```bash
bundle install
bin/rails db:setup   # migrate + seed
bin/dev            # http://localhost:3001
```

## Seeds

25 entregas fictícias com Faker (locale pt-BR):

```bash
bin/rails db:seed
```

Usa `order_id` de 1 a 25 (alinhado ao seed do Sales), gera `address` e cicla pelos 5 statuses. Idempotente: apaga e recria os registros. Os statuses são atribuídos diretamente (bypass da máquina de estados) para variar os dados de demo.

**Importante:** rode o seed do Sales antes para que os `order_id` façam sentido.

## Testes

```bash
bin/rspec
```
