# PortScan
Parallel port scanner written in Bash.

Name: PortScan.sh  
Helper Scripts: scan_ip_port.sh, ip_util.sh   
Scripting Language: Bash  
Author: Dylan Wagner   
Description:   
	PortScan.sh scans an IP address or IP address range with a supplied port range. The script will then display which ports are open to the user.  
Usage:   
./PortScan.sh [IPV4] [PORT]. 
	IPV4: 	Single IP(ex. 192.168.0.1),   
		IP range(ex. 192.168.0.1-192.168.0.50),   
		IP address with prefix(ex. 192.168.0.0/24)  
	  
	PORT: 	List(ex. 25,80,21), range(ex. 1-100)  


