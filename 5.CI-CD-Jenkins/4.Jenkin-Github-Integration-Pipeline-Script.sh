pipeline {
    agent any

    triggers {
        githubPush()
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Taking Latest'
                git branch: 'master', url: 'https://github.com/vijendra336/node-starter-main.git'
            }
        }
        stage('Install Dependencies') {
            steps {
                echo 'Installing Dependencies'
                dir('node-starter-main') {
                    sh 'npm install'
                }
            }
        }
        stage('Run Tests') {
            steps {
                echo 'Running Tests'
                dir('node-starter-main') {
                    sh 'npm test'
                }
            }
        }
        stage('Run Build') {
            steps {
                echo 'Building Application'
                dir('node-starter-main') {
                    sh 'npm run build'
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying Application'
                dir('node-starter-main') {
                    sh '''
                    pm2 stop my-app || true
                    pm2 start dist/main.js --name my-app
                    pm2 reload my-app
                    '''
                }
            }
        }
    }
}
