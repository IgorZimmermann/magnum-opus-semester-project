'use client'

import { useState } from 'react'
import { useRouter, useSearchParams } from 'next/navigation'
import { Button } from '@/components/ui/button'
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card'
import { useGetApiSummaryGetSummary, putApiSummaryEditSumamry, postApiPrescriptionGeneratePrescription, putApiPrescriptionEditPrescription, postApiPrescriptionApprovePrescription } from '@/src/api/heimdell'

type Prescription = { symptoms: string, diagnosis: string, description: string, advicePrescription: string }

// drives the editable cards rendered in the prescription review phase
// editable cards in review section
const fields: { key: keyof Prescription; label: string }[] = [
	{ key: 'symptoms', label: 'Symptoms' },
	{ key: 'diagnosis', label: 'Diagnosis' },
	{ key: 'description', label: 'Description' },
	{ key: 'advicePrescription', label: 'Advice / Prescription' },
]

export default function Page() {
	const router = useRouter()
	const consultationId = useSearchParams().get('consultationId') ?? undefined

	// doctor reviews summary first then reviews the generated prescription
	const [phase, setPhase] = useState<'summary' | 'prescription'>('summary')

	// null means the doctor hasn't edited the summary yet, then it uses the fetched value
	const [summaryEdit, setSummaryEdit] = useState<string | null>(null)
	const [prescription, setPrescription] = useState<Prescription>({ symptoms: '', diagnosis: '', description: '', advicePrescription: '' })
	const [isLoading, setIsLoading] = useState(false)
	const { data: summaryData, isLoading: summaryLoading } = useGetApiSummaryGetSummary(
		{ consultationId },
		{ query: { enabled: !!consultationId } },
	)

	const summaryText = summaryEdit ?? (summaryData as { data?: { sumamry?: { output?: string } } })?.data?.sumamry?.output ?? ''

	const generatePrescription = async () => {
		if (!consultationId) return
		setIsLoading(true)
		try {
			// save any edits the doctor made to the summary before generating
			await putApiSummaryEditSumamry({ output: summaryText, type: 'summary', status: 'approved' }, { consultationId })
			const result = await postApiPrescriptionGeneratePrescription({ consultationId })
			const note = (result as { data?: { note?: Prescription } })?.data?.note
			if (note) setPrescription(note)
			setPhase('prescription')
		} finally {
			setIsLoading(false)
		}
	}

	const approve = async () => {
		if (!consultationId) return
		setIsLoading(true)
		try {
			// save edits first, then approves / sends to patient
			await putApiPrescriptionEditPrescription(prescription, { consultationId })
			await postApiPrescriptionApprovePrescription({ consultationId })
			router.push('/')
		} finally {
			setIsLoading(false)
		}
	}

	if (summaryLoading) return <div className="w-full flex items-center justify-center py-20"><p>Loading...</p></div>

	return (
		<div className="w-full flex flex-col gap-5 items-center justify-center py-20">
			<p>Here is the breakdown of the consultation:</p>
			{phase === 'summary' ? (
				<>
					<Card className="w-[40dvw]">
						<CardHeader><CardTitle>Consultation Summary</CardTitle></CardHeader>
						<CardContent>
							<textarea className="w-full min-h-[200px] bg-transparent border-none outline-none resize-none text-sm" value={summaryText} onChange={e => setSummaryEdit(e.target.value)} />
						</CardContent>
					</Card>
					<Button onClick={generatePrescription} disabled={isLoading}>{isLoading ? 'Generating...' : 'Generate Prescription'}</Button>
				</>
			) : (
				<>
					<div className="flex flex-col gap-5">
						{fields.map(({ key, label }) => (
							<Card key={key} className="w-[40dvw]">
								<CardHeader><CardTitle>{label}</CardTitle></CardHeader>
								<CardContent>
									<p className="text-wrap outline-none" contentEditable suppressContentEditableWarning onBlur={e => setPrescription(prev => ({ ...prev, [key]: e.currentTarget.textContent ?? '' }))}>{prescription[key]}</p>
								</CardContent>
							</Card>
						))}
					</div>
					<Button onClick={approve} disabled={isLoading}>{isLoading ? 'Sending...' : 'Approve & Send to Patient'}</Button>
				</>
			)}
		</div>
	)
}
