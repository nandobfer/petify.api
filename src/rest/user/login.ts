import express, { Express, Request, Response } from "express"
import { LoginForm } from "../../types/shared/login"
import { prisma } from "../../prisma"
import { User, user_include } from "../../class/User"
const router = express.Router()

router.post("/", async (request: Request, response: Response) => {
    const data = request.body as LoginForm

    try {
        const user_prisma = await prisma.user.findFirst({
            where: { OR: [{ email: data.login }, { cpf: data.login }], password: data.password },
            include: user_include,
        })

        if (user_prisma) {
            const user = new User(user_prisma.id, user_prisma)
            response.json(user)
        } else {
            response.json(null)
        }
    } catch (error) {
        console.log(error)
        response.status(500).send(error)
    }
})

export default router
