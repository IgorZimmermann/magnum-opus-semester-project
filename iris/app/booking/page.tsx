"use client"

import { Button } from "@/components/ui/button"
import { Calendar } from "@/components/ui/calendar"
import { Card, CardContent } from "@/components/ui/card"
import { Field, FieldGroup, FieldLabel } from "@/components/ui/field"
import { Input } from "@/components/ui/input"
import { Popover, PopoverContent, PopoverTrigger } from "@/components/ui/popover"
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from "@/components/ui/select"
import { useGetApiAppointment, useGetApiAvailabilityDoctors, usePostApiAppointment } from "@/src/api/janus"
import { useUser } from "@auth0/nextjs-auth0"
import { format } from "date-fns"
import { ChevronDownIcon } from "lucide-react"
import * as React from "react"
import { useState } from "react"

type Booking = { appointmentId?: string, docId?: string, appointmentDate?: string, appointmentTime?: string, status?: string | null }
type Doctor = { docId?: string, name?: string | null }

export default function Page() {
	const { user } = useUser()
	const [showForm, setShowForm] = useState<boolean>(false)
	const [selectedDoctorId, setSelectedDoctorId] = useState<string>("")
	const [selectedDoctorName, setSelectedDoctorName] = useState<string>("")
	const [open, setOpen] = useState<boolean>(false)
	const [date, setDate] = React.useState<Date | undefined>(undefined)
	const [time, setTime] = useState<string>("10:30")

	const { data: doctorsData } = useGetApiAvailabilityDoctors()
	const { data: appointmentsData, refetch } = useGetApiAppointment()
	const { mutate: createAppointment } = usePostApiAppointment({
		mutation: {
			onSuccess: () => {
				refetch()
				setShowForm(false)
				setSelectedDoctorId("")
				setSelectedDoctorName("")
				setDate(undefined)
				setTime("10:30")
			},
		},
	})

	const doctors = ((doctorsData as any)?.data as Doctor[]) ?? []
	const appointments = ((appointmentsData as any)?.data as Booking[]) ?? []

	function handleMakeBooking() {
		if (!selectedDoctorId || !date) return
		createAppointment({
			data: {docId: selectedDoctorId, patId: user?.sub ?? "", appointmentDate: format(date, "yyyy-MM-dd"), appointmentTime: `${time}:00`}
		})
	}

	if (!user) return <p>Please authenticate to view your bookings.</p>

	return (
		<div className="flex h-dvh w-dvw items-center justify-center">
			{!showForm ? (
				<div className="flex w-[40dvw] flex-col items-center gap-5">
					<p>Welcome {user.name}! Here are your bookings:</p>
					{appointments.map((a) => (
						<Card className="w-[40dvw]" key={a.appointmentId}>
							<CardContent className="flex w-full flex-row items-center justify-between">
								<p>{doctors.find((d) => d.docId === a.docId)?.name ?? a.docId}</p>
								<span className="text-xl font-bold">{a.appointmentDate} - {a.appointmentTime}</span>
							</CardContent>
						</Card>
					))}
					<Button onClick={() => setShowForm(true)}>Make new booking</Button>
				</div>
			) : (
				<div className="flex w-[40dvw] flex-col gap-5">
					<p className="text-center">Dear {user.name}, add your booking details:</p>
					<p className="font-bold">Doctor</p>
					<Select
						value={selectedDoctorId}
						onValueChange={(value) => {
							setSelectedDoctorId(value)
							setSelectedDoctorName(doctors.find((d) => d.docId === value)?.name ?? "")
						}}
					>
						<SelectTrigger className="w-full">
							<SelectValue placeholder="Select a doctor...">
								{selectedDoctorName || "Select a doctor..."}
							</SelectValue>
						</SelectTrigger>
						<SelectContent>
							{doctors.map((d) => (
								<SelectItem key={d.docId} value={d.docId ?? ""}>
									{d.name}
								</SelectItem>
							))}
						</SelectContent>
					</Select>
					{selectedDoctorId && (
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
										<PopoverContent className="w-auto overflow-hidden p-0" align="start">
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
										value={time}
										onChange={(e) => setTime(e.target.value)}
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