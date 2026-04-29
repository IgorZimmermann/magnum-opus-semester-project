export const customFetch = async <T>(url: string, options: RequestInit): Promise<T> => {
    const tokenRes = await fetch('/api/access-token')
    if (!tokenRes.ok) {
        return { data: null, status: 401, headers: new Headers() } as T
    }
    const { token } = await tokenRes.json()

    const response = await fetch(url, {
        ...options,
        headers: { ...options.headers, Authorization: `Bearer ${token}` },
    })

    const contentType = response.headers.get('content-type')
    const data = contentType?.includes('application/json') ? await response.json() : null

    return { data, status: response.status, headers: response.headers } as T
}
