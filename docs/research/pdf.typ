#import "../templates/research.typ": research

#show: research.with(
  topic: "PDF Generation",
  author: "Igor Zimmermann",
)

= Researched options
- *#link("https://typst.app")[Typst]*
- #link("https://pandoc.org")[Pandoc + Markdown]

= Reason

Both Typst and Pandoc allows inputting json data in the command line, so my choice ultimately came down to customizability of the document, in which Typst highly exceeds Pandoc + Markdown.

= How to get started

1. Get `typst`:
  ```sh
  brew install typst
  # or windows alternative
  ```

2. Create a data document:
  ```json
  {
  	"data_a": "this is data",
  	"data_b": ["this is", "another", "data"],
  	"data_c": {
  		"data_d": "look, more data"
  	}
  }
  ```
3. Create a `typst` document that uses that data:
  ```typst
  #let data = json("data.json")

  #data.data_a

  #for s in data.data_b [
    *#s*

  ]

  #data.data_c.data_d
  ```
4. Compile document to PDF:
  ```sh
  typst compile <file-name>
  ```

= Interactivity

Other components in the system would get the file itself, or get the pdf buffer streamed. It depends on the implementation. Other components would pass in an object that is the data, and the system either returns the file path or the file buffer.
