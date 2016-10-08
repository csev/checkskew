#! /bin/bash

# Number of seconds to tolerate
tolerance=10

# email address to send to
email='py4e@example.com';

# Name of the system in question
# name='www.py4e.com';
name=`hostname`;

actual=`curl -s http://www.timeapi.org/utc/now`
actual='2015-10-08T13:18:00';
echo From web: $actual

# months are all 30 days
deltas=( 31104000 2592000 86400 3600 60 1 )

# http://stackoverflow.com/questions/1842634/parse-date-in-bash
a=(`echo $actual | sed -e 's/+/ /g' | sed -e 's/[T:-]/ /g' | sed -e 's/ 0/ /g'`)
# echo ${a[*]}
# echo ${a[3]}

system=`date -u +"%Y-%m-%dT%H:%M:%SZ"`
echo System $system
s=(`echo $system | sed -e 's/+/ /g' | sed -e 's/[TZ:-]/ /g' | sed -e 's/ 0/ /g'`)
# echo ${s[*]}
# echo ${s[3]}

skew=0
for i in `seq 0 5`;
do
  delta=${deltas[$i]}
  av=${a[$i]}
  sv=${s[$i]}
  if [ "$av" -gt "$sv" ]; then
    skew=$(($skew+($delta*($av-$sv))));
  else
    skew=$(($skew+($delta*($sv-$av))));
  fi
  # echo $i $delta $av $sv $skew
done  

echo Skew: $skew Tolerance: $tolerance

if [ "$skew" -lt "$tolerance" ]; then
    echo "Skew is acceptible"
    exit
fi

echo Sending email to $email

mail -s "Clock skew of $skew on $name" $email << EOF

Clock Error on $name

System time: $system
Web time: $actual

Skew (in seconds) : $skew
Tolerance: $tolerance

EOF

echo "Email sent to $email"
