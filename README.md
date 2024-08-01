# devops-practice

#4 Nginx  --------------------------************** Start ****************--------------------------

# 1.nginx-run-nodejs-backend.sh 
  	1. Install NodeJS, Pm2, Mongodb
	2. clone or pull repo latest code 
          https://github.com/Vidhya-Skill-School/NodeJS-Express-API-V1.git
	3. npm install
	4. pm2 start ./src/main.js
	5. pm2 ls ( verify server is running or not )
		localhost:3000
    6. run through Ubuntu Ec2 -> nginx -> localhost:3000    

-----------------------------------------------------------------------------------
# 2. create multiple routes in nginx configuration
    serve multiple applciation ( FE , BE ) with multiple different routes 
-----------------------------------------------------------------------------------
# 3. Nginx Load balancer 
	Configure multiple EC2 with same applciation and configure nginx 
	On sending multiple request it will handle load balancing with different EC2


#4 Nginx  --------------------------************** End ****************----------------------------

#5 CICD- Jenkins  --------------------------************** Start ****************--------------------------

# 1 Jenkins Installation 
	[text](5.CI-CD-Jenkins/1.Installation-Jenkins.txt)	

# 2 Jenkins Role Based access
	[text](5.CI-CD-Jenkins/2.Jenkin-Role-Based-Authorization.txt)

# 3 Jenkin with Github  
	#1 Setup Jenkins with github 
	#2 Enable Webhooks on Push for automatically trigger build on push 

https://medium.com/@amey-patki/github-jenkins-how-to-integrate-your-github-repository-to-your-jenkins-project-03f4f2d03991	

#5 CICD Jenkins  --------------------------************** End ****************----------------------------

#6 IAM Service AWS 
	User, Group, Policy 