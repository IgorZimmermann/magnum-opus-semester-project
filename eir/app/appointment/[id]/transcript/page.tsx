'use client'

import { Button } from '@/components/ui/button'
import { postApiSummaryGenerateSummary, useGetApiTranscriptGetTranscript } from '@/src/api/heimdell'
import { useParams, useRouter, useSearchParams } from 'next/navigation'
import { useState } from 'react'

export default function Page() {
	const { id } = useParams<{ id: string }>()
	const router = useRouter()
	const consultationId = useSearchParams().get('consultationId') ?? undefined

	const [buttonLoading, setButtonLoading] = useState<boolean>(false)

	const { data, isLoading } = useGetApiTranscriptGetTranscript(
		{ consultationId },
		{ query: { enabled: !!consultationId } },
	)

	// GetTranscript endpoint which returns transcript
	const transcript = (data as any)?.data?.transcript?.transcription ?? ''

	return (
		<div className="w-full flex flex-col gap-5 items-center justify-center py-20">
			<p>Here is the transcript of the consultation:</p>
			{isLoading ? (
				<p>Loading...</p>
			) : (
				// contentEditable lets the doctor fix transcription errors 
				<p contentEditable suppressContentEditableWarning className="m-0 text-wrap max-w-[40dvw] box-border outline-none">
					{transcript}
				</p>
			)}
			<Button disabled={buttonLoading} onClick={async () => {
				setButtonLoading(true)
				// generate summary before navigating
				if (consultationId) await postApiSummaryGenerateSummary({ consultationId })
				setButtonLoading(false)
				router.push(`/appointment/${id}/note?consultationId=${consultationId}`)
			}}>{buttonLoading ? "Analysing..." : "Analyse"}</Button>
		</div>
	)
}
