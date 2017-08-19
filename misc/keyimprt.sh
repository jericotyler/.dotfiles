echo "Provide PGP Key"
read key
gpg --keyserver hkp://pgp.mit.edu:11371 --recv-keys $key
