echo "0.0.0.0 dispatchcnglobal.yuanshen.com" >> /etc/hosts
sleep 5
sed -i '/0.0.0.0 dispatchcnglobal.yuanshen.com/d' /etc/hosts
