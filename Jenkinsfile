@Library('my-shared-library') _ 

pipeline {
    agent any

    environment {
        // معلومات الـ Docker Hub
        DOCKER_IMAGE = "seif7atemmohamed/ivolve-flask-app" 
        IMAGE_TAG    = "${env.BUILD_NUMBER}"
        
        // الـ Credentials IDs اللي لازم تكريتها في Jenkins بنفس الأسامي دي
        DOCKER_HUB_CREDS = credentials('docker-hub-login') 
        GITHUB_CREDS     = credentials('github-token')
        
        // رابط الـ Repo بتاعك (بدون https:// في البداية عشان الـ Push)
        REPO_URL = "github.com/seif7atemmohamed/ivolve-flask-app.git"
    }

    stages {
        stage('Build Image') {
            steps {
                script {
                    // بينادي على vars/dockerBuild.groovy
                    dockerBuild("${DOCKER_IMAGE}:${IMAGE_TAG}")
                }
            }
        }

        stage('Scan Image') {
            steps {
                script {
                    // بينادي على vars/dockerScan.groovy
                    dockerScan("${DOCKER_IMAGE}:${IMAGE_TAG}")
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    // تسجيل الدخول للـ Docker Hub
                    sh "echo ${DOCKER_HUB_CREDS_PSW} | docker login -u ${DOCKER_HUB_CREDS_USR} --password-stdin"
                    // بينادي على vars/dockerPush.groovy
                    dockerPush("${DOCKER_IMAGE}:${IMAGE_TAG}")
                }
            }
        }

        stage('Delete Image Locally') {
            steps {
                script {
                    // بينادي على vars/dockerDelete.groovy (عشان ميملاش مساحة السيرفر)
                    dockerDelete("${DOCKER_IMAGE}:${IMAGE_TAG}")
                }
            }
        }

        stage('Update Manifests') {
            steps {
                script {
                    // بينادي على vars/updateManifests.groovy عشان يعدل الـ YAML
                    updateManifests("${DOCKER_IMAGE}", "${IMAGE_TAG}")
                }
            }
        }

        stage('Push Manifests') {
            steps {
                script {
                    // دفع التعديلات اللي حصلت في الـ Deployment YAML للـ GitHub
                    sh """
                        git config user.email "seif@example.com"
                        git config user.name "Seif-DevOps"
                        git add k8s/deployment.yaml || echo "No changes to commit"
                        git commit -m "Update image tag to ${IMAGE_TAG} [skip ci]" || echo "No changes to commit"
                        git push https://${GITHUB_CREDS_USR}:${GITHUB_CREDS_PSW}@${REPO_URL} HEAD:main
                    """
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline Finished!"
        }
        success {
            echo "All stages completed successfully! 🚀"
        }
        failure {
            echo "Something went wrong. Check the logs above. ❌"
        }
    }
}
