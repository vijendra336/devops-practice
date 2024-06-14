# devops-practice

#4 Nginx Practice 
# 1.nginx-run-nodejs-backend.sh 
  	1. Install NodeJS, Pm2, Mongodb
	2. clone or pull repo latest code 
          https://github.com/Vidhya-Skill-School/NodeJS-Express-API-V1.git
	3. npm install
	4. pm2 start ./src/main.js
	5. pm2 ls ( verify server is running or not )
		localhost:3000
    6. run through Ubuntu Ec2 -> nginx -> localhost:3000    