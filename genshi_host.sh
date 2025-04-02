echo "0.0.0.0 dispatchcnglobal.yuanshen.com" >> /etc/hosts
sleep 5
sed '/0.0.0.0 dispatchcnglobal.yuanshen.com/d' /etc/hosts | tee /etc/hosts > /dev/null
