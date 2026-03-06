#import "../templates/research.typ": research

#show: research.with(
  topic: "PDF Generation",
  author: "Igor Zimmermann",
)

= Researched options
- *#link("https://typst.app")[Typst] with custom API*

= Reason

In Typst, it is easy to create a highly-customized template and pass in data. A custom wrapper API would be easy to implement around the typst-cli in whatever we choose as our backend tech.

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
