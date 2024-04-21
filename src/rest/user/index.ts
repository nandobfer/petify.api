import express, { Request, Response } from "express"
import login from "./login"
import signup from "./signup"
import { prisma } from "../../prisma"
import { PartialUser, User, user_include } from "../../class/User"
import { PetForm } from "../../class/Pet"

const router = express.Router()

router.use("/login", login)
router.use("/signup", signup)

router.get("/", async (request: Request, response: Response) => {
    try {
        const data = await prisma.user.findMany({ include: user_include })
        const users = data.map((item) => new User("", item))
        response.json(users)
    } catch (error) {
        console.log(error)
        response.status(500).send(error)
    }
})

router.patch("/", async (request: Request, response: Response) => {
    const data = request.body as PartialUser

    try {
        const user = new User(data.id)
        await user.init()
        await user.update(data)
        response.json(user)
    } catch (error) {
        console.log(error)
        response.status(500).send(error)
    }
})

export default router
