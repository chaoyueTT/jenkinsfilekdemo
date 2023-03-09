pipeline {
     agent {
        docker {
            image 'maven:3.6.3-jdk-8'
        }
     }

    parameters {
            string(name: 'ENVIRONMENT', defaultValue: 'dev', description: 'The target environment')
            string(name: 'MODULE_PATH', defaultValue: '', description: 'The parent module name to deploy')
            string(name: 'MODULE', defaultValue: '', description: 'The module name to deploy')
        }

    environment {
            ENVIRONMENT = parameters.ENVIRONMENT
            MODULE_PATH = parameters.MODULE_PATH
            MODULE = parameters.MODULE
        }

    stages {
        stage('Build') {
            steps {
                echo 'Building Spring Boot application...'
                sh 'mvn clean install'
            }
        }

        stage('Test') {
            when {
                expression { params.ENVIRONMENT == 'dev' }
            }
            steps {
                echo 'Testing Spring Boot application in dev environment...'
                sh 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh "docker build -t app-${MODULE_PATH}-${MODULE} ."
            }
        }

        stage('Deploy') {
            when {
                expression { params.ENVIRONMENT == 'prod' }
            }
            steps {
                echo 'Deploying Spring Boot application to production environment...'
                script {
                    if (params.ENVIRONMENT == 'prod') {
                        def remote = [
                            host: '172.30.239.255',
                            user: 'root',
                            keyFile: '',
                            script: "./deploy.sh ${params.ENVIRONMENT} ${params.MODULE_PATH} ${params.MODULE}"
                        ]
                        def sshCommand = "ssh -i ${remote.keyFile} ${remote.user}@${remote.host} '${remote.script}'"
                        sh sshCommand
                    }
                }
            }
        }
    }
}
