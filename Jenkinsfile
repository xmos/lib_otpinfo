// This file relates to internal XMOS infrastructure and should be ignored by external users

@Library('xmos_jenkins_shared_library@v0.38.0') _

def archiveLib(String repoName) {
    sh "git -C ${repoName} clean -xdf"
    sh "zip ${repoName}_sw.zip -r ${repoName}"
    archiveArtifacts artifacts: "${repoName}_sw.zip", allowEmptyArchive: false
}

getApproval()

pipeline {
  agent none
  options {
    buildDiscarder(xmosDiscardBuildSettings())
    skipDefaultCheckout()
    timestamps()
  }
  parameters {
    string(
      name: 'TOOLS_VERSION',
      defaultValue: '15.3.1',
      description: 'The XTC tools version'
    )
    string(
      name: 'XMOSDOC_VERSION',
      defaultValue: 'v6.3.1',
      description: 'The xmosdoc version'
    )
    string(
        name: 'INFR_APPS_VERSION',
        defaultValue: 'v2.0.1',
        description: 'The infr_apps version'
    )
  }
  environment {
    REPO = 'lib_otpinfo'
    REPO_NAME = 'lib_otpinfo'
  }
    stages {
    stage('Build + Documentation') {
      agent {
        label 'documentation && linux && x86_64'
      }
      stages {
        stage('Checkout') {
          steps {
            println "Stage running on: ${env.NODE_NAME}"
            dir("${REPO}") {
              checkoutScmShallow()
            }
          }
        }  // Get sandbox

        stage('Build examples') {
          steps {
            withTools(params.TOOLS_VERSION) {
              dir("${REPO}/examples") {
                script {
                  // Build all apps in the examples directory
                  xcoreBuild()
                } // script
              } // dir
            } //withTools
          } // steps
        }  // Build examples

        stage('Library checks') {
          steps {
            warnError("lib checks") {
              runLibraryChecks("${WORKSPACE}/${REPO}", "${params.INFR_APPS_VERSION}")
            }
          }
        }

        stage('Documentation') {
          steps {
            dir("${REPO}") {
              warnError("Docs") {
                buildDocs()
              }
            }
          }
        }

        stage("Archive Lib") {
          steps {
            archiveLib(REPO)
          }
        } //stage("Archive Lib")
      } // stages
      post {
        cleanup {
          xcoreCleanSandbox()
        } // cleanup
      } // post
    } // stage('Build + Documentation')
  } // stages
}
