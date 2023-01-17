
Project: Ensuring Quality Releases

Introduction
  In this project, you'll develop and demonstrate your skills in using a variety of industry leading tools, especially Microsoft Azure, to create disposable test environments and run a variety of automated tests with the click of a button. Additionally, you'll monitor and provide insight into your application's behavior, and determine root causes by querying the application’s custom log files.
  
  ![image](https://user-images.githubusercontent.com/20974800/212813810-0aada9e2-68f0-46ca-8395-db3752ce3aa6.png)


For this project we use the following tools:

  •	Azure DevOps: For creating a CI/CD pipeline to run Terraform scripts and execute tests with Selenium, Postman and Jmeter
  
  •	Terraform: For creating Azure infrastructure as code (IaS)
  
  •	Postman: For creating a regression test suite and publish the results to Azure Pipelines.
  
  •	Selenium: For creating a UI test suite for a website.
  
  •	JMeter: For creating a Stress Test Suite and an Endurance Test Suite.
  
  •	Azure Monitor: For configuring alerts to trigger given a condition from an App Service.

Dependencies

The following are the dependencies of the project you will need:
  
  •	Create an Azure Account
  •	Create an Azure DevOps Account

Install the following tools:
  
  o	Azure command line interface
  o	Terraform
  o	JMeter
  o	Postman
  o	Python
  o	Selenium

Instructions
  
  1) Execute the create-tf-storage.sh script
  2) Update terraform/main.tf with the Terraform storage account and state backend configuration variables:

    •	storage_account_name: The name of the Azure Storage account
    •	container_name: The name of the blob container
    •	key: The name of the state store file to be created
    
    terraform {
      backend "azurerm" {
        resource_group_name  = "tstate"
        storage_account_name = "tstate00000"
        container_name       = "tstate"
        key                  = "terraform.tfstate"
      }
    }

Configuring Terraform

Rename terraform/environments/test/terraform.tfvars.example to terraform.tfvars and update the following values as required:

# Resource Group/Location
  location = "East US"
  resource_group = "udacity-ensuring-quality-releases-rg"
  application_type = "WebApp"

# Network
  virtual_network_name = "udacity-ensuring-quality-releases-vnet"
  address_space = ["10.5.0.0/16"]
  address_prefix_test = "10.5.1.0/24"
  
Executing Terraform

Terraform creates the following resources for a specific environment tier:
  
  •	App Service
  •	App Service Plan
  •	Network
  •	Network Security Group
  •	Public IP
  •	Resource Group
  •	Linux VM

Use the following commands to create the infrastructure:

  cd terraform/environments/test
  terraform init
  terraform plan -out solution.plan
  terraform apply solution.plan

Setting up Azure DevOps
  
  Logged into the https://portal.azure.com/
  Logged into the https://dev.azure.com/ in a separate browser tab.

Create an Azure DevOps project
  
  Next, we'll need to create an Azure DevOps project and connect to Azure. The screenshots below show the steps, but if you need to, you can also refer to
  the official documentation for more detail.
  
  1.	Create new project and name it
      
  2.	Create new pipeline
  
  3.	Select GitHub and then your GitHub repository:
  
  ![pipeline-choosing repo](https://user-images.githubusercontent.com/20974800/212815356-c5f74dfa-8142-45c5-92d2-ca40bf023dc1.png)  
  
  4.	Configure your pipeline by choosing "Existing Azure Pipelines YAML File" and select the azure-piplines.yaml file in the menu that pops out on the right:
      
      ![pipeline yaml file](https://user-images.githubusercontent.com/20974800/212825978-c7970561-c5a6-4cce-962b-1998cc2bd05c.png)
      
      ![pipeline-choosing azure pipeline yaml](https://user-images.githubusercontent.com/20974800/212826017-feb9d7b6-5af6-4b6f-ab3a-3874540eea78.png)
      
Configuring the VM as a Resource

  Click on Environments and you should see an environment named Test. Click on it.
  
  ![agent registration-1](https://user-images.githubusercontent.com/20974800/212815784-f4d729f4-ecb4-4447-952e-bd195d26e2eb.png)
  
  ![agent registration-2](https://user-images.githubusercontent.com/20974800/212815806-79b43def-6908-4ba1-8852-db3ba0348eea.png)
  
  ![Environment test VM](https://user-images.githubusercontent.com/20974800/212815614-e151b1e2-dcf2-4faa-9e51-163be25dac71.png)
  
  click on Add resource and select Virtual Machine.
  
  ![Environment test VM - 2](https://user-images.githubusercontent.com/20974800/212815648-48cd0b19-4fc2-4d72-b16c-516d4f8d0fe3.png)
       
  Select Linux as the OS. You'll then need to copy the registration script to your clipboard and run this on the VM terminal.

  If everything was successful, you should see this output from the connection test:
  
  ![Environment test VM - 2](https://user-images.githubusercontent.com/20974800/212815964-1eddd79a-5674-49a5-9203-d5c5de7816b6.png)

  Back on Azure DevOps portal in Environments, you can close out the Add resource menu and refresh the page. You should now see the newly added VM resource
  listed   under Resources.

Adding service connection
  
  Go to project settings and then to service connections:
    
  Click on "New service connection" and select "Azure Resource Manager"

  Select "Service principal (automatic)":

  Name the connection "azurerm-sc" and create the new service principal:

  Create a Service Principal for Terraform

  Run the pipeline
  
  Go to the pipelines overview
  ![pipeline summary](https://user-images.githubusercontent.com/20974800/212816489-a7fc14ac-ce31-4413-b8f5-47d2667d9a78.png)

  ![pipeline summary tests](https://user-images.githubusercontent.com/20974800/212816464-23de301-5b43-4ea6-8024-95bacaa924d8.png)

  ![image](https://user-images.githubusercontent.com/20974800/212825041-08ef7c0f-db06-422f-8698-b5addb9b82e8.png)

  ![image](https://user-images.githubusercontent.com/20974800/212825179-90f0f1e9-4199-4d84-9918-f49eef4ad365.png)

  ![image](https://user-images.githubusercontent.com/20974800/212825407-76443d3e-4f87-47ba-a7ef-939deaed5745.png)

  Configure Azure Monitor
  
  Go to the Azure Portal, select your application service and create a new alert in the "Monitoring" group:
  
      
   ![create an alert rule](https://user-images.githubusercontent.com/20974800/212816175-23ee6a67-186a-49e7-8f49-bbe91776d619.png)
      

   ![Create action group](https://user-images.githubusercontent.com/20974800/212816188-c0539534-cf02-4fa7-ae57-c1367b73b3e7.png)
      
      
   ![Email MyAppservice action group](https://user-images.githubusercontent.com/20974800/212816303-935efe5e-da36-402d-be4f-ac293f2a192e.png)

      
   ![Alert metrics](https://user-images.githubusercontent.com/20974800/212816347-4ed8ae78-d916-4775-9ac7-56e80b00ec94.png)

      
   ![Email 3 page not found](https://user-images.githubusercontent.com/20974800/212816381-ff106925-8d4a-4b56-95ac-fd064ea857c8.png)
  
  Log Capturing:
   
   ![image](https://user-images.githubusercontent.com/20974800/212823473-4f5a7609-056a-49fa-ad44-f8c6b2f3c0bb.png)
   
   
   ![image](https://user-images.githubusercontent.com/20974800/212824277-84d73596-17d8-4bc8-a843-913393acecb8.png)


   
   ![image](https://user-images.githubusercontent.com/20974800/212823657-2008d6c7-7a20-40a1-824b-611c8ae8c7b9.png)






