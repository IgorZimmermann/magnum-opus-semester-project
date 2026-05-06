import { auth0 } from '@/lib/auth0'
import { NextResponse } from 'next/server'

// calls auth0 to get token to return plain JWT (that customFetch.ts can use)
export async function GET() {
    try {
        const { token } = await auth0.getAccessToken()
        return NextResponse.json({ token })
    } catch {
        return NextResponse.json({ token: null }, { status: 401 })
    }
}