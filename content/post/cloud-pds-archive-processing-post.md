---
title: "Cloud Processing of PDS Archival Products"
date: 2021-06-22T19:39:35-07:00
draft: true
tags: ["pds", "cloud", "aws", "kubernetes", "pdw", "psida"]
---

The presentation "Cloud Processing of PDS Archival Products with Amazon Web Services, Kubernetes, and Elasticsearch" was presented virutally to the 5th Planetary Data Workshop and 2nd Planetary Science Informatics and Data Analytics meeting on Wednesday, June 30, 2021.

## Video

{{< youtube mQGWqjcVZ6I >}}

## Downloads

- Abstract ([PDF](https://www.hou.usra.edu/meetings/planetdata2021/pdf/7102.pdf))
- Slideshow ([PPTX](/pptx/cloud_processing_pds3_pds4_products_pres_v2.pptx), [PDF](/pdf/cloud_processing_pds3_pds4_products_pres_v2.pdf))
- Lightning talk ([PPTX](/pptx/lightning_cloud_processing_pds3_pds4_products_pres_v1.pptx), [PDF](/pdf/lightning_cloud_processing_pds3_pds4_products_pres_v1.pdf))

## Abstract

**Note:** the following may be downloaded from [the conference's site](https://www.hou.usra.edu/meetings/planetdata2021/pdf/7102.pdf) in PDF format.

### Title

"CLOUD PROCESSING OF PDS ARCHIVAL PRODUCTS WITH AMAZON WEB SERVICES, KUBERNETES, AND ELASTICSEARCH" by Kevin M. Grimes II<sup>1</sup>, Rishi Verma<sup>1</sup>, James Michael McAuley<sup>1</sup>, Tariq Soliman<sup>1</sup>, Anil Natha<sup>1</sup>, Zachary M. Taylor<sup>1</sup>. <sup>1</sup>Jet Propulsion Laboratory, California Institute of Technology, Pasadena, CA.

### Introduction

As cameras and other spacecraft instruments improve, the data they produce becomes richer in quality and, inevitably, larger in volume. Processing these data in a timely fashion via traditional means becomes sluggish, inefficient, and expensive. In order to address challenges posed by next-generation missions taking place in our solar system, a reconsideration of processes used to process these data is required.

The Planetary Data System (PDS) Cartography and Imaging Sciences Node (IMG) retains hundreds of terabytes of data, collected from dozens of missions and spacecraft over as many years. Among the responsibilities of IMG is to make the data not only accessible by the public, but also searchable. By leveraging [PDS Engineering Node’s (ENG)](https://pds-engineering.jpl.nasa.gov/) software, [Amazon’s](https://amazon.com/) cloud offering [AWS](https://aws.amazon.com/), and the open-source container orchestration platform [Kubernetes](https://kubernetes.io/), IMG has made strides to provide a rich search experience of its data for the community.

### Architecture

IMG follows the microservices pattern for its backend architecture, which enables “rapid, frequent and reliable delivery of large, complex applications” [(link)](https://microservices.io/) in the form of small, individual services. These services may be developed independently from one another. In IMG’s case, they do not run on traditional servers, but instead on AWS’s [EKS](https://aws.amazon.com/eks/) service, which provides Kubernetes clusters using [Docker](https://docker.com/) as a service. Communication between these services is achieved via APIs, and common data is stored in various databases, including [Elasticsearch](https://www.elastic.co/enterprise-search) and [DynamoDB](https://aws.amazon.com/dynamodb).

![pds_img_api_high_level_arch.png](/images/pds_img_api_high_level_arch.png)

#### IMG API

Central to the architecture is the IMG API, a lightweight application interface responsible for interpreting general user requests, authenticating the user who made them, determining the user’s access via role authorization, and routing the request to the target backend service. By forcing all requests to the system (either from tools internal to IMG, or from outside entities) to go through this central location, we can easily revoke access to entities who abuse our services. For this component, IMG uses [API Gateway](https://aws.amazon.com/api-gateway/), another AWS offering that interprets [OpenAPI 3.0](https://swagger.io/specification/) specifications and allows routing to other services IMG maintains in the cloud. Additionally, API Gateway offers token-based authentication, which IMG uses.

![pds_img_api_class_diag.png](/images/pds_img_api_class_diag.png)

#### Data Access

Previously, IMG has allowed users to download its data holdings via HTTPS directly from our servers. However, IMG does not intend to continue holding all of its data on-premises; instead, it is exploring gradually moving its holdings to Amazon’s Simple Storage Service (S3). Of course, with movement to the cloud comes a variety of concerns, including cost. A requirement of the new system is that IMG be able to regulate users who abuse our system and, consequently, rack up a large bill, have their download rates be curtailed. This is enabled by the Data Access API, a lightweight application inspired by [TEA](https://github.com/asfadmin/thin-egress-app). The Data Access Application Programming Interface (API) abstracts away the physical location of files, allowing them to be stored in various different S3 buckets and actual servers. Additionally, access to these files is controlled by tokens, which the IMG API manages. Finally, users who abuse the system are curtailed, and risk having their tokens revoked altogether.

![data_access_api_class_diag.png](/images/data_access_api_class_diag.png)

#### Search

Searching IMG’s holdings is a capability that has been in place for years; however, several improvements are being made in various regards to the system. First, every file in our archive is being indexed, rather than just image files. This allows users to query programmatically for all the files in a virtual directory, for example. The entire label is being indexed into Elasticsearch for every product in the archive, using tools like [Harvest](https://pds-engineering.jpl.nasa.gov/development/pds4/5.0.0/ingest/harvest/) for PDS4, and [Logstash](https://www.elastic.co/logstash) with [PVL](https://pypi.org/project/pvl/) for PDS3.

Of course, mission-specific nuances exist in both the PDS3 and PDS4 cases. For example, the fields “longitude” and “latitude” may imply the location of the spacecraft for landed missions, but for orbital missions, may instead describe the location of the target being captured. Multimission tools like the [Atlas](https://pds-imaging.jpl.nasa.gov/search) require these discrepancies to be resolved, otherwise search across all of them would result in
inconsistencies. Toward this end, IMG separately converts the label contents into a “common” structure that maps between PDS3 and PDS4, while allowing users to query for the individual label fields as well.

### Deployment

The majority of the components described above are packaged as Docker images, which offer isolated runtime environments and virtually infinite scalability. Connecting containers to each other via their APIs is a challenging task, and requires additional tooling to orchestrate properly. Additionally, scaling (increasing the number of instances of) individual Docker containers to match increased consumer requests is a non-trivial task.

To this end, we leverage Kubernetes, an open-source container orchestration framework. By defining individual services within the context of Kubernetes-native resources, we can easily connect different components to each other via their APIs, regardless of how many replicas for each exist. The applications themselves and their corresponding definitions in Kubernetes are packaged into [Helm](https://helm.sh/) charts, which enable rapid deployment to the cluster.

An advantage of using Kubernetes and Docker for application deployment is that the system can be run effectively anywhere: as long as the target system can run Kubernetes (and, therefore, Docker), it can run the services. With few exceptions, there is little to no dependency on the host operating system; Docker containers can operate in their own contexts without worrying about the larger context. In IMG’s case, this involves running our development environment on hardware at JPL, but our production environment out of AWS.

Scaling and upgrading our services with no downtime is another requirement of the system. Kubernetes enables this with the help of a few additional technologies: [Flagger](https://flagger.app/), [FluxCD](https://fluxcd.io/), and [Istio](https://istio.io/). With the help of these tools, ["canary” rollouts](https://semaphoreci.com/blog/what-is-canary-deployment) are enabled which slowly redirect traffic to new, upgraded versions of services. If the system detects that a significant number of requests are failing, it cancels the rollout and automatically redirects traffic to the previous instance. If there do not appear to be any problems with the upgraded instance, however, all traffic is redirected to the new instance and the old instance is removed.

![pds_img_api_deployment_diag.png](/images/pds_img_api_deployment_diag.png)

### Future Work

Due to the rapidly changing nature of the technologies described above, IMG is constantly learning new and improved design patterns and technologies. Additionally, IMG hopes to interface with PDS Engineering Node’s [PDS API](https://github.com/NASA-PDS/pds-api)–a centralized API that routes traffic to different nodes.
