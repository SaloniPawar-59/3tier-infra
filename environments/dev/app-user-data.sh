#!/bin/bash
# Update the system
yum update -y

# Install Nginx, PHP, PHP-FPM, and MySQL client
sudo yum install nginx -y
sudo yum install php -y
sudo yum install mariadb105-server -y

# Start and enable services
sudo systemctl enable nginx
sudo systemctl start nginx
sudo systemctl enable php-fpm
sudo systemctl start php-fpm
sudo systemctl start mariadb
sudo systemctl enable mariadb


# Replace this with your actual RDS endpoint after terraform apply
DB_HOST="terraform-20250718091514666000000001.cz4isqggm02u.ap-south-1.rds.amazonaws.com:3306"
DB_USER="admin"
DB_PASS="StrongPassword123!"
DB_NAME="registration"

# Create PHP file
cat <<EOF > /usr/share/nginx/html/submit.php
<?php
\$conn = new mysqli("$DB_HOST", "$DB_USER", "$DB_PASS", "$DB_NAME");
if (\$conn->connect_error) {
    die("Connection failed: " . \$conn->connect_error);
}
\$name = \$_POST['name'];
\$email = \$_POST['email'];
\$sql = "INSERT INTO users (name, email) VALUES ('\$name', '\$email')";
if (\$conn->query(\$sql) === TRUE) {
    echo "Registration successful!";
} else {
    echo "Error: " . \$conn->error;
}
\$conn->close();
?>
EOF

# Set proper permissions
chown nginx:nginx /usr/share/nginx/html/submit.php
chmod 644 /usr/share/nginx/html/submit.php

# Configure Nginx to handle PHP
cat <<EOF > /etc/nginx/conf.d/default.conf
server {
    listen       80;
    server_name  localhost;

    root   /usr/share/nginx/html;
    index  index.php index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php$ {
        include        fastcgi_params;
        fastcgi_pass   unix:/run/php-fpm/www.sock;
        fastcgi_param  SCRIPT_FILENAME  \$document_root\$fastcgi_script_name;
    }

    error_page 404 /404.html;
}
EOF

# Restart Nginx to apply changes
systemctl restart nginx
