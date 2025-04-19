%% Preliminary TASK
clear
a=arduino; % create a to control the arduino
for i = 1:100 % create a for loop repeat 100 times
 writeDigitalPin(a,'d2',1);% swtich LED on
 pause(0.5);% pause 0.5 second
  writeDigitalPin(a,"D2",0);% swtich LED off
 pause(0.5);%pause 0.5 second
end

%% task 1
clear 
a=arduino; % create a to control the arduino
duration=600; % set  acquisition time 600s
A0_voltage=zeros(1,601); % create an array to store voltage readings
Temperature=zeros(1,601); % create an array to store temperature readings
V0=0.5; % the output voltage when 0 degree celsius of this thermistor
Tc=0.01; % changing rate between output voltage and temperature of this themistor 
for i=1:601 % create a for loop to read voltage to calculate temperature
    A0_voltage(i)=readVoltage(a,'A0'); % read voltage from analogA0
    Temperature(i)=(A0_voltage(i)-V0)/Tc; % calculate temperature by voltage
    pause(1); % pause 1 second for next reading
end
time=1:duration+1; % create an array of time to plot
plot(time,Temperature); % plot with time and temperature
xlabel('Time(s)'); % xlabel is 'time(s)'
ylabel('Temperature(c)'); % ylabel is 'temperature(c)'
Date=datetime('now'); % get the date of today
datenumber=datenum(Date); % turn date to number
year=year(datenumber); % get the year number of date
month=month(datenumber); % get the month number of date
day=day(datenumber); % get the day number of date
filedID=fopen('cabin_temperature.txt','w'); % open this file and writing
fwrite(filedID,sprintf('Data logging initiated-%d/%d/%d \n',day,month,year)); % display the date
fwrite(filedID,sprintf('Location-Nottingham\n')); % display the location
for n=1:11 % create a for loop to calculate minute number and display
    m=n-1; % calculate the number of minute
    a=m*60+1; % the second number corresponding minute
    fwrite(filedID,sprintf('\nMinute         %d \n',m)); % write minute number into file
    fwrite(filedID,sprintf('Temperature    %.2fC \n',Temperature(a))); % write temperature number into file
end
minTemp = min(Temperature); % find the minimum temperature
maxTemp = max(Temperature); % find the maximum temperature 
avgTemp = mean(Temperature); % calculate the average temperature
fprintf(filedID,'\nMax temp       %.2f C\n', maxTemp);  % write the the maximum temperature into the file
fprintf(filedID,'Min temp       %.2f C\n', minTemp); % write the the minimum temperature into the file 
fprintf(filedID,'Average temp   %.2f C\n', avgTemp); % write the the average temperature into the file 
fwrite(filedID,sprintf('\nData logging terminated')); % write message into file
fclose(filedID); % close file

%% task 2
clear
a=arduino;
A0_voltage=[]; % create an array to store voltage readings
Temperature=[]; % create an array to store temperature readings
V0=0.5; % the output voltage when 0 degree celsius of this thermistor
Tc=0.01; % the changing rate between output voltage and temperature of this themistor
i=1; %counter start from one
doc temp_monitor; % display the document of function temp_monitor
while true
    A0_voltage(i)=readVoltage(a,'A0'); % read voltage from analogA0
    Temperature(i)=(A0_voltage(i)-V0)/Tc; % calculate temperature by voltage
    x=Temperature(i); % make virable x equal to temperature(i)
    temp_monitor(x,a); % use function to monitor temperature and switch on light
    xlabel('Time(s)'); % set xlabel time
    ylabel('Temperature(C)'); % set ylabel temperature
    hold on; % keep the figure
    xlim([i-5,i+5]); % xlabel limit from i-5 to i+5
    ylim([x-10,x+10]); % ylabel limit from x-10 to x+10
    plot(1:i,Temperature,'k-'); % use black line to connect point
    plot(i,x,'ko'); % plot the point of nowtime (time,temperature)
    drawnow;% draw the figure real-time
    i=i+1; % counter increase by one
end

%% task 3
clear
a=arduino; % create cpnnection with arduino
A0_voltage=[]; % create an array to store voltage readings
Temperature=[]; % create an array to store temperature readings
avg_temp=[]; % create an array to store avg_temperature values
V0=0.5; % the output voltage when 0 degree celsius of this thermistor
Tc=0.01; % the changing rate between output voltage and temperature of this themistor
recent_temp=zeros(1,30); % create an empty array to store recent 30 temperature readings 
index=1;% the data starts recording from the first position of the array
i=1; % the counter start from one
doc temp_prediction; % display the document of function temp_prediction
while true
    A0_voltage(i)=readVoltage(a,'A0'); % read voltage from analogA0
    Temperature(i)=(A0_voltage(i)-V0)/Tc; % calculate temperature by voltage
    x=Temperature(i);% store temperature in virable x
    recent_temp(index)=x; % update the recent temperature into array
    index=mod(index,30)+1; % the index number cycle every 30 numbers
    avg_temp(i)=mean(recent_temp); % calculate the average temperature
    temp_prediction(i,avg_temp,a); % use function to predict temperature
    i=i+1; % counter increase by one
    pause(1);% pause for 1second
end

    

