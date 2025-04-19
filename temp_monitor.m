function y = temp_monitor(x,a)
% this function can monitor the temperature and can change the switch
% accoring to the temperature
% if the input temperature value is larger than 18 and less than 24,swtich green
% light on
% if the input temperature value is less than 18, swtich the yellow light
% on and blink every 0.5s
% if the input temperature value is larger than 24, switch the red light on
% and blink every 0.25s
if (18<x)&&(x<24)
    writeDigitalPin(a,'d2',1);% swtich green LED on
    pause(1);
else
    if x<18
       writeDigitalPin(a,'d2',0);% swtich green LED off
       writeDigitalPin(a,'d7',1);% swtich yellow LED on
       writeDigitalPin(a,'d7',0);% swtich yellow LED off
       pause(0.5);
       writeDigitalPin(a,'d7',1);% swtich yellow LED on
       writeDigitalPin(a,'d7',0);% swtich yellow LED off
       pause(0.5);
    else
        writeDigitalPin(a,'d2',0);% swtich gren LED off
        writeDigitalPin(a,'d8',1);% swtich red LED on
        writeDigitalPin(a,'d8',0);% swtich red LED off
        pause(0.25);
        writeDigitalPin(a,'d8',1);% swtich red LED on
        writeDigitalPin(a,'d8',0);% swtich red LED off
        pause(0.25);
        writeDigitalPin(a,'d8',1);% swtich red LED on
        writeDigitalPin(a,'d8',0);% swtich red LED off
        pause(0.25);
        writeDigitalPin(a,'d8',1);% swtich red LED on
        writeDigitalPin(a,'d8',0);% swtich red LED off
        pause(0.25);
    end
end
end