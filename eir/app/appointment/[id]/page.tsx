'use client'

import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { useAudioRecorder } from "@/hooks/use-audio-recorder"
import { useParams } from "next/navigation"
import { useState } from "react"

export default function Page() {
	const { id } = useParams<{ id: string }>()

	const appointment = {
		id: "cccccccc-cccc-cccc-cccc-cccccccccccc",
		name: "Péter Magyar",
		email: "peter.magyar@kormany.hu",
		time: "19:30"
	}

	const { start, finish } = useAudioRecorder()
	const [isRecording, setIsRecoding] = useState<boolean>(false)

	async function processRecording() {
	}

	return (
		<div className="w-dvw h-dvh flex flex-col gap-5 items-center justify-center">
			<p>Here is the appointment of <b>{appointment.name}</b>:</p>
			<Card className="w-[40dvw]">
				<CardContent>
					<div className="grid grid-cols-2 gap-y-5">
						<p className="font-bold">Time</p>
						<p>{appointment.time}</p>
						<p className="font-bold">Name</p>
						<p>{appointment.name}</p>
						<p className="font-bold">Email</p>
						<p>{appointment.email}</p>
					</div>
					{isRecording ? (
						<Button className="mt-10 w-full cursor-pointer bg-red-700 text-white" onClick={async e => {
							e.preventDefault()
							try {
								const buffer = await finish()
								setIsRecoding(false)
							} catch { }
						}}>End consultation</Button>
					) : (
						<Button className="mt-10 w-full cursor-pointer" onClick={async e => {
							e.preventDefault()
							try {
								await start()
								setIsRecoding(true)
							} catch { }
						}}>Start consultation</Button>
					)}
				</CardContent>
			</Card>
		</div>
	)
}
