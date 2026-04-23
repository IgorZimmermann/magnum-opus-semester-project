'use client'

import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { useGetApiConsultationGetDoctorAppointments } from "@/src/api/heimdell"
import { useUser } from "@auth0/nextjs-auth0"
import Link from "next/link"

type Appointment = { appointmentId?: string, patientName?: string | null, patientEmail?: string | null, appointmentDate?: string | null, appointmentTime?: string | null, appointmentStatus?: string | null }

export default function Page() {
	const { user } = useUser()

	// awaits for doctor's email from Auth0
	const { data, isLoading } = useGetApiConsultationGetDoctorAppointments(
		{ email: user?.email ?? undefined },
		{ query: { enabled: !!user?.email } },
	)
	const appointments = ((data as any)?.data as Appointment[]) ?? []

	// if unauthenticated 
	if (!user) return (
		<div className="w-dvw h-dvh flex flex-col items-center justify-center gap-5">
			<p>Welcome Doctor! Please authenticate!</p>
			<Link href="/auth/login"><Button>Authenticate</Button></Link>
		</div>
	)

	return (
		<div className="w-dvw h-dvh flex items-center justify-center">
			<div className="w-[40dvw] flex flex-col items-center gap-5">
				<p>Welcome {user.name ?? user.email}! Here are your appointments for today:</p>
				{isLoading && <p>Loading appointments...</p>}
				{appointments.map(a => (
					// pass patient info
					<Link
						key={a.appointmentId}
						href={`/appointment/${a.appointmentId}?name=${encodeURIComponent(a.patientName ?? '')}&email=${encodeURIComponent(a.patientEmail ?? '')}&time=${encodeURIComponent(a.appointmentTime ?? '')}`}
					>
						<Card className="grow w-[40dvw]">
							<CardContent className="flex flex-row w-full justify-between items-center">
								<p>{a.patientName}</p>
								<span className="font-bold text-xl">{a.appointmentTime}</span>
							</CardContent>
						</Card>
					</Link>
				))}
			</div>
		</div>
	)
}
