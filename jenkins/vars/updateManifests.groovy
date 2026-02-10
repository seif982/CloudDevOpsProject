def call(String imageName, String newTag) {
    // بيفترض إن عندك فولدر اسمه k8s وفيه ملف اسمه deployment.yaml
    sh "sed -i 's|image:.*|image: ${imageName}:${newTag}|g' k8s/deployment.yaml"
}
