
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

Lab environment:

- Azure Subs with Devops
- VM with VS19 + Git + PS
- 2 PowerPlatform instances

# Exercises

## Exercise 1 - Create DevOps project

- Log to your VM, please use credentials from Lab details.
- Open `Visual Studio 19` from the desktop. As you load Visual Studio for the first time it will ask you for account details.  Please use Azure credentials from Lab details.

## Exercise 2 - Create DevOps project

In this exercise we prepare Azure DevOps project.

- In browser of your choice navigate to https://dev.azure.com and log in by using your Azure credentials.
- Click on `Sign in to Azure DevOps`.

  ![Development Streams](doc-media/DevOps-SignIn.png 'Development Streams')
- Click `Continue` on "We need a few more details" and then on "Get started with Azure DevOps" pages.
- Pick a name for your private DevOps project.

  ![Development Streams](doc-media/DevOps-CreateProject.png 'Development Streams')
- In the navigation on the left click on `Repo` icon and then pick `Files`.

  ![Navigation](doc-media/DevOps-RepoFiles.png '')
- Click on `default Lab repository` link.

  Note highlighted code in the next image.  You will need it in the next exercise

  ![New repo screen](doc-media/DevOps-RepoAdd.png '')

## Exercise 3 - Prepare Initial Code

In this exercise we clone code from lab repo and then push it to our personal repo.

- in Windows search type `Power Shell` to find app, right click on it and select `Run as administrator`

  ![Open PS](doc-media/vm-openPS.png '')
- In the PowerShell window we will execute commands to clone code from Lab repository to your personal repository. Execute commands and keep PowerShell window open for later steps.
  - `cd c:\`
  - `git clone https://bocherch@dev.azure.com/bocherch/PowerPlatformCICDLab/_git/PowerPlatformCICDLab`
  - `cd .\PowerPlatformCICDLab\`
  - `git remote rm origin`
  - In this command replace URL_TO_YOUR_REPO with the url to your repo (red rectangle in image above)
  
    `git remote add origin URL_TO_YOUR_REPO`
  - `git push -u origin --all`
  
    Here you will be asked for credentials.  Use your Azure credentials.

## Exercise 4 - Prepare solution package

In this exercise we build solution from source code, install required PowerShell module and then create solution package.

- In Visual Studio Open solution from `C:\PowerPlatformCICDLab` folder and build it.

  In Visual Studio you can see that we have:
  - Plugins project - C# project for custom plugins
  - PluginsTest project - C# test project with unit tests for Plugins project
  - SolutionPackage project - Folder structure with XML files that represents solution.
  - WebResources project - Project for static web resources.

- In PowerShell window execute these commands:
  - `Set-ExecutionPolicy unrestricted`
  
    Select Option `A`
  - `Install-Module -Name Microsoft.Xrm.Data.Powershell`
  
    Select Option `A`
  - To package project into importable package run `.\PowerShell\Pack.ps1`.  Ignore two warnings.
- Your screen should look like this.

  ![PowerShell Modules](doc-media/vm-modules.png '')
- After last command you have `solution.zip` in `C:\PowerPlatformCICDLab` folder.  This is the package that was build from code.

## Exercise 5 - Import solution package to Power Platform instance

In this exercise we connect to online instance and then import and publish solution package.

- Run `.\PowerShell\Connect.ps1` in order to connect to online instance.  Fill form same way just provide your Azure username and password and then click `Login`
  
  ![Connect](doc-media/PP-Connect1.png 'Connect')

  IN the list of available instances pick your *Development* instance.

  ![Connect](doc-media/PP-Connect2.png 'Connect')

- Run `.\PowerShell\Local-2-Online.ps1`.  This power shell script will upload `solution.zip` to selected instance and then publish it.  This  script may run 2-4 minutes.
- Login to your PowerPlatform Dev instance and validate that you have `Sample App`.  This is the application you deployed from code.

  ![Sample App](doc-media/PP-SampleTile.png 'Sample App')

## Exercise 6 - Make a change to entity via online UI

In this exercise we change solution via PowerPlatform UI, then we load this change to our local repo.

- Login to https://make.powerapps.com/ to modify solution.  Make sure you pick the Dev environment in the top right corner.

- Navigate to `Solutions` and drill into `Sample Solution`.  This is the solution we deployed from code.  Do some changes withing this solution.  For example you can modify Sample entity.  The fast change would be to change the length of Value field.

  ![Solution Pick](doc-media/PP-SolutionPick.png 'Solution Pick')
- Do some changes withing this solution.  For example you can modify Sample entity.  The fast change would be to change the length of Value field.  Save Entity and then `Publish all customizations` for solution.

  ![Entity Change](doc-media/PP-EntityChange.png 'Entity Change')

- In PowerShell window execute `git checkout -b feature/newfeature`
- Run `.\PowerShell\Online-2-Local.ps1`.  This script will load solution from instance and unpack it to local folder structure.  You should see now what is changed if you run `git status`.
- Commit changes to remote repository:
  - `git add .` - stage changes
  - `git commit -m 'our change'` - commit changes to local repo
  - `git push origin feature/newfeature` - push changes to remote repo

So far we demonstrated steps 1 and 2 from this diagram.

![Power Platform ALM](doc-media/alm.png 'Power Platform ALM')

## Exercise 7 - Create Azure DevOps Pipeline

In this exercise we create Azure DevOps Pipeline that listens to commits in branches.  After commit, pipeline uses source code to build, run tests and package solution.  If commit is to `master` branch then pipeline will also deploy package.

- In Azure DevOps navigate to Pipeline Builds

  ![PipelineBuilds](doc-media/DevOps-PipelineBuilds.png '')

  On the new screen click `New pipeline`
- In `Where is your code?` page select `Azure Repos Git` and then on `Select a repository` select the name of your project.
- azure-pipelines.yml will be pulled from repo for your review.  Click `Run` to finish creating pipeline.  Pipeline will start immediately on `Master` branch.  It will fail on the second stage because we haven't provided pipeline variables yet.
- Navigate again to Pipeline Builds and then click `Edit`.  You will see yaml source.  On top right corner click on three dots menu and select `Variables`.

![PipelineBuilds](doc-media/DevOps-Variables.png '')

- Please add following variables:
  - `environment.url` - use *Production* url from Lab settings page
  - `serviceAccount.password` - use *Production* password from Lab settings page
  - `serviceAccount.upn` - use *Production* url from Lab settings page
  - `solution.packagetype` - set it to `Unmanaged`.  This setting give you ability to deploy Unmanaged and Managed solution packages.

  `system.` variables are added by Azure DevOps environment
- Click `Save and queue` and then pick your newly created branch `feature/newfeature`

## Exercise 6 - Commit

abc

## Exercise 7 - See the problem in Pipeline

abc

## Exercise 8 - Fix problem and commit fixed

abc

## Exercise 9 - Merge with master and deploy

abc
