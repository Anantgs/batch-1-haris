# Run a Docker Container on Amazon ECS (Step-by-Step Guide)

This guide explains how to run a Docker container on Amazon ECS (Fargate) using an image stored in Amazon ECR.

> In this guide, we are using a simple Node.js application that runs on port 3000 as an example.  
> Navigate to `ECS-Deployment/my-docker-app` in this GitHub repository to find the application code and the Dockerfile used in this tutorial.

---

## Architecture Overview

```
Docker Image → Amazon ECR → Amazon ECS (Fargate) → Public URL
```

---

## Part 1: Push Docker Image to Amazon ECR

---

### Step 1: Login to Docker

```bash
docker login
```

1. Open the URL shown in your terminal:  
   https://login.docker.com/activate  
2. Enter the confirmation code displayed in the terminal.

---

### Step 2: Create an ECR Repository

1. Open AWS Management Console  
2. Navigate to **Amazon ECR**  
3. Click **Create repository**  
4. Enter the following details:

| Setting | Value |
|----------|----------|
| Repository name | my-docker-app |
| Image tag mutability | Mutable |
| Encryption | AES-256 (default) |

5. Click **Create repository**

---

### Step 3: Authenticate Docker with Amazon ECR

```bash
aws ecr get-login-password --region ap-south-1 \
| docker login --username AWS --password-stdin 111111111111.dkr.ecr.ap-south-1.amazonaws.com
```

If successful, you will see:

```text
Login Succeeded
```

---

### Step 4: Build the Docker Image

Navigate to the project directory:

```bash
cd ECS-Deployment/my-docker-app
```

Build the image:

```bash
docker build -t my-docker-app .
```

---

### Step 5: Tag the Image for ECR

```bash
docker tag my-docker-app:latest \
111111111111.dkr.ecr.ap-south-1.amazonaws.com/my-docker-app:latest
```

---

### Step 6: Push the Image to ECR

```bash
docker push 111111111111.dkr.ecr.ap-south-1.amazonaws.com/my-docker-app:latest
```

---

### Step 7: Verify the Image

1. Go to **Amazon ECR → Repositories**  
2. Open `my-docker-app`  
3. Confirm the `latest` image tag is present  

ECR setup is now complete.

---

## Part 2: Run the Container Using Amazon ECS

There are two ways to run containers on ECS:

1. Manual setup  
2. Express Mode (automatic setup)

---

## Method 1: Manual ECS Setup

---

### Step 1: Open Amazon ECS

1. Go to AWS Management Console  
2. Navigate to **Amazon ECS**

---

### Step 2: Create an ECS Cluster

1. Click **Clusters**  
2. Click **Create cluster**  
3. Configure the following:

| Setting | Value |
|----------|----------|
| Cluster name | your-cluster-name |
| Infrastructure | Fargate |

4. Leave other settings as default  
5. Click **Create**

---

### Step 3: Create a Task Definition

1. Go to **Task definitions**  
2. Click **Create new task definition**  
3. Enter:

| Setting | Value |
|----------|----------|
| Task definition name | your-task-name |
| Infrastructure | Fargate |

4. Use default OS/Architecture  
5. Leave task role unchanged  
6. Create a task execution role  
7. Continue  

---

### Step 4: Configure the Container

1. Container configuration:
   - Container name
   - Image: Select from ECR (`latest`)
2. Port mapping:

| Field | Value |
|--------|--------|
| Container port | 3000 |

> Since our Node.js application runs on port 3000, make sure the container port is set to 3000.

3. Optional configuration:
   - Environment variables  
   - CPU and memory limits  

4. Click **Create**

---

### Step 5: Create a Service

1. Go to **Clusters**  
2. Select your cluster  
3. Scroll to **Services**  
4. Click **Create**  
5. Select the task definition  
6. Leave environment as default  
7. Choose the desired number of tasks  
8. Click **Create**

Wait until the service status becomes **RUNNING**.

---

### Step 6: Access the Application

1. Go to **Clusters → Tasks**  
2. Select a running task  
3. Copy the **Public IP**  
4. Open in browser:

```
http://<public-ip>:3000
```

---

## Method 2: Express Mode (Quick Setup)

---

### Step 1: Use ECS Express Mode

1. Go to **Amazon ECS → Express Mode**  
2. Select your ECR image  
3. Click **Create**

AWS automatically creates all required resources.

---

### Step 2: Access the Application

1. Go to **Clusters**  
2. Copy the **Application URL**  
3. Open it in your browser  

---

## Summary

- The sample app is located at `ECS-Deployment/my-docker-app`
- Amazon ECR stores Docker images  
- Amazon ECS (Fargate) runs containers without managing servers  
- Manual setup provides full control  
- Express Mode is faster and beginner-friendly  
