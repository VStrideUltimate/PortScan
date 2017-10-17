#file: ip_util.sh
#author: Dylan Wagner

# function takes ip address an converts it into a integer.
function int_ip(){

        local IP_ADDR="$1"
        local OONE=$(echo $IP_ADDR | cut -d. -f1)
        local OTWO=$(echo $IP_ADDR | cut -d. -f2)
        local OTHREE=$(echo $IP_ADDR | cut -d. -f3)
        local OFOUR=$(echo $IP_ADDR | cut -d. -f4)

        local INT
        INT=$[(256**3)*$OONE]
        INT=$[(256**2)*$OTWO+$INT]
        INT=$[(256)*$OTHREE+$INT]
        INT=$[$OFOUR+$INT]

        echo $INT
}

# converts ip int back into a ip str
function str_ip(){

        local INT="$1"

        echo $[($INT>>24)&255].$[($INT>>16)&255].$[($INT>>8)&255].$[$INT&255]
}

