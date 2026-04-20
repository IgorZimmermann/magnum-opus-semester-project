"use client"

import { Button } from "@/components/ui/button"
import { Calendar } from "@/components/ui/calendar"
import { Card, CardContent } from "@/components/ui/card"
import { Field, FieldGroup, FieldLabel } from "@/components/ui/field"
import { Input } from "@/components/ui/input"
import {
	Popover,
	PopoverContent,
	PopoverTrigger,
} from "@/components/ui/popover"
import {
	Select,
	SelectContent,
	SelectItem,
	SelectTrigger,
	SelectValue,
} from "@/components/ui/select"
import { format } from "date-fns"
import { ChevronDownIcon } from "lucide-react"
import * as React from "react"
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
	const [open, setOpen] = useState<boolean>(false)
	const [date, setDate] = React.useState<Date | undefined>(undefined)

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
					<Select
						value={selectedDoctor}
						onValueChange={(value) => setSelectedDoctor(value)}
					>
						<SelectTrigger className="w-full">
							<SelectValue placeholder="Select a doctor..." />
						</SelectTrigger>
						<SelectContent>
							{doctors.map((d) => (
								<SelectItem key={d} value={d}>
									{d}
								</SelectItem>
							))}
						</SelectContent>
					</Select>
					{selectedDoctor && (
						<>
							<FieldGroup className="w-full flex-row">
								<Field>
									<FieldLabel htmlFor="date-picker-optional">Date</FieldLabel>
									<Popover open={open} onOpenChange={setOpen}>
										<PopoverTrigger asChild>
											<Button
												variant="outline"
												id="date-picker-optional"
												className="w-32 justify-between font-normal"
											>
												{date ? format(date, "PPP") : "Select date"}
												<ChevronDownIcon />
											</Button>
										</PopoverTrigger>
										<PopoverContent
											className="w-auto overflow-hidden p-0"
											align="start"
										>
											<Calendar
												mode="single"
												selected={date}
												captionLayout="dropdown"
												defaultMonth={date}
												onSelect={(date) => {
													setDate(date)
													setOpen(false)
												}}
											/>
										</PopoverContent>
									</Popover>
								</Field>
								<Field className="w-32">
									<FieldLabel htmlFor="time-picker-optional">Time</FieldLabel>
									<Input
										type="time"
										id="time-picker-optional"
										step="900"
										defaultValue="10:30:00"
										className="appearance-none bg-background [&::-webkit-calendar-picker-indicator]:hidden [&::-webkit-calendar-picker-indicator]:appearance-none"
									/>
								</Field>
							</FieldGroup>
							<Button onClick={handleMakeBooking}>Make booking</Button>
						</>
					)}
				</div>
			)}
		</div>
	)
}
