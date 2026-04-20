import { Auth0Client } from '@auth0/nextjs-auth0/server'
import { config } from 'dotenv'

config()

export const auth0 = new Auth0Client()
