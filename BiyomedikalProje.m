% EEG verisini içe aktar
data = readtable('EEG_data.csv'); % Dosya adını ve yolunu doğru yazdığınızdan emin olun

% İlk birkaç satırı görüntüleyin (doğru okunduğundan emin olmak için)
head(data)

% İlk kanaldaki veriyi seç
channel_data = data.Var1; % Var1, ilk sütunun adı. Sütun ismine göre değiştirin.

Fs = 250; % Örnekleme frekansı (Hz) - gerçek değeri veri setinizden kontrol edin
L = length(channel_data); % Veri uzunluğu

% Zaman vektörünü oluştur
t = (0:L-1) / Fs; % Zaman vektörü (saniye)

% Fourier dönüşümünü gerçekleştir
Y = fft(channel_data); % Fourier dönüşümü
P2 = abs(Y/L);         % İki taraflı genlik spektrumu
P1 = P2(1:L/2+1);      % Tek taraflı spektrum (pozitif frekanslar)
P1(2:end-1) = 2*P1(2:end-1); % Tek taraflı spektrum için düzenleme

% Frekans vektörünü oluştur
f = Fs*(0:(L/2))/L; % Frekans vektörü

% Grafikleri yan yana çiz
figure;

% 1. Alt grafik: Genlik-Zaman Grafiği
subplot(1, 2, 1); % 1 satır, 2 sütun, 1. grafik
plot(t, channel_data);
title('Genlik-Zaman Grafiği');
xlabel('Zaman (s)');
ylabel('Genlik');
grid on;

% 2. Alt grafik: Genlik-Frekans Grafiği
subplot(1, 2, 2); % 1 satır, 2 sütun, 2. grafik
plot(f, P1);
title('Genlik-Frekans Grafiği');
xlabel('Frekans (Hz)');
ylabel('Genlik');

% Logaritmik ölçek uygulamak için frekans vektörünü logaritmik olarak ayarla
set(gca, 'XScale', 'log');
xlim([1, Fs/2]); % Frekans aralığını sınırla (1 Hz ile Nyquist frekansı arası)

grid on; % Izgara ekle
