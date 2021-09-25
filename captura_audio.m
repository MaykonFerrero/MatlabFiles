close all
clear all
% Record your voice for 5 seconds.
Tempo = 10;
recObj = audiorecorder;
disp('Start speaking.')
recordblocking(recObj, Tempo);
disp('End of Recording.');

% Store data in double-precision array.
myRecording = getaudiodata(recObj);
audiowrite('audio.wav',myRecording,8000);
sound(myRecording,8000); %o vetor myRecording deve ser utilizado para conv.
% Plot the waveform.
plot(myRecording);
