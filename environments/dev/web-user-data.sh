#!/bin/bash
# Update packages
sudo yum update -y

# Install Nginx
sudo yum install nginx -y


# Start Nginx and enable on boot
sudo systemctl start nginx
sudo systemctl enable nginx

# Replace with your app EC2's private IP after terraform apply
APP_IP="10.0.3.214"

# Create registration form in the Nginx web root
cat <<EOF > /usr/share/nginx/html/index.html
<html>
  <body>
    <h2>Registration Form</h2>
    <form action="http://$APP_IP/submit.php" method="post">
      Name: <input type="text" name="name"><br>
      Email: <input type="text" name="email"><br>
      <input type="submit" value="Submit">
    </form>
  </body>
</html>
EOF
