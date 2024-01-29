@Library("security_stages") _

pipeline {

    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '3'))
    }

    stages {
        stage ("Attempting security stages") {
            steps {
                shared()
            }
        }
        stage('Building our image') {
            steps {
                sh "sudo docker build ."
            }
        }
        stage('Login to Docker') {
            steps {
                withCredentials([string (credentialsId: 'docker_hub_token', variable: 'token')]) {
                    sh "sudo docker login --username vinnimous --password ${token}"
                }
            }
        }
        stage('Push to Docker') {
            steps {
                sh "sudo docker image push vinnimous/torproxy:latest"
            }
        }                                                                                                                                                                                                                           
    }
}