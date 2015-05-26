function receiver() 

  result = 'result.wav';
  FS = 44100;
  N_BITS = 16;
  N_CHANNELS = 1;
%audiorecorder creates by default an 8000 Hz, 8-bit, 
%1-channel audiorecorder object.
  OutputSound = audiorecorder(FS, N_BITS, N_CHANNELS); 

  %recordblocking: Record audio to audiorecorder object, holding control 
  %until recording completes
  %Choose time 10 sec arbritary (150 bits * 3 * 0.06 = 18 sec)
  recordblocking(OutputSound, 180);
  %Store recorded audio signal in numeric array
  myRecording = getaudiodata(OutputSound);
  audiowrite(result, myRecording, FS);  



conversion(result);
bits_to_text();

end