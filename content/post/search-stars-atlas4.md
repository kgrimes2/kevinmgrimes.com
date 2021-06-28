---
title: "Searching the Stars with Atlas IV"
date: 2021-06-22T21:03:35-07:00
draft: false
tags: ["pds", "atlas", "search", "elasticsearch", "js"]
showLicense: false
---

The presentation "Searching the Stars with Atlas IV" was presented virtually to the 5th Planetary Data Workshop and the 2nd Planetary Science Informatics and Data Analytics meeting on Thursday, July 1, 2021.

<!--more-->

## Video

{{< youtube pLp4QbK9b_8 >}}

## Downloads

- Abstract ([PDF](https://www.hou.usra.edu/meetings/planetdata2021/pdf/7099.pdf))
- Slideshow ([PPTX](/pptx/PDW_2021_SearchingTheStarsWithAtlas4_grimes-7099.pptx), [PDF](PDW_2021_SearchingTheStarsWithAtlas4_grimes-7099.pdf))
- Lightning talk ([PPTX](/pptx/lightning_talk_PDW_2021_SearchingTheStarsWithAtlas4_grimes-7099.pptx), [PDF](/pdfs/lightning_talk_PDW_2021_SearchingTheStarsWithAtlas4_grimes-7099.pdf))

## Abstract

**Note:** the following may be downloaded from [the conference's site](https://www.hou.usra.edu/meetings/planetdata2021/pdf/7099.pdf) in PDF format.

### Title

"SEARCHING THE STARS WITH ATLAS IV" by T. Soliman<sup>1</sup>, A. Natha<sup>1</sup>, K. Grimes<sup>1</sup>, R. Verma<sup>1</sup>, M. McAuley<sup>1</sup>, <sup>1</sup>Jet Propulsion Laboratory, California Institute of Technology, Pasadena, CA.

### Introduction

The Planetary Data System (“PDS”) Cartography and Imaging Sciences Node (“IMG”) retains hundreds of terabytes of planetary imagery captured by dozens of spacecraft over as many years. Bodies featured therein include the martian surface, the rings of Saturn, and the plumes of Europa. Each product held in our archive is associated with a label, rich with metadata describing the product itself, the body it captured, and the spacecraft that delivered it.

As our imagery collection continues to grow with missions like Mars 2020 preparing to deliver their first set of data, our approach to making these data available and searchable needs to scale and advance to meet challenges presented by these next-generation missions. Additionally, as web technologies continue to advance, so too do security and performance expectations, requiring IMG to undergo a substantial modernization effort to keep up.

Toward these ends, multiple components of the IMG website are being completely rebuilt. The main website has been completely redesigned to bring it up-to-date with today’s user experience standards. The IMG archive will be migrated to commercial cloud storage in the future, and therefore our website and portal infrastructure needs to be made compatible. Backend services are being rebuilt from the ground up to provide state-of-the-art workflows, security, search, and access. Finally, the Image Atlas search tool is receiving a complete revamp to give end users a more friendly search experience.

![New Atlas IV homepage](/images/atlas4_img_homepage.png)

### Atlas

The fourth iteration of the Image Atlas (“Atlas IV”) boasts several improvements over its predecessor and even more features. The entire codebase has been redone in favor of modern web technologies: the previous JQuery-era web application is replaced with a single-page React, Redux, MaterialUI, Node, and Webpack application. These technologies enable faster development; cleaner, scalable, and more maintainable code; access to an ever-growing suite of open-source JavaScript libraries; superior design; bundling; and transpiling.

### Filtering

Atlas IV’s search now utilizes addable filters to narrow the user’s search. This lowers the cognitive overhead to begin searching, when compared to Atlas III’s unset filter approach, while continuing to allow advanced users to search every facet. Addable filters are now organized into higher-level groups such as “Lighting” and “Time”. Additionally, facet descriptions have been added throughout the application, helping to describe ambiguously-named label keywords. Textual searching and other core Atlas III features are included and improved as well.

![GIF of filter-driven search in Atlas IV](/gifs/atlas4_filter.2021-06-27_19_27_20.gif)

### Map

Through recent user studies and interviews, we have arrived at the conclusion that geospatial search must be a primary way to navigate our archive–a markedly different approach than Atlas III. An expandable map is not only integrated into the filtering system but it can also render resulting imagery locations and footprints onto the surface. Bounding boxes and other spatial operations provide both a more powerful search and an increased context to better understand results. Another limit of Atlas III’s mapping functionality was that it only supported three maps. With the courtesy of our USGS partner’s mapping library [CartoCosmos](https://ceias.nau.edu/capstone/projects/CS/2020/CartoCosmos-S20/), Atlas IV will showcase maps of nearly 30 bodies all with various basemaps and layers for each. Polar maps are also supported.

![Image of Atlas IV map capability](/images/atlas4_map.png)

### File explorer

Implicit in the PDS3 and PDS4 archival standards are directory structures which provide a view of our holdings that facet-based and map-based search cannot adequately represent. The previous iteration of the site exposed our holdings as they existed on our servers as a directory listing. While this properly conveyed the structure of the archive, it was more arduous to navigate to specific items of interest in a timely fashion. Further, application security patches were required across a larger exposure attack surface. Atlas IV’s File Explorer solves these problems by abstracting away file locations via a secure API, and rendering results via a reactive web application that is intuitively reminiscent of a file exploration tree, while including enhancements like dynamic presentation and organization of archival files to meet specific user use cases.

The entirety of IMG’s archive is indexed in ElasticSearch and a new user interface has been developed to interact with it. Users can now filter over and search through all images, metadata, and ancillary files while still being able to traverse the file tree by clicking on folders.

![GIF of file explorer in Atlas IV](/gifs/Atlas4_filex.2021-06-27_19_27_49.gif)

### Download

Downloading large amounts of data is an increasingly popular task users like to perform against the IMG archive, and so we are introducing a “shopping cart” capability to better facilitate mass downloads. As users browse the archive and identify files they would like to download, they can place them into their cart for later download. Once the user has finished adding items to their cart, they may review them, remove any unwanted items, and begin the download. This "shopping cart" model enables IMG to support user archival downloads in a more intuitive manner.

The download mechanisms themselves are being reworked as well. Users will continue to be able to download individual files via command-line tools like [wget](https://www.gnu.org/software/wget/) and [curl](https://curl.se/); however, we are exploring other download methods such as asynchronous downloads. With this approach, the products the user has selected are collected behind the scenes and zipped into a file, and the user is sent via email notification a one-time link to download it. Another option being considered is streaming data straight to the user as a ZIP via the web browser. A final option is to offer a specialized download client that offers features like automatic retries and file prioritization. IMG is currently in the process of evaluating the most efficient and user-centric method among these options to support user downloads.

![Screenshot of Atlas IV bulk download](/images/atlas4_bulk_download.png)

### Record View

Archival data products are made available as first-class, individual, and standalone web pages in Atlas IV. In a given image’s page, users can expand the image to near full screen and interact with it by panning, zooming, and adding layers. Example layers include machine-learned boundaries indicating martian landmarks such as craters and dunes. Finally label information resides beside the image instead of off on another page. Users may interact with the keywords in the label and add them to their search to
find matching products.

The Record View also supports a highly-extensible “tabbed” view of imagery products, keeping users from being locked into a single perspective of the data. The raw, two-dimensional image may take the focus; or, perhaps, users would like to place their attention on its label and search through it interactively. Users may wish to see their image rendered on the surrounding surface, or know the three-dimensional orientation of the spacecraft, camera and their target at capture. All these perspectives are possible with Atlas IV’s new, extensible record view. It allows images and their data to be front and center. The Record View feature of Atlas IV also supports IMG's goals of providing more reusable and consistent web-links that users can share among the community.

![GIF of Record View in Atlas IV](/gifs/Atlas4_record.2021-06-27_19_28_55.gif)

### Additional Features

Additional features being introduced with Atlas IV include: mobile-friendly support, a closer integration with machine learning capabilities, extensive help to aid new users, an easily extensible code base for future improvements, virtualized, lazy-loaded, infinite scrolling results and a variety of ways to view them, a shared design system, and a tighter relationship with its parent IMG site.

![Atlas IV additional features screenshot](/images/atlas4_adtl_features.png)

### Conclusions and Further Work

Atlas IV, while still in the works, will exceed its predecessor Atlas III and ensure the Atlas experience is compliant with
modern web standards. Atlas IV is both an evolutionary and revolutionary reimagining of Atlas III with modern web UX and UI frameworks. Geospatial faceting and mapping are core features. File exploration will enable new searching options, orderly hierarchies, and standardized naming conventions. Atlas IV’s download functionality will be more robust and highly integrated into the search experience. Lastly, individual product images will be presented through dedicated pages that will enable tailored insights into the data, their labels, and the mission-specific context around the images.

> JPL URS clearance number: CL#21-2766

