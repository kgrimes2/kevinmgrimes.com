---
title: "Should You Worry about Cloud Vendor Lock-in?"
date: 2021-06-30T09:33:12-07:00
draft: true
tags: ["cloud", "aws", "architecture", "kubernetes", "docker", "microservices"]
---

Cloud computing makes a lot of promises, such as cheaper compute, no maintenance, and virtually infinite scalability. The task of migrating from legacy, on-premises systems to the cloud has gotten easier as well, with offerings like [AWS Lightsail](https://aws.amazon.com/lightsail/) helping users new to the cloud get simple applications running in the cloud in minutes. What used to be available only to the most technically savvy (and rich!) companies in Silicon Valley is now being used by small businesses, government agencies, and others around the world.

<!--more-->

With these advancements, software managers are having their interest piqued. However, went doing their cost-benefit analysis of whether they should moving their legacy systems to the cloud, the question inevitably comes up: what if our cloud provider of choice goes out of business? What if their prices skyrocket and we are no longer able to afford to use them?

In short, these managers are raising concerns about *vendor lock-in*. I like [Wasabi's definition](https://wasabi.com/help/glossary-of-terms/cloud-lock-in-definition/):

> "Cloud lock-in (also known as vendor lock-in or data lock-in) occurs when transitioning data, products, or services to another vendor’s platform is difficult and costly, making customers more dependent (locked-in) on a single cloud storage solution."[<sup>1</sup>](https://wasabi.com/help/glossary-of-terms/cloud-lock-in-definition/)

Some managers will use the vendor lock-in issue as a reason to not use the cloud at all. However, I argue here that if your engineers architect your systems properly, you can switch between cloud providers relatively easily. Additionally, I question whether the need to switch clouds (or come out of the cloud altogether) is a real issue plagueing companies today.

## Legacy architectures

<!-- Software architectures have always evolved with the available technologies. For example, traditional client-server architectures were ideal for monolithic software applications developed by many different people within the same company. Pre-version control, keeping software together in a single monolithic application made sense since it made it easier to develop and maintain, as the code was all in one place. -->

Companies with monolithic applications can follow the "lift-and-shift" paradigm, which entails uploading your software binaries to a server running in the cloud, and effectively replicating what you are already doing with physical servers. No rearchitecting of your system is required.

<!-- You might ask, "well, why bother moving to the cloud, then?" There are a handful of advantages of "lifting-and-shifting" your application to the cloud, even if it isn't necessarily architected for it:

- Automated VM upgrades,
- Pay only for what you use, and
- Availability guarantees -->

A lot of companies find this option appealing, as it doesn't require any code refactoring. The code running in the cloud is exactly the same as the code running on their on-premises servers. That is, the cost of switching cloud providers (or falling out of the cloud altogether) is virtually nil.

Of course, even monolithic applications can have external dependencies, such as a database. All cloud providers offer managed database servers, which can serve your data to your applications. They run much more efficiently than you spinning up a VM with a database server on it, plus you get single-click upgrades, automatic backups, and the like.

## Architecting for the cloud

## Paying for the cloud

## Leaving the cloud
