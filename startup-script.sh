#!/bin/sh
# Example custom script for Linux VM
# This custom script will be executed on the VM instance using /bin/sh via the Microsoft.Azure.Extensions CustomScript extension.
# This file will be gzip'ed and then base64 encoded for the extension. The size of the resulting gzip'ed and base64 encoded script must not exceed 256KB.
# echo "Hello World!" > ./hello-world.txt
#echo "Humana application ID: ${humana-application-id}" > ./humana-application.txt

echo "create bootstrap log........................." > /tmp/bootstrap.log 2>&1

cd /opt
mkdir -p /opt/dynatrace
chmod 755 dynatrace

#unmount Mountpoint /uploads (mounted by ECA Terraform module while doing data disk init)
umount /uploads

# remove data1 directory and fstab entry of the mountpoint (which is the default directory created when provisioning a disk)
retVal=$?
if [ $retVal -eq 0 ]; then
   echo "removing /uploads fstab entry and deleting folders on sdc new disk" >> /tmp/bootstrap.log 2>&1
   cd /media
   rm -rf data1
   sed -i '/media\/data1/s/^/#/g' /etc/fstab
   cp /etc/fstab /etc/fstab.bkp
   sed -i '/media\/data1/d' /etc/fstab
else
   echo "/uploads mountpoint not found" >> /tmp/bootstrap.log 2>&1
fi

# /dev/sda is reserved mostly for OS disk and /dev/sdb is created by ECA module
# Create partiions on additional data disk /dev/sdc in order to add space to /opt and /var folders for Dynatrace

if (pvdisplay | grep -q '/dev/sdc1') && (pvdisplay | grep -q 'dev/sdc2'); then
   echo "partitions and physical volumes already present!" >> /tmp/bootstrap.log 2>&1
else
   echo "creating partitions and logical volumes" >> /tmp/bootstrap.log 2>&1
   parted --script /dev/sdc \
   mklabel gpt \
   mkpart sdc1  ext4  1000MB 50GB \
   set 1 lvm on \
   mkpart sdc2  ext4  50GB 80GB \
   set 2 lvm on \
   quit

# Create Physical Volumes
   pvcreate /dev/sdc1
   pvcreate /dev/sdc2
  # extend volume group to include the 2 new physical volumes just created
   if vgdisplay | grep -q 'rootvg'  ; then
      echo "volume group already present. Extending to add physical volumes" >> /tmp/bootstrap.log 2>&1
      vgextend rootvg /dev/sdc2
   else
      echo "volume group rootvg does not exist" >> /tmp/bootstrap.log 2>&1
   fi
   if lvdisplay | grep -q 'optlv'; then
       lvextend -l +100%PVS /dev/mapper/rootvg-optlv /dev/sdc1
      xfs_growfs /dev/mapper/rootvg-optlv
   echo "logical volume optlv already exists" >> /tmp/bootstrap.log 2>&1
   else   
     echo "New VG and lvm for /opt is being created" >> /tmp/bootstrap.log 2>&1
	  vgcreate dynatraceagvg /dev/sdc1
     lvcreate -L 45G --name optlv dynatraceagvg /dev/sdc1
     mkfs.ext4 /dev/mapper/dynatraceagvg-optlv
     #mount /dev/mapper/dynatraceagvg-optlv /opt
   fi
   if lvdisplay | grep -q 'varlv'; then
      lvextend -l +100%PVS /dev/mapper/rootvg-varlv /dev/sdc2
      xfs_growfs /dev/mapper/rootvg-varlv
   else
      echo "logical volume varlv does not exist" >> /tmp/bootstrap.log 2>&1
   fi
fi

# Add /etc/fstab file entries for mountpoints

if cat /etc/fstab | grep -q 'optlv'; then
   echo "fstab entries already present" >> /tmp/bootstrap.log 2>&1
