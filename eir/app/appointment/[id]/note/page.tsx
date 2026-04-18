'use client'
import { Button } from '@/components/ui/button'
import { Card, CardHeader, CardTitle, CardContent } from '@/components/ui/card'
import { useRouter } from 'next/navigation'

export default function Page() {
	const router = useRouter()

	return (
		<div className="w-full flex flex-col gap-5 items-center justify-center py-20">
			<p>Here is the breakdown of the consultation:</p>
			<div className="flex flex-col gap-5">
				<Card className='w-[40dvw]'>
					<CardHeader>
						<CardTitle>Symptoms</CardTitle>
					</CardHeader>
					<CardContent>
						<p className="text-wrap">{`In aliquam, sapien a ullamcorper tempor, risus tellus imperdiet diam, at sagittis neque metus at est. Etiam pellentesque tincidunt luctus. Fusce mauris leo, gravida et congue in, tristique et orci. Etiam ut leo iaculis, lobortis nibh at, tincidunt purus. Nam urna ipsum, tincidunt ut sollicitudin quis, luctus id purus. Praesent maximus vulputate turpis, eu vehicula nisl sollicitudin non. Cras feugiat dolor nibh, eu mattis mauris luctus a.`}</p>
					</CardContent>
				</Card>
				<Card className='w-[40dvw]'>
					<CardHeader>
						<CardTitle>Diagnosis</CardTitle>
					</CardHeader>
					<CardContent>
						<p className="text-wrap">{`In aliquam, sapien a ullamcorper tempor, risus tellus imperdiet diam, at sagittis neque metus at est. Etiam pellentesque tincidunt luctus. Fusce mauris leo, gravida et congue in, tristique et orci. Etiam ut leo iaculis, lobortis nibh at, tincidunt purus. Nam urna ipsum, tincidunt ut sollicitudin quis, luctus id purus. Praesent maximus vulputate turpis, eu vehicula nisl sollicitudin non. Cras feugiat dolor nibh, eu mattis mauris luctus a.`}</p>
					</CardContent>
				</Card>
				<Card className='w-[40dvw]'>
					<CardHeader>
						<CardTitle>Advice/Prescription</CardTitle>
					</CardHeader>
					<CardContent>
						<p className="text-wrap">{`In aliquam, sapien a ullamcorper tempor, risus tellus imperdiet diam, at sagittis neque metus at est. Etiam pellentesque tincidunt luctus. Fusce mauris leo, gravida et congue in, tristique et orci. Etiam ut leo iaculis, lobortis nibh at, tincidunt purus. Nam urna ipsum, tincidunt ut sollicitudin quis, luctus id purus. Praesent maximus vulputate turpis, eu vehicula nisl sollicitudin non. Cras feugiat dolor nibh, eu mattis mauris luctus a.`}</p>
					</CardContent>
				</Card>
			</div>
			<Button onClick={(e) => {
				e.preventDefault()

				router.push('/')
			}}>Seal consultation</Button>
		</div>
	)
}
