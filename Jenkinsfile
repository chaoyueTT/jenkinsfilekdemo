pipeline {
     agent any

    parameters {
            string(name: 'ENVIRONMENT', defaultValue: 'dev', description: 'The target environment')
            string(name: 'MODULE_PATH', defaultValue: '', description: 'The parent module name to deploy')
            string(name: 'MODULE', defaultValue: '', description: 'The module name to deploy')
        }

    environment {
            ENVIRONMENT = 'prod'
            MODULE_PATH = ''
            MODULE = 'ruoyi-admin'
        }

    stages {
        stage('Build') {
             agent {
                  docker {
                      image 'maven:3.6.3-jdk-8'
                  }
               }
            steps {
                echo 'Building Spring Boot application...'
                sh 'mvn clean install'
            }
        }

        stage('Test') {
            when {
                expression { env.ENVIRONMENT == 'dev' }
            }
            steps {
                echo 'Testing Spring Boot application in dev environment...'
                sh 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh "docker build --build-arg MODULE=${env.MODULE} -t ${env.MODULE}:latest ."
            }
        }

        stage('Deploy') {
            when {
                expression { env.ENVIRONMENT == 'prod' }
            }
            steps {
                echo 'Deploying Spring Boot application to production environment...'
                script {
                    if (env.ENVIRONMENT == 'prod') {
//                         def remote = [
//                             host: '172.31.79.255',
//                             user: 'root',
//                             keyFile: '',
//                             script: "./deploy.sh ENVIRONMENT=${env.ENVIRONMENT} MODULE=${env.MODULE}"
//                         ]
//                         def sshCommand = "ssh -i ${remote.keyFile} ${remote.user}@${remote.host} '${remote.script}'"
                        sh "chmod 777 -R ${env.WORKSPACE}"
                        sh "./deploy.sh ENVIRONMENT=${env.ENVIRONMENT} MODULE=${env.MODULE}"
                    }
                }
            }
        }
    }
}
