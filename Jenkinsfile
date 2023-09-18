@Library("security_stages") _

pipeline {
    agent any
    environment {
        dockerHome = tool "jenkinsDocker"
        registry = "vinnmous/torproxy"
        registryCredential = 'docker_hub_usernamepw'
        dockerImage = ''
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }
    stages {
        stage ("Initializing Docker") {
            steps {
                script {
                    env.Path = "${dockerHome}/bin:${env.PATH}"
                }
            }
        }
        stage ("Attempting security stages") {
            steps {
                shared()
            }
        }
        stage('Building our image') {
            steps{
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy our image') {
            steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                }
                }
            }
        }
        stage('Cleaning up') {
            steps{
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }                                                                                                                                                                                                                           
    }
}