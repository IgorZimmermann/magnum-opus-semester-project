#import "../templates/report.typ": appendix, report

#show: report.with(
  title: "Project Report",
  authors: json("../team-members.json"),
)

= Introduction

= Methodology

= Problem analysis

= Requirements

= Design

= Implementation

= Validation

= Conclusion

