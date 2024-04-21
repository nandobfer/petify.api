import { Prisma } from "@prisma/client"
import { FileUpload, WithoutFunctions } from "./helpers"

export type MediaType = "video" | "image"

export type MediaPrisma = Prisma.MediaGetPayload<{}>

export type MediaForm = Omit<WithoutFunctions<Media>, "id" | "url"> & {
    file: FileUpload
}

export class Media {
    id: string
    url: string
    type: MediaType
    position: number
    width: number
    height: number

    constructor(data: MediaPrisma) {
        this.id = data.id
        this.url = data.url
        this.type = data.type
        this.position = data.position
        this.width = data.width
        this.height = data.height
    }
}
