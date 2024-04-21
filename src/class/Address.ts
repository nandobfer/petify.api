import { Prisma } from "@prisma/client"
import { WithoutFunctions } from "./helpers"

export type AddressPrisma = Prisma.AddressGetPayload<{}>

export type AddressForm = Omit<WithoutFunctions<Address>, "id">

export class Address {
    id: number
    street: string
    number: string
    district: string
    complement: string | null
    city: string
    uf: string
    postcode: string

    constructor(data: AddressPrisma) {
        this.id = data.id
        this.street = data.street
        this.number = data.number
        this.district = data.district
        this.complement = data.complement
        this.city = data.city
        this.uf = data.uf
        this.postcode = data.postcode
    }
}
