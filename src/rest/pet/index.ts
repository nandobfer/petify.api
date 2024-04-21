import express, { Express, Request, Response } from "express"
import { User } from "../../class/User"
import { PetForm } from "../../class/Pet"
const router = express.Router()

router.get("/", async (request: Request, response: Response) => {
    const user_id = request.query.user_id as string | undefined

    if (user_id) {
        try {
            const user = new User(user_id)
            await user.init()
            const pets = await user.getPets()
            response.json(pets)
        } catch (error) {
            console.log(error)
            response.status(500).send(error)
        }
    } else {
        response.status(400).send("user_id param required")
    }
})

router.post("/pet", async (request: Request, response: Response) => {
    const data = request.body as PetForm

    try {
        const user = new User(data.user_id)
        await user.init()
        const pet = await user.newPet(data)
        response.json(pet)
    } catch (error) {
        console.log(error)
        response.status(500).send(error)
    }
})

export default router
