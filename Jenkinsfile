pipeline{
    agent any
    options {
        ansiColor('xterm')
    }
    stages{
        stage('Git checkout'){
            steps{
                git credentialsId: '81da3224-35db-461a-a2c4-9e99ab3fdb74', url: 'https://github.com/revanthsai-bandi/hack-24-s2s'
            }
        }
        stage('Initialize'){
            steps{
                sh 'terraform init'
            }
        }
        stage('Plan'){
            steps{
                sh 'terraform plan'
            }
        }
        stage('Approval') {
            steps {
                script {
                    def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
                }
            }
        }
        stage('Apply'){
            steps{
               sh 'terraform apply -auto-approve'
               
               echo ' ******** LOOKS GOOD TO ME **********'
            }
        }
    }
}
