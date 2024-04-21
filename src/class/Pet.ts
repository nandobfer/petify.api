import { Prisma } from "@prisma/client"
import { Behavior, BehaviorForm } from "./Behavior"
import { Diet, DietForm } from "./Diet"
import { Media, MediaForm } from "./Media"
import { prisma } from "../prisma"
import { WithoutFunctions } from "./helpers"
import { saveFile } from "../tools/saveFile"
import { uid } from "uid"

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

export type PetForm = Omit<WithoutFunctions<Pet>, "id" | "diet_restriction" | "diet_preferred" | "profile_picture" | "gallery" | "user_id"> & {
    user_id: string
    profile_picture?: MediaForm
    gallery?: MediaForm[]
    diet_restriction?: DietForm[]
    diet_preferred?: DietForm[]
    behaviors?: BehaviorForm[]
}

export class Pet {
    id: string
    name: string
    species: string | null
    breed: string | null
    birth: string | null
    weight: string | null
    color: string | null
    sex: Sex | null
    user_id: string | null
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
        this.user_id = data.user_id
        this.diet_restriction = data.diet_restriction.map((item) => new Diet(item))
        this.diet_preferred = data.diet_preferred.map((item) => new Diet(item))
        this.behaviors = data.behaviors.map((item) => new Behavior(item))
        this.emergency_contact = data.emergency_contact
        this.profile_picture = data.profile_picture ? new Media(data.profile_picture) : null
        this.gallery = data.gallery.map((item) => new Media(item))
    }

    async updateProfilePicture(data: MediaForm) {
        try {
            const url = saveFile(`/users/${this.user_id}/pets/${this.id}`, data.file)
            const updated = await prisma.pet.update({
                where: { id: this.id },
                data: {
                    profile_picture: {
                        delete: { id: this.profile_picture?.id },
                        create: {
                            ...data,
                            id: uid(),
                            url,
                        },
                    },
                },
                include: pet_include,
            })
            this.load(updated)
        } catch (error) {
            console.log(error)
        }
    }

    async updateGallery(data: MediaForm[]) {
        // TODO
    }
}
