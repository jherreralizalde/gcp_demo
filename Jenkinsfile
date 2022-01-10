pipeline {
  agent any
  environment {
    GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp')
  }
  tools {
    terraform "terraform"
  }
  stages {
    stage('Git Checkout') {
      steps {
        git branch: 'main', credentialsId: 'github', url: 'https://github.com/jherreralizalde/gcp_demo'
      }

    }

    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
      stage('Terraform Plan') {
        steps {
          sh 'terraform plan -out myplan'
        }
      }
      stage('Terraform apply') {
        steps {
          sh 'terraform apply -input=false myplan'
        }
      }
    }
  }
}