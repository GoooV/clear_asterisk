#!/bin/bash

declare -a array
while read -e ARG && [ "$ARG" ] ; do
	array=(` echo $ARG | sed -e 's/://'`)
	export ${array[0]}=${array[1]}
done

# following variables are available from asterisk 
echo $agi_request >&2
echo $agi_channel >&2
echo $agi_language >&2
echo $agi_type >&2
echo $agi_uniqueid >&2
echo $agi_callerid >&2
echo $agi_dnid >&2
echo $agi_rdnis >&2
echo $agi_context >&2
echo $agi_extension >&2
echo $agi_priority >&2
echo $agi_enhanced >&2

checkresults() {
	while read line
	do
	case ${line:0:4} in
	"200 " ) echo $line >&2
	         return;;
	"510 " ) echo $line >&2
	         return;;	
	"520 " ) echo $line >&2
	         return;;
	*      ) echo $line >&2;;	#keep on reading those Invlid command
					#command syntax until "520 End ..."
	esac
	done
}

# echo "1.  Testing 'sendfile' ..." >&2
# echo "STREAM FILE out \"\""
# checkresults

# echo "2.  Testing 'sendtext' ..." >&2
# echo "SEND TEXT \"hello world\""
# checkresults

# echo "3.  Testing 'sendmage' ..." >&2
# echo "SEND IMAGE asterisk-image"
# checkresults

# echo "4.  Testing 'saynumber' ..." >&2
# echo "SAY NUMBER 192837465 \"\""
# checkresults

# echo "5.  Testing 'waitdtmf' ..." >&2
# echo "WAIT FOR DIGIT 1000"
# checkresults

echo "6.  Testing 'record' ..." >&2
echo "RECORD FILE rec gsm 1234 3000"
checkresults

echo "6a.  Testing 'record' playback" >&2
echo "STREAM FILE rec \"\" "
checkresults

echo "=================== Complete ====================" >&2