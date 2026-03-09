import { serve } from '@hono/node-server'
import { createRoute, OpenAPIHono, z } from '@hono/zod-openapi'

const app = new OpenAPIHono()

app.openapi(
	createRoute({
		method: 'get',
		path: '/ping',
		responses: {
			200: {
				description: 'Sends back pong to check connection',
				content: {
					'application/text': {
						schema: z.string(),
					},
				},
			},
		},
	}),
	(c) => {
		return c.text('pong')
	},
)

app.doc('/doc', {
	openapi: '3.0.0',
	info: {
		version: '1.0.0',
		title: 'Saga API',
		description: 'PDF Generation API',
	},
})

serve(
	{
		fetch: app.fetch,
		port: 3000,
	},
	(info) => {
		console.log(`Server is running on http://localhost:${info.port}`)
	},
)
