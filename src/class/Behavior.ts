import { Prisma } from "@prisma/client"

export type BehaviorPrisma = Prisma.BehaviorGetPayload<{}>

export class Behavior {
    id: number
    name: string
    description: string | null

    constructor(data: BehaviorPrisma) {
        this.id = data.id
        this.name = data.name
        this.description = data.description
    }
}
