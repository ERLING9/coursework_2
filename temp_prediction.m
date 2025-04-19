function y = temp_prediction (i,avg_temp,a)
%this function can calculate the temperature changing rate and predict the
%expected temperature 5 minutes later.
%this function can also constantly monitor the temperature changing rate
%and switch different light acording to the changing rate
%if the changing rate is increase faster than 5c/min, it will swtich on
%red light
%if the changing rate is decrease faster than 5c/min, it will switch
%on yellow light
%if the temperature is stable in comfort range, it will swtich green light.
if i>=30
    avg_changingrate_second(i)=(avg_temp(i)-avg_temp(i-1))/1;
    fprintf('the temperature changing rate is %.2f C/s\n',avg_changingrate_second(i));
    avg_changingrate_minute(i)=avg_changingrate_second(i)*60;
    predict_temp(i)=avg_temp(i)+avg_changingrate_minute(i)*5;
    fprintf('the temperature now is %.2f C, the temperature expected in 5 minutes is %.2f C\n',avg_temp(i),predict_temp(i));
    if 18<avg_temp(i)&&avg_temp(i)<24
        writeDigitalPin(a,'d2',1);% swtich green LED on
    else
        writeDigitalPin(a,'d2',0);% swtich green LED off
    end
    if avg_changingrate_minute(i)>4
        writeDigitalPin(a,'d7',0);% swtich yellow LED off
        writeDigitalPin(a,'d8',1);% swtich red LED on
    elseif avg_changingrate_minute(i)<-4
        writeDigitalPin(a,'d8',0);% swtich red LED off
        writeDigitalPin(a,'d7',1);% swtich yellow LED on
    else
        writeDigitalPin(a,'d7',0);% swtich yellow LED off
        writeDigitalPin(a,'d8',0);% swtich red LED off
    end
else
    rest_time=30-i;
    fprintf('Data recording, will display %.f s seconds later\n',rest_time);
end
end