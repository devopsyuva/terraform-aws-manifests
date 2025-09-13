// Groovy Declarative Pipeline
pipeline { 
    /*
    agent {
        label 'docker'
    }
    */
    agent any
    environment { 
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY') 
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    stages { 
        stage('Terraform Initialization') { 
            steps { 
                sh 'cd initialization && terraform init || terraform init -upgrade'
            } 
        } 
        stage('Terraform Format') { 
            steps { 
                sh 'cd initialization && terraform fmt -check || exit 0' 
            } 
        } 
        stage('Terraform Validate') { 
            steps { 
                sh 'cd initialization && terraform validate'
            } 
        }
        stage('SonarQube Analysis') {
           steps {
               script {
                   def scannerHome = tool 'sonarqube-1';
                   withSonarQubeEnv('sonarqube-1') {
                       sh "${scannerHome}/bin/sonar-scanner"
                   }
               }
           }
        }
        stage('Terraform Planning') { 
            steps { 
                sh 'cd initialization && terraform plan -no-color -out=terraform_plan'
                sh 'cd initialization && terraform show -json ./terraform_plan > terraform_plan.json'
            } 
        }
        stage('archive terrafrom plan output') {
            steps {
                archiveArtifacts artifacts: 'terraform_plan.json', excludes: 'output/*.md', onlyIfSuccessful: true
            }
        }
        stage('Review and Run terraform apply') {
            steps {
                script {
                    env.selected_action = input  message: 'Select action to perform',ok : 'Proceed',id :'tag_id',
                    parameters:[choice(choices: ['apply', 'abort'], description: 'Select action', name: 'action')]
                }
            }
        }
        stage('Terraform Apply') { 
            steps {
                script {
                    if (env.selected_action == 'apply') {
                        sh 'cd initialization && terraform apply -auto-approve'
                    } else {
                        sh 'echo Review failed and terraform apply was aborted'
                        sh 'exit 0'
                    }
                }   
            }
        }
        stage('Run terraform destroy or not?') {
            steps {
                script {
                    env.selected_action = input  message: 'Select action to perform',ok : 'Proceed',id :'tag_id',
                    parameters:[choice(choices: ['destroy', 'abort'], description: 'Select action', name: 'action')]
                }
            }
        }
        stage('Terraform Destroy') { 
            steps {
                script {
                    if (env.selected_action == "destroy") {
                        sh 'cd initialization && terraform destroy -auto-approve'
                    } else {
                        sh 'echo We are not destroying the resource initialted, aborted!!!'
                        sh 'exit 0'
                    }
                }
            } 
        }
    } 
}