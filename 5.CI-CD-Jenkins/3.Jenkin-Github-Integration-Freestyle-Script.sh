# Variables
REPO_URL="https://github.com/vijendra336/node-starter-main.git"
REPO_DIR="node-starter-main"

# Print current directory
echo "Current working directory:"
pwd

# Print current user
echo "Current user:"
whoami

# Clone or pull the repository
if [ -d "$REPO_DIR" ]; then
    echo "Directory $REPO_DIR exists. Pulling the latest changes."
    cd "$REPO_DIR"
    git pull
else
    echo "Directory $REPO_DIR does not exist. Cloning the repository."
    git clone "$REPO_URL"
    cd "$REPO_DIR"
fi

# Install dependencies
echo "Installing dependencies"
npm install

# Run tests
echo "Running tests"
npm test

# Build the project
echo "Building the project"
npm run build

# Deploy the application using pm2
echo "Deploying the application"
pm2 stop my-app || true
pm2 start dist/main.js --name my-app
pm2 reload my-app
