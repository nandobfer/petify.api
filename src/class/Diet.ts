import { Prisma } from "@prisma/client"
import { WithoutFunctions } from "./helpers"

export type DietPrisma = Prisma.DietGetPayload<{}>

export type DietForm = Omit<WithoutFunctions<Diet>, "id">

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
