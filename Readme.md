
[![Build Status](https://dev.azure.com/bocherch/DynamicsCICD/_apis/build/status/DynamicsDevOpsVS-2?branchName=master)](https://dev.azure.com/bocherch/DynamicsCICD/_build/latest?definitionId=8&branchName=master) - Master branch

# Adopt CI/CD for Power Platform Model Driven Apps by leveraging Azure DevOps

## Hands-on lab step-by-step

June 2019

# Contents

- [Disclaimer](#Disclaimer)
- [Overview](#Overview)
- [Solution architecture](#Solution-architecture)
- [Requirements](#Requirements)
- [Exercises](#Exercises)
  - [Exercise 1 - Load from Git](#Exercise-1---Load-from-Git)
  - [Exercise 2 - Compile code in Visual Studio](#Exercise-2---Compile-code-in-Visual-Studio)
  - [Exercise 3 - Make a change to entity via online UI](#Exercise-3---Make-a-change-to-entity-via-online-UI)
  - [Exercise 4 - Load solution to local machine](#Exercise-4---Load-solution-to-local-machine)
  - [Exercise 5 - Add a bug](#Exercise-5---Add-a-bug)
  - [Exercise 6 - Commit](#Exercise-6---Commit)
  - [Exercise 7 - See the problem in Pipeline](#Exercise-7---See-the-problem-in-Pipeline)
  - [Exercise 8 - Fix problem and commit fixed](#Exercise-8---Fix-problem-and-commit-fixed)
  - [Exercise 9 - Merge with master and deploy](#Exercise-9---Merge-with-master-and-deploy)

# Disclaimer

Information in this document, including URL and other Internet Web site references, is subject to change without notice. Unless otherwise noted, the example companies, organizations, products, domain names, e-mail addresses, logos, people, places, and events depicted herein are fictitious, and no association with any real company, organization, product, domain name, e-mail address, logo, person, place or event is intended or should be inferred. Complying with all applicable copyright laws is the responsibility of the user. Without limiting the rights under copyright, no part of this document may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means (electronic, mechanical, photocopying, recording, or otherwise), or for any purpose, without the express written permission of Microsoft Corporation.

Microsoft may have patents, patent applications, trademarks, copyrights, or other intellectual property rights covering subject matter in this document. Except as expressly provided in any written license agreement from Microsoft, the furnishing of this document does not give you any license to these patents, trademarks, copyrights, or other intellectual property.

The names of manufacturers, products, or URLs are provided for informational purposes only and Microsoft makes no representations and warranties, either expressed, implied, or statutory, regarding these manufacturers or the use of the products with any Microsoft technologies. The inclusion of a manufacturer or product does not imply endorsement of Microsoft of the manufacturer or product. Links may be provided to third party sites. Such sites are not under the control of Microsoft and Microsoft is not responsible for the contents of any linked site or any link contained in a linked site, or any changes or updates to such sites. Microsoft is not responsible for webcasting or any other form of transmission received from any linked site. Microsoft is providing these links to you only as a convenience, and the inclusion of any link does not imply endorsement of Microsoft of the site or the products contained therein.

© 2019 Microsoft Corporation. All rights reserved.

Microsoft and the trademarks listed at <https://www.microsoft.com/en-us/legal/intellectualproperty/Trademarks/Usage/General.aspx> are trademarks of the Microsoft group of companies. All other trademarks are property of their respective owners.

# Overview

This lab will explain ALM (Application Lifecycle Management) and CI/CD for Power Platform.

## Abstract

Learn how to leverage Azure DevOps Pipelines in continuous integration and continuous delivery (CI/CD) for Power Platform Model Driven Apps - one of the most requested topics from our enterprise clients. This lab will cover configuration migration, automatic testing, automatic build and automatic deployment.

## Learning Objective

Learn how to effectively integrate development streams, test and deploy solutions across Power Platform instances by utilizing Azure DevOps.

# Solution architecture

Common development practice is when you have separate environments for Production, Staging/UAT, QA and Development.  When you have team working on some feature (Feature 1) then you also need feature specific instance and depending of what developers do you may also have developer specific instances.

The challenge is how to effectively integrate all development stream and then deliver result to all stages.

![Development Streams](doc-media/developmentStreams.png 'Development Streams')

Let's review how development process looks like for team of two developers working on the same feature.

![Power Platform ALM](doc-media/alm.png 'Power Platform ALM')

1 – Export from Dev 1 instance

2 – Back and forth development

3 – Push to Feature 1 branch

4 – Test/Package/Deploy

5 – Fetch new changes

6 – Back and forth development

7 – Push to Feature 1 branch

8 – Test/Package/Deploy

9 – Fetch new changes

...

55 – Merge to Development

56 – Test/Package/Deploy

In this Lab we will implement 1-3 steps.

# Requirements

# Exercises


## Exercise 1 - Create DevOps project

- Log to your VM, please use credentials from Lab details.
- Open `Visual Studio 19` from the desktop. As you load Visual Studio for the first time it will ask you for account details.  Please use Azure credentials from Lab details.

## Exercise 2 - Create DevOps project


- In browser of your choice navigate to https://dev.azure.com and log in by using your Azure credentials.
- Click on `Sign in to Azure DevOps`.
![Development Streams](doc-media/DevOps-SignIn.png 'Development Streams')
- Click `Continue` on "We need a few more details" and then on "Get started with Azure DevOps" pages.
- Pick a name for your private DevOps project.
![Development Streams](doc-media/DevOps-CreateProject.png 'Development Streams')
- In the navigation on the left click on `Repo` icon and then pick `Files`
![](doc-media/DevOps-RepoFiles.png '')
- Note code highlighted in the next image.  You will need it in the next Exercise
![](doc-media/DevOps-RemoteAdd.png '')

## Exercise 3 - Load from Git


- in Windows search type Git to find app click on `Git Bash` app
![](doc-media/vm-openGit.png '')
- In the console window we will execute commands to clone code from Lab repository to your personal repository. Execute one-by-one commands and keep console window open for later steps.
  - `cd c:`
  - `git clone https://bocherch@dev.azure.com/bocherch/PowerPlatformCICDLab/_git/PowerPlatformCICDLab`
  - `cd PowerPlatformCICDLab/`
  - `git remote rm origin`
  - In this command replace URL_TO_YOUR_REPO with the url to your repo (red rectangle in image above) `git remote add origin URL_TO_YOUR_REPO`
  - `git push -u origin --all`
  - `git checkout -b feature/newfeature`
  - ########### delete `git push origin feature/newfeature`

## Exercise 2 - Compile code in Visual Studio

abc

## Exercise 3 - Make a change to entity via online UI

abc

## Exercise 4 - Load solution to local machine

abc

## Exercise 5 - Add a bug

abc

## Exercise 6 - Commit

abc

## Exercise 7 - See the problem in Pipeline

abc

## Exercise 8 - Fix problem and commit fixed

abc

## Exercise 9 - Merge with master and deploy

abc
