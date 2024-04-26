sudo apt-get update
sudo apt-get install nginx -y
echo "<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Hello, Nginx!</title>
</head>
<body>
    <h1>Hello, Nginx!</h1>
    <p>This is a test server</p>
</body>
</html>" > /var/www/html/index.html
sudo systemctl start nginx