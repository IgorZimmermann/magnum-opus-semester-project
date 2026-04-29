import { Geist, Geist_Mono, Inter } from "next/font/google"
import { Providers } from "./providers";

import "./globals.css"
import { ThemeProvider } from "@/components/theme-provider"
import { cn } from "@/lib/utils";
import { Auth0Provider } from "@auth0/nextjs-auth0";

const inter = Inter({ subsets: ['latin'], variable: '--font-sans' })

const fontMono = Geist_Mono({
	subsets: ["latin"],
	variable: "--font-mono",
})

export default function RootLayout({
	children,
}: Readonly<{
	children: React.ReactNode
}>) {
	return (
		<html
			lang="en"
			suppressHydrationWarning
			className={cn("antialiased", fontMono.variable, "font-sans", inter.variable)}
		>
			<body>
				<Auth0Provider><Providers><ThemeProvider>{children}</ThemeProvider></Providers></Auth0Provider>
			</body>
		</html>
	)
}
