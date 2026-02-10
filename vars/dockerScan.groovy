def call(String imageName) {
    echo "Scanning Image: ${imageName}"
    sh "trivy image --severity HIGH,CRITICAL ${imageName} || echo 'Scan failed but continuing...'"
}
