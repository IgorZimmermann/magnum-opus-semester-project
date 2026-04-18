'use client'
import { Button } from '@/components/ui/button'
import { useParams, useRouter } from 'next/navigation'
import { useRef } from 'react'

export default function Page() {
	const { id } = useParams<{id: string}>()
	const router = useRouter()

	const ref = useRef<HTMLParagraphElement>(null)

  const getValue = () => {
    return ref.current?.innerText
  }

	return (
		<div className="w-full flex flex-col gap-5 items-center justify-center py-20">
			<p>Here is the summary of the consultation:</p>
			<p ref={ref} contentEditable suppressContentEditableWarning className="m-0 text-wrap max-w-[40dvw] box-border outline-none">
				{`
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi cursus, tellus sed tincidunt interdum, sapien mi ornare sapien, vel cursus massa massa id nisl. Donec finibus erat non nisi ultricies elementum. Donec at velit a enim feugiat tristique ac et ipsum. Mauris a tincidunt ligula, id eleifend enim. Etiam hendrerit sit amet odio sed ultricies. In eros tellus, faucibus quis cursus non, sagittis non justo. Aliquam malesuada finibus augue, eu ornare neque ullamcorper vel. Sed eu arcu vitae tortor iaculis venenatis et at sem. Vivamus iaculis eleifend ultricies. Aliquam felis felis, pretium sed euismod at, porta vitae elit. Vivamus dictum viverra quam, at pretium tellus dictum ut. Sed leo elit, iaculis convallis est et, imperdiet porta dolor. Nunc iaculis aliquet lectus vitae ornare. Nam in congue nibh. In eu pulvinar velit. Integer commodo dolor ac erat viverra, vitae viverra ipsum tristique.

In aliquam, sapien a ullamcorper tempor, risus tellus imperdiet diam, at sagittis neque metus at est. Etiam pellentesque tincidunt luctus. Fusce mauris leo, gravida et congue in, tristique et orci. Etiam ut leo iaculis, lobortis nibh at, tincidunt purus. Nam urna ipsum, tincidunt ut sollicitudin quis, luctus id purus. Praesent maximus vulputate turpis, eu vehicula nisl sollicitudin non. Cras feugiat dolor nibh, eu mattis mauris luctus a.

Suspendisse id lobortis orci. Etiam maximus tempus metus vitae molestie. Etiam non tempus nulla. Mauris mattis lobortis sem, eu ornare nisi egestas sed. Proin nec efficitur lacus, ut feugiat turpis. Nam facilisis fermentum ex eu accumsan. Morbi efficitur lacus tellus, vel scelerisque nisi ullamcorper non. Integer nisi eros, porta eget tortor eu, tempor tempus neque. Nullam feugiat accumsan turpis, nec viverra diam varius quis. Integer eros felis, faucibus in lorem sed, sagittis hendrerit lorem. Morbi sit amet luctus augue, sit amet rhoncus augue. In condimentum odio risus, vitae lacinia eros faucibus nec. Phasellus in ante tempus, vehicula magna vel, gravida dui. Pellentesque et est a nulla consequat ultrices vitae vitae ligula. Mauris augue augue, posuere non condimentum ullamcorper, eleifend vel sapien.

Nunc vel sem varius, posuere augue eget, bibendum ipsum. Cras non velit ut nunc tincidunt tristique. Sed ullamcorper, tellus lacinia pretium cursus, sapien nulla tincidunt justo, vitae luctus leo ex in dui. Cras non metus vel mi suscipit elementum. Duis accumsan, urna id dignissim finibus, metus neque feugiat ex, ut dignissim velit augue in libero. Nulla lacinia elit tellus, id efficitur felis tincidunt sed. Etiam molestie urna at nisl semper faucibus. In dignissim, massa at bibendum pretium, ante purus commodo orci, et vestibulum lacus dolor consectetur velit.

Integer ac turpis laoreet, venenatis tellus sed, condimentum ligula. Nam pulvinar nibh quis condimentum vehicula. Vestibulum justo purus, scelerisque id mollis ac, consequat sed purus. Integer lacinia, metus non dignissim interdum, mauris augue posuere ex, a commodo mauris sapien non mi. Sed tristique tincidunt nibh dictum ultrices. Nulla finibus, quam id vulputate interdum, sapien neque ornare lectus, id posuere ante ipsum eget nunc. In mollis iaculis convallis. Fusce blandit finibus libero, vel volutpat velit ultricies eu.
`}
			</p>
			<Button onClick={(e) => {
				e.preventDefault()
				console.log(getValue())
				router.push(`/appointment/${id}/note`)
			}}>Analyse</Button>
		</div>
	)
}
