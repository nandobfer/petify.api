import express, { Request, Response } from "express"
import login from "./login"
import signup from "./signup"
import { prisma } from "../../prisma"
import { User, user_include } from "../../class/User"

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

export default router
