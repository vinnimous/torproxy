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
                script {
                    docker build .
                }
            }
        }
        stage('Login to Docker') {
            steps {
                script {
                    withCredentials([credentialsID: 'docker_hub_token', variable: 'token']) {
                        docker login --username vinnimous --password ${token}
                    }
                }
            }
        }
        stage('Push to Docker') {
            steps {
                script {
                    docker image push vinnimous/torproxy:latest
                }
            }
        }                                                                                                                                                                                                                           
    }
}