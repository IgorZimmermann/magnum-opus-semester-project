import { serve } from '@hono/node-server'
import { createRoute, OpenAPIHono, z } from '@hono/zod-openapi'
import { execFileSync } from 'child_process'
import { randomUUID } from 'crypto'
import { readFileSync, rmSync } from 'fs'

const app = new OpenAPIHono()

app.doc('/doc', {
	openapi: '3.0.0',
	info: {
		version: '1.0.0',
		title: 'Saga API',
		description: 'PDF Generation API',
	},
})

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

app.openapi(
	createRoute({
		method: 'post',
		path: '/generate',
		request: {
			body: {
				content: {
					'application/json': {
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
						schema: z.object({
							message: z.string(),
						}),
					},
				},
			},
		},
	}),
	(c) => {
		const data = c.req.valid('json')
		const id = randomUUID()

		try {
			execFileSync('typst', [
				'compile',
				'--input',
				`data=${JSON.stringify(data)}`,
				'templates/doctors-note.typ',
				`temp/${id}.pdf`,
			])
		} catch {
			return c.json({ message: 'error creating pdf' }, 500)
		}

		try {
			const buffer = readFileSync(`temp/${id}.pdf`)

			return c.body(buffer, 200, {
				'Content-Type': 'application/pdf',
				'Content-Disposition': 'attachment; filename="output.pdf"',
			})
		} catch {
			return c.json({ message: 'error reading file' }, 500)
		} finally {
			rmSync(`temp/${id}.pdf`, { force: true })
		}
	},
)

serve(
	{
		fetch: app.fetch,
		port: 3000,
	},
	(info) => {
		console.log(`Server is running on http://localhost:${info.port}`)
	},
)
