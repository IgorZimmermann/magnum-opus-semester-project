'use client'

import { Button } from '@/components/ui/button'
import { postApiSummaryGenerateSummary, putApiTranscriptEditTranscript, useGetApiTranscriptGetTranscript } from '@/src/api/heimdell'
import { useParams, useRouter, useSearchParams } from 'next/navigation'
import { useEffect, useState } from 'react'

export default function Page() {
	const { id } = useParams<{ id: string }>()
	const router = useRouter()
	const consultationId = useSearchParams().get('consultationId') ?? undefined

	const [buttonLoading, setButtonLoading] = useState<boolean>(false)
	const [transcriptEdit, setTranscriptEdit] = useState<string>('')

	const { data, isLoading } = useGetApiTranscriptGetTranscript(
		{ consultationId },
		{ query: { enabled: !!consultationId } },
	)

	const transcript = (data as any)?.data?.transcript?.transcription ?? ''

	useEffect(() => {
		if (transcript) setTranscriptEdit(transcript)
	}, [transcript])

	return (
		<div className="w-full flex flex-col gap-5 items-center justify-center py-20">
			<p>Here is the transcript of the consultation:</p>
			{isLoading ? (
				<p>Loading...</p>
			) : (
				<textarea
					className="w-[40dvw] min-h-[60dvh] bg-transparent border rounded-md p-3 outline-none resize-y text-sm"
					value={transcriptEdit}
					onChange={(e) => setTranscriptEdit(e.target.value)}
				/>
			)}
			<Button disabled={isLoading || buttonLoading} onClick={async () => {
				setButtonLoading(true)
				if (consultationId) {
					await putApiTranscriptEditTranscript({ transcription: transcriptEdit }, { consultationId })
					await postApiSummaryGenerateSummary({ consultationId })
				}
				setButtonLoading(false)
				router.push(`/appointment/${id}/note?consultationId=${consultationId}`)
			}}>
				{isLoading ? 'Loading transcript...' : buttonLoading ? 'Analysing...' : 'Analyse'}
			</Button>
		</div>
	)
}
