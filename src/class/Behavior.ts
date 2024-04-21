import { Prisma } from "@prisma/client"
import { WithoutFunctions } from "./helpers"

export type BehaviorPrisma = Prisma.BehaviorGetPayload<{}>

export type BehaviorForm = Omit<WithoutFunctions<Behavior>, "id">
    
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
