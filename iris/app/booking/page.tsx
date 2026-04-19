"use client"

import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { useState } from "react"

type Booking = {
	id: string
	doctor: string
	datetime: string
}

const session = { user: { name: "Jaber" } }

const bookings: Booking[] = [
	{
		id: "cccccccc-cccc-cccc-cccc-cccccccccccc",
		doctor: "Dr. Dániel Deák",
		datetime: "12.04.2026 - 21:21",
	},
]

const doctors = ["Dr. Dániel Deák", "Dr. Tamás Deutsch", "Dr. Feró Nagy"]

export default function Page() {
	const [allBookings, setAllBookings] = useState<Booking[]>(bookings)
	const [showForm, setShowForm] = useState<boolean>(false)
	const [selectedDoctor, setSelectedDoctor] = useState<string>("")
	const [selectedDatetime, setSelectedDatetime] = useState<string>("")

	function handleMakeBooking() {
		if (!selectedDatetime) return
		const [datePart, timePart] = selectedDatetime.split("T")
		const [year, month, day] = datePart.split("-")
		const formatted = `${day}.${month}.${year} - ${timePart}`
		setAllBookings([
			...allBookings,
			{
				id: String(allBookings.length + 1),
				doctor: selectedDoctor,
				datetime: formatted,
			},
		])
		setShowForm(false)
		setSelectedDatetime("")
	}

	return (
		<div className="flex h-dvh w-dvw items-center justify-center">
			{!showForm ? (
				<div className="flex w-[40dvw] flex-col items-center gap-5">
					<p>Welcome {session.user.name}! Here are your bookings:</p>
					{allBookings.map((a) => (
						<Card className="w-[40dvw]" key={a.id}>
							<CardContent className="flex w-full flex-row items-center justify-between">
								<p>{a.doctor}</p>
								<span className="text-xl font-bold">{a.datetime}</span>
							</CardContent>
						</Card>
					))}
					<Button onClick={() => setShowForm(true)}>Make new booking</Button>
				</div>
			) : (
				<div className="flex w-[40dvw] flex-col gap-5">
					<p className="text-center">
						Dear {session.user.name}, add your booking details:
					</p>
					<p className="font-bold">Doctor</p>
					<select
						className="rounded-md border bg-card p-2"
						value={selectedDoctor}
						onChange={(e) => setSelectedDoctor(e.target.value)}
					>
						<option value="">Select a doctor...</option>
						{doctors.map((d) => (
							<option key={d} value={d}>
								{d}
							</option>
						))}
					</select>
					{selectedDoctor && (
						<>
							<p className="font-bold">Date</p>
							<input
								className="rounded-md border bg-card p-2"
								type="datetime-local"
								value={selectedDatetime}
								onChange={(e) => setSelectedDatetime(e.target.value)}
							/>
							<Button onClick={handleMakeBooking}>Make booking</Button>
						</>
					)}
				</div>
			)}
		</div>
	)
}
