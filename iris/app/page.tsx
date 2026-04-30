import { Button } from "@/components/ui/button"
import Link from "next/link"

export default function Page() {
	const isLoggedIn = true

	return (
		<div>
			{isLoggedIn ? (
				<div className="w-dvw h-dvh flex items-center justify-center">
					<div className="flex flex-col items-center gap-5">
						<p>Welcome! Please authenticate!</p>
						<Link href="/auth/login?returnTo=/booking">
							<Button>Authenticate</Button>
						</Link>
					</div>
				</div>
			) : (
				<span>logged in</span>
			)}
		</div>
	)
}
