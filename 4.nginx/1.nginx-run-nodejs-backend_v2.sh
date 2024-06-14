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

cd /home/ubuntu/VJDevops/shellscriptdemo/

echo "get_repo function Git Repo..."
  local  Repo_URL="$1"
  local  Repo_Dir="$2"
  echo " Repo=$Repo_URL and Directory=$Repo_Dir"


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
#  cd /home/ubuntu/VJDevops/shellscriptdemo/
 # cd $app_name
  echo "Current directory # $(pwd)"
  local app_name="$1"
  local app_dir="$2"
  local app_alias_name="$3"
  echo "App Name=$app_name & directory=$app_dir & app_name_alias=$3"

  # Check if src/main.js is already running
  if pm2 list | grep -q "$app_alias_name"; then
    echo "PM2 process for $app_name is already running."
    sudo pm2 restart "$app_name" --update-env
  else
    echo "PM2 process for src/main.js is not running, starting it."
   sudo pm2 start  "$app_name" --update-env
  fi

  echo "Application started, please check."
}

install_node
install_mongodb
install_pm2
get_repo "https://github.com/Vidhya-Skill-School/NodeJS-Express-API-V1.git"  "NodeJS-Express-API-V1"
run_repo "src/main.js" "NodeJS-Express-API-V1" "main"
#get_repo "https://github.com/Adedoyin-Emmanuel/react-weather-app.git" "react-weather-app"
#run_repo "src/main.js" "react-weather-app" "main"
restart_services
