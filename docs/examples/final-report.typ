#import "../templates/report.typ": appendix, report

#show: report.with(
  title: "MAGNUM OPUS REPORT",
  authors: json("../team-members.json"),
)

= Design
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dapibus maximus ipsum sit amet luctus. Mauris aliquam dolor in accumsan fringilla. Curabitur ac augue eu urna feugiat tincidunt ut eu velit. Nunc id efficitur mauris. Aenean aliquet quam ipsum, nec ultrices enim fermentum id. Phasellus ullamcorper sem eget eros scelerisque pretium. Cras vehicula tellus nec lacus pellentesque, sed semper tellus vulputate. Curabitur egestas elit varius gravida cursus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Morbi blandit eros vel nunc rutrum, scelerisque dictum magna lobortis. Etiam vel pellentesque erat, volutpat vehicula metus. Morbi vel arcu in arcu eleifend egestas ut ac felis. Vestibulum eu libero interdum, maximus purus ac, posuere lectus. Nam in egestas nisl, non convallis metus. *@mona.*

= Implementation
== Python
Pellentesque condimentum blandit viverra. Quisque non ultricies dui. Fusce magna est, lacinia quis viverra at, mattis sit amet diam. Nunc est leo, finibus vitae est sit amet, tempus tincidunt justo. Duis mollis congue enim, vel elementum quam faucibus nec. Aenean aliquam congue urna, at dignissim neque consequat at. Nullam euismod vel nisl in lobortis. Proin ullamcorper placerat feugiat. Vivamus quis laoreet arcu. Ut gravida justo massa, in molestie tellus consequat id. Praesent pretium, leo at luctus tristique, nisi eros blandit velit, in porttitor elit est sit amet lacus. Vestibulum eu sollicitudin nisi. *See @python.*

#appendix(
  <python>,
  ```py
  print("Hello, World!")
  ```,
  "Example python code",
)

== Java
Pellentesque tempus fringilla felis hendrerit scelerisque. Nulla porttitor libero metus, sit amet sodales dolor interdum at. Fusce cursus mattis lectus ac maximus. In vehicula ullamcorper metus, ut pharetra elit posuere eu. Praesent faucibus, risus ac egestas efficitur, libero sem auctor enim, vel vulputate magna felis ut purus. Etiam erat velit, posuere vel tristique in, rhoncus quis ligula. Phasellus cursus bibendum neque, id auctor velit rutrum eu. Mauris tincidunt neque et felis tincidunt mollis. Aenean dictum, ex et egestas porttitor, dolor velit facilisis est, sollicitudin mollis velit magna in magna. Duis et metus iaculis, venenatis mauris id, convallis metus. Nullam venenatis est a pellentesque accumsan. Maecenas sit amet rhoncus felis, vel commodo libero. Etiam malesuada eu nisi a posuere. Ut vel pulvinar sem.

= Motivation
Fusce bibendum tortor quis imperdiet condimentum. Phasellus sit amet tellus sit amet dolor feugiat sagittis. Nam lobortis nisi sed libero consequat, sit amet semper quam tempor. Nulla molestie commodo ipsum. Nunc euismod ex et congue vehicula. Quisque laoreet non ex non elementum. Nullam iaculis nunc arcu, nec placerat ex maximus a. *See @snoop and @mona.*

#figure(
  image("../images/snoop.jpg"),
  caption: "Snoop Doggy Dog",
) <snoop>

#appendix(
  <mona>,
  image("../images/mona.png"),
  "Leonardo Da Vinci's Magnum Opus, the Mona Lisa",
)

= Component-based design
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis dapibus maximus ipsum sit amet luctus. Mauris aliquam dolor in accumsan fringilla. Curabitur ac augue eu urna feugiat tincidunt ut eu velit. Nunc id efficitur mauris. Aenean aliquet quam ipsum, nec ultrices enim fermentum id. Phasellus ullamcorper sem eget eros scelerisque pretium. Cras vehicula tellus nec lacus pellentesque, sed semper tellus vulputate. Curabitur egestas elit varius gravida cursus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Morbi blandit eros vel nunc rutrum, scelerisque dictum magna lobortis. Etiam vel pellentesque erat, volutpat vehicula metus. Morbi vel arcu in arcu eleifend egestas ut ac felis. Vestibulum eu libero interdum, maximus purus ac, posuere lectus. Nam in egestas nisl, non convallis metus.

Pellentesque condimentum blandit viverra. Quisque non ultricies dui. Fusce magna est, lacinia quis viverra at, mattis sit amet diam. Nunc est leo, finibus vitae est sit amet, tempus tincidunt justo. Duis mollis congue enim, vel elementum quam faucibus nec. Aenean aliquam congue urna, at dignissim neque consequat at. Nullam euismod vel nisl in lobortis. Proin ullamcorper placerat feugiat. Vivamus quis laoreet arcu. Ut gravida justo massa, in molestie tellus consequat id. Praesent pretium, leo at luctus tristique, nisi eros blandit velit, in porttitor elit est sit amet lacus. Vestibulum eu sollicitudin nisi.
