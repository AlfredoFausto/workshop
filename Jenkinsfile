pipeline{
    agent any
    environment{
        TOKEN_ALF = credentials('git-alfredo-token')
        LOGIN = sh script:"vault login -method=github token=${TOKEN_ALF}"
        DIGITALTOKEN = sh (script:'vault kv get -field=token workshop/AlfredoFausto/digitalocean', returnStdout: true).trim()
    }
    stages{
        stage ("init"){
            when { expression { env.BRANCH_NAME ==~ /dev.*/ || env.BRANCH_NAME ==~ /PR.*/ || env.BRANCH_NAME ==~ /feat.*/ } }
            steps{
                sh 'cd workshop && terraform init -input=false'
            }
        }
        stage ("validate"){
            when { expression { env.BRANCH_NAME ==~ /dev.*/ || env.BRANCH_NAME ==~ /PR.*/ || env.BRANCH_NAME ==~ /feat.*/ } }
            steps{
                sh 'cd workshop && terraform validate'
            }
        }
        stage ("plan"){
            when { expression { env.BRANCH_NAME ==~ /dev.*/ || env.BRANCH_NAME ==~ /PR.*/ || env.BRANCH_NAME ==~ /feat.*/ } }
            steps{
                sh 'cd workshop && terraform plan -out=plan -input=false'
                input(message: "Do you want to create a PR to apply this plan?", ok: "yes")
            }
        }
        stage ("apply"){
            when { expression { env.BRANCH_NAME ==~ /master.*/ } }
            steps{
                echo "validate"
            }
        }
        stage ("destroy"){
            steps{
                echo "validate"
            }
        }
    }
}