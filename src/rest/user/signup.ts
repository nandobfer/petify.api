import express, { Express, Request, Response } from "express"
import { User, UserForm } from "../../class/User"
const router = express.Router()

router.post("/", async (request: Request, response: Response) => {
    const data = request.body as UserForm

    try {
        const user = await User.signup(data)
        response.json(user)
    } catch (error) {
        console.log(error)
        response.status(500).send(error)
    }
})

export default router
