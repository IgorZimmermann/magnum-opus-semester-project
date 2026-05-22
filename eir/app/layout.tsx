import { Geist, Geist_Mono, Inter } from "next/font/google"
import { Providers } from "./providers";

import "./globals.css"
import { ThemeProvider } from "@/components/theme-provider"
import { cn } from "@/lib/utils";
import { Auth0Provider } from "@auth0/nextjs-auth0";
import { auth0 } from "@/lib/auth0";

const inter = Inter({ subsets: ['latin'], variable: '--font-sans' })

const fontMono = Geist_Mono({
	subsets: ["latin"],
	variable: "--font-mono",
})

export default async function RootLayout({
	children,
}: Readonly<{
	children: React.ReactNode
}>) {
	const session = await auth0.getSession()
	return (
		<html
			lang="en"
			suppressHydrationWarning
			className={cn("antialiased", fontMono.variable, "font-sans", inter.variable)}
		>
			<body>
				<Auth0Provider user={session?.user}><Providers><ThemeProvider>{children}</ThemeProvider></Providers></Auth0Provider>
			</body>
		</html>
	)
}
