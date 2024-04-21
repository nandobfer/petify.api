import { Prisma } from "@prisma/client"
import { Behavior } from "./Behavior"
import { Diet } from "./Diet"
import { Media } from "./Media"
import { prisma } from "../prisma"

export type Sex = "male" | "female" | "undefined"

export const pet_include = Prisma.validator<Prisma.PetInclude>()({
    behaviors: true,
    diet_preferred: true,
    diet_restriction: true,
    gallery: true,
    profile_picture: true,
    schedules: { include: { provider: true, service: true } },
    user: true,
})

export type PetPrisma = Prisma.PetGetPayload<{ include: typeof pet_include }>

export class Pet {
    id: string
    name: string
    species: string | null
    breed: string | null
    birth: string | null
    weight: string | null
    color: string | null
    sex: Sex | null
    diet_restriction: Diet[]
    diet_preferred: Diet[]
    behaviors: Behavior[]
    emergency_contact: string | null
    profile_picture: Media | null
    gallery: Media[]

    constructor(id: string, data?: PetPrisma) {
        this.id = id
        if (data) this.load(data)
    }

    async init() {
        const data = await prisma.pet.findUnique({ where: { id: this.id }, include: pet_include })
        if (data) this.load(data)
    }

    load(data: PetPrisma) {
        this.id = data.id
        this.name = data.name
        this.species = data.species
        this.breed = data.breed
        this.birth = data.birth
        this.weight = data.weight
        this.color = data.color
        this.sex = data.sex
        this.diet_restriction = data.diet_restriction.map((item) => new Diet(item))
        this.diet_preferred = data.diet_preferred.map((item) => new Diet(item))
        this.behaviors = data.behaviors.map((item) => new Behavior(item))
        this.emergency_contact = data.emergency_contact
        this.profile_picture = data.profile_picture ? new Media(data.profile_picture) : null
        this.gallery = data.gallery.map((item) => new Media(item))
    }
}
