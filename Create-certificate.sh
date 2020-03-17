#!/bin/bash

x="xlc"
loop ()
{
while true $x != "xlc"
do


$ca_name = ''
$cert_name = ''


clear



echo -e "\E[31m [*] \E[00m (1) Create CA  "
echo -e "\E[32m [*] \E[00m (2) Create a certificate "
echo -e "\E[31m [*] \E[00m (3) Signing a certificate"
echo -e "\E[32m [*] \E[00m (4) Create a PFX"

read -p "Option: " x

case "$x" in

    1)
      clear
      read -p "Write the CA name: " ca_name

      echo "-=Creating a Key=-"
      openssl genrsa -des3 -out $ca_name.key 4096
# sign a certificate for 365 days; replace that number with whatever's
# suitable for your application
      echo "-=Signing a certificate with the key=-"
      openssl req -new -x509 -days 1095 -key $ca_name.key -out $ca_name.crt

      clear
      
      #test
      echo "-=Testing the certificate=-"
      openssl x509 -in $ca_name.crt -noout -text


      echo -e "\E[00m\n"
      read -p $'\E[32m[*] \E[00mPress enter to continue.' pxc

      clear
;;
      
    2)
      clear
      read -p "Write the CA name: " ca_name
      read -p "Write the certificate name: " cert_name
          #Create a key

      clear
      echo "-=Creating a key to certificate=-"
      openssl genrsa -des3 -out $cert_name.key 4096


      echo \n
      echo \n

      echo "-=Creating a certificate with the key=-"
      openssl req -new -key $cert_name.key -out $cert_name.csr

      echo -e "\E[00m\n"
      read -p $'\E[32m[*] \E[00mPress enter to continue.' pxc
      
      clear


;;
      3)


      clear
      read -p "Write the CA name: " ca_name
      read -p "Write the certificate name: " cert_name
      clear

      echo "-=Signing the certificate=-"

      #Sign a certificate
      openssl x509 -req -days 1095 -in $cert_name.csr -CA $ca_name.crt -CAkey $ca_name.key -set_serial 01 -out $cert_name.crt


      echo -e "\E[00m\n"
      read -p $'\E[32m[*] \E[00mPress enter to continue.' pxc
      
      clear


;;

      4)

      
            clear
            read -p "Write the CA name: " ca_name
            read -p "Write the certificate name: " cert_name
            clear

            echo "-=Creating a PKCS #12=-"


            #create a PKCS #12
            openssl x509 -req -days 1095 -in $cert_name.csr -CA $ca_name.crt -CAkey $ca_name.key -set_serial 01 -out $cert_name.crt

           echo -e "\E[00m\n"
            read -p $'\E[32m[*] \E[00mPress enter to continue.' pxc
            
            clear
      

;;


      *)

      echo -e "Invalid option"

      echo -e "\E[00m\n"

      read -p $'\E[32m[*] \E[00mPress enter to continue.' pxc
clear


esac
done

}
loop
      
