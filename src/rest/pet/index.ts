import express, { Express, Request, Response } from "express"
import { User } from "../../class/User"
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

export default router
