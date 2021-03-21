case $deploy_env in
    deploy)
        echo "deploy: $deploy_env"
        mvn clean test package
;;
    rollback)
        echo "rollback: $deploy_env"
        echo "version: $version"
        rm -rf target
        cp -R ${JENKINS_HOME}/jobs/deploy-zr/builds/${version}/archive/target .
        pwd && ls
;;
    *)
        exit
;;
esac
