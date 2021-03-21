#!groovy

pipeline {
    agent {node {label 'master'}}
    
    environment {
        def PASSWD = credentials('9b495860-9cb4-4d9e-a756-49f618159bd1')
        def GIT_ADDR = 'git@172.16.1.252:/data/repo/solo'
    }

    parameters {
	choice (
	    choices: 'dev\nprod',
	    description: 'choose deploy environment',
	    name: 'devploy_env'
	)
	string (name: 'branch', defaultValue: 'master', description: 'Fill in your branch')
    }
    
    stages {
        stage ('Get Code') {
            steps {
                dir ("${env.WORKSPACE}") {
                    git branch:'master',  url: "${GIT_ADDR}"
                }
            }
        }

        stage ('Maven Build') {
            steps {
                sh 'mvn clean package -Dmaven.test.skip=true'
            }
        }

        stage ('Prod Deploy') {
            steps {
                sh 'pwd'
                sh 'cd /data/ansible/roles/deploy && ansible-playbook deploy.yaml'
            }
        }
       
        stage ('Test') {
            steps {
                sh 'echo "Test"'
            }
        }
    }
}
