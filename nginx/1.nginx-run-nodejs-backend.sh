install_node() {
  if command -v node > /dev/null 2>&1; then
          echo "node.js is already installed."
  else
        echo "node.js not installed."
                 echo "Installing node.js ..."

  # update the package index
  echo "** Update package **"
  sudo apt update

  # install curl if not installed
  echo "** install curl ** "
  sudo apt install -y curl

  # install nvm
  # echo "install nvm"
  # curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

  # load nvm
  # echo "reload bash"
  # source ~/.bashrc


  # Use nvm to install latest node.js
  echo "** install latest stable node.js using nvm **"
  nvm install lts

  fi
}

install_mongodb(){

                # Check MongoDB service status
                if systemctl status mongod >/dev/null 2>&1; then
                        echo "MongoDB service is installed and running."
                else
                        echo "MongoDB service is not running or not installed."

                        sudo apt-get install gnupg curl
                        curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
                           sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
                           --dearmor
                        echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

                        sudo apt-get update
                        sudo apt-get install -y mongodb-org

                        echo "mongodb daemon reload.."
                        sudo systemctl daemon-reload

                        echo "mongodb try to start..."
                        sudo systemctl start mongod
                        sudo systemctl status mongod
                        sudo systemctl enable mongod

                        echo "mongodb installation end..."
                fi
}

install_pm2(){
        # Check PM2 version
        if pm2 --version >/dev/null 2>&1; then
            echo "PM2 is installed."
            echo "PM2 version: $(pm2 --version)"
        else
            echo "PM2 is not installed."

            echo "pm2 installation start..."
            sudo npm install pm2 -g
            sudo apt update

        echo "pm2 installation end..."

        fi
}

restart_services(){
   echo "Restart mongod"
         sudo systemctl restart mongod

   echo "Restart nginx"
         sudo systemctl restart nginx
}

get_repo(){
  echo "get_repo function Git Repo..."
  Repo_URL="https://github.com/Vidhya-Skill-School/NodeJS-Express-API-V1.git"
  Repo_Dir="NodeJS-Express-API-V1"
  echo "Clone Repo=$RepoURL and Directory=$RepoDir"

 if [ -d "$Repo_Dir" ]; then
    cd "$Repo_Dir"
    echo "$Repo_Dir aldready exist so doing git pull "
   sudo git pull
 else

    echo "$Repo_Dir not exist so doing git clone "
    sudo git clone "$Repo_URL"
    cd "$Repo_Dir"
 fi

 echo "npm install - install all dependencies for app"
 sudo npm install

}

run_repo(){
 echo "restart pm2 application"
 pm2 restart ./src/main.js
 echo "application started please check"

}

install_node
install_mongodb
install_pm2
get_repo
restart_services
run_repo
