---
title: "About"
date: 2021-06-22T19:39:09-07:00
draft: false
---

<table>
    <tr>
        <td style="width:60%;">
            <p>
       Hi, my name's Kevin. I've been a Software Engineer at NASA Jet Propulsion Laboratory since 2017, working mainly on missions to Mars (Mars 2020 and MSL) and the Planetary Data System. I'm passionate about open-source software, cloud computing, space, and coffee.

Hobbies include going to Disneyland with my awesome wife Brittany, playing with my idiot cat, and reading comic books.         
            </p>
        </td>
        <td>
            <img style="width:400px;" src="/images/cali_adv_ferris_wheel_bright.png" />
        </td>
    </tr>
</table>
<table style="margin-left:auto;margin-right:auto;">
    <tr>
        <td>
            <img style="width:300px;" src="/images/photo_with_britt.png" />
        </td>
        <td>
            <img style="width:200px;" src="/images/ru_idiot.png" />
        </td>
    </tr>
</table>

## Resume

You can download my latest resume as a PDF from [here](/pdf/grimes_cv_fall2025.pdf).

### Introduction

Senior software engineer at NASA Jet Propulsion Laboratory supporting the Mars 2020 and PDS Imaging Node projects as cognizant engineer and development team lead, respectively. Graduated with a Master of Science degree in computer science from the University of Southern California. Graduated summa cum laude with a Bachelor of Science degree in mathematics from Evangel University. Experienced in designing, architecting, and implementing complex, mission-critical software systems.

### Skills

#### Programming languages

<table>
    <tr>
        <td>Go</td>
        <td>Java</td>
        <td>Python</td>
    </tr>
    <tr>
        <td>Bash</td>
        <td>JavaScript</td>
        <td>C++</td>
    </tr>
</table>

#### Technologies

<table>
    <tr>
        <td>Docker</td>
        <td>Kubernetes</td>
        <td>Flagger</td>
        <td>Istio</td>
    </tr>
    <tr>
        <td>FluxCD</td>
        <td>AWS</td>
        <td>Terraform</td>
        <td>ELK stack</td>
    </tr>
    <tr>
        <td>Apache Solr</td>
        <td>Linux</td>
        <td>Github</td>
        <td>Cameo System Modeler</td>
    </tr>
    <tr>
        <td>VICAR</td>
        <td>ISIS</td>
        <td>Ansible</td>
        <td></td>
    </tr>
</table>

#### Other skills

<table>
    <tr>
        <td>Team leadership</td>
        <td>Technical writing</td>
    </tr>
    <tr>        
        <td>Public speaking</td>
        <td>Agile software development</td>
    </tr>
    <tr>
        <td>Functional programming</td>
        <td>Object-oriented programming</td>
    </tr>
    <tr>
        <td>Microservice architectures</td>
        <td>Software cost estimation</td>
    </tr>
    <tr>
        <td>Linear algebra</td>
        <td>Image processing</td>
    </tr>
</table>

### Work experience

#### January 2017 to present: Scientific Applications Software Engineer at NASA Jet Propulsion Laboratory

Projects:

**PDS Imaging Node (“IMG”)** – Development Team Lead and Cognizant Engineer

- Architects, designs, and leads development of the Image Atlas, a system offering a “Amazon-like” search experience for >1 PB of planetary imagery data to the scientific community. The system adheres to the microservice style, consisting of over a dozen components orchestrated by Kubernetes and running in AWS.
- Participates in requirement negotiation with the system engineer, project manager, and various other stakeholders for the different IMG efforts.
- Architected and oversaw development of KDP, a Kubernetes operator used by IMG in data validation pipelines.
- Ensures success of IMG’s ongoing efforts by holding regular sprint planning and retrospective meetings, as well as small-group technical discussions with the development team as needed.
- Represents IMG’s efforts at planetary science conferences with posters and presentaNons.

**Mars 2020 (“M20”) Ground Data System (“GDS”) Instrument Data Subsystem (“IDS”)** – Cognizant Engineer

- Lead developer on PLACES, a mission-critical API used directly by rover drive planners to understand the rover’s position and attitude at any point along its traverse, beginning at the landing site. Written in Java using the Restlet framework, packaged in a Docker image, and deployed on AWS ECS.
- Holds training sessions with PLACES users and writes technical specification documents to ensure proper use of the tool.
- Develops on the IDS Pipeline team, the data processing pipeline that transforms raw telemetry packets into various image products for consumption by scientists as well as public release. Areas contributed to include PLACES ingestion, image transcoding, and trapezoid correction of PIXL image products.
- Lead developer on C-POSE, an API for registering models of the various M20 cameras. Written in Go using the Buffalo framework, packaged in a docker image, and deployed on AWS ECS.

**Mars Science Laboratory (“MSL”) Operations Product Generation Subsystem (“OPGS”)** - Cognizant Engineer

- Maintains PLACES Legacy, a system offering capabilities similar to the M20 system by the same name.
- Develops ingestion software that parses data products and populates PLACES accordingly.
- Provides operational support and training.

**Advanced Multi-Mission Operations System (“AMMOS")** - Cognizant Engineer

- Maintains the Web Resource Platform (“WRP”), a suite of tools and SDKs enabling programmatic access of image products, as well as their raster data and label information. Remote execution of image processing software is bundled with the suite.
- Maintains JEDI, a real-time analysis tool that renders data products and their metadata as they are processed. Adapted JEDI for the InSight project.
- Provides operational support and training.
- Prototyped WRP Tiling Service, which leverages the WRP Product Repository technology to cache image tiles in DZI format and provide them on-demand to clients such as OpenSeadragon.

#### Summer 2016: Summer Intern at NASA Jet Propulsion Laboratory

Worked with the Jason-3 team to redesign the pipeline used to ingest, parse, and process Jason-3 telemetry. Employed by Columbus Technologies.

- Became familiar with NetCDF format, Boost C++ libraries, Autotools, Doxygen, smart pointers, and lambda funcNons.
- Created readers that parsed low-level ASCII and binary satellite telemetry.
- Developed a printer to write high-level science and engineering data to file in NetCDF format.
- Implemented an algorithm that performed mathematical operations on satellite telemetry to produce a running average.
- Created validation scripts in Python to validate the full-processing code.
- Worked both independently and collaboraNvely via GitHub.

#### Summer 2015: Summer Intern at NASA Jet Propulsion Laboratory

Worked collaboratively with another intern to develop a visualization suite to assist the Ocean Surface Topography Mission in analyzing Jason-2 telemetry.

- Utilized Elasticsearch, Logstash, and Apache Spark to process, sort, and visualize satellite telemetry.
- Created a visualization tool in JavaScript with another intern using D3, JQuery, and Bootstrap.
- Created software in Perl to pull Jason-2 telemetry from an ElasNcsearch host, parse it, and print it to file in a variety of different file formats (CSV, ECSV, TSV).
- Used GitHub for version control.
- Enabled users to receive software as GitHub Enterprise releases and as Docker images

### Education

- Master of Science, Computer Science, from University of Southern California
- Bachelor of Science, Mathematics, from Evangel University
