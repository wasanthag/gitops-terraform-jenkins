def repoName = "gitops-terraform-jenkins"                         //Repo to store TF code for the TFE Workspace
def repoSshUrl = "git@github.com:wasanthag/gitops-terraform-jenkins.git"   //Must be ssh since we're using sshagent()
def tfCodeId = "example-${env.BUILD_NUMBER}"        //Unique name to use in the TF code filename and resource
def tfCodeFilePath = "${repoName}/${tfCodeId}.tf"   //Path and filename of the new TF code file
//Credentials
def gitCredentials = 'github-ssh'                   //Credential ID in Jenkins of your GitHub SSH Credentials
def tfeCredentials = 'tfc-token'                         //Credential ID in Jenkins of your Terraform Enterprise Credentials

  pipeline {
    agent any
      
  stages {
      
    stage('1. checkout') {
        steps {
           cleanWs()
          checkout scm
        }
    }  

   
    stage('2. Run the Workspace'){
      environment {
          REPO_NAME = "${repoName}"
      }
      steps {
       withCredentials([string(credentialsId: tfeCredentials, variable: 'TOKEN')]) {
          sh '''
            terraform init -backend-config="token=$TOKEN"  #Uses config.tf and the user API token to connect to TFE
            terraform apply
          '''
        }
      }
    }

    stage('3. Do integration or deployment testing'){
      steps {
        echo "Do whatever integration or deployment testing you need to do..."
        sleep 60
      }
    }

    stage('4. Cleanup (destroy) the test machines'){
      steps {
        sh """
           terraform init -backend-config="token=$TOKEN" 
           terraform destroy
          """
        }
    }

  } //stages

  
}
