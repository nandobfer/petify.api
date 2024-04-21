import { Prisma } from "@prisma/client"

export type DietPrisma = Prisma.DietGetPayload<{}>

export class Diet {
    id: number
    name: string
    quantity: string | null
    interval: string | null
    notes: string | null

    constructor(data: DietPrisma) {
        this.id = data.id
        this.name = data.name
        this.quantity = data.quantity
        this.interval = data.interval
        this.notes = data.notes
    }
}
