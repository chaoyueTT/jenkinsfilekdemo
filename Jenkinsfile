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
            ENVIRONMENT = 'prod'
            MODULE_PATH = 'ruoyi-vue'
            MODULE = 'ruoyi-admin'
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
                expression { environment.ENVIRONMENT == 'dev' }
            }
            steps {
                echo 'Testing Spring Boot application in dev environment...'
                sh 'mvn test'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh "docker build -t app-${environment.MODULE_PATH}-${environment.MODULE} ."
            }
        }

        stage('Deploy') {
            when {
                expression { environment.ENVIRONMENT == 'prod' }
            }
            steps {
                echo 'Deploying Spring Boot application to production environment...'
                script {
                    if (environment.ENVIRONMENT == 'prod') {
                        def remote = [
                            host: '172.30.239.255',
                            user: 'root',
                            keyFile: '',
                            script: "./deploy.sh ${environment.ENVIRONMENT} ${environment.MODULE_PATH} ${environment.MODULE}"
                        ]
                        def sshCommand = "ssh -i ${remote.keyFile} ${remote.user}@${remote.host} '${remote.script}'"
                        sh sshCommand
                    }
                }
            }
        }
    }
}
