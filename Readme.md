
[![Build Status](https://dev.azure.com/bocherch/DynamicsCICD/_apis/build/status/DynamicsDevOpsVS-2?branchName=master)](https://dev.azure.com/bocherch/DynamicsCICD/_build/latest?definitionId=8&branchName=master) - Master branch

# Adopt CI/CD for Power Platform Model Driven Apps by leveraging Azure DevOps

## Hands-on lab step-by-step

July 2019

# Contents

- [Disclaimer](#Disclaimer)
- [Overview](#Overview)
- [Solution architecture](#Solution-architecture)
- [Requirements](#Requirements)
- [Exercises](#Exercises)
  - [Exercise 1 - Prepare VM](#Exercise-1---Prepare-VM)
  - [Exercise 2 - Create DevOps project](#Exercise-2---Create-DevOps-project)
  - [Exercise 3 - Prepare Initial Code](#Exercise-3---Prepare-Initial-Code)
  - [Exercise 4 - Prepare solution package](#Exercise-4---Prepare-solution-package)
  - [Exercise 5 - Import solution package to Power Platform instance](#Exercise-5---Import-solution-package-to-Power-Platform-instance)
  - [Exercise 6 - Make a change to entity via online UI](#Exercise-6---Make-a-change-to-entity-via-online-UI)
  - [Exercise 7 - Create Azure DevOps Pipeline](#Exercise-7---Create-Azure-DevOps-Pipeline)
  - [Exercise 8 - Fixing Unit Test](#Exercise-8---Fixing-Unit-Test)
  - [Exercise 9 - Pull request to master and deployment](#Exercise-9---Pull-request-to-master-and-deployment)
- [Summary](#Summary)

# Disclaimer

Information in this document, including URL and other Internet Web site references, is subject to change without notice. Unless otherwise noted, the example companies, organizations, products, domain names, e-mail addresses, logos, people, places, and events depicted herein are fictitious, and no association with any real company, organization, product, domain name, e-mail address, logo, person, place or event is intended or should be inferred. Complying with all applicable copyright laws is the responsibility of the user. Without limiting the rights under copyright, no part of this document may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means (electronic, mechanical, photocopying, recording, or otherwise), or for any purpose, without the express written permission of Microsoft Corporation.

Microsoft may have patents, patent applications, trademarks, copyrights, or other intellectual property rights covering subject matter in this document. Except as expressly provided in any written license agreement from Microsoft, the furnishing of this document does not give you any license to these patents, trademarks, copyrights, or other intellectual property.

The names of manufacturers, products, or URLs are provided for informational purposes only and Microsoft makes no representations and warranties, either expressed, implied, or statutory, regarding these manufacturers or the use of the products with any Microsoft technologies. The inclusion of a manufacturer or product does not imply endorsement of Microsoft of the manufacturer or product. Links may be provided to third party sites. Such sites are not under the control of Microsoft and Microsoft is not responsible for the contents of any linked site or any link contained in a linked site, or any changes or updates to such sites. Microsoft is not responsible for webcasting or any other form of transmission received from any linked site. Microsoft is providing these links to you only as a convenience, and the inclusion of any link does not imply endorsement of Microsoft of the site or the products contained therein.

© 2019 Microsoft Corporation. All rights reserved.

Microsoft and the trademarks listed at <https://www.microsoft.com/en-us/legal/intellectualproperty/Trademarks/Usage/General.aspx> are trademarks of the Microsoft group of companies. All other trademarks are property of their respective owners.

# Overview

This lab explains ALM (Application Lifecycle Management) and CI/CD for Power Platform.

## Abstract

Learn how to leverage Azure DevOps Pipelines in continuous integration and continuous delivery (CI/CD) for Power Platform Apps - one of the most requested topics from our enterprise clients. This lab covers configuration migration, automatic testing, automatic build and automatic deployment.

## Learning Objective

Learn how to effectively integrate development streams, test and deploy solutions across Power Platform instances by utilizing Azure DevOps.

# Solution architecture

Common development practice is to have separate environments for Production, Staging/UAT, QA and Development.  When team of developers is working on some feature (Feature 1) then feature specific instance is also needed.  Developer specific instances are required too.

The challenge is how to effectively integrate all development streams and then deliver results to next instances in the chain.

![Development Streams](doc-media/developmentStreams.png 'Development Streams')

Let's review how development process looks like for the team of two developers working on the same feature.

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

In this Lab we implement 1-4 steps.

# Requirements

Lab environment:

- Azure Subscription with DevOps license
- VM with VS19 + Git + PowerShell
- 2 PowerPlatform instances
  - `Dev` for Developer's needs
  - `Feature` feature instance that integrates work from all in team.

# Exercises

## Exercise 1 - Prepare VM

- Use Remote Desktop Connection app on your PC to log to lab VM, use credentials from Lab details.
- Open `Visual Studio 19` from the desktop. As you load Visual Studio for the first time it asks for account details.  Please use Azure credentials from Lab details.

## Exercise 2 - Create DevOps project

In this exercise we prepare Azure DevOps project.

- In browser of your choice navigate to https://dev.azure.com and log in by using your Azure credentials.
- Click on `Sign in to Azure DevOps`.

  ![Development Streams](doc-media/DevOps-SignIn.png 'Development Streams')
- Click `Continue` on "We need a few more details" and then click on `Get started with Azure DevOps` pages.
- Pick a name for your private DevOps project.

  ![Development Streams](doc-media/DevOps-CreateProject.png 'Development Streams')

- In the rop right corner click on circle icon avatar and then lick `Preview features`.  Switch `Multi-stage pipelines` to on.

- In the navigation on the left, click on `Repo` icon and then pick `Files`.

  ![Navigation](doc-media/DevOps-RepoFiles.png '')
- Navigate to your `default <project name> repository` link.

  Note highlighted code in the next image.  You will need it in the next exercise.

  ![New repo screen](doc-media/DevOps-RepoAdd.png '')

## Exercise 3 - Prepare Initial Code

In this exercise we clone code from lab repository and then push it to our Azure DevOps repository.

- In Windows Search type `Power Shell` to find app, right click on it and select `Run as administrator`

  ![Open PS](doc-media/vm-openPS.png '')
- In the PowerShell window we will execute commands to clone code from Lab repository to your Azure DevOps repository. Execute commands and keep PowerShell window open for later exercises.
  - `cd c:\`
  - `git clone https://bocherch@dev.azure.com/bocherch/PowerPlatformCICDLab/_git/PowerPlatformCICDLab`
  - `cd .\PowerPlatformCICDLab\`
  - `git remote rm origin`
  - In this command replace URL_TO_YOUR_REPO with the url to your repository (red rectangle in the image above)
  
    `git remote add origin URL_TO_YOUR_REPO`
  - `git push -u origin --all`
  
    Here you will be asked for credentials.  Use Azure credentials from Lab details.

## Exercise 4 - Prepare solution package

In this exercise we build solution from source code, install required PowerShell module and then create solution package.

- In Visual Studio Open solution from `C:\PowerPlatformCICDLab` folder and **build it** (Ctrl + Shift + B).

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
  - To package project into importable package run `.\PowerShell\Pack.ps1`.  Ignore two warnings after execution.
- Your screen should look like this.

  ![PowerShell Modules](doc-media/vm-modules.png '')
- After the last command you have `solution.zip` in `C:\PowerPlatformCICDLab` folder.  This is the package that was built from the source code.

## Exercise 5 - Import solution package to Power Platform instance

In this exercise we connect to PowerPlatform *Development* instance and then import and publish the solution package.

- Run `.\PowerShell\Connect.ps1` in order to connect to online instance.  Fill form the same way, just provide your Azure username and password and then click `Login`.
  
  ![Connect](doc-media/PP-Connect1.png 'Connect')

  In the list of available instances pick your *Development* instance.

  ![Connect](doc-media/PP-Connect2.png 'Connect')

- Run `.\PowerShell\Local-2-Online.ps1`.  This PowerShell script will upload `solution.zip` to selected instance and then publish it.  This script may run 2-4 minutes.
- Login to your PowerPlatform *Development* instance and validate that you have `Sample App`.  This is the application you've just deployed.

  ![Sample App](doc-media/PP-SampleTile.png 'Sample App')

## Exercise 6 - Make a change to entity via online UI

In this exercise we change the solution via PowerPlatform UI, then we load changes to the local repository.

- Login to https://make.powerapps.com/ to modify solution.  Make sure you pick the *Development* environment in the top right corner.

- Navigate to `Solutions` and drill into `Sample Solution`.  This is the solution we deployed from the source code.  

  ![Solution Pick](doc-media/PP-SolutionPick.png 'Solution Pick')

- Do some changes withing this solution.  For example you can modify Sample entity.  The fast change would be to change the length of the Value field.  Save Entity and then `Publish all customizations` for the solution.

  ![Entity Change](doc-media/PP-EntityChange.png 'Entity Change')

- In PowerShell window execute `git checkout -b feature/newfeature`
- Run `.\PowerShell\Online-2-Local.ps1` this loads solution file (zip) from online to your local folder.  If it fails with message *A connection to CRM is required* then run `.\PowerShell\Connect.ps1` again and pick your Dev instance.
- Run `.\PowerShell\Extract.ps1` this extracts solution into folder structure.
- If you run `git status` you will see what was changed.  Change that you did online was loaded to your PC.
- Commit changes to remote repository:
  - `git config --global user.email "you@example.com"` this and the second commands are required when you start using Git
  - `git config --global user.name "Your Name"`
  - `git add .` - stage changes
  - `git commit -m 'Exercise 6 change'` - commit changes to local repository
  - `git push origin feature/newfeature` - push changes to remote repository

At this point we demonstrated steps 1 and 2 from this diagram.

![Power Platform ALM](doc-media/alm.png 'Power Platform ALM')

## Exercise 7 - Create Azure DevOps Pipeline

In this exercise we create Azure DevOps Pipeline that listens to commits in branches.  After commit, pipeline uses source code to build, run tests and package solution.  If commit is to `master` branch then pipeline will also deploy package to `Feature` PowerPlatform instance.  In order for pipeline to "know" where to deploy we use pipeline variables.

- In Azure DevOps navigate to Pipelines Pipelines  (in older environments you will see Pipelines Builds in navigation)

  ![Pipeline](doc-media/DevOps-PipelinePipelines.png '')

- Latest Azure DevOps creates pipeline automatically as it sees `azure-pipelines.yml` is the repository.  Generated name for the pipeline is `<your project name> CI`.

  If pipeline was not create then follow these steps:
  
  - On the new screen click `New pipeline`
  - In `Where is your code?` page select `Azure Repos Git` and then on `Select a repository` select the name of your project.
  - `azure-pipelines.yml` is pulled from repository for your review.  Click `Run` to finish creating pipeline.  Pipeline starts immediately on `Master` branch.  Pipeline will fail on the first stage because of failing unit test.  We will fix unit tests in the next exercise.


- To finish setting up the pipeline we need to set pipeline variables.

  Navigate to the Pipelines Pipelines, click on your pipeline and then click `Edit`.  You will see yaml source.  On top right corner click on three dots menu and select `Variables`.

  ![Pipeline](doc-media/DevOps-Variables.png 'Pipeline')

- Please add the following variables:
  - `environment.url` - use *Feature* url from Lab settings page
  - `environment.username` - use *Feature* username from Lab settings page
  - `environment.password` - use *Feature* password from Lab settings page
  - `solution.packagetype` - set it to `Unmanaged`.  This setting gives you ability to deploy Unmanaged and Managed solution packages.

  `system.` variables are added by Azure DevOps system.
- Click `Save and queue` and then pick your newly created branch `feature/newfeature`

- Click on Branches in left navigation and after page is loaded click on three dots for `master` branch row.  Then click `Branch policies`.  We are going to set a rule that pull requests to master must be followed by successful pipeline run.

  ![Branch Policy](doc-media/DevOps-BranchPolicy.png 'Branch Policy')
- In the newly loaded window click `Add build policy.
- In the sliding `Add build policy` form select your pipeline for `Build pipeline` and then click Save

## Exercise 8 - Fixing Unit Test

In the previous exercise we created a pipeline and it detected that one of our tests is failing.  We are going to fix it now.  Failing demonstrates how the branch wll be automatically tested in the future.

- Open `.\PluginsTest\SamplePreCreateTests.cs` file and change `Assert.False(true);` to `Assert.False(false);`.  In this lab we are not teaching how to write unit tests but we show how to build infrastructure that builds code, tests code, packages it and then deploys.
- Commit change to Azure DevOps repository
  - `git add .`
  - `git commit -b 'bag fix'`
  - `git push origin feature/newfeature`
- After pipeline job is finished you will see that first Stage of pipeline was completed successfully.  Second stage was skipped because it is a deployment stage that runs only when we push code to `master` branch.

## Exercise 9 - Pull request to master and deployment

In this exercise we verify continues deployment.  `azure-pipelines.yml` has steps that pipeline runs when branches are updated or when pull request is created.  Let's create a pull request that takes changes from `feature/newfeature` to `master`

- In Azure DevOps navigate to Pull Requests

  ![PR Navigation](doc-media/DevOps-PR-Nav.png 'PR Navigation')

  Then in the top right corner click `New pull request`

- Pick `feature/newfeature` in `Select a source branch`.  Put any title and then click `Create`

- Click `Set auto-complete` to open `Enable automatic completion` form and then click `Set auto-complete`.  This step tells Azure DevOps to Complete pull request after successfully running the pipeline.

- The last step is: Azure DevOps runs pipeline on newly updated master branch.  During this pipeline job second stage will be activated which deploys changes automatically to `Feature` branch.

# Summary

Configured solution allows us running tests, builds, packaging jobs and deployments for all new branches in future.  This significantly saves time and prevents from human errors.

This Lab demonstrates 1-4 steps from this diagram

![Power Platform ALM](doc-media/alm.png 'Power Platform ALM')

All further steps are done in same pattern.

For questions and comments please contact bohdan.cherchyk@microsoft.com
