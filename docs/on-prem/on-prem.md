# Popsink API Documentation - Easy Step-by-Step Guide

## Table of Contents
1. [What You Need to Know](#what-you-need-to-know)
2. [Step 1: Create a User](#step-1-create-a-user)
3. [Step 2: Log In](#step-2-log-in)
4. [Step 3: Create an Environment](#step-3-create-an-environment)
5. [Step 4: Create a Team](#step-4-create-a-team)
6. [Step 5: Add Team Members](#step-5-add-team-members)
7. [Step 6: Create a Pipeline](#step-6-create-a-pipeline)
8. [Step 7: Update a Pipeline](#step-7-update-a-pipeline)
9. [Step 8: Start/Stop a Pipeline](#step-8-startstop-a-pipeline)
10. [Alternative Testing Methods](#alternative-testing-methods)

---

## What You Need to Know

### What is this guide for?
This guide shows you exactly how to use the Popsink API to create data pipelines. Think of it like a recipe - follow each step in order and you'll get great results!

### What you'll need:
- A computer with internet access
- Basic copy/paste skills
- 15 minutes of your time

### Important Notes:
- **Server URL**: All examples use `https://your-server/api` - this is your Popsink server
- **Order matters**: Follow steps 1-8 in order for best results
- **Save your IDs**: Each step gives you important IDs to use in the next step

### How the API Works (Simple Version):
1. **You ask** → Send a request to the API
2. **API responds** → Gives you data or confirms your action
3. **You use the response** → Take the ID from the response to use in the next step

**The Complete Flow:**
1. Create a user account (like signing up)
2. Log in to get your "access pass" (token)
3. Create an environment (your workspace)
4. Create a team (organize your work)
5. Add team members (invite people)
6. Create pipelines (set up data processing)
7. Control pipelines (start/stop as needed)

---

## Step 1: Create a User

### What you're doing:
Creating your first user account - like signing up for any website!

### What you need:
- An email address
- A password

### How to do it:

**Copy this command and paste it into your terminal:**
```bash
curl -X POST "https://your-server/api/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "your-email@company.com",
    "password": "your-password-here",
    "is_active": true,
    "is_superuser": false,
    "is_verified": false
  }' -k
```

**⚠️ Important:** Replace `your-email@company.com` and `your-password-here` with your actual email and password!

### What you'll get back:
```json
{
  "id": "3b0c298a-062e-42d1-a01b-277fa66908da",
  "email": "your-email@company.com",
  "is_active": true,
  "is_superuser": false,
  "is_verified": false,
  "active_env_id": null
}
```

### 📝 SAVE THIS:
**User ID:** `3b0c298a-062e-42d1-a01b-277fa66908da` ← This is an example! Copy YOUR actual User ID from the response above!

---

## Step 2: Log In

### What you're doing:
Getting your "access pass" (token) so you can use the API.

### How to do it:

**Copy and paste this command:**
```bash
curl -X POST "https://your-server/api/auth/jwt/login" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d 'username=your-email@company.com&password=your-password-here' -k
```

**⚠️ Important:** Use the same email and password from Step 1!

### What you'll get back:
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer"
}
```

### 📝 SAVE THIS:
**Your Token:** `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...` ← This is an example! Copy YOUR actual token from the response above!

### 💡 How to use your token:
From now on, add this to every command:
```
-H "Authorization: Bearer YOUR_TOKEN_HERE"
```

---

## Step 3: Create an Environment

### What you're doing:
Creating your workspace - think of it like creating a folder to organize all your work.

### Why you need this:
Without an environment, you can't create teams or pipelines. It's like needing a building before you can have offices!

### How to do it:

**Copy and paste this command:**
```bash
curl -X POST "https://your-server/api/envs/" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "my-workspace",
    "description": "My first workspace",
    "use_retention": true
  }' -k
```

**⚠️ Important:** Replace `YOUR_TOKEN_HERE` with your actual token from Step 2 (not the example shown above)!

### What you'll get back:
```json
{
  "name": "my-workspace",
  "use_retention": true,
  "retention_configuration": null,
  "id": "d455a981-be17-455e-a03c-4d9c3224db72"
}
```

### 📝 SAVE THIS:
**Environment ID:** `d455a981-be17-455e-a03c-4d9c3224db72` ← This is an example! Copy YOUR actual Environment ID from the response above!

---

## Step 4: Create a Team

### What you're doing:
Creating a team to organize your work and invite other people to help.

### What you need:
- Your token from Step 2
- A name for your team

### How to do it:

**Copy and paste this command:**
```bash
curl -X POST "https://your-server/api/teams/" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "My Data Team",
    "description": "Team for processing our data"
  }' -k
```

**⚠️ Important:** Replace `YOUR_TOKEN_HERE` with your actual token from Step 2 (not the example shown above)!

### What you'll get back:
```json
{
  "name": "My Data Team",
  "description": "Team for processing our data",
  "env_id": "d455a981-be17-455e-a03c-4d9c3224db72",
  "id": "881e0fce-5caa-4f5c-82c6-5eb883c47100"
}
```

### 📝 SAVE THIS:
**Team ID:** `881e0fce-5caa-4f5c-82c6-5eb883c47100` ← This is an example! Copy YOUR actual Team ID from the response above!

### 🎉 Success!
Notice how the `env_id` matches your environment ID? That means your team is properly connected to your workspace!

---

## Step 5: Add Team Members

### What you're doing:
Adding people to your team and giving them different roles.

### What you need:
- Your token from Step 2
- Your team ID from Step 4
- User IDs of people you want to add

### Roles explained:
- **Owners**: Can manage the team and do everything
- **Members**: Can use the team and view things

### First, create another user to invite:

**Copy and paste this command:**
```bash
curl -X POST "https://your-server/api/auth/register" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "teammate@company.com",
    "password": "teammatepass123",
    "is_active": true,
    "is_superuser": false,
    "is_verified": false
  }' -k
```

**You'll get back something like:**
```json
{
  "id": "32d4b09d-4527-40d5-923b-e166d85cb459",
  "email": "teammate@company.com",
  ...
}
```

### 📝 SAVE THIS:
**New User ID:** `32d4b09d-4527-40d5-923b-e166d85cb459` ← This is an example! Copy YOUR actual New User ID from the response above!

### Now add them to your team:

**Copy and paste this command:**
```bash
curl -X POST "https://your-server/api/teams/YOUR_TEAM_ID/members/bulk" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "members": [
      "NEW_USER_ID_FROM_ABOVE"
    ]
  }' -k
```

**⚠️ Important:** Replace:
- `YOUR_TEAM_ID` with your actual team ID from Step 4 (not the example shown)
- `YOUR_TOKEN_HERE` with your actual token from Step 2 (not the example shown)
- `NEW_USER_ID_FROM_ABOVE` with the actual new user ID you just created (not the example shown)

**💡 Note:** The user who created the team is automatically added as an owner, so you only need to add new members here.

### What you'll get back:
If successful, you'll get no response (that's normal and means it worked!)

### 🎉 Success!
Your team now has members and is ready to create pipelines!

---

## Step 6: Create a Pipeline

### What you're doing:
Creating your first data pipeline! This is where the magic happens - it will move and process your data.

### What you need:
- Your token from Step 2
- Your team ID from Step 4

### What this pipeline does:
- **Source**: Reads data from Kafka (a messaging system)
- **Target**: Writes data to Oracle (a database)
- **Transform**: Processes the data between source and target

### How to do it:

**Copy and paste this command:**
```bash
curl -X POST "https://your-server/api/pipelines/" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "My First Pipeline",
    "team_id": "YOUR_TEAM_ID",
    "state": "draft",
    "json_configuration": {
      "source_name": "kafka-source",
      "source_type": "kafka_source",
      "source_config": {
        "topic": "user-events",
        "bootstrap_servers": "localhost:9092",
        "consumer_group_id": "events-consumer-group",
        "sasl_username": "kafka_user",
        "sasl_password": "kafka_password",
        "sasl_mechanism": "PLAIN",
        "security_protocol": "SASL_SSL",
        "include_metadata": false
      },
      "target_name": "oracle-target",
      "target_type": "oracle_target",
      "target_config": {
        "database": "ORCL",
        "user": "oracle_user",
        "password": "oracle_password",
        "host": "localhost",
        "port": "1521",
        "server_name": "XE",
        "server_id": "oraclesrv01"
      },
      "smt_name": "basic-transform",
      "smt_config": [],
      "draft_step": "config"
    }
  }' -k
```

**⚠️ Important:** Replace:
- `YOUR_TOKEN_HERE` with your actual token from Step 2 (not the example shown)
- `YOUR_TEAM_ID` with your actual team ID from Step 4 (not the example shown)

### What you'll get back:
```json
{
  "name": "My First Pipeline",
  "state": "draft",
  "json_configuration": { ... },
  "id": "5efd3d63-a6eb-4b0c-afe9-6ee1d8f5f820",
  "team_name": "My Data Team",
  "team_id": "881e0fce-5caa-4f5c-82c6-5eb883c47100"
}
```

### 📝 SAVE THIS:
**Pipeline ID:** `5efd3d63-a6eb-4b0c-afe9-6ee1d8f5f820` ← This is an example! Copy YOUR actual Pipeline ID from the response above!

### 🎉 Success!
Your pipeline is created and ready to be configured and started!

---

## Step 7: Update a Pipeline

### What you're doing:
Changing your pipeline settings - like editing a document after you've written it.

### What you need:
- Your token from Step 2
- Your pipeline ID from Step 6

### How to do it:

**Copy and paste this command:**
```bash
curl -X PATCH "https://your-server/api/pipelines/YOUR_PIPELINE_ID" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Updated Pipeline Name",
    "json_configuration": {
      "source_name": "updated-kafka-source",
      "source_type": "kafka_source",
      "source_config": {
        "topic": "updated-topic",
        "bootstrap_servers": "localhost:9092",
        "consumer_group_id": "updated-consumer-group",
        "sasl_username": "updated_user",
        "sasl_password": "updated_password",
        "sasl_mechanism": "PLAIN",
        "security_protocol": "SASL_SSL",
        "include_metadata": false
      },
      "target_name": "updated-oracle-target",
      "target_type": "oracle_target",
      "target_config": {
        "database": "ORCL",
        "user": "updated_oracle_user",
        "password": "updated_oracle_password",
        "host": "localhost",
        "port": "1521",
        "server_name": "XE",
        "server_id": "oraclesrv01"
      },
      "smt_name": "updated-transform",
      "smt_config": [],
      "draft_step": "config"
    }
  }' -k
```

**⚠️ Important:** Replace:
- `YOUR_PIPELINE_ID` with your actual pipeline ID from Step 6 (not the example shown)
- `YOUR_TOKEN_HERE` with your actual token from Step 2 (not the example shown)

### What you'll get back:
```json
{
  "name": "Updated Pipeline Name",
  "state": "draft",
  "json_configuration": { ... },
  "id": "5efd3d63-a6eb-4b0c-afe9-6ee1d8f5f820",
  "team_name": "My Data Team",
  "team_id": "881e0fce-5caa-4f5c-82c6-5eb883c47100"
}
```

### 🎉 Success!
Your pipeline has been updated with the new settings!

---

## Step 8: Start/Stop a Pipeline

### What you're doing:
Controlling your pipeline - like turning a machine on and off.

### What you need:
- Your token from Step 2
- Your pipeline ID from Step 6

### 🚀 Start your pipeline:

**Copy and paste this command:**
```bash
curl -X POST "https://your-server/api/pipelines/YOUR_PIPELINE_ID/start" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -k
```

**⚠️ Important:** Replace:
- `YOUR_PIPELINE_ID` with your actual pipeline ID from Step 6 (not the example shown)
- `YOUR_TOKEN_HERE` with your actual token from Step 2 (not the example shown)

### What you'll get back:
```
"building"
```

### 💡 What "building" means:
Your pipeline is starting up and getting ready to process data. This is normal!

### ⏸️ Stop (pause) your pipeline:

**Copy and paste this command:**
```bash
curl -X POST "https://your-server/api/pipelines/YOUR_PIPELINE_ID/pause" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -k
```

**⚠️ Important:** Replace:
- `YOUR_PIPELINE_ID` with your actual pipeline ID from Step 6 (not the example shown)
- `YOUR_TOKEN_HERE` with your actual token from Step 2 (not the example shown)

### What you'll get back:
```
"paused"
```

### 🎉 Success!
You now know how to start and stop your data pipeline!

### 📊 Pipeline States Explained:
- **draft**: Pipeline is being designed
- **building**: Pipeline is starting up
- **live**: Pipeline is running and processing data
- **paused**: Pipeline is stopped
- **error**: Pipeline has a problem (check logs)

---

## Alternative Testing Methods

### 🛠️ Other Ways to Test the API

If you don't want to use curl commands, you can use these tools:

#### 1. **Postman** (Recommended for beginners)
- Download Postman (free)
- Create a new request
- Set the method (GET, POST, PATCH)
- Add the URL: `https://your-server/api/...`
- Add headers: `Authorization: Bearer YOUR_TOKEN`
- Add JSON body for POST/PATCH requests
- Click Send!

#### 2. **Python Script**
```python
import requests

# Your token from Step 2
token = "YOUR_TOKEN_HERE"
headers = {"Authorization": f"Bearer {token}"}

# Example: Get all pipelines
response = requests.get("https://your-server/api/pipelines/", 
                       headers=headers, verify=False)
print(response.json())
```

#### 3. **Browser DevTools**
- Open your browser
- Go to any website
- Press F12 to open DevTools
- Go to Console tab
- Paste JavaScript code like:
```javascript
fetch('https://your-server/api/pipelines/', {
    headers: {'Authorization': 'Bearer YOUR_TOKEN_HERE'}
})
.then(response => response.json())
.then(data => console.log(data));
```

#### 4. **HTTPie** (Command line tool)
```bash
http GET https://your-server/api/pipelines/ \
  Authorization:"Bearer YOUR_TOKEN_HERE"
```

### 📝 Important Reminders:

When using any method, remember to:
- Replace `YOUR_TOKEN_HERE` with your actual token (not the examples shown in this guide)
- Replace all example UUIDs with your actual IDs from the API responses
- Use `https://your-server/api` as the base URL
- Follow the 8 steps in order
- Save all the IDs you get back from YOUR actual API responses

### 🎯 Pro Tips:

1. **Start with curl**: It's included on most computers
2. **Use Postman**: If you want a visual interface
3. **Try Python**: If you want to automate multiple steps
4. **Save your work**: Keep a text file with all your actual IDs and tokens (not the examples from this guide)

---

## 🎉 Congratulations!

You've learned how to:
- ✅ Create user accounts
- ✅ Log in and get tokens
- ✅ Create environments (workspaces)
- ✅ Create teams
- ✅ Add team members
- ✅ Create data pipelines
- ✅ Update pipelines
- ✅ Start and stop pipelines

You're now ready to build amazing data processing pipelines with Popsink! 🚀