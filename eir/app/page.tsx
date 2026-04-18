import { Button } from "@/components/ui/button"
import { Card, CardContent } from "@/components/ui/card"
import { auth0 } from "@/lib/auth0"
import Link from "next/link"

export default async function Page() {
	const session = await auth0.getSession()

	const appointments = [{
		id: "cccccccc-cccc-cccc-cccc-cccccccccccc",
		name: "Péter Magyar",
		time: "19:30"
	}]

	return (
		<div className="w-dvw h-dvh flex items-center justify-center">
			{!session ? (
				<div className="w-dvw h-dvh flex items-center justify-center">
					<div className="flex flex-col items-center gap-5">
						<p>Welcome Doctor! Please authenticate!</p>
						<Link href="/auth/login">
							<Button>Authenticate</Button>
						</Link>
					</div>
				</div>
			) : (
				<div className="w-[40dvw] flex flex-col items-center gap-5">
					<p>Welcome {session.user.name}! Here are your appointments for today:</p>
					{appointments.map(a => (
						<Link href={`/appointment/${a.id}`} key={a.id}>
							<Card className="grow w-[40dvw]">
								<CardContent className="flex flex-row w-full justify-between items-center">
									<p>{a.name}</p>
									<span className="font-bold text-xl">{a.time}</span>
								</CardContent>
							</Card>
						</Link>
					))}
				</div>
			)}
		</div>
	)
}
