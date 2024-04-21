import { google } from "googleapis"

export const getGoogleClient = () => new google.auth.OAuth2()
