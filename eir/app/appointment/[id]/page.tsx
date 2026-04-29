'use client'

import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { useAudioRecorder } from "@/hooks/use-audio-recorder"
import { postApiConsultationStartConsultation, postApiTranscriptGenerateTranscript } from "@/src/api/heimdell"
import { useUser } from "@auth0/nextjs-auth0"
import { useParams, useRouter, useSearchParams } from "next/navigation"
import { useState } from "react"

export default function Page() {
	// id is the appointmentId from the URL — used as bookingId when starting a consultation
	const { id } = useParams<{ id: string }>()
	const router = useRouter()
	const search = useSearchParams()
	const { user } = useUser()

	// patient info passed via query params from the dashboard
	const patientName    = search.get('name')  ?? 'Unknown'
	const patientEmail   = search.get('email') ?? 'Unknown'
	const appointmentTime = search.get('time') ?? 'Unknown'

	const { start, finish } = useAudioRecorder()
	const [isRecording, setIsRecording]       = useState(false)
	const [isLoading, setIsLoading]           = useState(false)
	// returned by StartConsultation; held in state so endConsultation can reference it
	const [consultationId, setConsultationId] = useState<string | null>(null)

	const startConsultation = async () => {
		setIsLoading(true)
		try {
			const result = await postApiConsultationStartConsultation({
				bookingId: id,
				doctorName: user?.name ?? user?.email ?? '',
				patientName,
				patientEmail,
			})
			setConsultationId(result.data?.consultationId)
			await start() // request mic and begin recording
			setIsRecording(true)
		} catch { }
		setIsLoading(false)
	}

	const endConsultation = async () => {
		setIsLoading(true)
		try {
			const blob = await finish() // stops recording and encodes audio as .wav
			setIsRecording(false)
			if (consultationId) {
				await postApiTranscriptGenerateTranscript({ audio: blob }, { consultationId })
			}
			router.push(`/appointment/${id}/transcript?consultationId=${consultationId}`)
		} catch {
			// only reset loading on error — on success the page navigates away
			setIsLoading(false)
		}
	}

	return (
		<div className="w-dvw h-dvh flex flex-col gap-5 items-center justify-center">
			<p>Here is the appointment of <b>{patientName}</b>:</p>
			<Card className="w-[40dvw]">
				<CardContent>
					<div className="grid grid-cols-2 gap-y-5">
						<p className="font-bold">Time</p>  <p>{appointmentTime}</p>
						<p className="font-bold">Name</p>  <p>{patientName}</p>
						<p className="font-bold">Email</p> <p>{patientEmail}</p>
					</div>
					{isLoading ? (
						<p className="mt-10 text-center text-muted-foreground">Loading...</p>
					) : isRecording ? (
						<Button className="mt-10 w-full cursor-pointer bg-red-700 text-white" onClick={endConsultation}>End consultation</Button>
					) : (
						<Button className="mt-10 w-full cursor-pointer" onClick={startConsultation}>Start consultation</Button>
					)}
				</CardContent>
			</Card>
		</div>
	)
}
