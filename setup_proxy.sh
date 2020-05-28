voms-proxy-init -voms cms -rfc -valid 192:00
export VOMS_PATH=$(echo $(voms-proxy-info | grep path) | sed 's/path.*: //')
export VOMS_USERID=$(echo $(voms-proxy-info | grep path) | sed 's/.*p_u//')
export VOMS_TRG=/home/$USER/x509up_u$VOMS_USERID
rm -f $VOMS_TRG
cp $VOMS_PATH $VOMS_TRG
echo "Your proxy is copied here: "$VOMS_TRG
export X509_USER_PROXY=$VOMS_TRG
