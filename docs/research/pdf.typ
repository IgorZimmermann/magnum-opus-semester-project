#import "../templates/research.typ": research

#show: research.with(
  topic: "PDF Generation",
  author: "Igor Zimmermann",
)

= Researched options
- *#link("https://typst.app")[Typst]*
- #link("https://pandoc.org")[Pandoc + Markdown]

= Reason

Typst unfortunately does not support passing in data from the cli, so writing data to a `json` file would be necessary. However, it support more extensive customizable options for the document, allowing us to make the final document look official. Ultimately I chose typst, because we already use it in the project and it's more customizable than markdown.

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
