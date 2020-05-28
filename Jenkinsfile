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
      
    stage('checkout') {
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
       withCredentials([usernamePassword(credentialsId: tfeCredentials, usernameVariable: 'USER', passwordVariable: 'TOKEN')]) {
          sh '''
            cd $REPO_NAME       #This gets cleared in Stage 1, which is required for terraform init to run properly
            terraform init -backend-config="token=$TOKEN"  #Uses config.tf and the user API token to connect to TFE
            terraform apply
          '''
        }
      }
    }

    stage('3. Do integration or deployment testing'){
      steps {
        echo "Do whatever integration or deployment testing you need to do..."
      }
    }

    stage('4. Cleanup (destroy) the test machines'){
      steps {
        sshagent (credentials: [gitCredentials]) {
          sh """
              cd ${repoName}
              terraform apply
          """
        }
      }
    }

  } //stages

  
}