else
   echo "add /etc/fstab entries " >> /tmp/bootstrap.log 2>&1

   echo /dev/mapper/dynatraceagvg-optlv /opt ext4 defaults 0 0 >> /etc/fstab
   # Issue Mount command 
   echo "mount step " >> /tmp/bootstrap.log 2>&1
   mount -a
   mount 
fi

cd /opt
mkdir -p /opt/dynatrace
chmod 755 dynatrace

# Extend Logical Vol for /opt and /var to accommodate /opt/dynatrace-managed folder.
# Image has only 2 GB for opt
 
# Open 9999/tcp Port with firewall-cmd
firewall-cmd --zone=drop --permanent --add-port=9999/tcp --add-port=22/tcp
firewall-cmd --reload
firewall-cmd --set-default-zone drop

# Install AG 
service dynatracegateway status > /tmp/activegatestatus.txt
if cat /tmp/activegatestatus.txt | grep -q 'running'; then
   echo "dynatrace activegate already installed and status is up and running"
else
  cd /opt/dynatrace

  if test ${dynatrace_ag_version} = "latest"
  then
 # This command on the target host to download the latest ActiveGate installer.
    echo "I am here : ${dynatrace_ag_version}" >> /tmp/bootstrap.log 2>&1
    wget  -O Dynatrace-ActiveGate-Linux-x86-${dynatrace_ag_version}.sh "${dynatrace_apiurl}/v1/deployment/installer/gateway/unix/${dynatrace_ag_version}?arch=x86&flavor=default" --header="Authorization: Api-Token ${dynatrace_ag_paas_token}" --no-check-certificate
 # Verify signature
    ( echo 'Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="--SIGNED-INSTALLER"'; echo ; echo ; echo '----SIGNED-INSTALLER' ; cat Dynatrace-ActiveGate-Linux-x86-${dynatrace_ag_version}.sh ) | openssl cms -verify -CAfile dt-root.cert.pem > /dev/null

 # Run the installer with root rights.
   /bin/bash Dynatrace-ActiveGate-Linux-x86-${dynatrace_ag_version}.sh
  else
 # This command on the target host to download the specific version of ActiveGate installer.
    echo "I am here : ${dynatrace_ag_version}" >> /tmp/bootstrap.log 2>&1
    wget  -O Dynatrace-ActiveGate-Linux-x86-${dynatrace_ag_version}.sh "${dynatrace_apiurl}/v1/deployment/installer/gateway/unix/version/${dynatrace_ag_version}?arch=x86&flavor=default" --header="Authorization: Api-Token ${dynatrace_ag_paas_token}" -k -O Dynatrace-ActiveGate-Linux-x86-${dynatrace_ag_version}.sh >> /tmp/bootstrap.log 2>&1
 # Verify signature
    ( echo 'Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="--SIGNED-INSTALLER"'; echo ; echo ; echo '----SIGNED-INSTALLER' ; cat Dynatrace-ActiveGate-Linux-x86-$dynatrace_ag_version.sh ) | openssl cms -verify -CAfile dt-root.cert.pem > /dev/null

 # Run the installer with root rights.
    /bin/bash Dynatrace-ActiveGate-Linux-x86-${dynatrace_ag_version}.sh
  fi
fi  

#Apply activegate certificate
if test -f /var/lib/dynatrace/gateway/ssl/${dynatrace_ag_cert_name}; then
   echo "Certificate ActiveGate cert ${dynatrace_ag_cert_name} already present "
