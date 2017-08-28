node("master")
{
  checkout scm

  stage("build"){
    sh "make docker-build"
  }
  stage("push"){
    sh "make docker-push"
  }

}
