import { Prisma } from "@prisma/client"
import { prisma } from "../prisma"
import { Socket } from "socket.io"
import { uid } from "uid"
import { FileUpload, WithoutFunctions } from "./helpers"
import { handlePrismaError } from "../prisma/errors"
import { saveFile } from "../tools/saveFile"
import { Address, AddressForm } from "./Address"
import { Media, MediaForm } from "./Media"

export const user_include = Prisma.validator<Prisma.UserInclude>()({ address: true, pets: true, profile_picture: true })
export type UserPrisma = Prisma.UserGetPayload<{ include: typeof user_include }>
export interface UserImageForm {
    id: string
    image?: FileUpload | null
    cover?: FileUpload | null
}

export type UserForm = Omit<WithoutFunctions<User>, "id" | "profile_picture" | "address"> & {
    address?: AddressForm
    profile_picture?: MediaForm
}
export type PartialUser = Partial<User> & { id: string }

export type Gender = "male" | "female" | "other" | "undefined"

export class User {
    id: string
    email: string
    phone: string
    cpf: string
    password: string
    name: string
    birth: string | null
    gender: Gender | null
    address: Address | null
    // TODO pets: Pet[]
    profile_picture: Media | null

    constructor(id: string, user_prisma?: UserPrisma) {
        user_prisma ? this.load(user_prisma) : (this.id = id)
    }

    async init() {
        const user_prisma = await prisma.user.findUnique({ where: { id: this.id }, include: user_include })
        if (user_prisma) {
            this.load(user_prisma)
        } else {
            throw "usuário não encontrado"
        }
    }

    static async signup(data: UserForm) {
        try {
            const signed = await prisma.user.create({
                data: {
                    ...data,
                    id: uid(),
                    address: data.address ? { create: { ...data.address } } : undefined,
                    profile_picture: undefined,
                },
                include: user_include,
            })

            const user = new User("", signed)
            if (data.profile_picture) {
                await user.updateProfilePicture(data.profile_picture)
            }

            return user
        } catch (error) {
            const message = handlePrismaError(error)
            return message
        }
    }

    load(data: UserPrisma) {
        this.id = data.id
        this.email = data.email
        this.phone = data.phone
        this.cpf = data.cpf
        this.password = data.password
        this.name = data.name
        this.birth = data.birth
        this.gender = data.gender
        this.address = data.address ? new Address(data.address) : null
        this.profile_picture = data.profile_picture ? new Media(data.profile_picture) : null
    }

    async update(data: Partial<User>, socket?: Socket) {
        try {
        } catch (error) {
            const message = handlePrismaError(error)
            socket?.emit("user:update:error", message)
            return message
        }
    }

    async updateProfilePicture(data: MediaForm) {
        try {
            const url = saveFile(`/users/${this.id}`, data.file)
            const updated = await prisma.user.update({
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
                include: user_include,
            })
            this.load(updated)
        } catch (error) {
            console.log(error)
        }
    }
}

