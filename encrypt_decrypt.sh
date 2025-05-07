#!/bin/bash

# ./encrypt_decrypt.sh <action> <file>
# actions:  enc, dec

TOTP_SECRET=$(cat /root/totp.secret)
CAT_PASSWORD=$(cat /root/secret.key)

echo "Please enter TOTP code: "
read USER_CODE

VALID_CODE=$(oathtool --totp -b $TOTP_SECRET)

if [ "$USER_CODE" != "$VALID_CODE" ]
then
    echo "invalid code"
    exit
fi

if [ "$1" == "enc" ]
then
    openssl enc -aes256 -pbkdf2 -in $2 -out "$2.enc" -pass pass:$CAT_PASSWORD
elif [ "$1" == "dec" ]
then
    openssl enc -aes256 -pbkdf2 -d -in $2 -out "${2::-4}" -pass pass:$CAT_PASSWORD
fi
