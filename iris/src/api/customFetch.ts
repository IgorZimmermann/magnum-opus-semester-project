// Custom http call for every request
export const customFetch = async <T>(url: string, options: RequestInit): Promise<T> => {
    // fetches the users JWT
    const tokenRes = await fetch('/api/access-token')
    if (!tokenRes.ok) {
        // create fake one (will not work) if not found
        return { data: null, status: 401, headers: new Headers() } as T
    }
    // else attaches it to every call
    const { token } = await tokenRes.json()

    const response = await fetch(url, {
        ...options,
        headers: { ...options.headers, Authorization: `Bearer ${token}` },
    })

    const contentType = response.headers.get('content-type')
    const data = contentType?.includes('application/json') ? await response.json() : null

    if (!response.ok) {
        throw new Error(`Request failed: ${response.status} ${response.statusText}`)
    }

    return { data, status: response.status, headers: response.headers } as T
}