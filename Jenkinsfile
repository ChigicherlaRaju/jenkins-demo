pipeline {
  agent any
	parameters {
		choice(name: 'VERSION', choices: ['1.0', '1.1', '2.0'], description: '')
		booleanParam(name: 'executeTests', defaultValue: true, description: '')
	}
  
  // Using 'environment'
  environment {
    DATE = "May 02nd, 2022"
  }
  stages {
    stage("init"){
        steps{
          script {
            gv = load "deployScript.groovy"
          }
        }
    }
    stage("Env Variables") {
      environment {
        NAME = "Raju Chigicherla"
      }
      steps {
        echo "Today is ${env.DATE}"
        echo "My name ${env.NAME}"
        
        script {
          env.WEBSITE = "localhost"
        }
        echo "This is an example for ${env.WEBSITE}"
        
				// using withEnv([]) method
        withEnv(["TEST_VARIABLE=TEST_VALUE"]) {
          echo "The value of TEST_VARIABLE is ${env.TEST_VARIABLE}"
        }
        
        echo "The current build number is ${env.BUILD_NUMBER}"
        echo "Another method is to use \${BUILD_NUMBER}, which is ${BUILD_NUMBER}"
      }
    }
    stage("build") {
      steps {
        script {
          gv.buildApp()
        }
      }
    }
    stage("test") {
			when {
				expression {
					params.executeTests
				}
			}
			steps {
        script {
          gv.testApp()
        }
      }
    }
    stage("deploy") {
      steps {
        script {
          gv.deployApp()
        }				
      }
    }
  }
}
