# 🚀 Cloud DevOps Final Project - Flask App Deployment

This project demonstrates a complete CI/CD lifecycle for a Flask application using modern DevOps tools. The pipeline covers everything from containerization to automated deployment using GitOps.

## 🛠 Tech Stack
* **App:** Flask (Python)
* **CI/CD:** Jenkins & ArgoCD
* **Containerization:** Docker
* **Orchestration:** Kubernetes (Minikube/EC2)
* **Configuration:** Ansible

---

## 📋 Task Progress

### Task 1: Web Application Development
* Developed a simple Flask web application.
* **Deliverable:** `app.py` and `requirements.txt`.


### Task 2: Containerization (Docker)
* Created a `Dockerfile` for the Flask app.
* Built and optimized the image.
* **Deliverable:** `Dockerfile` and local image build.
*

---

### Task 3: Infrastructure as Code (Ansible)
* Wrote Ansible playbooks to automate the setup.
* **Deliverable:** `playbook.yml` to install Docker/Jenkins.
[image](https://github.com/seif982/CloudDevOpsProject/blob/main/ansible/screenshots/verifyipandtestjenkins.png)

---

### Task 4: Continuous Integration (Jenkins)
* Configured a Jenkins Pipeline (`Jenkinsfile`).
* Automated Building, Tagging, and Pushing images to DockerHub.
* **Deliverable:** Jenkins pipeline stages successfully completed.
[Test](https://github.com/seif982/CloudDevOpsProject/blob/main/ArgoCD/screenshots/Screenshot%20from%202026-02-10%2016-15-16.png)

---

### Task 5: Kubernetes Manifests
* Created K8s manifests for the application.
* **Deliverable:** `deployment.yaml` and `service.yaml`.
[Running](https://github.com/seif982/CloudDevOpsProject/blob/main/k8s/screenshots/run.png)
---

### Task 6: Continuous Deployment (ArgoCD & GitOps)
* Configured ArgoCD to sync the Git repository with the K8s cluster.
* Implemented the "Self-healing" and "Automated Sync" features.
* **Deliverable:** `argo-app.yaml` and ArgoCD UI Sync status.
[GetPods](https://github.com/seif982/CloudDevOpsProject/blob/main/ArgoCD/screenshots/Screenshot%20from%202026-02-13%2021-38-48.png)
---

### Task 7: Infrastructure Observability & Resource Management
* Monitored the deployment and handled hardware resource limitations.
* Applied **Swap Space** configuration to stabilize the AWS/Local environment.
* **Deliverable:** System stability report and resource optimization.
> [Running](https://github.com/seif982/CloudDevOpsProject/blob/main/ArgoCD/screenshots/Screenshot%20from%202026-02-13%2021-46-57.png)

---

## 🚀 How to Run
1. **Clone the repo:** `git clone https://github.com/seif982/CloudDevOpsProject.git`
2. **Setup Cluster:** `minikube start --memory 4096`
3. **Deploy ArgoCD:** `kubectl apply -f argocd/argo-app.yaml`

---
## 👨‍💻 Author
**Seif Hatem** - Network DevOps Engineer
