import { serve } from '@hono/node-server'
import { createRoute, OpenAPIHono, z } from '@hono/zod-openapi'
import { execFileSync } from 'child_process'
import { randomUUID } from 'crypto'
import { readFileSync, rmSync } from 'fs'

// Creating OpenAPI Hono application instance
const app = new OpenAPIHono()

// Creating documentation route to serve OpenAPI specification
app.doc('/doc', {
	openapi: '3.0.0',
	info: {
		version: '1.0.0',
		title: 'Saga API',
		description: 'PDF Generation API',
	},
})

// Creating a ping route to check connection to API
app.openapi(
	// Describing route and reponses for OpenAPI documentation
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
		// Returning pong
		return c.text('pong')
	},
)

// Creating a generate route that generates the doctor's note
app.openapi(
	// Describing route, request and responses for OpenAPI documentation
	createRoute({
		method: 'post',
		path: '/generate',
		request: {
			body: {
				content: {
					'application/json': {
						// Creating a zod schema for request body validation
						schema: z.object({
							doctor: z.object({
								name: z.string(),
								id: z.number(),
							}),
							patient: z.object({
								name: z.string(),
								id: z.number(),
							}),
							diagnosis: z.string(),
							description: z.string(),
							advice_prescription: z.string(),
						}),
					},
				},
			},
		},
		responses: {
			200: {
				description: 'Generates PDF and returns the file buffer',
				content: {
					'application/pdf': {
						// Creating zod schema for 200 response and describing it for OpenAPI
						schema: z.instanceof(Buffer).openapi({
							type: 'string',
							format: 'binary',
						}),
					},
				},
			},
			500: {
				description: 'PDF Generation process fails',
				content: {
					'application/json': {
						// Creating zod schema for 500 response
						schema: z.object({
							message: z.string(),
						}),
					},
				},
			},
		},
	}),
	(c) => {
		// Getting validated data from request body
		const data = c.req.valid('json')
		
		// Generating random UUID for filename
		const id = randomUUID()

		// Generating PDF using typst cli
		try {
			// Executing typst command, outputting to generated id
			execFileSync('typst', [
				'compile',
				'--input',
				`data=${JSON.stringify(data)}`,
				'templates/doctors-note.typ',
				`temp/${id}.pdf`,
			])
		} catch {
			// Returning 500 error and message if process fails
			return c.json({ message: 'error creating pdf' }, 500)
		}

		// Reading PDF file and returning 200 success and file buffer
		try {
			// Reading file using the generated id
			const buffer = readFileSync(`temp/${id}.pdf`)

			// Return 200 success and buffer, along with headers about the content
			return c.body(buffer, 200, {
				'Content-Type': 'application/pdf',
				'Content-Disposition': 'attachment; filename="output.pdf"',
			})
		} catch {
			// Returning 500 error and message if process fails
			return c.json({ message: 'error reading file' }, 500)
		} finally {
			// Removing temporary PDF file based on generated id
			rmSync(`temp/${id}.pdf`, { force: true })
		}
	},
)

// Serving application on port 3000
serve(
	{
		fetch: app.fetch,
		port: 3000,
	},
	(info) => {
		console.log(`Server is running on http://localhost:${info.port}`)
	},
)