else
   mkdir -p /tmp/certificate
   chmod -R 775 /tmp/certificate
   echo "$${dynatrace_ag_cert_rawdata}" > ${dynatrace_ag_cert_name}
   #wget "https://emfnpestgaccx01.blob.core.windows.net/emfnpehubcontainer/${dynatrace_ag_cert_name}?sp=r&st=2021-01-26T15:26:05Z&se=2021-01-26T23:26:05Z&spr=https&sv=2019-12-12&sr=b&sig=P46WBw5ytIid2gpStze77EwLpj0SD2auwXMBXrtKZXU%3D" -k -O /tmp/certificate/${dynatrace_ag_cert_name}

   echo "${storage_acct_sas_url}" >> /tmp/bootstrap.log 2>&1
   wget "${storage_acct_sas_url}" -k -O /tmp/certificate/${dynatrace_ag_cert_name}
   cp /tmp/certificate/* /var/lib/dynatrace/gateway/ssl
   cd /var/lib/dynatrace/gateway/
   chmod -R 775 *
   chown -R dtuserag:dtuserag *
fi

#Update custom.properties file
cd /var/lib/dynatrace/gateway/config
cp -rp custom.properties custom.properties.bkp
cat /dev/null custom.properties

if  (hostname | grep -q 'npe'); then
echo "writting non prod properties"
cat <<EOT > custom.properties
[collector]
MSGrouter = true
AzureAgentEnabled = true
enableHttpChecks = false
group = aggroup.azure1.eastus2
ignoreClusterRuntimeInfo = true
seedServerUrl = ${dynatrace_loadbalancerUrl}                                             #Added LB url variable pointing to NPE@Avinash.P     #https://np-dt.humana.com:443/communication

[aws_monitoring]
aws_monitoring_enabled = false

[dbAgent]
dbAgent_enabled = false

[rpm]
rpm_enabled = false

[vmware_monitoring]
vmware_monitoring_enabled = false

[cloudfoundry_monitoring]
cloudfoundry_monitoring_enabled = false
cloudfoundry_read_events_enabled = false

[com.compuware.apm.webserver]
certificate-file = ${dynatrace_ag_cert_name}
certificate-alias = ${dynatrace_ag_cert_alias}
certificate-password = ${dynatrace_ag_cert_pass}

[directories]
logDir = /var/log/dynatrace/gateway
tempDir = /var/tmp/dynatrace/gateway
rootDir = /opt/dynatrace/gateway

[connectivity]
networkZone = ${dynatrace_ag_network_zone}
dnsEntryPoint = ${dynatrace_DNSentrypointUrl}                                                                    #https://azureaggreenfield.np-dt.humana.com:9999
EOT
else
    if (hostname | grep -q 'prod'); then
echo "writting prod properties"
cat <<EOT > custom.properties
[collector]
MSGrouter = true
AzureAgentEnabled = true
enableHttpChecks = false
group = aggroup.azure1.eastus2
ignoreClusterRuntimeInfo = true
seedServerUrl = ${dynatrace_loadbalancerUrl}  

[aws_monitoring]
aws_monitoring_enabled = false

[dbAgent]
dbAgent_enabled = false

[rpm]
rpm_enabled = false

[vmware_monitoring]
vmware_monitoring_enabled = false

[cloudfoundry_monitoring]
cloudfoundry_monitoring_enabled = false
cloudfoundry_read_events_enabled = false

[com.compuware.apm.webserver]
certificate-file = ${dynatrace_ag_cert_name}
certificate-alias = ${dynatrace_ag_cert_alias}
certificate-password = ${dynatrace_ag_cert_pass}

[directories]
logDir = /var/log/dynatrace/gateway
tempDir = /var/tmp/dynatrace/gateway
rootDir = /opt/dynatrace/gateway

[connectivity]
networkZone = ${dynatrace_ag_network_zone}
dnsEntryPoint = ${dynatrace_DNSentrypointUrl}  
EOT
fi
fi

#Stop/start ActiveGate
service dynatracegateway stop
service dynatracegateway start

#uninstall ActiveGate
#/bin/sh /opt/dynatrace/gateway/uninstall.sh

# Install Self Monitoring Agent 
service oneagent status > /tmp/oneagentstatus.txt
if cat /tmp/oneagentstatus.txt | grep -q 'running'; then
   echo "dynatrace oneagent already installed and status is up and running"
else
  cd /opt/dynatrace
 # This command on the target host to download the latest ActiveGate installer.
    echo "I am here : ${dynatrace_oneagent_version}" >> /tmp/bootstrap.log 2>&1
    wget  -O Dynatrace-OneAgent-Linux-${dynatrace_oneagent_version}.sh "${dynatrace_oneagent_apiurl}/v1/deployment/installer/agent/unix/default/${dynatrace_oneagent_version}?arch=x86&flavor=default" --header="Authorization: Api-Token ${dynatrace_og_pass_token}" 
 # Verify signature
    ( echo 'Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="--SIGNED-INSTALLER"'; echo ; echo ; echo '----SIGNED-INSTALLER' ; cat Dynatrace-ActiveGate-Linux-x86-${dynatrace_oneagent_version}.sh ) | openssl cms -verify -CAfile dt-root.cert.pem > /dev/null

 # Run the installer with root rights.
   /bin/bash Dynatrace-OneAgent-Linux-${dynatrace_oneagent_version}.sh
fi 
 
#PIV Automation commands from here.Strating script to a file PIVAutomation.log and executing required commands. So, once above azure pipeline is completed we can validate by viewing file cotents: @Avinash Pallagani

sudo su
#1. check for disk allocation after server instance is rebuilt, /var folder allocated size will be in range of ~40-50 GB
df -h >> /tmp/bootstrap.log 2>&1

echo "PIV Check: Allocated disk space list in the AG server " >> /tmp/bootstrap.log 2>&1

#2. Check/ Validation for INSTALLED HUmana Enterprise Root and Intermediate certificates in openssl and PEM directories
cd /etc/pki/ca-trust/extracted/openssl 
cat ca-bundle.trust.crt | grep "Humana" >> /tmp/bootstrap.log 2>&1
if cat  /tmp/bootstrap.log 2>&1 | grep -q 'Humana Enterprise Root CA 3'; then
   echo "PIV Check: Active gate has Humana Enterprise Root Certificate **INSTALLED** in openssl directory "
   else
   echo "PIV Check: Active Gate is **MISSING** Humana Enterprise Root Certificate in openssl directory "
fi
if cat  /tmp/bootstrap.log 2>&1 | grep -q 'Humana General Purpose Issuing CA 3'; then
   echo "PIV Check: Active gate has Humana General Purpose Issuing Certificate **INSTALLED** in openssl directory"
   else
   echo "PIV Check: Active Gate is **MISSING** Humana General Purpose Issuing Certificate in openssl directory "
fi 
cd /etc/pki/ca-trust/extracted/pem
cat tls-ca-bundle.pem | grep "Humana" >> /tmp/bootstrap.log 2>&1
if cat  /tmp/bootstrap.log 2>&1 | grep -q 'Humana Enterprise Root CA 3'; then
   echo "PIV Check: Active gate has Humana Enterprise Root Certificate **INSTALLED** in PEM directory "
   else
   echo "PIV Check: Active Gate is **MISSING** Humana Enterprise Root Certificate in PEM directory "
fi
if cat  /tmp/bootstrap.log 2>&1 | grep -q 'Humana General Purpose Issuing CA 3'; then
   echo "PIV Check: Active gate has Humana General Purpose Issuing Certificate **INSTALLED** in openssl directory"
   else
   echo "PIV Check: Active Gate is **MISSING** Humana General Purpose Issuing Certificate in PEM directory "
fi 

#3. check for certificates and health of a gateway server from AG using curl command

curl -v https://agazureagonedotzero.dr-dt.humana.com:9999/rest/health >> /tmp/bootstrap.log 2>&1

if cat  /tmp/bootstrap.log 2>&1 | grep -q '/var/log'; then
   echo "PIV Check: DT log directory created successfully" 
   else
   echo "PIV check: DT log directory NOT created "
fi
echo "PIV Check: DT gateway server health check/ certificates and connection check " 
if cat  /tmp/bootstrap.log 2>&1 | grep -q 'RUNNING'; then
   echo "PIV Check: DT gateway server connection Successful: 200 ok"
   else
   echo "PIV Check: DT gateway server connection NOT Successful"
fi


# End of PIV automation code snippet